Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2448AFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbiAKOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:49:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:26492 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbiAKOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:49:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220111144931euoutp017c61f93e95ae727b39fe2ca9a3942953~JPsi9hgGB1643016430euoutp01z;
        Tue, 11 Jan 2022 14:49:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220111144931euoutp017c61f93e95ae727b39fe2ca9a3942953~JPsi9hgGB1643016430euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641912571;
        bh=rI0jF1+gw7Mi1ZYnk9EKut/wbj5ldZkbbhSeA9GHrlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXszf5/lY1yYY/MWUa99lzOxJf/6Lr/9AdRk1Ng4ShiES6yNXMLPjsa6r+BTjKLOa
         h7wmyBZ+g+B01B8edVxEfxeS/q0Na3aqt347k8CLAsi3DjUdITsmsX811bH4/iU3YI
         TCe+iA/rkClfRc8qmj6CQhZuHkysvV5Wyj6IDK5c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220111144930eucas1p2fc5d22af34d0e26398f58d6ae299e618~JPsizuqVP2832428324eucas1p2H;
        Tue, 11 Jan 2022 14:49:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.52.10009.AF89DD16; Tue, 11
        Jan 2022 14:49:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220111144930eucas1p1d538f02d731983b1cd1b56472163eda4~JPsib6aD71250812508eucas1p1o;
        Tue, 11 Jan 2022 14:49:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220111144930eusmtrp2e04b3ccf6ab62397be424b6d47f5c9cf~JPsibIdMx0347903479eusmtrp24;
        Tue, 11 Jan 2022 14:49:30 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-65-61dd98fa65b8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C6.A1.09404.AF89DD16; Tue, 11
        Jan 2022 14:49:30 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220111144930eusmtip2d5cc5d1ed83c9a9de793fab32226ddae~JPsiQZodF2525125251eusmtip2G;
        Tue, 11 Jan 2022 14:49:30 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] media: s5p-g2d: Use platform_get_irq() to get
 the interrupt
Date:   Tue, 11 Jan 2022 15:49:06 +0100
In-Reply-To: <20220111002314.15213-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
        (Lad Prabhakar's message of "Tue, 11 Jan 2022 00:23:12 +0000")
Message-ID: <dleftjtuea8h0d.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87q/ZtxNNFjeoWfxcsJhRouLM++y
        WGx6fI3V4vKuOWwWPRu2slos2/SHyeLl/RXMFn1v1jFbtO49wu7A6bHyxWx2j52z7rJ7bFrV
        yeaxeUm9x+dNch6nvn5mD2CL4rJJSc3JLEst0rdL4MrY+3oSc8FF4Yo93/azNzCeFehi5OSQ
        EDCRmP/2IHMXIxeHkMAKRokrh/dDOV8YJbp7N7NCOJ8ZJWY/amaDaTnS+IwVxBYSWM4o8fGs
        CkTRc0aJrZOvARVxcLAJ6EmsXRsBUiMiYC3ReW4PO0gNs8BeJomF63qZQRLCAtESc7/MBBvE
        IqAqMePIDyaQIk6BfkaJFYvOsYAkeAXMJS6eesAOYosKWEr8efaRHSIuKHFy5hOwGmaBXImZ
        598wgjRLCPRzSiycc4MZ4lQXiW/fzzBC2MISr45vYYewZST+75zPBHKphEC9xORJZhC9PYwS
        2+b8YIGosZa4c+4X1MuOEqubv7JB1PNJ3HgrCLGXT2LStunMEGFeiY42IYhqFYl1/XugpkhJ
        9L5awQhR4iExrZ8fEm4LGSXWnk2cwKgwC8kzs5A8Mwuog1lAU2L9Ln2IsLbEsoWvmSFsW4l1
        696zLGBkXcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYtk7/O/5pB+PcVx/1DjEycTAe
        YlQBan60YfUFRimWvPy8VCUR3rKYu4lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQn
        lqRmp6YWpBbBZJk4OKUamKLiIp01JE6UyPkt1LNQNW1hsdXtE7n3qUrU90nUp9weabXJnFab
        mLSaLcrCEptbRTw42nSFL0/ff8v+7PUfuf8cP8Z0r+zYzipU/1F8+a7HZs/7nYL3C8xYejT3
        6DLeD2v3Fjywvb0v6uyuTLHN0cVTIx4++2qlYCJ1/L24p8QHMbOJs10m9ZVGG3ZU/Xrc1mB2
        vu/jPqe0PQkflnpvnFYr6ftk6r1bH0Oaw0qKrtk/e5HPefXH9fKJXdfytkp3iYe2r+qsmvqh
        OT4qPEGx8di8aOOnpsJLFfeUzKi6+j/j59KUV1eWLypW69/7gLW6tkpsz/9y2UttT/9+epr1
        O4/RXXDb9YtPdXj2SHhmK7EUZyQaajEXFScCABqTBRLWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7q/ZtxNNGhYJmXxcsJhRouLM++y
        WGx6fI3V4vKuOWwWPRu2slos2/SHyeLl/RXMFn1v1jFbtO49wu7A6bHyxWx2j52z7rJ7bFrV
        yeaxeUm9x+dNch6nvn5mD2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0MvY+3oSc8FF4Yo93/azNzCeFehi5OSQEDCRONL4jLWLkYtDSGApo8S6
        M42MXYwcQAkpiZVz0yFqhCX+XOtig6h5yijRcv4IE0gNm4CexNq1ESA1IgLWEp3n9rCD1DAL
        7GOSuHujiwUkISwQLTH3y0xWkHohAV+JxpfuIGEWAVWJGUd+MIHUcwr0M0qsWHQOrJ5XwFzi
        4qkH7CC2qIClxJ9nH9kh4oISJ2c+AathFsiW+Lr6OfMERoFZSFKzkKRmAa1jFtCUWL9LHyKs
        LbFs4WtmCNtWYt269ywLGFlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbdtmM/t+xgXPnq
        o94hRiYOxkOMKkCdjzasvsAoxZKXn5eqJMJbFnM3UYg3JbGyKrUoP76oNCe1+BCjKdBvE5ml
        RJPzgekgryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBaV98rtci
        QxHXRz8OaOQyN66XXrIkUt1GSqyxSL5aNletYtmiu0kn/1f0Gs9pKli97/mkiOuyRcohTyW7
        EzZcenzMTTArRXVi4wPOTatnx13azWFmqpI78aHk0WuGU5xLFWwjV+1Z5RT0IP/eSQkD3VMZ
        Ospb/+d0NUjOvuuWOv0Xh+ie1KhS84hLP3cnza6XXtKfxPWOOfhj/JM9T1P/GH75tnKxVV6b
        ++nosg2J1W/uX7/l+H1t8vVYu6bfbQUZ03m5+R2O9ikKJHQ9U/s9qebNtw3L62bcmHtA44tR
        5PU0ltyvHDO9kz/tKndsmMcQMD+qSWx+3fS4o7VuxbElJ+tNmRwb1fe+jeYyT5ZQYinOSDTU
        Yi4qTgQAMepTl08DAAA=
X-CMS-MailID: 20220111144930eucas1p1d538f02d731983b1cd1b56472163eda4
X-Msg-Generator: CA
X-RootMTR: 20220111144930eucas1p1d538f02d731983b1cd1b56472163eda4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220111144930eucas1p1d538f02d731983b1cd1b56472163eda4
References: <20220111002314.15213-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <CGME20220111144930eucas1p1d538f02d731983b1cd1b56472163eda4@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2022-01-11 wto 00:23>, when Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * No change.
> ---
>  drivers/media/platform/s5p-g2d/g2d.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>

Acked-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

> diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platfor=
m/s5p-g2d/g2d.c
> index fa0bb31bd2b9..dd8864779a7c 100644
> --- a/drivers/media/platform/s5p-g2d/g2d.c
> +++ b/drivers/media/platform/s5p-g2d/g2d.c
> @@ -623,7 +623,6 @@ static int g2d_probe(struct platform_device *pdev)
>  {
>  	struct g2d_dev *dev;
>  	struct video_device *vfd;
> -	struct resource *res;
>  	const struct of_device_id *of_id;
>  	int ret =3D 0;
>=20=20
> @@ -664,14 +663,11 @@ static int g2d_probe(struct platform_device *pdev)
>  		goto put_clk_gate;
>  	}
>=20=20
> -	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "failed to find IRQ\n");
> -		ret =3D -ENXIO;
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0)
>  		goto unprep_clk_gate;
> -	}
>=20=20
> -	dev->irq =3D res->start;
> +	dev->irq =3D ret;
>=20=20
>  	ret =3D devm_request_irq(&pdev->dev, dev->irq, g2d_isr,
>  						0, pdev->name, dev);

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmHdmOIACgkQsK4enJil
gBCanwf6Aru4u2Ip5vQSlbsLmuYJXeqaKjnZarh/si7gSktxJKWL9tl+cfJlVnq6
vcsePMsFPuHU/nkLTgJRNnKXaM/nkftkZfsZ42rZ9yQe3iD2C8qeZFsLiF+g4jlR
CDn+M0YYM+aLgWqj+MotiX/ZHzouMGepc8P/9N2KyV84T1BVWKAFVXZEJFBk8oh0
7HO0nuFsTiX9jA1QBGFc3mIasm9xRWqfHt93g3YyEKZr9vomGLNhbGGdjlA03pts
ZXrx9vXU5aLRXQWvwbkFY2wp6Rny8kQBEeqrratzVL3roNHWDKHnv/Z+H3dm7vhz
XNToe3GrDtW9mLwdSrt7oA5NTURIsw==
=7fYZ
-----END PGP SIGNATURE-----
--=-=-=--
