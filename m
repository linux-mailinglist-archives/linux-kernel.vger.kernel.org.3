Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39FF49644C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351802AbiAURnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:43:11 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28568 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381953AbiAURmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:42:06 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220121174138epoutp019cf357178d6622f985de69e9267f9dd6~MWfrkvyvQ1378513785epoutp01T
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220121174138epoutp019cf357178d6622f985de69e9267f9dd6~MWfrkvyvQ1378513785epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786898;
        bh=4HkzwrHZHTOLVm8bvp/nAaK6ObaRJ0G92SKKDYrFwU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ssfdm3WjliOWjIRehRMOE9SmqOuE0YjKl+ZPNk03AzNHev3LxnwC9NL8xoyXzxFfo
         gHFM4M618Xh54ZSdSWp0cXNDOUD66MFGdgV4GnY5rztECoKaRvjgJJQ4Sy3Ld1NOF7
         itjoyo2bbiR0EVdHN2VKQyZkkGTisXR77uIs561c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220121174136epcas5p17ad3363fd52b2e7e4b25982b3c615580~MWfqRiIDd2780827808epcas5p1H;
        Fri, 21 Jan 2022 17:41:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JgRWY3t5Dz4x9Pp; Fri, 21 Jan
        2022 17:41:29 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.C5.05590.640FAE16; Sat, 22 Jan 2022 02:41:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174126epcas5p281335ae041b65918d0e6675f5c6d44ba~MWfgPMdUM0949909499epcas5p2z;
        Fri, 21 Jan 2022 17:41:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174126epsmtrp126cbf4ee1032cf6b671ed3380ad9bbb2~MWfgOWIX12608726087epsmtrp1m;
        Fri, 21 Jan 2022 17:41:26 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-54-61eaf0462d98
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.C7.08738.540FAE16; Sat, 22 Jan 2022 02:41:25 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174123epsmtip21d528796f6e18a757f022f8248ee18df~MWfd7CwK91229812298epsmtip2b;
        Fri, 21 Jan 2022 17:41:23 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v3 16/16] arm64: defconfig: Enable Tesla FSD SoC
Date:   Fri, 21 Jan 2022 22:58:40 +0530
Message-Id: <20220121172840.12121-17-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmlq77h1eJBmsPM1o8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM31uOMhXsZ604vXEdYwPjE5YuRk4OCQETiV8X
        TjN1MXJxCAnsZpR4ur+fFcL5xCix83EjO4TzmVFiy6/vzDAtjSdWMkIkdjFKfH5/DqqlhUli
        7uEzjCBVbALaEnenb2ECsUUE3CRuNHaALWEW+M8ksbFnGRtIQljAQeL17yZWEJtFQFVi7tlL
        YHFeAVuJFW8WskOsk5dYveEA2GpOoPjrs/OYQQZJCGzhkHi3fRvUTS4Sp5qPsEHYwhKvjm+B
        apaSeNnfBmRzANnZEj27jCHCNRJL5x2DhoC9xIErc1hASpgFNCXW79IHCTML8En0/n7CBNHJ
        K9HRJgRRrSrR/O4qVKe0xMTublaIEg+JmduzIcEwgVHiW9NUtgmMsrMQhi5gZFzFKJlaUJyb
        nlpsWmCcl1oOj6jk/NxNjOBkquW9g/HRgw96hxiZOBgPMUpwMCuJ8Bbkv0oU4k1JrKxKLcqP
        LyrNSS0+xGgKDLGJzFKiyfnAdJ5XEm9oYmlgYmZmZmJpbGaoJM57Kn1DopBAemJJanZqakFq
        EUwfEwenVAMTk4rEs1anXWVmrww1/rKFZf5P42++s3SzpXN5m/oNgfkezd2/txje9f++0Fne
        ++o7/cMtMawdKdav65NWPlnXe/+d1rM67SPyXIsmLG/Jc+PawdDwYF2kXMJL5ntHt0rl8icb
        Mq0VOr7p1OQvaQ2T+7Sv6XRqObXM1uE8cqHIjt3ZYfWt/cWKW2R2Jrc8ZZo2u8O8/gBbTFFO
        3dSDLd8rmlxYGKxSZxr+O+Sx+hPbpje814unN87bJZJ+9IDzrwk821quT9udfcFmZuvHjOMX
        TMNivrSveVDYoPVMrWHZjs2KPrp1bA+Vq3gqjji5vfkxQ+20ccbji+7NGzZdODXDVsJGfyaz
        xJs3MUem5U5UYinOSDTUYi4qTgQADxQjqi8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvK7rh1eJBneXWVk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8bvLUeZCvazVpzeuI6x
        gfEJSxcjJ4eEgIlE44mVjF2MXBxCAjsYJX687mWHSEhLXN84AcoWllj57zk7RFETk8S7R8vA
        EmwC2hJ3p29hArFFBDwk2v7dYwYpYhaYyCyxce9ZsBXCAg4Sr383sYLYLAKqEnPPXmIDsXkF
        bCVWvFkItUFeYvWGA8wgNidQ/PXZeWC2kICNRPOsrUwTGPkWMDKsYpRMLSjOTc8tNiwwykst
        1ytOzC0uzUvXS87P3cQIjgUtrR2Me1Z90DvEyMTBeIhRgoNZSYS3IP9VohBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1Mwi3bI8S3dUrb3K14KyTWusZ/
        I/eRztjHn7McL1VtKY+cZLJY6dkcxX96bFWJs3clNNX1lzlKJFbtzpr/VbUmfNuDfbMZbp0o
        d6u222jg5X22S8Rpy75y2W0lRkk7kmp29ojcb15068ka2+R/TwpX1dmkl7rIzBXzO/zqWcFB
        lnYF9fJNDd4Xvi3fxJQa1hazZiXrC2bVxs7ZB3a2pB3nCGdw2t7hWqK3ttf9zqpNN0/E2pt5
        Jzz6/WLbu+zbj2UE0oqYnjDUPzk+ddLSB6tF7pV9mFZeESjf7XDs8h7GTUZbNS/yeM6eukpS
        YULVnEtnumfsiTw70X9asfeGy2tf94X2GO3aeCg7UmpV9MpIJZbijERDLeai4kQA1l3oAvQC
        AAA=
X-CMS-MailID: 20220121174126epcas5p281335ae041b65918d0e6675f5c6d44ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174126epcas5p281335ae041b65918d0e6675f5c6d44ba
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174126epcas5p281335ae041b65918d0e6675f5c6d44ba@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the Tesla FSD SoC in arm64 defconfig.

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ee4bd7710a0d..7dd0693a233e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -54,6 +54,7 @@ CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_INTEL_SOCFPGA=y
 CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_TEGRA=y
+CONFIG_ARCH_TESLA_FSD=y
 CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_THUNDER2=y
-- 
2.25.1

