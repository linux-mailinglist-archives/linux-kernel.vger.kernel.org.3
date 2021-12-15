Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF234754B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhLOIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:55:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34356 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhLOIzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:55:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4299121107;
        Wed, 15 Dec 2021 08:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639558540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rA2PPHimPqd2WGEoLE7pNkyE+Am9co0F2w1XVXqv7Zk=;
        b=S/GwLbmn3qKwx0KN9nxLxeqVEdiGo9YQqSxP/vTa38UIOXKGLMcUk65NXIHaOizghBafKF
        8YiX1plzZAoUS6fYVtEsC46Hz1kzC/DzSRDSRe7mNkUd1Wd+fA0NVz1sdMe2xmqpB1rD0a
        jO/lRnADuribuIzpcfJrOQW0sz92gaU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BEE413A6B;
        Wed, 15 Dec 2021 08:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fr2CBYytuWE6QwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Dec 2021 08:55:40 +0000
Subject: Re: [PATCH] xen/pciback: fix typo in a comment
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20211212032408.52180-1-wangborong@cdjrlc.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <68aa97ae-dd76-5879-3dba-a08c3581f25b@suse.com>
Date:   Wed, 15 Dec 2021 09:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211212032408.52180-1-wangborong@cdjrlc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MtKaboN7PRCVbLi20XvpiHLMkP7wJh3Dt"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MtKaboN7PRCVbLi20XvpiHLMkP7wJh3Dt
Content-Type: multipart/mixed; boundary="GorFHiUnBwJkF0gcj3A7cXL8s8u8YTG3J";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jason Wang <wangborong@cdjrlc.com>
Cc: boris.ostrovsky@oracle.com, sstabellini@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <68aa97ae-dd76-5879-3dba-a08c3581f25b@suse.com>
Subject: Re: [PATCH] xen/pciback: fix typo in a comment
References: <20211212032408.52180-1-wangborong@cdjrlc.com>
In-Reply-To: <20211212032408.52180-1-wangborong@cdjrlc.com>

--GorFHiUnBwJkF0gcj3A7cXL8s8u8YTG3J
Content-Type: multipart/mixed;
 boundary="------------FB1518124BAB239808CC7C2F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------FB1518124BAB239808CC7C2F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12.12.21 04:24, Jason Wang wrote:
> The double `the' in the comment in line 163 is repeated. Remove it
> from the comment.
>=20
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/xen/xen-pciback/pciback_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/xen/xen-pciback/pciback_ops.c b/drivers/xen/xen-pc=
iback/pciback_ops.c
> index 3fbc21466a93..e38b43b5065e 100644
> --- a/drivers/xen/xen-pciback/pciback_ops.c
> +++ b/drivers/xen/xen-pciback/pciback_ops.c
> @@ -160,7 +160,7 @@ int xen_pcibk_enable_msi(struct xen_pcibk_device *p=
dev,
>   	}
>  =20
>   	/* The value the guest needs is actually the IDT vector, not the
> -	 * the local domain's IRQ number. */
> +	 * local domain's IRQ number. */

When touching this comment, would you mind to correct its style, too?
It should have a leading "/*" and a trailing "*/" line like e.g. in
line 72 of the same source file.


Juergen

--------------FB1518124BAB239808CC7C2F
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------FB1518124BAB239808CC7C2F--

--GorFHiUnBwJkF0gcj3A7cXL8s8u8YTG3J--

--MtKaboN7PRCVbLi20XvpiHLMkP7wJh3Dt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmG5rYsFAwAAAAAACgkQsN6d1ii/Ey8x
mwf+ISB1pg5TvxP1/6a20M2SKwjPP+lmaGU3qJ9bCJidSAUBQgbvJj+sq/r5LWnrEdD9i7IlAj9K
JUfRRxnrDwWHUW5OO89hvhDnN1zG1pMJam6dQH76VP4nrtiYOR1pOQMIj3dkAP/iKOvFl+b9wNrJ
foiq3OYM+Gu/KPX5H3JHU2GM98EdGT0+wMDjrc+vlSwMBvG+zEgRVX5kso1f49EuS2+Oh2yEytdR
U/NfwdKfPoqLt7EacFdaXP5uWdqEs4YFZXh+MVgNV4X8ZmSXt4JrW70DVZjAfmQnifriVWZOaB2e
9Z7pXr3Ahy9yox29XewCMgTDXTfT2jzIt/KfZQIj6w==
=UUpl
-----END PGP SIGNATURE-----

--MtKaboN7PRCVbLi20XvpiHLMkP7wJh3Dt--
