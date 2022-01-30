Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF64A3513
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348784AbiA3II3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:08:29 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38111 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiA3IIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:08:19 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220130080817epoutp03de005241f639bf469c9858aa4c017b87~O-eqSxMfx2581825818epoutp03f
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 08:08:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220130080817epoutp03de005241f639bf469c9858aa4c017b87~O-eqSxMfx2581825818epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643530098;
        bh=Osa62qP78HGsGxEvJpSvkyVjVh7AHtU1ZnKUW40CAyQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dBJwdFRVfbf/J058F6OPbi1q5vTGnHAhjeXjWtk8fwBSBTuuu5Tlo+pBUb3clgvbG
         UcSrLvGf3q/w7lcnHgdMuZU3oOQkzsbipfXQN7a3DLSfk4mTVJNdTRP/WEeTbslI9n
         NM0VVKUqjgM93mKag2OgX8uDqsbGAkbtmx8L/Ag8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220130080816epcas5p1dd01c817b2dc325bc5a5955c5427e815~O-epVg3yU3002130021epcas5p1i;
        Sun, 30 Jan 2022 08:08:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JmkMv13kqz4x9Pp; Sun, 30 Jan
        2022 08:08:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.5A.05590.B6746F16; Sun, 30 Jan 2022 17:08:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220130080810epcas5p425f29e7a017b4b1690509e60651d4245~O-ejppo2Q1949419494epcas5p4B;
        Sun, 30 Jan 2022 08:08:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220130080810epsmtrp17735b5b33b1542baa88967a6dd5cff33~O-ejnjeSD1370913709epsmtrp1O;
        Sun, 30 Jan 2022 08:08:10 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-c1-61f6476becad
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.51.29871.A6746F16; Sun, 30 Jan 2022 17:08:10 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220130080805epsmtip28942026ae2fba7f23d764e375d3d42a8~O-efCPlXE3158931589epsmtip2a;
        Sun, 30 Jan 2022 08:08:05 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 1/3] ARM: dts: exynos: update dma nodename for exynos3250
Date:   Sun, 30 Jan 2022 13:25:18 +0530
Message-Id: <20220130075520.49193-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmhm62+7dEgyVNLBYP5m1js5h/5Byr
        xca3P5gsNj2+xmpxedccNosZ5/cxWbTuPcLuwO4xq6GXzWPTqk42j81L6j36tqxi9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dsbt31+YCyZwVkxY+YqtgXEHexcjJ4eEgInEqp0tbF2MXBxCArsZJd4e7WQCSQgJfGKUuHch
        ACLxjVHi0Mf5zF2MHGAdv3a7Q8T3MkrMmraIBcJpYZLoOLwNbCybgLbE3elbwCaJCLhJ3Gjs
        ALOZBRYzSvxamA5iCwt4Ssy/0MsGYrMIqEr0v77MCmLzCthI9De3Q50nL7F6wwFmkAUSAuvY
        JfqbpkElXCT6vk+BsoUlXh3fAmVLSbzsb2OHuDRbomeXMUS4RmLpvGMsELa9xIErc1hASpgF
        NCXW79KHOI1Povf3EyaITl6JjjYhiGpVieZ3V6E6pSUmdnezQtgeEp/P/mWHhFWsxP7Nv1km
        MMrMQhi6gJFxFaNkakFxbnpqsWmBcV5qOTxmkvNzNzGCU5OW9w7GRw8+6B1iZOJgPMQowcGs
        JMI7Y9OnRCHelMTKqtSi/Pii0pzU4kOMpsBQmsgsJZqcD0yOeSXxhiaWBiZmZmYmlsZmhkri
        vKfSNyQKCaQnlqRmp6YWpBbB9DFxcEo1MC1+6+UR8uo+7xMbrSmbFqpwWtS/D7hXvc2l6jTv
        Ff/2tmfbdNbt9zjTEtGyWWpbYIwc48NHjCqCqitZXF/ZuPer23Mlviy0q0uas073dp3A7Mba
        muM1lzx461h17+gqK2jEzvF1Yz7Ku29R2DmuxGkn9WbW/S+6M0tsonKlE+snpvMzNnb8dnzn
        4yFw1kV1s6zJu8DF8/a1OHB9eCa3dFrGW/tHNY0Hlt/VqVnFId0tmns8M0V5pdGciXe3Llyx
        RvKXhkRbwZ9F+/T/FIu2NpjdLWduvLIzavXJ9XuuHJlR2Bt8ZPEJ0SuHTz/kW3vkZu8PBZ20
        Lf8uT3h59Lv1Pc1rgXGiGc6MJ9eEz7rSL6LEUpyRaKjFXFScCABwvad41gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsWy7bCSvG6W+7dEg4u79C0ezNvGZjH/yDlW
        i41vfzBZbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1jVkMvm8emVZ1sHpuX1Hv0bVnF6PF5k1wA
        axSXTUpqTmZZapG+XQJXxu3fX5gLJnBWTFj5iq2BcQd7FyMHh4SAicSv3e5djFwcQgK7GSW6
        P29m7GLkBIpLS1zfOIEdwhaWWPnvOTtEUROTxInd01hBEmwC2hJ3p29hArFFBDwk2v7dYwYp
        YhZYzijRuWs5G0hCWMBTYv6FXjCbRUBVov/1ZbBmXgEbif7mdqgN8hKrNxxgnsDIs4CRYRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnAQaWnuYNy+6oPeIUYmDsZDjBIczEoivDM2
        fUoU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgcmRz9lg
        vWr0wozstBmyPtwmcrMOenldP7/yhnnVvnk9Evemnoo96iVqMSPYc9K84Mk9EnVp75KS51rU
        84j8yg0/vE5f0Pm/z4SGDKsTzhybxM2bz1x8tPuu7COp41nSalb1mQy/D9y9vExnmvb3dX9a
        Yp/w/5kQ/XeBxoMns0Vytifz1G89KrbadkpBQZn3D7mtip6XtzX8qD/6ktU0KfnMJYtd/C/N
        EiY5Nds+e5TZk6m/THziYdED2+2slebqbmRIvb4taDEDu+/6JFcvLlnHfL0jX7gkq/wXHFvD
        Ol/LZuam79/PvRVVZJ4ep+bnbPlq4dzYGvbunWqvbk/NaFRI/yBjuEb6eYZEktbps0osxRmJ
        hlrMRcWJAFh3DbSRAgAA
X-CMS-MailID: 20220130080810epcas5p425f29e7a017b4b1690509e60651d4245
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220130080810epcas5p425f29e7a017b4b1690509e60651d4245
References: <CGME20220130080810epcas5p425f29e7a017b4b1690509e60651d4245@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dma node name does not matches the pl330
dt schema and make dtbs_check report below warning

'pdma@12680000' does not match '^dma-controller(@.*)?$'

Update the dma node name to match pl330 dt schema

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index a10b789d8acf..ae644315855d 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -421,7 +421,7 @@ exynos_usbphy: exynos-usbphy@125b0000 {
 			status = "disabled";
 		};
 
-		pdma0: pdma@12680000 {
+		pdma0: dma-controller@12680000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12680000 0x1000>;
 			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
@@ -432,7 +432,7 @@ pdma0: pdma@12680000 {
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma@12690000 {
+		pdma1: dma-controller@12690000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12690000 0x1000>;
 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

