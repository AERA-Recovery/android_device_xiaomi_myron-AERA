#!/usr/bin/env python3
import os
import struct
import sys

def transplant_avb_smart(official_img, custom_img, output_img):
    print("[*] Parsing images and transplanting the stock AVB footer...")
    
    # 1. Extract the stock VBMeta signature block.
    with open(official_img, 'rb') as f_off:
        f_off.seek(0, os.SEEK_END)
        part_size = f_off.tell()
        
        f_off.seek(part_size - 64)
        footer = f_off.read(64)
        magic, major, minor, orig_size, vbmeta_offset, vbmeta_size = struct.unpack('>4sLLQQQ', footer[:36])
        
        if magic != b'AVBf':
            print("[-] Error: the stock image has no AVB footer.")
            sys.exit(1)
            
        f_off.seek(vbmeta_offset)
        off_vbmeta_blob = f_off.read(vbmeta_size)
        print(f"[+] Extracted the stock signature block ({vbmeta_size} bytes)")

    # 2. Strip padding and any old signature from the custom image.
    with open(custom_img, 'rb') as f_cust:
        f_cust.seek(0, os.SEEK_END)
        cust_size = f_cust.tell()
        
        f_cust.seek(cust_size - 64)
        cust_footer = f_cust.read(64)
        magic, _, _, _, cust_vbmeta_offset, _ = struct.unpack('>4sLLQQQ', cust_footer[:36])
        
        f_cust.seek(0)
        if magic == b'AVBf':
            # Strip the build-time test signature and retain the actual payload.
            pure_cust_data = f_cust.read(cust_vbmeta_offset)
            print(f"[+] Stripped the test signature; AERA payload: {len(pure_cust_data)} bytes")
        else:
            pure_cust_data = f_cust.read()
            print(f"[+] No test signature found; AERA payload: {len(pure_cust_data)} bytes")

    # Ensure the payload plus the stock signature fits the physical partition.
    if len(pure_cust_data) + len(off_vbmeta_blob) + 64 > part_size:
        print("[-] Error: the AERA image and AVB signature exceed the 100 MiB recovery partition.")
        sys.exit(1)

    # 3. Rebuild the AVB footer offsets and assemble the final image.
    new_vbmeta_offset = len(pure_cust_data)
    # Pack the new 64-byte footer.
    new_footer = struct.pack('>4sLLQQQ', b'AVBf', major, minor, new_vbmeta_offset, new_vbmeta_offset, vbmeta_size)
    new_footer += b'\0' * 28  # Pad the remaining reserved bytes.

    with open(output_img, 'wb') as f_out:
        f_out.write(pure_cust_data)       # Write the AERA payload.
        f_out.write(off_vbmeta_blob)      # Append the stock signature block.
        
        current_pos = f_out.tell()
        f_out.write(b'\0' * (part_size - 64 - current_pos)) # Pad the unused partition space.
        
        f_out.write(new_footer)           # Write the new pointer in the final 64 bytes.
        
    print(f"[+] AVB transplant complete: {output_img}")

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print("Usage: python3 transplanting_vbmeta.py <stock-recovery.img> <aera-recovery.img> <output.img>")
        sys.exit(1)
    transplant_avb_smart(sys.argv[1], sys.argv[2], sys.argv[3])
