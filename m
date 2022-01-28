Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95584A023F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiA1UqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:46:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:53665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbiA1UqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643402753;
        bh=fvBXmchELKFrsBjNEtaycdRKiDfSA5/xZ38kBsQKSDE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=N36qmdIMNhZlgh5vOUl3X2L4LNxEGtfqY8RiftwgiorYR8xl9Yrvy6tuZhPpYCoI2
         SOQB2IACxZ6nVF6dmfXCVvXrMVwQo/Qpz+/fNqzK+v+TWrszN+9ifA0gjWXw8Rv9rI
         zS5oVep8Y3U3w4hiImUakoHwcN7TJ0zVEBH9uCe8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1n9xMg2wLb-005I4Z; Fri, 28
 Jan 2022 21:45:53 +0100
Date:   Fri, 28 Jan 2022 21:45:52 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] scripts/get_abi.pl: Ignore hidden files
Message-ID: <YfRWAP2OoW4t8juH@latitude>
References: <20220128201354.1928412-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cz/6HKNIMjM/vwyx"
Content-Disposition: inline
In-Reply-To: <20220128201354.1928412-1-j.neuschaefer@gmx.net>
X-Provags-ID: V03:K1:qDoSB9yiKMWzI/Ccu/msBD5TQ+MoSjscyGianNiqO9/CneMEMl5
 Tr5gt4ZQaLlSPZneW+WVsiYxoyvpu5QpCTpBsFurxAqdKmeS6Mkwqn6/t9vsSYWxF6SyQgO
 u3vLeGmPmOqsyP9Qy+zp1i9bBjv+uCEOG35Tbo8jeALqkIhdZsO/LmSzYP/RObO2fcacKTh
 hsPm/o+EfAMq0XwbV3v9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DPVQKfcSYHM=:I/AjZnXT6hms8CqUb7dGcN
 BZha3/RYfEpUF86nNTVKclrWmj8Ib24m0C45CtQrTleyQ2IDSa5II/AWL4AIBK8THgQ0rWL6J
 7yi/xPApdcjArjbIAotF9xAkHt58k5S5lky/8k5YuUbrSC6nxHCG46WGSAUjJF/itOBENgTAy
 ZTwf1BQK6cPCzg8ZkV4kKZTILpGzUNvHvu1xdfd3xzMu3yHM25S93EWHCivO2vEW4EVXrifZM
 4Ys0zON7BGFV/Hh4z/Z8ETseeHa2Qjlj50t/aLipx8sA6iAbNgLbVdIQA00hzJs2lZHJcjUEe
 XZb3cV3P1m1r6YO7JSyiTnxBkka4m5BXuf1P2H2jp3PieTUd8YLPrnnY2ddHxhNPXs37oFaCe
 RwHo+kzni6SyU+rGttesOfFe2XVlTWENh32Lcu3x9S7jhe3ryVEeMTslkTVcgOHhZM5dYN8m1
 WUS/6rnplgwAf81nWZ/Sn3GBKuk4cWjCToPb3pwasXEDut9iWy4+cDaunP4mO7yFdv9RGNIOi
 hBeasANRbC+wroANIVlPMtlLEkVVDd+Y3WQcg4K2arxKtuuYsiFBJ+C1L4nPEwlCtszxtHDyb
 H6j7H+jH0ye8yLgbvaEgC222Lg8eJTlwW5vc0raFug7XObKydiUYRtMHfhoeCiaMh1vvTXjx0
 jSZpVRA+13jzPvgorEzUkU+3NVo/yX8D5lgCEDTBj4fP07jkpg3uFvc/LBl1KdVwqm6Pg61E3
 kqci+oOfgU7kIRSAaMMWyS9oRr7AJlPf+F3Ik3fYZv1yqEVB84Mol2erqEaIZJWG8fDqaVdTL
 JINXa60zeGf/6m40/BEWBkb71/4l6Yv3F2eyCkYr5/Dgxg60GJOUohbDix6tBhYKBZaGdG0sO
 NgH3s+rdE0GIvxIbHZ+tP4PbDXJiiZV/XliMf7ybvXgl3glHrXMHEL8gtIkgk+dhK7SVO0T6e
 sv78y8kYPJ2zO+78vtUN6P6e0/f5n89y3l2QETubobNWzat16xufthFerrdJEm8SKC8FKQoy6
 Wwb5MqEhWNYzdwmHAYOv9xtJbNyNCSvTKbq/pX0HbPyNxgxkjEwNeh9lFmnAQfvyiTff84K0g
 jd1IZCvypJTWGw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cz/6HKNIMjM/vwyx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2022 at 09:13:53PM +0100, Jonathan Neusch=C3=A4fer wrote:
> get_abi.pl currently collects every file in Documentation/ABI. This
> causes a UnicodeDecodeError in Documentation/sphinx/kernel_api.py,

Ooops, this should be kernel_abi.py.


> when it finds my Vim swap files (.foo.swp) in the directory.
>=20
> To avoid such issues, ignore hidden files in get_api.pl.

=2E.. and get_abi.pl.


>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  scripts/get_abi.pl | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
> index 6212f58b69c61..47b7eca5b0b71 100755
> --- a/scripts/get_abi.pl
> +++ b/scripts/get_abi.pl
> @@ -92,6 +92,7 @@ sub parse_abi {
>  	my $mode =3D (stat($file))[2];
>  	return if ($mode & S_IFDIR);
>  	return if ($file =3D~ m,/README,);
> +	return if ($file =3D~ m,/\.,);
>=20
>  	my $name =3D $file;
>  	$name =3D~ s,.*/,,;
> --
> 2.34.1
>=20

--Cz/6HKNIMjM/vwyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH0Vd0ACgkQCDBEmo7z
X9tQNxAAnXdfIuXxIdEZ82V4jLuu8T+Ee/q9DTkuPGbgJDmOGwytk+M1dGSoBoHZ
hq6ussdtU/d5p1zEqrFYXd3alN+2NVX/LGxI2XseETLLOtpXk0sOstgn/CgZ1wuw
fTKbgjNdQvegh4fS9Y4fZBTdBGeejRbyB5QP7iCeQZV7YERbglLVIkeqmbm4GWpq
4GF+3YBXsmqjv104aO1SsgJheTx84XEVXRDitWqgb8kq1q0KB4JVyYUYJR7eE3r/
BfxIoA+cZsZs28m4YQIroytFsh2FqUfHAHaSFjmbi/JuCdOe48NP9aWmgk5KlxBd
pdr2/cKnUKZpzC+RlOPCCsKrAHHzlZ9aN6aLJ656R2oeNrRRlA+D2Xbym1INTpa+
tVNu+rPuhnQt23SuX9tSk5nZBErNwJ9t5IhII3MjEuTvKzDy8yWf6dNd62pMYAZZ
G4QvfklUgvcOnOqKe1vpREzuogxDSG0uNQ3VCNWL7us8Z4bxbQ3daLuKLHAn2Z5B
QoIxom0IMOTqe7ESwPORc05dpy5Q7t50n81oyDwVbXzg5kxh+gG8g0tAFR/utwQw
MzW8yfggPnBKB/jU4qR2WoCK1Fj1Q5+4BjPSy0LensNHI0TthhsHGaJFMsQMARsN
a02Dx5zyf3H5Bz+WuIz6/0UuSymv/9BOkJKfIvQxKpgthXMJaws=
=FAiJ
-----END PGP SIGNATURE-----

--Cz/6HKNIMjM/vwyx--
