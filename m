Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E813053CC99
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiFCPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbiFCPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:49:23 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86250B23
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:49:07 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220603154905epoutp028df2e3b7cfb6900a2f3eb1ada413fc97~1JwY40mcw1756717567epoutp02U
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:49:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220603154905epoutp028df2e3b7cfb6900a2f3eb1ada413fc97~1JwY40mcw1756717567epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271345;
        bh=0eZm7eKAbkf54yudyV9mqTFcBkeReT2Aou+UZwhcVN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tlj4b76sd8J55xH/wMWNufWvLIdxk2z0qrIvQHfimM9apX8UYa+qyu8RmtM6kdYj1
         OZnSUnEp4RLUX0SJ6xD9zUabC3iSG0GBZldHUzyYJRWdqox6vDdoc6UukkhavNzMUV
         4WX+0FW+k9ksgdWTPetGhJO/nVmovpgaJC0g4D6w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220603154904epcas5p2979d3468e3f5722384d8a0d59fb47bb0~1JwXqZB221440614406epcas5p2K;
        Fri,  3 Jun 2022 15:49:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LF6kP70bnz4x9Pt; Fri,  3 Jun
        2022 15:49:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.A8.10063.D6D2A926; Sat,  4 Jun 2022 00:49:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220603154900epcas5p3380c14eb436089205a8a58a6af6ce3e6~1JwULPjUL2016420164epcas5p3S;
        Fri,  3 Jun 2022 15:49:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603154900epsmtrp14c3dfd9989da7119a323d6fd7cffae8f~1JwUJDn8x2840828408epsmtrp1O;
        Fri,  3 Jun 2022 15:49:00 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-48-629a2d6d8e8b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.6C.11276.C6D2A926; Sat,  4 Jun 2022 00:49:00 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154858epsmtip1b9be119c1d9906619487870f9194c2a2~1JwRuFKai2494124941epsmtip1I;
        Fri,  3 Jun 2022 15:48:57 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v2 4/7] dt-bindings: ufs: exynos-ufs: add fsd compatible
Date:   Fri,  3 Jun 2022 21:17:11 +0530
Message-Id: <20220603154714.30532-5-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTXTdXd1aSwYt/5hYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzrh8ci5jwVW2ig8z+lkbGG+ydjFycEgImEh0znHvYuTiEBLYzSix5/QfFgjnE6PEnGfn
        WSGcb4wSWx69Z+ti5ATrmHn1KTNEYi+jxISmW1BOC5PEsY2/WUCq2AS0Je5O38IEkhARaGaU
        ONixC8xhFtjJJHHx93RmkCphAQ+JZ+u6mEEuYRFQlfi7xQckzCtgI/Hz/BWodfISqzccACvh
        FLCVmHqaD2SMhMBMDonVm7czQdS4SPTfvMcIYQtLvDq+hR3ClpJ42d/GDvGoh8SiP1IQ4QyJ
        t8vXQ5XbSxy4MocFpIRZQFNi/S59kDCzAJ9E7+8nTBCdvBIdbUIQ1aoSze+uskDY0hITu7tZ
        IWwPiT1PP0ADawKjxMXWrawTGGVnIUxdwMi4ilEytaA4Nz212LTAMC+1HB5Pyfm5mxjBCVLL
        cwfj3Qcf9A4xMnEwHmKU4GBWEuEtmzczSYg3JbGyKrUoP76oNCe1+BCjKTDAJjJLiSbnA1N0
        Xkm8oYmlgYmZmZmJpbGZoZI4r8D/xiQhgfTEktTs1NSC1CKYPiYOTqkGJlXevI8rdU4LZfcs
        9+p6frjxZ5Ooh62pmHX5pfBfrEtmFSyesm9RrMnkx9ZcHn9nSxp8uj3zhMiqT1waGTfbbPdO
        FOI3zrpcf3t5N/ena+vnrs1e/FBzs1Bze+P1jORLgozXpM/K/eF/7+lSsVk00EfsJscip84p
        IU1vTi6yFXzes0r/izaXVdHBet6pbPO5d6xck/1n3Sf70GOJC1fk9X7eee8636mDWwszGXfK
        lmQuKIp3enZl4tnHVYuvp9V3JWut2Xe9/HXxBoe03JhfEw9mft4RX781aRrLK24plsMiXxVN
        bSoand3qyrenGL3+3pQzWf6bx/Za55/C/eX61e+tQ129axc3P2D8e+WSqBJLcUaioRZzUXEi
        AKd2b5kZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG6O7qwkgwWTNSwezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKuHxyLmPBVbaKDzP6WRsYb7J2MXJySAiYSMy8+pS5i5GLQ0hg
        N6PEulXzmSES0hLXN05gh7CFJVb+e84OUdTEJPHiex8LSIJNQFvi7vQtTCC2iEA7o8T97Wwg
        RcwCR5kklp86BjZJWMBD4tm6LiCbg4NFQFXi7xYfkDCvgI3Ez/NX2CAWyEus3nAArIRTwFZi
        6mk+kLAQUMn38/dZJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzcWpo7
        GLev+qB3iJGJg/EQowQHs5IIb9m8mUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhP
        LEnNTk0tSC2CyTJxcEo1MO3mXr13a+bCWtMZyWL8Das65h9JvMj0f0ZZw+rOXwxRTHUp86ap
        cCn1xb0o8lqw9Inl+kUe81PY56zdrXr6Ud2kmV0PNRcdYjJbwenZ5fJBMOvNpqCd7OsjU0wC
        bM/Pm8ptdejB8VliH8P/7GB47XN2ko3qU66nsqHfNi993zrvng6Hxu0vZceVw5QUMmPs91nN
        b+KxEr4zMWyqkeu7/t6MPayJgXUn+58vDGTSqlpQvvvMJs7l2ySDwjNUnuw6IdgZEN/1PeXo
        TO9FqTMm6r/OzL1wej9jrdruP4Uh5zSPLl9zXLCY47H3JzftN52Pq/7NtJ2Rv/WEktmOeWuL
        eGYad2wXNPmar/ysanfsHRMlluKMREMt5qLiRACx1kbg3QIAAA==
X-CMS-MailID: 20220603154900epcas5p3380c14eb436089205a8a58a6af6ce3e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154900epcas5p3380c14eb436089205a8a58a6af6ce3e6
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154900epcas5p3380c14eb436089205a8a58a6af6ce3e6@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds tesla,fsd-ufs compatible for Tesla FSD SoC.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index c949eb617313..2c715eec48b8 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -21,6 +21,7 @@ properties:
       - samsung,exynos7-ufs
       - samsung,exynosautov9-ufs
       - samsung,exynosautov9-ufs-vh
+      - tesla,fsd-ufs
 
   reg:
     items:
-- 
2.25.1

