Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8655F497536
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiAWTVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:21:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:41637 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbiAWTUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:52 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220123192051epoutp03a8d979a3497be77226f7f9b38dd44e62~M-I4IVNv42678526785epoutp03n
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220123192051epoutp03a8d979a3497be77226f7f9b38dd44e62~M-I4IVNv42678526785epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965651;
        bh=20DD9ZfqdzeIRvLdgr8SyGYaXTaluXzTMYIGxQu91xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIskFPMabVh418TRBqgXpYHn9dTRFg+9E5d6wQeOW3aDDZZkWM/63sUcT71g5NZu7
         7oWBfk8Rp6831SAU/Z/yAElLXHDTC5fk+v9EvsW0Y0LMC26WjDenyhKUmcBuq3uMHD
         D724GthEjUll14NriWuWP11gkhlWZg/o1NVC1fI8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220123192049epcas5p1f403eaed071cde30e464d74ddfed8f04~M-I3BHEPO0431504315epcas5p1C;
        Sun, 23 Jan 2022 19:20:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jhjd50M2Fz4x9Pv; Sun, 23 Jan
        2022 19:20:41 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.FD.05590.88AADE16; Mon, 24 Jan 2022 04:20:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220123192039epcas5p3fc21ed81a383a05f1ea1704481641c69~M-ItyEnvt1076210762epcas5p3E;
        Sun, 23 Jan 2022 19:20:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123192039epsmtrp2e1c504a2666e3e37e5137a606b44bf3b~M-ItxG_EL2018820188epsmtrp2q;
        Sun, 23 Jan 2022 19:20:39 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-06-61edaa888ddc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.F7.29871.78AADE16; Mon, 24 Jan 2022 04:20:39 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192037epsmtip14c08f325fa1cd561400ae42cf9667787~M-IreTbo30799407994epsmtip1F;
        Sun, 23 Jan 2022 19:20:37 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v4 16/16] arm64: defconfig: Enable Tesla FSD SoC
Date:   Mon, 24 Jan 2022 00:37:29 +0530
Message-Id: <20220123190729.1852-17-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmlm7HqreJBi9Wmls8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMM38XsxbsZ62Ytv48cwPjE5YuRk4OCQETiYYH
        J1lBbCGB3YwS286KdzFyAdmfGCU+9v9ghnC+MUpseHubrYuRA6zjxL4siPheRokbnw6wQTgt
        TBJPXi8FG8UmoC1xd/oWJhBbRMBN4kZjBxNIEbPAfyaJjT3LwCYJCzhI3GviBzFZBFQlfixi
        BCnnFbCRuLzlJyvEdfISqzccYAaxOYHiva8+QMV3cEg0Hq2BsF0k/k35wARhC0u8Or6FHcKW
        kvj8bi/UzdkSPbuMIcI1EkvnHYN63l7iwJU5LCAlzAKaEut36YOEmQX4JHp/P2GC6OSV6GgT
        gqhWlWh+dxWqU1piYnc31DEeEk/+TWWEBEI/o8SzM0eZJjDKzkKYuoCRcRWjZGpBcW56arFp
        gXFeajk8kpLzczcxgpOolvcOxkcPPugdYmTiYDzEKMHBrCTCW5D/KlGINyWxsiq1KD++qDQn
        tfgQoykwwCYyS4km5wPTeF5JvKGJpYGJmZmZiaWxmaGSOO+p9A2JQgLpiSWp2ampBalFMH1M
        HJxSDUx7tZRNRC2DMtMj/fYXXynXjDxez5ozp/fP+9d/lnFsyckQ/Lr556sTrK8Vp7IzmiQc
        kVEUC46dzSP5u05x76srO757Ps3wvF12+ufLnsmakzfwPe++EK3wLMg8SEiycOGMveG/L9ex
        18atTSudsdzxe8+dJ0Lhe0M0uvv2iGf1CXVdPrliQs76EPXpt6ovbXbaJ2bLuOSwt8DULXOe
        WD35Nv/9ip+bwj59nHJy2sknvCr38zU2zZ/ZHW+jmRd6/YmD6e5/pjxSUw+fvWz/Or771QqW
        9bGbPrzguHrk47GUO/cDmD2rXaetY924vM1rF9P1OWpnvn0v27Zu/aakJUsuzk7hmzLVI+7z
        8WnvC10KnJVYijMSDbWYi4oTARlmgIkrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnG77qreJBov/61o8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8aZv4tZC/azVkxbf565
        gfEJSxcjB4eEgInEiX1ZXYxcHEICuxklTs+dwt7FyAkUl5a4vnEClC0ssfLfc3aIoiYmiTcX
        ljGCJNgEtCXuTt/CBGKLCHhItP27xwxSxCwwkVli496zYBuEBRwk7jXxg5gsAqoSPxaBtfIK
        2Ehc3vKTFWK+vMTqDQeYQWxOoHjvqw+sIOVCAtYSE47KTWDkW8DIsIpRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzgGtDR3MG5f9UHvECMTB+MhRgkOZiUR3oL8V4lCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MEVMrFmZPtm9U2LG1FWJQS+L
        pz7hWurvPDEv7Jvopb+BvfetFl34Yf5ZMMzBSJ/ptuGZZR+5RL/prA1s+bPozoEzH5O888/o
        fy7Of6LU+4n7fS93lsz/++f+rC8+s4RPIPvsAVvzOMfmHbxnow9PZtR6tMc7Ot+f3X+FQb3n
        HsuN0aK7HnuwqXmdWfx67vrFt+s3JJ95sfZi+KtJmW/OCF6dd1Ht7m/VbVK/bnErdSfzTw9S
        m9dzS2rF9dTqlf67r88tZnUSZ//13F4ltb8gaukuru8i/6r/iBwz99vmPF3tz7MsH9EXN1Yu
        c9sespfL8Xqnneejt36+n6cmuVz1frV1m8UFtmMVuzQyD2pfP/hfiaU4I9FQi7moOBEAJUax
        Y/ACAAA=
X-CMS-MailID: 20220123192039epcas5p3fc21ed81a383a05f1ea1704481641c69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192039epcas5p3fc21ed81a383a05f1ea1704481641c69
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192039epcas5p3fc21ed81a383a05f1ea1704481641c69@epcas5p3.samsung.com>
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
index 30516dc0b70e..415fb3aca4b3 100644
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

