Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6F488FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 06:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiAJFhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 00:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiAJFhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 00:37:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE07C06173F;
        Sun,  9 Jan 2022 21:37:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w7so10915906plp.13;
        Sun, 09 Jan 2022 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XzgijtCVnpWWb3j5iItG13/d5JVIpcL83JQiv8SrL4U=;
        b=fpQIOC9XwhRefOwF8OMBFEc95nRHlXccjoFsoHgDZhgaANuVfyoqLdk05EJPhL3mSV
         aoJLBLEV86Aigy3rSXJc/GpOd1zb301ZwJXmP2A8Ao8Gij6kppAXmY8lp30yue0Tmg4V
         OSaiATcTIQVkxMkp/rwFDb2mrKVWTj/1+uXIUJLm0/kPLA28wvdSiRFd6KISY47SRL8s
         rA4w6jwJpoH/z07TmBFSXWNVbJ0aJQzg1Y/yqNJUahDIH9R/ZofOGa9H4e8mBqpHg/ny
         BpyGbCx/aIjhHJRrjjsrcJpmapY3sQnNBKRTb4KCDEBiO3KfS/Ahx2pNH2outeM1x4xZ
         yo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzgijtCVnpWWb3j5iItG13/d5JVIpcL83JQiv8SrL4U=;
        b=CDEKR+WgtkU+MmLV4/CADJX6XNStj1JemB7Sk7qYOd7skaOAZbjdehZIhRXMyCph0J
         tMcTXvNXuov+TzV1yRmMAqR9s2EN20fSIE+wmEqBoGqqoe+qXj3MoaFRzPyNcNfXI9gE
         hY2+DIxs/ck0vDGy+3sCFId1KagFeRAShhHa8eRAcrmGUg3MzKZ5Po+DQP62O9rPASbU
         4JS0ov4Sy+Lc/c2Ucd3BlqY2d4Qm1aCQsFNiu5oCB+NsUaweBoSM3ExaBPmJ4ZUNjAxN
         tAP/CWjHQxD1aVInZtsXcL30xsuHEpCe7La4WB7W7Sg967qVY0slGReQAw/N2ghultwS
         vW7w==
X-Gm-Message-State: AOAM531S1jhr8nT4Z8Gbn4ayRx0jfazSQcTfOuzj/DG4GcOD5bFWxoaT
        W83bjIgnQXv/rNe/zxEYSEo=
X-Google-Smtp-Source: ABdhPJzmW1fXWA9i1bXgccJWzMMXxot0p+bBuTLZc7rK9tfwPrana8thmUbJGddowe5hON5Jzme5Qw==
X-Received: by 2002:a17:902:e84c:b0:14a:421f:1670 with SMTP id t12-20020a170902e84c00b0014a421f1670mr1091683plg.21.1641793021249;
        Sun, 09 Jan 2022 21:37:01 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id my5sm8435238pjb.5.2022.01.09.21.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 21:37:00 -0800 (PST)
Date:   Mon, 10 Jan 2022 14:36:54 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH] counter: 104-quad-8: Add COMPILE_TEST depends
Message-ID: <YdvF0teoR/ymJJ7e@shinobu>
References: <20220105094137.259111-1-vilhelm.gray@gmail.com>
 <20220109212251.xzwilquctuij5lev@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ANM/I4XkLOKhQBIc"
Content-Disposition: inline
In-Reply-To: <20220109212251.xzwilquctuij5lev@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ANM/I4XkLOKhQBIc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 09, 2022 at 10:22:51PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jan 05, 2022 at 06:41:37PM +0900, William Breathitt Gray wrote:
> > 104_QUAD_8 depends on X86, but compiles fine on ARCH=3Darm. This patch
> > adds support for COMPILE_TEST which is useful for compile testing code
> > changes to the driver and Counter subsystem.
> >=20
> > Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/counter/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index 3dcdb681c4e4..5edd155f1911 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -14,7 +14,7 @@ if COUNTER
> > =20
> >  config 104_QUAD_8
> >  	tristate "ACCES 104-QUAD-8 driver"
> > -	depends on PC104 && X86
> > +	depends on (PC104 && X86) || COMPILE_TEST
>=20
> The driver uses inb and friends. Without looking I wonder if there is
> something like HAVE_IO or similar this needs to depend on for that?
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

If I'm not mistaken, on unsupported architectures include/linux/io.h
will pull in include/asm-generic/io.h which has default implementations
for inb and friends if they are not otherwise defined. It doesn't look
like these default implementations are guarded by a Kconfig setting so
we should be fine in this case.

William Breathitt Gray

--ANM/I4XkLOKhQBIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHbxfYACgkQhvpINdm7
VJLyVBAAoJe+migjeZDIOiRWJUsmvSxd9df68w7iRU2LfCGeoX+kDWx9txgsnWyD
MjBzxiILN+I20JxtG+TOZDLfGkN74s8kBnE+tnPp4YEnFtpCbJ1atk5VF1pS82g9
+Ki/RBEVILRM/HsA0Ej/7HbeoQQYp0QO/rSYRvQlp980f6uVeIoHt29DCyGXuzfK
fQEmIrlwC2Tlz/tVmK+ZdHB9Cvo11labhayeuUWt7LSZMIw7Covi3aJBraQPvw1P
/bPEYBTql6Xq0qGsq8jRjWQi0ObU85w+ZxItPEcP89P7ik0GU3O270NSolhEnQpm
1I8w8bgZ1sKc30xrvNHtkSgkEvpfgAgLweRnIPWoYpPZLYrww92lTPwMGwgDYlef
KxF78ljboTCbQfwizDbKVESolRfkN5bHKOVXhpswoN3wWdgpXnqX4YkCizjiB3rH
OxXGHgpk9PiecxP5pyLs/hiT681FEf9k5x4t9uH5zUXoEzFTybYnZfdWYRxzhCdn
JxuD6toO5Xu1b0v84hRD9u3p1XBI1HMC3NqRer8ePJjXcsWegCQ71t8/MS8U1G2G
3y1AKma8Mjx4O7vmA1uPsWumSp8DysdsnK56L11M16W2QsLk4ha4oCbuTwqyg1bN
0aIk0bF5y2jVMCRgnrEdgrKVEMK8gta2LhrpK+FZdJOijXds1zg=
=ll8+
-----END PGP SIGNATURE-----

--ANM/I4XkLOKhQBIc--
