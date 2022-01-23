Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC049751D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiAWTUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:38 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:45337 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiAWTU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:28 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220123192026epoutp023f4733a919f0f0fd2a82a114b73b90cc~M-Ihe_4kO1521715217epoutp02L
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220123192026epoutp023f4733a919f0f0fd2a82a114b73b90cc~M-Ihe_4kO1521715217epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965626;
        bh=IsUOpJL8ombE3d2kJBRoIHDQ/zVrAi2acH1a4CUB5eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVqdh3nxigBXSMOACm6650x+K03CVMUdQH7Dk/DlKVvDTaEABeOIu1wcaFKp2qeWE
         cb7SpJk0WFhV2lcTdVZpGref1/rB/JteWf1qIwwZNVce6ipCppAIjPWxp+RSRrlmAW
         EVXXVc1+YDIt/p3HPcSw8EX6fePljVwI9TpVapeM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220123192025epcas5p36ce3df3b16c5fe7363d27d4d1cd74b90~M-IgG95hy2905929059epcas5p39;
        Sun, 23 Jan 2022 19:20:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jhjch2BMNz4x9Pr; Sun, 23 Jan
        2022 19:20:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.47.06423.47AADE16; Mon, 24 Jan 2022 04:20:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220123192019epcas5p3c2af6ef38e644adaf9ecd7efbb6ba840~M-Iat0msR2905929059epcas5p36;
        Sun, 23 Jan 2022 19:20:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123192019epsmtrp2e124e238b2a0ea914657e4f9196c5666~M-Iasw-Xw2018820188epsmtrp2k;
        Sun, 23 Jan 2022 19:20:19 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-97-61edaa74946c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.C9.08738.37AADE16; Mon, 24 Jan 2022 04:20:19 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192017epsmtip1482c9e928a41a5b1271d6badb23843e7~M-IYdjRs20551505515epsmtip1P;
        Sun, 23 Jan 2022 19:20:16 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v4 11/16] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Date:   Mon, 24 Jan 2022 00:37:24 +0530
Message-Id: <20220123190729.1852-12-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmlm7JqreJBuen81s8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMXZceMxasZK/4euAMSwPjNLYuRk4OCQETiT8f
        rjF2MXJxCAnsZpTYdHsFG4TziVFi5fpnUM5nRom+OXdZYVrmXWtnBLGFBHYxSny9rgVR1MIk
        cevhHGaQBJuAtsTd6VuYQGwRATeJG40dTCBFzAL/mSQ29iwDWy4sEC3xZ+JasAYWAVWJA/em
        g8V5BWwkNjTfYoLYJi+xesMBsBpOoHjvqw+sIIMkBHZwSPy4tosFoshF4vr8A1DnCUu8Or6F
        HcKWkvj8bi/QUA4gO1uiZ5cxRLhGYum8Y1Ct9hIHrsxhASlhFtCUWL9LHyTMLMAn0fv7CRNE
        J69ER5sQRLWqRPO7q1Cd0hITu7uhlnpItL7vYIGEST+jxOI/IRMYZWchDF3AyLiKUTK1oDg3
        PbXYtMAwL7UcHk/J+bmbGMGpVMtzB+PdBx/0DjEycTAeYpTgYFYS4S3If5UoxJuSWFmVWpQf
        X1Sak1p8iNEUGGITmaVEk/OByTyvJN7QxNLAxMzMzMTS2MxQSZz3dPqGRCGB9MSS1OzU1ILU
        Ipg+Jg5OqQamuA6Ztd+2LeJ6EfzEVzV3z7XGEzLflMTSJQqvPF/ae5bbW8awcyEDq67vvpK3
        71dtMDsir+2Qe/zG/El2L+89VImy6t+Wsekfh8OmX/zGrJGO0d18t3ryJI6ruR1svKZmNeU9
        a0TrWoZVZzUWmUd3zgj+uXjrbQvlLFvdR70yH5Z+LudXuTYxMSa2NlJv6vX8nbvYzIs0Exat
        LLOXUqgq33X4usQ8IaXCda6zjVZEcZ+YMzG8+e5Ws1XzL3G49i3hZd+mELbD0Y394+W7Gg6m
        R84omjxjvaoVenR/5NYbrL0x74x2dBfunL2Q3f3/md+sPKsXhj9rCTNzkLxs9ds/j/ULq7z9
        5d8zV/UEX/VWYinOSDTUYi4qTgQAWBEv4C4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnG7xqreJBjv/ilg8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8auS48ZC1ayV3w9cIal
        gXEaWxcjJ4eEgInEvGvtjF2MXBxCAjsYJa5degqVkJa4vnECO4QtLLHy33N2iKImJonbN98w
        gSTYBLQl7k7fAmaLCHhItP27xwxSxCwwkVli496zLCAJYYFIid0fHoNNZRFQlThwbzqYzStg
        I7Gh+RYTxAZ5idUbDjCD2JxA8d5XH1i7GDmAtllLTDgqN4GRbwEjwypGydSC4tz03GLDAqO8
        1HK94sTc4tK8dL3k/NxNjOBI0NLawbhn1Qe9Q4xMHIyHGCU4mJVEeAvyXyUK8aYkVlalFuXH
        F5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwCQiEnj37bOeOwxu6dohPJxx
        jP82+Ta8XvlvjerjrZ15x65o3xTpkj14bX8ycxDjvzdpUlVztJ6EdG7VLTMMz1m1ydnH/JXr
        SY17DU0Ljx3Vc177zOK2ztlL6xee+sx9o9AnjE9pdtu2z/PsVRKnOD0M3M9yn41Jhun6F7uY
        wwofuCs5H9XGr19fbKys9lbnb8yrG/sOXrS/F7OrznSdnhbXvSVui2MEradPNlvWpPDdL+di
        hqHs2Zmcbm0me+pn2U6+2Npa+Zn9enjW8WknrzupHVCzrT9xfVmheDlHVvjKWdcWf9xsIZ/B
        cMg+mv99skjJ7NeTSxuLTovXTNyXX9NVIvRnQ4n9yYNfS886/1ViKc5INNRiLipOBAB76mw2
        8wIAAA==
X-CMS-MailID: 20220123192019epcas5p3c2af6ef38e644adaf9ecd7efbb6ba840
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192019epcas5p3c2af6ef38e644adaf9ecd7efbb6ba840
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192019epcas5p3c2af6ef38e644adaf9ecd7efbb6ba840@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Tesla Full Self-Driving SoC. The
pinctrl hardware IP is similar to what found on most of the
Exynos series of SoC, so this new compatible is added in
Samsung pinctrl binding.

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 28f0851d07bb..989e48c051cf 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -56,6 +56,7 @@ properties:
       - samsung,exynos7885-pinctrl
       - samsung,exynos850-pinctrl
       - samsung,exynosautov9-pinctrl
+      - tesla,fsd-pinctrl
 
   interrupts:
     description:
-- 
2.25.1

