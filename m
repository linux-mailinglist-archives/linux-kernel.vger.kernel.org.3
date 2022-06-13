Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB71547E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 06:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiFMELf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 00:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiFMELd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 00:11:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD5436140
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:11:25 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220613041120epoutp0165dbf4eb8bc19d8fb7f17caaca28975e~4EsBE7eZF1153811538epoutp01I
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:11:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220613041120epoutp0165dbf4eb8bc19d8fb7f17caaca28975e~4EsBE7eZF1153811538epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655093480;
        bh=SBIzwu2YUiz3ad3PTWMRf8V68ma4mBuWe6+GzoVy6tQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oFe3RwefKg49yife0cAdY7/3lWtS2Bt9bSvgnmsYmRPobV5ei1ZGszjat/8E6afe7
         TnpsMJBbd+JYrZEC0Wkin1wprEbAYjJLO6idU2mPkomnwYk/LnDHwSz7qg4vpTbzfU
         KwtQqdMtSaXARXhvxwp7cODzgSt/XmwyjqT9S5qY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220613041119epcas5p4fb6d5c475f361ed67e82169634ae88de~4EsAtPA9G3176031760epcas5p4l;
        Mon, 13 Jun 2022 04:11:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LLymj1cVwz4x9Q7; Mon, 13 Jun
        2022 04:11:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.29.09762.0E8B6A26; Mon, 13 Jun 2022 13:11:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220613041111epcas5p426ea95c3b26a5507b1a0d23e82b926a0~4Er5jzrxA3176031760epcas5p4E;
        Mon, 13 Jun 2022 04:11:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220613041111epsmtrp204ced861682ba2d541e6a8ecdbd82e91~4Er5i7Fte0853108531epsmtrp2W;
        Mon, 13 Jun 2022 04:11:11 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-1a-62a6b8e021c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.2C.08924.FD8B6A26; Mon, 13 Jun 2022 13:11:11 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220613041110epsmtip1abf95802df5da28f86f4b5d9be1a280e~4Er4JxrwH1718617186epsmtip1X;
        Mon, 13 Jun 2022 04:11:10 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Colin Ian King'" <colin.i.king@gmail.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andi Shyti'" <andi@etezian.org>,
        "'Mark Brown'" <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Cc:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220612203428.2754823-1-colin.i.king@gmail.com>
Subject: RE: [PATCH][next] spi: s3c64xx: set pointers to null using NULL
 rather than 0
Date:   Mon, 13 Jun 2022 09:41:09 +0530
Message-ID: <006901d87edb$9dbd5c00$d9381400$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEk9w57DWWeRR+saBNtUt2pHf6gBQH2xDQurqQSkYA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmpu6DHcuSDCZs5bdY/OM5k8XUh0/Y
        LCa1f2G12HpL2mLv663sFpseX2O1uLxrDpvFjPP7mCwaP95kd+D0uL7kE7PHzll32T02repk
        87hzbQ+bx+Yl9R6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl
        5qbaKrn4BOi6ZeYA3aSkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0u
        zUvXy0stsTI0MDAyBSpMyM64+fcHa8EugYpD04MbGN/wdjFyckgImEgcn97B2MXIxSEksJtR
        4sflk1DOJ0aJX3+fMYNUCQl8ZpSYPaG4i5EDrGPXn2KIml2MEssPTYSqecko0b46GsRmE9CV
        2LG4jQ2kSERgIZNE/6V77CAJZgFXiTtn7rGC2JwCdhJnVnUxgtjCAhESfb07mEBsFgFViX07
        LoHFeQUsJRZcmskOYQtKnJz5hAVijrzE9rdzmCFeUJD4+XQZ2EwRASuJJd3LoHaJS7w8eoQd
        5AgJgZUcEtsmP2WBaHCRePn9OhOELSzx6vgWdghbSuLzu71sEF96SCz6IwURzpB4u3w9I4Rt
        L3HgyhwWkBJmAU2J9bv0IVbxSfT+fsIE0ckr0dEmBFGtKtH87irUUmmJid3drBC2h8T6Ld/Z
        JzAqzkLy2Cwkj81C8sAshGULGFlWMUqmFhTnpqcWmxYY56WWwyM7OT93EyM4uWp572B89OCD
        3iFGJg7GQ4wSHMxKIrwBtxclCfGmJFZWpRblxxeV5qQWH2I0BYb2RGYp0eR8YHrPK4k3NLE0
        MDEzMzOxNDYzVBLnFfjfmCQkkJ5YkpqdmlqQWgTTx8TBKdXANO3YmRMnb9o8dUq/vVxcNPOD
        u2zvKjO9tSr+2VrbZ8iu+78qOHRy8a599ydtPHPUlHXjD6/9Li2Cimmx5sfmTGC1ebZobdO8
        SsG2E6v6/jB82RDg6zu5z+7X7tzp5+Kl/zuV/RU5tmP6id4NS8vDRKR1TC/pRCxZdkLg0rFl
        hy5rlEVfD6v0tpRntelWP3vgS6ePc9BDK24XufenHDeXp+kVXXUNWWPOmLiTa5XiG4+1fAd9
        wnTt/81Yu0HBaPmq+40vk25dPRu+4nj+tpVHW34sZGT20b4ouZ418kIi1wOBmtZqjzbB9HOM
        yV3rVRgsO3dNazXZY3bCq5z11tFOy21LNHQOOB42uvc9od3tghJLcUaioRZzUXEiAL/f+a83
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTvf+jmVJBkeXm1ks/vGcyWLqwyds
        FpPav7BabL0lbbH39VZ2i02Pr7FaXN41h81ixvl9TBaNH2+yO3B6XF/yidlj56y77B6bVnWy
        edy5tofNY/OSeo/Pm+QC2KK4bFJSczLLUov07RK4Mm7+/cFasEug4tD04AbGN7xdjBwcEgIm
        Erv+FHcxcnIICexglHi1vBTElhCQlri+cQI7hC0ssfLfcyCbC6jmOaPE/+XT2UASbAK6EjsW
        t7GBJEQEljNJbP27nhkkwSzgLjGtaScjxNR+RomTlwJBbE4BO4kzq7rA4sICYRLzz/aDDWIR
        UJXYt+MSWJxXwFJiwaWZ7BC2oMTJmU9YIGZqS/Q+bGWEsOUltr+dwwxxnYLEz6fLWEFsEQEr
        iSXdy9ghasQlXh49wj6BUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YW
        l+al6yXn525iBEeZltYOxj2rPugdYmTiYDzEKMHBrCTCG3B7UZIQb0piZVVqUX58UWlOavEh
        RmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTK4lx2q+ufLqTlhU+2Kt2cGoL0fv/A4/
        +uaoljnXBJdEe84NqutaeoM0tk+dmr61eK8q11buw+sXsbi9uFnz2MTjyR2tINFaNV2FXINF
        0rILS4QaFsZKpj+70VXktM43+IZO4elrtxZG7Q9o+5J58vPXCAu1HZ9Tf4e7VhWcFHyaUMmb
        H3Xpy1I98XcvazI1uz6smr48etqk7X8Xn9kx9dO12tefot/bXMvq75S5p613ynbPqv7uOI+y
        pgARpcoXT/Vfd1RoPrnkrxAYZBRf9eHFvrM/F0xofT3ZbpZdr/jq4q+b9l7aqOyn4/vLbkbt
        uoNb6/Pef7i40szHRtOyU11jf8mb/pxqoXoZ160afkosxRmJhlrMRcWJAJvB7mohAwAA
X-CMS-MailID: 20220613041111epcas5p426ea95c3b26a5507b1a0d23e82b926a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220612203434epcas5p3f44780ebc5f34f5fd3f55362cbe21a2e
References: <CGME20220612203434epcas5p3f44780ebc5f34f5fd3f55362cbe21a2e@epcas5p3.samsung.com>
        <20220612203428.2754823-1-colin.i.king@gmail.com>
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
>From: Colin Ian King [mailto:colin.i.king@gmail.com]
>Sent: Monday, June 13, 2022 2:04 AM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Andi Shyti
><andi@etezian.org>; Mark Brown <broonie@kernel.org>; Alim Akhtar
><alim.akhtar@samsung.com>; linux-spi@vger.kernel.org; linux-samsung-
>soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH][next] spi: s3c64xx: set pointers to null using NULL rather
>than 0
>
>There are pointers being set to null using use. Use NULL instead.
>
Nit: s/using use / using zero

>Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/spi/spi-s3c64xx.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c index
>0ce58105dbac..819b660dae82 100644
>--- a/drivers/spi/spi-s3c64xx.c
>+++ b/drivers/spi/spi-s3c64xx.c
>@@ -354,7 +354,7 @@ static int s3c64xx_spi_prepare_transfer(struct
>spi_master *spi)
> 	sdd->rx_dma.ch = dma_request_chan(&sdd->pdev->dev, "rx");
> 	if (IS_ERR(sdd->rx_dma.ch)) {
> 		dev_err(&sdd->pdev->dev, "Failed to get RX DMA
>channel\n");
>-		sdd->rx_dma.ch = 0;
>+		sdd->rx_dma.ch = NULL;
> 		return 0;
> 	}
>
>@@ -362,8 +362,8 @@ static int s3c64xx_spi_prepare_transfer(struct
>spi_master *spi)
> 	if (IS_ERR(sdd->tx_dma.ch)) {
> 		dev_err(&sdd->pdev->dev, "Failed to get TX DMA
>channel\n");
> 		dma_release_channel(sdd->rx_dma.ch);
>-		sdd->tx_dma.ch = 0;
>-		sdd->rx_dma.ch = 0;
>+		sdd->tx_dma.ch = NULL;
>+		sdd->rx_dma.ch = NULL;
> 		return 0;
> 	}
>
>@@ -808,8 +808,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master
>*master,
> 	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
> 		dma_release_channel(sdd->rx_dma.ch);
> 		dma_release_channel(sdd->tx_dma.ch);
>-		sdd->rx_dma.ch = 0;
>-		sdd->tx_dma.ch = 0;
>+		sdd->rx_dma.ch = NULL;
>+		sdd->tx_dma.ch = NULL;
> 	}
>
> 	return status;
>--
>2.35.3


