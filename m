Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B033A465E18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355720AbhLBGQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:16:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355700AbhLBGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:16:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CB52212BE;
        Thu,  2 Dec 2021 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638425573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PoHxH+44BVmQxV5StpyJtBKJQ6b18O343WAGNo7xpu4=;
        b=QxcuKPLlhBOYjqMoxMu9oUKMyvifbvVJlHyE3jKEW5UGA42eRXO48W3J25IBX3DFsdPI0x
        aoHstQUDTMO6jZeLSN7Or6gKVcZjU6fPwe6GjTKt+CaPeqsOr3Yssx3q1F3VsNQClvdoI0
        PnS5vd2zhFgWM1+oBblZyuz39IwZkS4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86CF813DFB;
        Thu,  2 Dec 2021 06:12:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pWBwHuRjqGE4HwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 02 Dec 2021 06:12:52 +0000
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
Date:   Thu, 2 Dec 2021 07:12:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AfdMuwUczXW0MKITwWVq4jy42wC20ICQg"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AfdMuwUczXW0MKITwWVq4jy42wC20ICQg
Content-Type: multipart/mixed; boundary="pQIE5E6xcpkHUkTK3irWuIH6aIHhgRqRR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 boris.ostrovsky@oracle.com, sstabellini@kernel.org, roger.pau@citrix.com,
 axboe@kernel.dk
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-ID: <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>

--pQIE5E6xcpkHUkTK3irWuIH6aIHhgRqRR
Content-Type: multipart/mixed;
 boundary="------------90B5D640AB7801A38E7FE002"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------90B5D640AB7801A38E7FE002
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 01.12.21 22:10, Christophe JAILLET wrote:
> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid =
some
> open-coded arithmetic in allocator arguments.
>=20
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
>=20
> Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/block/xen-blkfront.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.=
c
> index 700c765a759a..fe4d69cf9469 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -442,16 +442,14 @@ static int xlbd_reserve_minors(unsigned int minor=
, unsigned int nr)
>   	if (end > nr_minors) {
>   		unsigned long *bitmap, *old;
>  =20
> -		bitmap =3D kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
> -				 GFP_KERNEL);
> +		bitmap =3D bitmap_zalloc(end, GFP_KERNEL);
>   		if (bitmap =3D=3D NULL)
>   			return -ENOMEM;
>  =20
>   		spin_lock(&minor_lock);
>   		if (end > nr_minors) {
>   			old =3D minors;
> -			memcpy(bitmap, minors,
> -			       BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
> +			bitmap_copy(bitmap, minors, nr_minors);
>   			minors =3D bitmap;
>   			nr_minors =3D BITS_TO_LONGS(end) * BITS_PER_LONG;
>   		} else

Shouldn't you use bitmap_free(old) some lines down?

> @@ -2610,7 +2608,7 @@ static void __exit xlblk_exit(void)
>  =20
>   	xenbus_unregister_driver(&blkfront_driver);
>   	unregister_blkdev(XENVBD_MAJOR, DEV_NAME);
> -	kfree(minors);
> +	bitmap_free(minors);
>   }
>   module_exit(xlblk_exit);


Juergen


--------------90B5D640AB7801A38E7FE002
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

--------------90B5D640AB7801A38E7FE002--

--pQIE5E6xcpkHUkTK3irWuIH6aIHhgRqRR--

--AfdMuwUczXW0MKITwWVq4jy42wC20ICQg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmGoY+MFAwAAAAAACgkQsN6d1ii/Ey9C
GQf7B6nQsjmwuu6nmhJBkobL+EuHIRbd8Q+Fp4t1UNVICF9LvicwjotgNHBHo0LRRxq0vWn6E8td
31rc+lkllzJ5oDo2gsFTbgZxPXc83NA0MTPygu+E1bKQNOUhJqKtgryvIoeWAl4/VAu4f4RhFVPI
0F/GLXISo/1UXVO9Yk/aokmFHIK5RR/vzuTc3XPhbsNiIjIydv3ba2Wa5UXqsp8bN5vi3+HQp0hu
Wxgsdluph/jEidWDVWFQHj2namNURRXFhqJA2ImwE5e0aHs4Yfd+RAAF437L+zSDtX549zo0HONd
HGVya/rFi+QEWNCaDpq4FoN6JafAsS+P56dgQq+x6Q==
=QD8J
-----END PGP SIGNATURE-----

--AfdMuwUczXW0MKITwWVq4jy42wC20ICQg--
