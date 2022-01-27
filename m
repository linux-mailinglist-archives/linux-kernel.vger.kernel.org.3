Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90B49E3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiA0Nld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiA0Nlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:41:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A627C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:41:31 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y15so5371774lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iXBBEQoOXJnBRxAZr0l1x81N7onumq+bvC/7VZ0Ools=;
        b=bfo3y8+IPT30NTs0E7R2wBFxmnmXBPygTVqTjeZCVWAsRchtm2nbOeIc0mkwMDVOka
         Pa0GRJIn+QBdBAGBuIaYA0juClfPndlprDMqGCtewecn22x+3N5Jv85GCj1zBVqtwDMR
         UEZ7nBY8+8X0ryB8P0c9yhYjJ5mLmUsCEj581daFYhGcJJipQdDxYjPjh68ulw8iE4gb
         pGrmvec0e/TADfH0OYLnfnrddYql6dnp7MeJEyqENmZat/1hHHtq9ZsTYtAHMPqqfnGx
         GiRd9yqpFtu3kGQRTwHDKNfLJ/ySJJ+OEENv3hVDAjSGfzAimxSVZJNkLRtGU4w77aUL
         ooxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iXBBEQoOXJnBRxAZr0l1x81N7onumq+bvC/7VZ0Ools=;
        b=p8KsjwbeQ7dmF2ehrHaW18HIu5uHOE0hU8AZjFBUdW4oZnv8lHZjuAwe7uMkmH8xee
         ilZHiERVUWNWwIFRWP/Fxe/hekZnoSb+NFAaEkrQP/PxG1kN7xMwszp8soMmlU9Bripp
         Ug4BrZzgtVGWGp+7sPCWz6Oh22Ly1sBNW8iQF9DyfRMBH5fPmqAWxtzIAQEunUvX7P1Z
         7nQIjX0ynt74YsGuT5rH+feJ4xeA7EnGsqYoXbuCPzWv1d7I/nSrY6qbrajzZOZResqY
         2p7PKmXb1pQ1BIpQtrjwI1HmuGp8+TQclB6KEgJsy28LcLZA0mnmLNP7WJLfRWdOJKqC
         xowg==
X-Gm-Message-State: AOAM530JxLgTBjxMJha5YRCqPV/nf4jDwLsCEe9zMLcYxa1NxdXot7Lt
        EoYu+c3d457jz3PVKuQh7vM=
X-Google-Smtp-Source: ABdhPJw8wLBdnRj1u4aG7OpkbgsFF8xj0JUXtTkQFPuqNUFrxxArYKz93usMMeBpj3mqNSYMFtlBFA==
X-Received: by 2002:a05:6512:b23:: with SMTP id w35mr2780197lfu.653.1643290889588;
        Thu, 27 Jan 2022 05:41:29 -0800 (PST)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id o19sm710770lfl.259.2022.01.27.05.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:41:28 -0800 (PST)
Date:   Thu, 27 Jan 2022 14:41:30 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.og, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] spi: make remove callback a void function
Message-ID: <YfKe7wmORV/NB6K6@gmail.com>
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
 <20220123175201.34839-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+v5ovSx6NdfX+t2+"
Content-Disposition: inline
In-Reply-To: <20220123175201.34839-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+v5ovSx6NdfX+t2+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 23, 2022 at 06:52:01PM +0100, Uwe Kleine-K=F6nig wrote:
> The value returned by an spi driver's remove function is mostly ignored.
> (Only an error message is printed if the value is non-zero that the
> error is ignored.)
>=20
> So change the prototype of the remove function to return no value. This
> way driver authors are not tempted to assume that passing an error to
> the upper layer is a good idea. All drivers are adapted accordingly.
> There is no intended change of behaviour, all callbacks were prepared to
> return 0 before.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---


>  drivers/iio/adc/mcp3911.c                             |  4 +---
>  drivers/iio/dac/ltc1660.c                             |  4 +---

Acked-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--+v5ovSx6NdfX+t2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmHyoQQACgkQiIBOb1ld
UjKpzw//X302S4XWfBm4ad7jJOQHD3UX9Jh7ivlcRV8k5Fqn6BKDlq50UmSrP1AC
U1KO86IUTq8yOSaPKztHY1SA9mUkXAGom1Pk56fdGbSf9k7f1ILd+n1Cp/U8XaYS
UArOTZHvDuy0LhUkIQfUqqqwbSxw2ibLHC0eFzCibWga+0Fi8cp/wWVwfgLlgL1H
6dOtU9w8y4s2qiyDKFQPqix4SdTcbIw1hV8RR1rmUgpsxzeo7/0JW7ogW5y64K/l
ctTNvWYEcIAofoA+Cu1eZXn2sXhIpd571tXbemzdWN9HgidnECsp+fv2o9JKdHOI
6hM6Rdv4l6ZQAnb8C5uuUmDiqpCDWOIGUlVX/fz4eVJjST+pl/OIJMavtpjzEASb
gHn2kOui8ZxixyUhaNW5k0tL63NVg7VoOfJqx8aP0DKvg34Px9ONX6iWioMZV7zT
FOYZdkJTZHlftmmHZcttEy3w3XxjfrqPhs74viq96k0mRthycfcTry+McLyi6ZyL
RW48Gu/JKfO9cLRw98uxYAd3cTj/jUh2PxPhH0nFE//VNi5QKhlQFjomXysxuXfp
wx5WFlTJrzM04hvwtbMglSuXyqSFqNzxrxfni+Gd1SqsBNwE4d/gBHvswnjV0raa
WbvpDgwsmHhRtOXgH4kzAsXIqva5hUZcrDaBHd9Tpk6rDoys8EE=
=Opui
-----END PGP SIGNATURE-----

--+v5ovSx6NdfX+t2+--
