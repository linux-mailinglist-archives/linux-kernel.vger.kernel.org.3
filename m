Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420B94BCEA3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbiBTN12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:27:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbiBTN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:27:18 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA435845
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 05:26:57 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220220132651epoutp048dbf121aea9604cadaa9950cd57308dd~VgXyoNypa1461814618epoutp04Q
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:26:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220220132651epoutp048dbf121aea9604cadaa9950cd57308dd~VgXyoNypa1461814618epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645363611;
        bh=tSo2reU1UKCOdjcpnCsVa18TmwpMfYdF3qeO3szLFLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWVmLz4XRP1TPN3uH4xNGhsLeolr/8XkHQGhtptLq4hG/LxkzYafdRzOIcfU3lqhS
         o7A7ReKEapGpO4/uIdwcLchATpShTNe9erZDiMo3E8jaff//uOv889NUmh5kgEODdT
         9MrH5lblikju/LWAzR4LRS2YbZNEawcJxdDmi8TA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220220132650epcas5p40eff534d30a733844e0838a3f6322d4c~VgXxuCVKU2772027720epcas5p4s;
        Sun, 20 Feb 2022 13:26:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4K1mRn1kZbz4x9Pp; Sun, 20 Feb
        2022 13:26:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.EB.06423.39142126; Sun, 20 Feb 2022 22:26:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220220132643epcas5p39d48a27bb3fcde2ea3a01a260b46e1a0~VgXrsbyFZ0719107191epcas5p3l;
        Sun, 20 Feb 2022 13:26:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220220132643epsmtrp1c95de1de4426b0fce5bf13fe49af6b7b~VgXrxaHRp0610706107epsmtrp1b;
        Sun, 20 Feb 2022 13:26:43 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-ef-62124193a85e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.F0.08738.19142126; Sun, 20 Feb 2022 22:26:41 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220220132642epsmtip1032ae595d8aa0bbeedff726725dabe64~VgXqVOPN12018020180epsmtip1v;
        Sun, 20 Feb 2022 13:26:42 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 3/3] clocksource/drivers/exynos_mct: bump up number of
 local timer
Date:   Sun, 20 Feb 2022 19:08:24 +0530
Message-Id: <20220220133824.33837-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220220133824.33837-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmuu5kR6EkgykPhCwezNvGZjHvs6zF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZrD1yl91i0dYv7BabN01lduD0mNXQy+Zx59oeNo93586x
        e2xeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjNuTl/AVvCMo2LLs/dMDYxz2bsYOTkkBEwkpl9extzFyMUhJLCb
        UWLx1ilQzidGiTXvNrBAOJ8ZJT6efs4K07J31QRWiMQuRomnL5uYQRJCAi1MEh8nCoDYbALa
        Enenb2ECsUUE3CRuNHYwgTQwC1xjlPgz8RAjSEJYIFyi//8isKksAqoS52/cBhvEK2AjcfbT
        B6gD5SVWbzgAFOfg4BSwlbjVaQwyR0LgHrtEa/dUJogaF4kdBx9B2cISr45vgeqVknjZ38YO
        0ishkC3Rs8sYIlwjsXTeMRYI217iwJU5LCAlzAKaEut36YOEmQX4JHp/P2GC6OSV6GgTgqhW
        lWh+dxWqU1piYnc3NEg8JJauec4ICZIJjBInWrawTGCUnYUwdQEj4ypGydSC4tz01GLTAsO8
        1HJ4PCXn525iBKc0Lc8djHcffNA7xMjEwXiIUYKDWUmE98NB3iQh3pTEyqrUovz4otKc1OJD
        jKbAEJvILCWanA9Mqnkl8YYmlgYmZmZmJpbGZoZK4ryn0zckCgmkJ5akZqemFqQWwfQxcXBK
        NTBx205eJ/B/beTTSZ1xzMnp+evrxG7ILVFT33mZ5SZnv4GE+v6v/YlLmJ8tdeC71Lho7nUX
        PbVljWYrPK6HOszfv/TQIUufxFmuXjciRHrcXxhcvrBA6U+jzs+wQylHGXwsDHyPcTyd8eL2
        aTbJ1L1WLdo/GOYE/u1N6nt3RrnwXlRi54LdaUHtB1vrXl23Cv23QYj3ye9nFUt7ZtatuFls
        2DbZX7GhZlEvb2W2MVv3jclMs9j8GHVt7u0OCV215kXf/CNVj+4pFa4KzvB1urBg+XJ7veMs
        L2KOOz+uOxH+53T7PAY1Pd9fE/zCy1uy+TvKatl3NF3jmxz8+ETPzurXxqezp6Sk6LzpKb+W
        E6HEUpyRaKjFXFScCABzetYD8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnO5ER6Ekg+tNZhYP5m1js5j3WdZi
        49sfTBabHl9jtbi8aw6bxYzz+5gs1h65y26xaOsXdovNm6YyO3B6zGroZfO4c20Pm8e7c+fY
        PTYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujJvTF7AVPOOo2PLsPVMD41z2LkZODgkB
        E4m9qyawdjFycQgJ7GCU2PBhMytEQlri+sYJUEXCEiv/PQezhQSamCS2rRABsdkEtCXuTt/C
        BGKLCHhItP27xwwyiFngHqPE75ZpjF2MHBzCAqESN/bwgtSwCKhKnL9xmxnE5hWwkTj76QPU
        fHmJ1RsOMIOUcwrYStzqNIZYZSMx++5+5gmMfAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfm
        pesl5+duYgQHo5bWDsY9qz7oHWJk4mA8xCjBwawkwvvhIG+SEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzHf5U5vOCau7de+oZ9u1Sl0YV/++Iidt26
        +0D3AI/XN+lVIkb/Xx1ubNJY80P32i0Gu7gNW1Tvrt4QLSKsuWmaS0XO33VrprRuCjc6kzvL
        h6erfUP7lV8T3/foZ/HVlD0+8nnupI+snEGnFCTt3zR0d1bGHXjh9YnldN40i80tqXYFsbqS
        Yu+bvnR53ghSOVl5gvUU1843p3zla6a93Rt75HLJlfUvbMJEWJap7PE9F+HLduyQdvDU61NP
        f5v/N5iXLXVH28YdCw3ucHq78CzWWPqdQYZnVcB9Z41ah0beQvt//T/7LuqysCzYNTP51sTL
        L05ymeXsWaYTYHi2riVj/v/w6DaWSBPjgr4L3b1KLMUZiYZazEXFiQDkHmSWtQIAAA==
X-CMS-MailID: 20220220132643epcas5p39d48a27bb3fcde2ea3a01a260b46e1a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220220132643epcas5p39d48a27bb3fcde2ea3a01a260b46e1a0
References: <20220220133824.33837-1-alim.akhtar@samsung.com>
        <CGME20220220132643epcas5p39d48a27bb3fcde2ea3a01a260b46e1a0@epcas5p3.samsung.com>
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

As per the dt binding, maximum number of local timer can be
up to 16. Increase the array size of the _name_ variable
which holds the number of local timer name per CPU to
reflect the binding. While at it, change the magic number to a
meaningful macro.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 0c7931f7f99a..8d63a9376701 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -66,6 +66,8 @@
 #define MCT_L0_IRQ	4
 /* Max number of IRQ as per DT binding document */
 #define MCT_NR_IRQS	20
+/* Max number of local timers */
+#define MCT_NR_LOCAL_TIMERS	16
 
 enum {
 	MCT_INT_SPI,
@@ -80,7 +82,7 @@ static int mct_irqs[MCT_NR_IRQS];
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
-	char name[10];
+	char name[MCT_NR_LOCAL_TIMERS];
 };
 
 static void exynos4_mct_write(unsigned int value, unsigned long offset)
-- 
2.25.1

