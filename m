Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9997542E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiFHKre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiFHKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:47:24 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3371B435E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:47:12 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220608104705epoutp04e19b0fab2e839e6c0af8b1d1deefc649~2n3Ir3qzh2679726797epoutp04k
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:47:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220608104705epoutp04e19b0fab2e839e6c0af8b1d1deefc649~2n3Ir3qzh2679726797epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654685225;
        bh=2dU2sAdbeia4z93Pb2uYez3kPuHX+7BlUxRqxtHkiAs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=qgYRb+ZrRqFuQSInwWyUk62zNGe1Yf87tnux7uBicxQoZZgm6o4sFRaGhv2l5v6lx
         7Hg84f9kKlzQeabPJ7JqmSQ5gHqw99Lo9GMybtrYd8d4mfpGDi7HdhjHvXiGlP1Evn
         CibUp4GiVT1VJohlZw53PyixEv61g+33cxqEKTHs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220608104705epcas5p1d694985714f56d9701f4aee5fe1ad881~2n3ISYSxZ2064620646epcas5p1-;
        Wed,  8 Jun 2022 10:47:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LJ3nf3cXjz4x9Q5; Wed,  8 Jun
        2022 10:47:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.6E.10063.62E70A26; Wed,  8 Jun 2022 19:47:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220608104702epcas5p2525c59a62b884ba03a6671aceedd68a0~2n3FJIfKF1979619796epcas5p2F;
        Wed,  8 Jun 2022 10:47:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220608104701epsmtrp20c59c4ee5bc6ad00878ece679a57263f~2n3FHjN-z1680016800epsmtrp2M;
        Wed,  8 Jun 2022 10:47:01 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-6d-62a07e2673d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.3D.08924.52E70A26; Wed,  8 Jun 2022 19:47:01 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220608104700epsmtip27683496ebe4e7dc62ecbe5ac68ce4329~2n3DnBg_e0534805348epsmtip2R;
        Wed,  8 Jun 2022 10:47:00 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Colin Ian King'" <colin.i.king@gmail.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andi Shyti'" <andi@etezian.org>,
        "'Mark Brown'" <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Cc:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220608081912.2083086-1-colin.i.king@gmail.com>
Subject: RE: [PATCH][next] spi: s3c64xx: Fix spelling mistake "hannel" ->
 "channel"
Date:   Wed, 8 Jun 2022 16:16:59 +0530
Message-ID: <015701d87b25$15c75120$4155f360$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKhUm8gmV47Tzdc05Wc3hzH2R1CbQJXQw5aq6Dq7IA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuq5a3YIkg5mfxSwW/3jOZDH14RM2
        i0ntX1gttt6Sttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxc9Zddo9NqzrZ
        PO5c28PmsXlJvcfnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjPeTnjMWvCAu+JQwzmmBsZ5XF2MnBwSAiYSr8+uZAWxhQR2M0rs
        umTdxcgFZH9ilHi7fwULhPOZUeL3u2ssMB19X+4xQXTsYpR4v1ITwn7JKPFvuxeIzSagK7Fj
        cRsbSLOIwEImif5L99hBEswCrhJ3ztwDW8cpYCfxpOErmC0sECoxe+N+sBoWARWJaa8nMILY
        vAKWEi8/QCzmFRCUODnzCQvEHG2JZQtfM0McpCDx8+kysDkiAlYSH/+0MUPUiEu8PHqEHeQI
        CYGlHBJnvn1lh2hwkTj6ejUjhC0s8er4Fqi4lMTnd3uBruYAsj0kFv2RgghnSLxdvh6q3F7i
        wJU5LCAlzAKaEut36UOs4pPo/f2ECaKTV6KjTQiiWlWi+d1VaLBJS0zs7maFsD0kpi+8wj6B
        UXEWksdmIXlsFpIHZiEsW8DIsopRMrWgODc9tdi0wDAvtRwe28n5uZsYwelVy3MH490HH/QO
        MTJxMB5ilOBgVhLhlQyfnyTEm5JYWZValB9fVJqTWnyI0RQY2hOZpUST84EJPq8k3tDE0sDE
        zMzMxNLYzFBJnFfgf2OSkEB6YklqdmpqQWoRTB8TB6dUA1MOr7bGdHXnki8Pei+6LL94X76r
        y9lt4Vexwlvqu5mibxhs2tN4/3iL279V8Ryfr+zdpMH1aJvEDQO/zAcNOTvOqmsUWNhX9DSd
        tLhoMSNzdllOvGla5SLBVO2rS1neGPx9LibUyLnp0fpol6/xnOceP1nCFpOfEioYVWDPlbLX
        MPby8kDWR09lQw11Dvyf/7NX8/G2l/87yjg7DZfkMRt9tvN2jTK3k1nAzvdWed5T7zMsz/J2
        ztL0fTXzNeurUyxbdux40b62fPbUlfNmn3x4UdHqb9x02epF8UYnp3FZv/4g29NywS58p5me
        dSYvV0gW57w9D+Xs4qbwqPxU3bVJKvpzSP6k2mcPX87XiFNiKc5INNRiLipOBADnpYV8OAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvK5q3YIkgwsvTC0W/3jOZDH14RM2
        i0ntX1gttt6Sttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxc9Zddo9NqzrZ
        PO5c28PmsXlJvcfnTXIBbFFcNimpOZllqUX6dglcGUs/dDIVzOau2H3zIlsD43XOLkZODgkB
        E4m+L/eYQGwhgR2MEjd380PEpSWub5zADmELS6z89xzI5gKqec4o0f98ClgDm4CuxI7FbWwg
        CRGB5UwSW/+uZwZJMAu4S0xr2skI0dHPKPH+5lZWkASngJ3Ek4avYLawQLDEjKfXwWwWARWJ
        aa8nMILYvAKWEi8/XGOBsAUlTs58wgIxVFui92ErI4y9bOFrZojzFCR+Pl0GNkdEwEri4582
        qCPEJV4ePcI+gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl
        5+duYgTHmpbWDsY9qz7oHWJk4mA8xCjBwawkwisZPj9JiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqZ5l7c+Kev4WfY9VancOnXJ+anLkxo2ZKUKu/2z
        XNbqHbd9idcEts9pHxO9m4JPuXZ8LZd549l76xo709pZtzcee/rDPnmz8d/C2iflv4/uvySR
        dO7VrCX774eei595WfRgNc/Th62XKuLl1XqmdV+Ys7Kift/knGqu/8xMT41X/rwd9Vy2xU7v
        9ZutkxxNMk+HvVu/ZKvig6dv3svkWt+OC935aWqAWdwvV1/2C0vyHHPfJMvZz7vx4u/KjhtZ
        Wz7LX5j2yOlDyk1lzZLWY9GJ/4wPnv+kszTmyouiTZ7ZYjckzrFc3ramR//z3Zjp85n2+y1d
        +iRQ+MSm1Es79VcLLXP0scm4vu3qRoepLBeZWpRYijMSDbWYi4oTAXaoUDwkAwAA
X-CMS-MailID: 20220608104702epcas5p2525c59a62b884ba03a6671aceedd68a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220608081916epcas5p2c35a76a868edcb8ec14d3a83edb00ee6
References: <CGME20220608081916epcas5p2c35a76a868edcb8ec14d3a83edb00ee6@epcas5p2.samsung.com>
        <20220608081912.2083086-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Colin Ian King =5Bmailto:colin.i.king=40gmail.com=5D
>Sent: Wednesday, June 8, 2022 1:49 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>; Andi Shyti
><andi=40etezian.org>; Mark Brown <broonie=40kernel.org>; Alim Akhtar
><alim.akhtar=40samsung.com>; linux-spi=40vger.kernel.org; linux-samsung-
>soc=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org
>Cc: kernel-janitors=40vger.kernel.org; linux-kernel=40vger.kernel.org
>Subject: =5BPATCH=5D=5Bnext=5D spi: s3c64xx: Fix spelling mistake =22hanne=
l=22 -> =22channel=22
>
>There is a spelling mistake in a dev_err message. Fix it.
>
>Signed-off-by: Colin Ian King <colin.i.king=40gmail.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

> drivers/spi/spi-s3c64xx.c =7C 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c index
>82558e37c735..f56d9c819a76 100644
>--- a/drivers/spi/spi-s3c64xx.c
>+++ b/drivers/spi/spi-s3c64xx.c
>=40=40 -360,7 +360,7 =40=40 static int s3c64xx_spi_prepare_transfer(struct
>spi_master *spi)
>
> 	sdd->tx_dma.ch =3D dma_request_chan(&sdd->pdev->dev, =22tx=22);
> 	if (IS_ERR(sdd->tx_dma.ch)) =7B
>-		dev_err(&sdd->pdev->dev, =22Failed to get TX DMA hannel=5Cn=22);
>+		dev_err(&sdd->pdev->dev, =22Failed to get TX DMA
>channel=5Cn=22);
> 		dma_release_channel(sdd->rx_dma.ch);
> 		sdd->tx_dma.ch =3D 0;
> 		sdd->rx_dma.ch =3D 0;
>--
>2.35.3


