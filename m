Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68E498264
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiAXOaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:46 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:48208 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiAXOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:30:11 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220124143009epoutp04a66913182c72aabd147391b1747131d6~NO0WzrUGn2185021850epoutp04d
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:30:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220124143009epoutp04a66913182c72aabd147391b1747131d6~NO0WzrUGn2185021850epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034609;
        bh=20DD9ZfqdzeIRvLdgr8SyGYaXTaluXzTMYIGxQu91xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZhxuCjnNYa6gOhdz+dKCKRatBrxxO2dzd0pSeIG6gAggVbrHJwM3XoFrrX1sdYkA
         90iKUqB/30U3lQfJ2qWmFu1YBSRoByzOsKfyojN7Zz8oWoKsxqgT3YG/R/o+JfOLRv
         Mv7olzN+Orf3nGsO9g8wtBEdOYTHc0cLxj/ax2R0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220124143008epcas5p2bb837ff8cf602145bc5c095dda672815~NO0V9kiRs2966029660epcas5p2L;
        Mon, 24 Jan 2022 14:30:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JjC7K4qdqz4x9Pp; Mon, 24 Jan
        2022 14:30:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.AE.06423.DE7BEE16; Mon, 24 Jan 2022 23:30:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220124143005epcas5p103598aa358ac35fe5e1ee762faf508b0~NO0SsNLtz2099820998epcas5p10;
        Mon, 24 Jan 2022 14:30:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124143005epsmtrp1037a66a6b091dfba90a2804bc822bad1~NO0SrVxqR2824028240epsmtrp1A;
        Mon, 24 Jan 2022 14:30:05 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-d6-61eeb7ed8a7d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.BB.08738.DE7BEE16; Mon, 24 Jan 2022 23:30:05 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124143002epsmtip143653e4940264b251bcd9b8d509793be~NO0QdrvR92189021890epsmtip1H;
        Mon, 24 Jan 2022 14:30:02 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v5 16/16] arm64: defconfig: Enable Tesla FSD SoC
Date:   Mon, 24 Jan 2022 19:46:44 +0530
Message-Id: <20220124141644.71052-17-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhu7b7e8SDc7tVLR4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HdtI4vF4+t/2BwEPdbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofN
        Y/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoH+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZZ/4uZi3Yz1oxbf155gbGJyxdjJwcEgImEiv2
        TAeyuTiEBHYzSmxrmMgG4XxilJj04DIThPOZUeLUhPXMMC2zJ85ghUjsYpT4/2sjM4TTwiTx
        8vk/NpAqNgFtibvTtzCB2CICbhI3GjvARjEL/GeS2NizDKxIWMBB4kVLP1A3BweLgKrE8+vJ
        IGFeAVuJTyfWskJsk5dYveEA2GZOoPi8hd/A5kgI7OGQuNBxhwWkV0LARWL2zRCIemGJV8e3
        sEPYUhIv+9vYIUqyJXp2GUOEaySWzjsG9b+9xIErc8CmMAtoSqzfpQ8SZhbgk+j9/YQJopNX
        oqNNCKJaVaL53VWoTmmJid3dUEd6SLy42g0NxQmMEnundTFOYJSdhTB1ASPjKkbJ1ILi3PTU
        YtMCw7zUcng8JefnbmIEp1Itzx2Mdx980DvEyMTBeIhRgoNZSYS3KuVdohBvSmJlVWpRfnxR
        aU5q8SFGU2CATWSWEk3OBybzvJJ4QxNLAxMzMzMTS2MzQyVx3tPpGxKFBNITS1KzU1MLUotg
        +pg4OKUamNbuj1CzTLb2257mpVWo0vN6Sr314WvnrlsI5kZq131Ojf7s+0TlV+Pi1T81z5fu
        evmXxX1lZ0DruYLTV798zHjmWsKTP5PhtolKxzVFPa5f3WeTL/5wefPhs8CiV0n16Y11rA+e
        rVp/tsJdwPW4i8gc/v/Smw7uWvpn2j1//8dL2eV9bnFuCamW+H1jsbTwa/G9ufP273KJP/DF
        9c98jWYdMfX289eDlL/36D3/UyU4S+3LP45jKj/faoYdrjjlcJHpi1GCG3uX+OmNYe8spzY+
        vbqsIfaZ+VWRnQE5KRcS07fJ/N5wgv2ufNOEv8/6K0v8Nng28G8Titmq+CUgyILl77UfM5tL
        xC5O6nyQ0qbEUpyRaKjFXFScCADzD9EoLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO7b7e8SDaZdYbV4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HdtI4vF4+t/2BwEPdbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofN
        Y/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK4oLpuU1JzMstQifbsErowzfxezFuxnrZi2/jxz
        A+MTli5GTg4JAROJ2RNnsHYxcnEICexglPj24gEbREJa4vrGCewQtrDEyn/P2SGKmpgkTvY8
        ZAVJsAloS9ydvoUJxBYR8JBo+3ePGaSIWWAis8TGvWfBVggLOEi8aOkHSnBwsAioSjy/ngwS
        5hWwlfh0Yi0rxAJ5idUbDjCD2JxA8XkLvzGBlAsJ2Eic+60ygZFvASPDKkbJ1ILi3PTcYsMC
        o7zUcr3ixNzi0rx0veT83E2M4DjQ0trBuGfVB71DjEwcjIcYJTiYlUR4q1LeJQrxpiRWVqUW
        5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAJPbs2cP3es0LuTcu5mRs
        VC6SiGx7vrHMq67ulS7j0X3fy9hvKixttp0S0TmFa/OaM5P7biU80dHiFou85h/ozLvrS+vr
        hMlqNi+5C4MnfzT/l7rZbfpDzuPzjuqnJc19ujiDe4PPyd8+V7StTy7ZriF2dF/qypnB1368
        k1e7NfnXLb3jsl8Xz7luFv0zN8tw7drzYsq1ASLnA3bL2qh+D/2Y+fzmGn7FUB1jjVIhjsnX
        BV+KKD3oaU6wSC0Rz2DZbFf/XHJtnYzUlCffH/ZZ/xJ7e6ntjWXwu6SDmQmr7hSd67nNeGdR
        2kJ7vd6yiaLdG+6+erigc+mOw4dviMye+MI0f1XgyjtZ5YujGTrttymxFGckGmoxFxUnAgB7
        h8ho8gIAAA==
X-CMS-MailID: 20220124143005epcas5p103598aa358ac35fe5e1ee762faf508b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124143005epcas5p103598aa358ac35fe5e1ee762faf508b0
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124143005epcas5p103598aa358ac35fe5e1ee762faf508b0@epcas5p1.samsung.com>
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

