Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716C74C197B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiBWRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbiBWRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:08:07 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1801E65409
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:07:37 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220223170732epoutp04bd5650f57cd0b69807e633fb36fa7bd4~WeUVkHWvS3148231482epoutp04D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:07:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220223170732epoutp04bd5650f57cd0b69807e633fb36fa7bd4~WeUVkHWvS3148231482epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645636052;
        bh=UL4yhKqRjrF/i/6aY21BYBDYT+6g6lJv1blGzeLha14=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PrbEmm2Pa70axQTVADf3yZuIWHVXlhcd+TkVepcPwoyQs31trdu4buaPVVfNqssOB
         CgYy7IGqtMWEjH6iZrJo6jzPkhMG1Y7s673DoYMkqNRG0inn62M4TJPSWpjukVyNkR
         ptMQz1czxZBakPxm5BNs4rtbKuk+OzuIHoXK2o6o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220223170731epcas5p23aa2664ea9b6a4782322656b004b8e40~WeUUkjA7F0865808658epcas5p2k;
        Wed, 23 Feb 2022 17:07:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K3jC43wbrz4x9Pv; Wed, 23 Feb
        2022 17:07:28 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.AC.05590.0D966126; Thu, 24 Feb 2022 02:07:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220223170727epcas5p20066f8455fa0ca98323ac286dabc90ec~WeUQyf_yy2933129331epcas5p29;
        Wed, 23 Feb 2022 17:07:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220223170727epsmtrp10e82f6823a94ebb3d16642084f81978e~WeUQxwOV32819728197epsmtrp1T;
        Wed, 23 Feb 2022 17:07:27 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-55-621669d007b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.E2.29871.FC966126; Thu, 24 Feb 2022 02:07:27 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220223170726epsmtip1457171ab722826f93d0e118b0385d941~WeUPnYIXk1400314003epsmtip17;
        Wed, 23 Feb 2022 17:07:26 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, robh+dt@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] arm64: dts: fsd: Add the MCT support
Date:   Wed, 23 Feb 2022 22:48:58 +0530
Message-Id: <20220223171858.11384-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7bCmuu6FTLEkg1W90hYP5m1js5h/5Byr
        xca3P5gsNj2+xmpxedccNosZ5/cxWSza+oXdonXvEXYHDo9ZDb1sHptWdbJ5bF5S79G3ZRWj
        x+dNcgGsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
        OUCnKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0M
        jEyBChOyM54+2M1YsIO74v3HN4wNjAs5uxg5OSQETCTObD3H3sXIxSEksJtR4vrFnSwQzidG
        iSVdU5kgnG+MEv9n/WeEabm37QJU1V5Gif6Fr6CcFiaJub8+gVWxCWhL3J2+hQnEFhFwk7jR
        2AE2ihmkY3XbJTaQhLCAqcS0GbPAGlgEVCW+nJrDDmLzCthILGraxgaxTl5i9YYDzBD2NnaJ
        pq/5ELaLxMT5z9khbGGJV8e3QNlSEi/724BsDiA7W6JnlzFEuEZi6bxjLBC2vcSBK3NYQEqY
        BTQl1u/SBwkzC/BJ9P5+wgTRySvR0SYEUa0q0fzuKlSntMTE7m5WCNtDouXsK7DDhARigaaf
        Y5nAKDMLYegCRsZVjJKpBcW56anFpgXGeanl8LhJzs/dxAhOVFreOxgfPfigd4iRiYPxEKME
        B7OSCO8dduEkId6UxMqq1KL8+KLSnNTiQ4ymwECayCwlmpwPTJV5JfGGJpYGJmZmZiaWxmaG
        SuK8p9I3JAoJpCeWpGanphakFsH0MXFwSjUw3bW46cKvEM3J/G5JrJbEuWCe+Ent8n3sIpfP
        LChfxeD2hctlavMukTR3JznvOi+mzhMT5X4yLNha9PCYpPIKn91d3/l1g57q6x14e5pvHzv7
        x4CytIuNEzg3/rqneMmHP1a+wO3MwXU9Bo/fPxX7nPqD92C33LOk+Jg3OXpR2e5Vk9Uf9yz7
        /kV4gq399zVP1mxZVOd3WOZ+jpzjzT3P8puPn3prtE1P5WlO8mzBBfr507IO33C8f+nchwct
        bz8nTem2ija8eiG1XS7Vdvm3W3rfVEJcV/z2mORoFnRsR9keDf1vZc+uuK46fFqxdiXbgqj4
        bq79r+9fWNHlKt5/5PFVu60CG3PWmjCKcZY6KrEUZyQaajEXFScCANqbSIXdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJTvd8pliSwfs5yhYP5m1js5h/5Byr
        xca3P5gsNj2+xmpxedccNosZ5/cxWSza+oXdonXvEXYHDo9ZDb1sHptWdbJ5bF5S79G3ZRWj
        x+dNcgGsUVw2Kak5mWWpRfp2CVwZTx/sZizYwV3x/uMbxgbGhZxdjJwcEgImEve2XWABsYUE
        djNKzFqtBhGXlri+cQI7hC0ssfLfcyCbC6imiUli29VeNpAEm4C2xN3pW5hAbBEBD4m2f/eY
        QYqYBQ4zSnx5t5EZJCEsYCoxbcYsRhCbRUBV4supOWBTeQVsJBY1bWOD2CAvsXrDAeYJjDwL
        GBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh5OW5g7G7as+6B1iZOJgPMQowcGs
        JMJ7h104SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQam
        qRcYX/kezOk0Cgs2CV29WeSKoJyBjtPF7iN188Q7+nWSspcE75TcI8NZee7Tn9rD3bUuO//9
        2rdqoapa3I1HJarz6v/ItCqdbxHLcil2TF7DuixZcMHNzafvVkg/6JAqt49b6JmsUaM/IenI
        M27J2iU129sE9l3qfePTH5V1rkWNy/PwJ6/rWxbslIxQZomSmmq7eeF73prXPcl7n/06NPl2
        vJGcTMpxtd/MVjP5zmUc90uob8wyNlR71xB2+z737+7/r+umWjW23cmICHv2s62+fdmz5Xsi
        o8yDHNJb8x/Y1lxb1mMmyyuq8nl79MbetQUefJNOXP0VZxZs+2/Oy9lVZ6eGrokxE/Q7ckiJ
        pTgj0VCLuag4EQBi/eUilgIAAA==
X-CMS-MailID: 20220223170727epcas5p20066f8455fa0ca98323ac286dabc90ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220223170727epcas5p20066f8455fa0ca98323ac286dabc90ec
References: <CGME20220223170727epcas5p20066f8455fa0ca98323ac286dabc90ec@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node relevant to support MCT, which is used as
one of the system timer on this SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index da4acd68b976..9a652abcbcac 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -725,6 +725,29 @@ spi_2: spi@14160000 {
 			num-cs = <1>;
 			status = "disabled";
 		};
+
+		timer@10040000 {
+			compatible = "samsung,exynos4210-mct";
+			reg = <0x0 0x10040000 0x0 0x800>;
+			interrupts = <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&fin_pll>, <&clock_imem IMEM_MCT_PCLK>;
+			clock-names = "fin_pll", "mct";
+		};
 	};
 };
 
-- 
2.25.1

