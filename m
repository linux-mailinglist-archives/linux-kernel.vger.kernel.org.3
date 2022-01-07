Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A972E487688
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiAGLbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:31:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiAGLbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:31:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A132210E7;
        Fri,  7 Jan 2022 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641555091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ZjHiAsPPaO++z4L8pxYEGbs90oQXthjx6sCL5hyEBU=;
        b=b2wMNFDsMFnPwCDeJRTXZL7riiTGsB41hyCGyThb+AuKE8jzQGLN60JL00WYQxCWqninc5
        g5Z4q/VYuHQo06q3vf8Awm392uzUhai4hOHD8k7EOonAk9pXx5R8bRBljPME7xaGSEATDW
        o7v/R7X0q0x3H3hIIsMLwAWeRIZ5/yI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA4AF13CCC;
        Fri,  7 Jan 2022 11:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nFSoL5Ik2GH4JAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jan 2022 11:31:30 +0000
Subject: Re: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges)
 on Arm
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <d594a183-c7be-5fff-da7a-e4c1e707b83c@suse.com>
Date:   Fri, 7 Jan 2022 12:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zxl7OBpx57u7dBEPjP24KfQ9qSnYGWYGc"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zxl7OBpx57u7dBEPjP24KfQ9qSnYGWYGc
Content-Type: multipart/mixed; boundary="bYQWwZXVskXxny1ZB8gcdtLP4a0dOoygv";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Julien Grall <julien@xen.org>,
 Bertrand Marquis <bertrand.marquis@arm.com>, Wei Chen <Wei.Chen@arm.com>,
 Henry Wang <Henry.Wang@arm.com>, Kaly Xin <Kaly.Xin@arm.com>,
 Jiamei Xie <Jiamei.Xie@arm.com>
Message-ID: <d594a183-c7be-5fff-da7a-e4c1e707b83c@suse.com>
Subject: Re: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges)
 on Arm
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>

--bYQWwZXVskXxny1ZB8gcdtLP4a0dOoygv
Content-Type: multipart/mixed;
 boundary="------------FE9D85ECD2D104C4DCB635EC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------FE9D85ECD2D104C4DCB635EC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 09.12.21 21:05, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>=20
> Hello all.
>=20
> You can find the RFC-V3 patch series at [1],[2] and [3].
>=20
> The corresponding Xen support (for both Dom0 and DomU) is already commi=
tted and
> is available in mainline Xen since the following commit:
> 57f87857dc2de452a796d6bad4f476510efd2aba libxl/arm: Add handling of ext=
ended regions for DomU
>=20
> The extended region (safe range) is a region of guest physical address =
space
> which is unused and could be safely used to create grant/foreign mappin=
gs instead
> of ballooning out real RAM pages to obtain a physical address space for=
 creating
> these mappings (which simply results in wasting domain memory and shatt=
ering super
> pages in P2M table).
>=20
> The problem is that we cannot follow Linux advise which memory ranges a=
re unused
> on Arm as there might be some identity mappings in P2M table (stage 2) =
the guest is not
> aware of or not all device I/O regions might be known (registered) by t=
he time the guest
> starts creating grant/foreign mappings. This is why we need some hints =
from the hypervisor
> which knows all details in advance to be able to choose extended region=
s (which won't
> clash with other resources).
>=20
> The extended regions are chosen at the domain creation time and adverti=
sed to it via
> "reg" property under hypervisor node in the guest device-tree [4]. As r=
egion 0 is reserved
> for grant table space (always present), the indexes for extended region=
s are 1...N.
> No device tree bindings update is needed, guest infers the presence of =
extended regions
> from the number of regions in "reg" property.
>=20
> Please note the following:
> - The ACPI case is not covered for now
> - patch series was created in a way to retain existing behavior on x86
>=20
> The patch series is based on v5.16-rc3 and also available at [5], it wa=
s fully
> tested on Arm64 and only compile tested on x86.
>=20
> [1] https://lore.kernel.org/all/1627490656-1267-1-git-send-email-olekst=
ysh@gmail.com/
>      https://lore.kernel.org/all/1627490656-1267-2-git-send-email-oleks=
tysh@gmail.com/
> [2] https://lore.kernel.org/all/1635264312-3796-1-git-send-email-olekst=
ysh@gmail.com/
> [3] https://lore.kernel.org/all/1637787223-21129-1-git-send-email-oleks=
tysh@gmail.com/
> [4] https://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dblob_plain;f=3Ddocs=
/misc/arm/device-tree/guest.txt;hb=3Drefs/heads/master
> [5] https://github.com/otyshchenko1/linux/commits/map_opt_ml7
>=20
> Oleksandr Tyshchenko (6):
>    xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list=
()
>    arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
>    xen/balloon: Bring alloc(free)_xenballooned_pages helpers back
>    xen/unpopulated-alloc: Add mechanism to use Xen resource
>    arm/xen: Read extended regions from DT and init Xen resource
>    dt-bindings: xen: Clarify "reg" purpose
>=20
>   Documentation/devicetree/bindings/arm/xen.txt |  14 +--
>   arch/arm/xen/enlighten.c                      | 132 +++++++++++++++++=
+++++++--
>   drivers/xen/Kconfig                           |   2 +-
>   drivers/xen/balloon.c                         |  20 ++--
>   drivers/xen/unpopulated-alloc.c               |  87 ++++++++++++++++-=

>   include/xen/balloon.h                         |   3 +
>   include/xen/xen.h                             |  16 ++++
>   7 files changed, 245 insertions(+), 29 deletions(-)
>=20

Series pushed to xen/tip.git for-linus-5.17


Juergen

--------------FE9D85ECD2D104C4DCB635EC
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

--------------FE9D85ECD2D104C4DCB635EC--

--bYQWwZXVskXxny1ZB8gcdtLP4a0dOoygv--

--zxl7OBpx57u7dBEPjP24KfQ9qSnYGWYGc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmHYJJIFAwAAAAAACgkQsN6d1ii/Ey/B
fggAguLLO4r4bqWIPJQiFCMQLiM8URWp6RPvi7mzKA5PhOFxx7xnRJT9ocXuoUt+p/PS200k6HuH
OZFN+KDehNmtXK8PtJE+P3/fmCe72Lfl65WOmDtw47JfCgjkUmp4v2aiFL6J0dGxSA8m4NiJkPRt
In/e1ziRq0R318pQm+xzR9S+MLt+Pv749iKSK6ZGS/arXiqFlQ1+iDzcxT2WWS9pwt9aGiHebej1
c2Ybn6RyScqC8ObSU5JotE2llvexMQIm5EmABVskoIj/gT8KQNrhIlQxGqOXtOomi2dn4gyPUjdL
fRBjD83ay8OW+7b6cNtAN2T+jb9w3S0tcCPNkeTs1A==
=OH9o
-----END PGP SIGNATURE-----

--zxl7OBpx57u7dBEPjP24KfQ9qSnYGWYGc--
