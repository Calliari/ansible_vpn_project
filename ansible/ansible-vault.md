Ansible vault


Usiong a file as ansible password (`vault_pass.yml`)
Creating New Encrypted Files (manual steps, type password twice)
```
echo 'unencrypted stuff' > encrypt_me.txt
ansible-vault encrypt --vault-password-file vault_pass.yml  encrypt_me.txt 
```

View the content of a Encrypted file with the `--vault-password-file` parameter and the password file`vault_pass.yml` 
```
ansible-vault view --vault-password-file vault_pass.yml encrypt_me.txt # type the 'ansible-vault' password
```

Decrypting file with password from a file containg the ansible password already saved on the machine
```
ansible-vault decrypt --vault-password-file vault_pass.yml encrypt_me.txt
```
