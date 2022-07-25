Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20E57F9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiGYGxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiGYGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:22 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4BD11156
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:17 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220725065313epoutp0262ab83868554adccb2323ca51a85259a~E--Wf_02P2079420794epoutp02U
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220725065313epoutp0262ab83868554adccb2323ca51a85259a~E--Wf_02P2079420794epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731993;
        bh=6P6qPA7UjBVSaBFTSmkW9CDd7N+0QYKFfGR2SV8Sp74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBcqUihl2OIYY/o7pPAjwsFeI11QUvghJzFetYoICA3xQUehO1lHWRCEPPRfLFW2S
         oigbP2qzgESLkeA6CY6HJJEw1vUTEmduZK5Nw3ja9RRDX88e+DIYONI+FcdtDSWqcU
         ioG+T91f4UduczqjgJ+Wpvp+msmSxPjYXyEv1tuE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220725065312epcas1p4d3d86cb937bc4eccd073e8770af45d65~E--WNvAD71623716237epcas1p4B;
        Mon, 25 Jul 2022 06:53:12 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.233]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LrrN81xrzz4x9QD; Mon, 25 Jul
        2022 06:53:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.A3.09661.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065310epcas1p2735e463512b0db489f2af532f15dae6e~E--UBHAZi2588425884epcas1p2Z;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220725065310epsmtrp1e46291c50c7419d5beed00dde25a1277~E--UANeMt0382103821epsmtrp1t;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
X-AuditID: b6c32a37-2cfff700000025bd-d7-62de3dd6bd4b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.B6.08802.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065310epsmtip2e2f0e189e7737971da725bd8876391ed~E--Tr0kd22537425374epsmtip2X;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 9/9] MAINTAINERS: add TRINITY driver
Date:   Mon, 25 Jul 2022 15:53:08 +0900
Message-Id: <20220725065308.2457024-10-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmru4123tJBj3TDSz+TjrGbtG8eD2b
        xfvu3cwWl3fNYbO43biCzeL5tOssDmwev39NYvTYP3cNu0ffllWMHp83yQWwRGXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ7yc3cVWsJ+t
        Yv/F3ewNjAdZuxg5OSQETCR2XjrF1sXIxSEksINRYtnz5cwQzidGidtHzrOBVAkJfGaU2LdS
        Dqaj8e0fJoiiXYwSDSduQXUAFR1//ZwdpIpNQFVi5ow1YLaIgLfE/NYuoA4ODmaBSIlrK6pA
        TGGgQRPWS4FUsABVn2xoYwKxeQVsJJ43TwHbywlkL/ixmxkiLihxcuYTFhCbWUBeonnrbLC1
        EgKn2CV279vABHGci8SC9XuYIWxhiVfHt7BD2FISL/vboOxsiSkdi1gg7AKJc8+3MoPcIyFg
        LHFxRQrElZoS63fpQ1QoSuz8PZcRYi2fxLuvPawQ1bwSHW1CECVKEkv+HIYaLiExdcY3qGM8
        JFafOA4N235GiUfN9xgnMMrPQvLNLCTfzELYvICReRWjWGpBcW56arFhgTE8SpPzczcxglOf
        lvkOxmlvP+gdYmTiYDzEKMHBrCTC25V2O0mINyWxsiq1KD++qDQntfgQoykwfCcyS4km5wOT
        b15JvKGJpYGJmZGxiYWhmaGSOO+qaacThQTSE0tSs1NTC1KLYPqYODilGpjOGJ+bMHNfdPys
        ST/sJSdnS00Vv/Sv4NGhFZ8l3rZ8eLFKQ005RP+ha06qrEvS+ZkGzzZ82Kvt3nM2jO3bt1Ns
        nn8+VJcxdNwt8LY7ZGEoWBV0MjOu6ID5375S1iW/Da/5B3BP9XcpyEw3PvvA8Om8IxYdV3Yw
        bnFYKHs4kdf4x7fEWel3bE12iErN6Anf3SFg829Kz5+1/d+Ekr6Xrgpvrw+9ya4sL6d3zvvk
        Nh+D6iuS596q3atfLli2edqT2/6zVBs5NUQ+uUexBzN9l1u88rzy+SMHf6y075vObsjDbZQr
        l3mSY/n1/rnPDljusNHKUF134E2E9mXTyuRGdnG2pr1VL1g9HltMuPoy/oMSS3FGoqEWc1Fx
        IgBdTutaBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO4123tJBgs/iFn8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKeDm7i61gP1vF/ou72RsYD7J2MXJySAiYSDS+/cPUxcjFISSwg1Hi3vIbTBAJCYlN
        95YzdzFyANnCEocPF0PUfGSUWH2hCayZTUBVYuaMNewgtoiAv8TfT8fA4swC0RKrt91nAekV
        BlowYb0USJgFqPxkQxvYeF4BG4nnzVPYQGxOIHvBj93MILaQgLVEf9cJVogaQYmTM5+wQIyU
        l2jeOpt5AiP/LCSpWUhSCxiZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIepltYO
        xj2rPugdYmTiYDzEKMHBrCTC25V2O0mINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJ
        JanZqakFqUUwWSYOTqkGJuEbFwPib+ye3W33vSbvi9/8XZ2SvutS8oMnLuNfXMd2+sCJhmIr
        rmnyIY/j/jnkbQk6zrZyjmDW1eNlrdM9HUxNkoxzMi6tVGsR85qy8JDSto8R1f56/fcPX99j
        Earmf3pCkPSRFdw3PBTWv608P3X+5erERBW7HeeqZr98X/nnSLld+MbnKwL4teQkH61cHdVy
        W33KooNzmdpuPc63/M4ToVr0+aO61/KAmavTXd9vDqpd56a4v5Lhzlo9x1Mtszv/y978kNM7
        WXSSetOL2uuzHLZs42mfu/53dtz/PKYP2/z6S39ZWT3Nqr/gKx217rQKg6xJ89qoD/aN4rLP
        OnMP7fpRxeavwfyodg8boxJLcUaioRZzUXEiALtG0TDCAgAA
X-CMS-MailID: 20220725065310epcas1p2735e463512b0db489f2af532f15dae6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065310epcas1p2735e463512b0db489f2af532f15dae6e
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065310epcas1p2735e463512b0db489f2af532f15dae6e@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMSUNG TRINITY DRIVER.
Jiho Chu and Yelin Jeong is added as the maintainers.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..3c41497e5e76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17690,6 +17690,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
 F:	drivers/thermal/samsung/
 
+SAMSUNG TRINITY DRIVER
+M:	Jiho Chu <jiho.chu@samsung.com>
+M:	Yelin Jeong <yelini.jeong@samsung.com>
+S:	Supported
+F:	drivers/misc/trinity/
+F:	include/uapi/misc/trinity.h
+
 SAMSUNG USB2 PHY DRIVER
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.25.1

