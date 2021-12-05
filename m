Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C390468D67
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 22:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbhLEVIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 16:08:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:35883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238875AbhLEVIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 16:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638738277;
        bh=2EiR9uztq5PPUQGQMlP2ON2JLL/nRNGYU5rWdoLEwWw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OaHawuy2t5kaM9mbk5sdN+9sRXAy1Zo88gVByzhO97s6rxy7OAEekFUqCMtbQ9RkD
         oiUyda1TrjqVYVLk6+XYZhRhV1aaLpz8JecB5u1KAlz4dLzv/fCIYdLMlhkPg1khlW
         ind2pXQbP2S6U+/TS5LlcxvSgSgP98v/zNlwU9ZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.79.181.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1mhHKJ3rTH-00wCDS; Sun, 05
 Dec 2021 22:04:37 +0100
Date:   Sun, 5 Dec 2021 22:04:32 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Sort entries using parse-maintainers.pl
Message-ID: <Ya0pYDo4y+xep0mt@latitude>
References: <20211204175255.1361385-1-j.neuschaefer@gmx.net>
 <429227f33cf14aee6f0668a3d98aa220b54383d6.camel@perches.com>
 <YavGALvWdsW+BO9w@latitude>
 <2ced60214ef3bf449e27f5cb22d3dbd0863d97bb.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoHzLUV3LJH+BrCl"
Content-Disposition: inline
In-Reply-To: <2ced60214ef3bf449e27f5cb22d3dbd0863d97bb.camel@perches.com>
X-Provags-ID: V03:K1:PhZ4tw/H9ePRhscbicnUsMdrcXSnYY06gDhFgzuHpA0a5Cjj2kA
 rLBIOZaponC1XSul20z0Kdmpfq6QCzZ8QwnAyH3UGUiq5XeMdAYkdi0PNQ3DztEJNzu/AVV
 ix2OqSLbYbHFjIkBgHmhsyfh6JKxPEN1qCgipVSjqkZTnxJSmpClah/ppjExfTaM+h0av/H
 LgPlnRmubmwBlQ2KUhiNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3hm/iNrAKVU=:Vl8MyXijyaCqYz6YHI3y+p
 AY3h1AzshH4MCQ58kzYCBSL/DL5Bw5Hq9QYGRjTvKZzuOZbRoAsdG6kAfG8QGjmcQYev0c4pg
 3sEMNN6vj116NZsYtxWJYbFx5UnJyJZ4ewpP8ikpf6dozfd1y4ZxcH143Ls6gqM9XKAXzi5jR
 ZeNW6VbM+H90AESh5fNIBwWK79py3u8AKrzahF7D0aCaiUMEleuRWUfQO1k4KBTfQc10soY7J
 sjq6N5eyeIG3NlP1AV2ltNX6PEaReGFgsWnDZcKjtcL9c7SVRj6OGO8fOgIZpG6ZB0QSTKTyU
 KnFG2E7SNBiYnHDPuc7wuzvV69fg7WNhlgZV4AmmJONcQvN9807RQ2F+gMID4LO0ovtvDB1Za
 S2DvqNN3OO79FdkTHvPMuKYA0n77M7SUFfplvEJ9omWfOGmIvBRO0Dvm5xRTyzdscTOMJeFIl
 joRgSdNYD2PsR3THeYgSL02+WDy2d1+sfSqCZuHEO0H1CUVL/IiYx1uHITVIv4kPPSpPDaZKV
 10t00uds1YYTJeXVvCyWV5W+z853HyALTYkUI2Z0WYqJARaRwGKxpyUjIoiAjTbXDJcmto60X
 3aJ/F3fZEwwi7+y2f2a7WORPxFWPd7U4VTh6rsK6ZcHB7NQXIAL+vV/hw2x83yw9Vgfk9zqzx
 jWrdFWWg3As2LGAxK2wTMMWzIeYl6C+blVLTdHn0o16S01SPAc5ytbKXcKw877JHlD0aSFPj3
 ZpoYGZSb3Ky8O+UXXhtbleyb3PIe5IYA2N2oJXOzjAfTdildwiJ57XJ2WvP+2JnDnbCyJZVyD
 JMDEsEhSKmXGhnCtO1pmlUbnx4drB6B5Nvy5ktp/XyGoZNfnfmBTHIJ247oPEPiGUNaFFrIzA
 yb9o/uxmgglqHc3m6ikyhGqgMD7AbOX0X05qZ3jlfpmkef4H9B9E8fHvcKd1XYqglZPqwTzLx
 A9apD/VKfQOg7mJej5brOw6v3zIbYf1zccNoqZQG54xXsy+TdOHp8/L+wq2WrrwscOpg0+LKL
 5ZV+ekdyghnT+19Ym5MvWekvKXYSs7QcKtqU5Mj0p9JT2ZVIrsTE3gCR6NvkPdM5Tu+RW0khQ
 ahN/fGrsitUaT8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoHzLUV3LJH+BrCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 04, 2021 at 02:34:36PM -0800, Joe Perches wrote:
[...]
> My preference is still to automate the running of this command
> by some script and apply it just before every -rc1 is released.

I agree, that sounds good.


Jonathan

--hoHzLUV3LJH+BrCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmGtKUEACgkQCDBEmo7z
X9s/Vg/+PlE3o0SYOVcyRLX6QJh9DJsF0qW7BG51u0fRqrc1+XagLg2FmnVS/GGX
z/1UZvqMxR4Yn37mumoldzwOMeKlOf07YCrJEyw9gaZMb9QcIQZl8eIXsy/2Isr8
jHw4n0RdQbI2yWn2tYZrtCyG/Uk9MAdOUGNYZRY+Byv8dTBXQVdeFJBW0yZ+6lc5
IM6xPdJuOnFw6NG5+jC/7oSvueD1DBF9JkbDYUAfEBLr4kLEn8DcNBwrECOuEUnE
Nf/xQyyMkLKdQRVcF22hQpD78vPZ2VroAs9BLC0jyIH8RKboxbLNwW12aEiSqXQf
/ej5EQs1t4PB3X3PMFNq7Q4S4EbfT6VnygNNIOQLBOUHehBTqNmrtH9kzenVctf8
HkzDXlBWSMYSLIssIxdotjvJa3BylZQCch9ov6Fsp92dYYVZaxAwc6QiEkbuLTHP
OgpelzY28RTNUhtDQ2zOw4rzdu99ZtARg6v84iHI1c5kv676eH9DYkEYBp6rimfE
8Qrfz9vDwuh/6nwhCeFlL3CSTq5kxN5bWHr5BUuaJgRqU6nujO9nfb21onkXy/BS
anRrYMQEJObYEESR2qvfsvhDclhKp4rwhxHO8KD31ahJ/IcL+jUmDli9og5JdkRf
339NVS8tfN6c/hEdzd+bvurPNTOcxSVT/RsMptNC6+BDq9svXXo=
=jMEx
-----END PGP SIGNATURE-----

--hoHzLUV3LJH+BrCl--
