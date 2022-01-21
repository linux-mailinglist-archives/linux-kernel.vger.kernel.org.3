Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68074496444
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381926AbiAURnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:43:05 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16398 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351856AbiAURlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:41:24 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220121174114epoutp028ef16984b5261d734fe3c61c0cc90cb3~MWfVLOuFP0775707757epoutp02h
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220121174114epoutp028ef16984b5261d734fe3c61c0cc90cb3~MWfVLOuFP0775707757epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786874;
        bh=VvOW6/hCyAo0ZBnyGVkfkxIXPNa25JMGNCASZTiNRG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpvagFjkrWQHHR8pDBiMDanBtmDMXPcuVwvneEhCMOGYj2hQh+xjpTNoqs7GwQXa7
         1YnR2srRyP/dO3j3xcx0ZKI5YrVeC0/QbN6q0vxyYQgQ/gfjprEa2u1swSUi14wYre
         aUG2MYWpZdyj0lDYKmMq41MtAaCpau7SGQ50LQLo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220121174113epcas5p394bfd2d3c1bd1eaf75921543f51cccc5~MWfUNWWTK2795427954epcas5p3y;
        Fri, 21 Jan 2022 17:41:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JgRW64HYkz4x9Pr; Fri, 21 Jan
        2022 17:41:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.30.06423.230FAE16; Sat, 22 Jan 2022 02:41:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220121174105epcas5p4c2719b5f14d43cfa4f3b6dd160a74972~MWfNN4ta-0759707597epcas5p4P;
        Fri, 21 Jan 2022 17:41:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121174105epsmtrp260f63f169967fe8b91ec41f520c557b8~MWfNNDdAW1824918249epsmtrp2u;
        Fri, 21 Jan 2022 17:41:05 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-df-61eaf032bddf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.B7.08738.130FAE16; Sat, 22 Jan 2022 02:41:05 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174103epsmtip2bb73052d30b296bf44aa2af5917f563d~MWfK5uLUl0551005510epsmtip2F;
        Fri, 21 Jan 2022 17:41:02 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v3 11/16] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Date:   Fri, 21 Jan 2022 22:58:35 +0530
Message-Id: <20220121172840.12121-12-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmpq7Rh1eJBifmKFo8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMr02/2Qvmc1bceDqRqYHxL3sXIyeHhICJxOdV
        P1i6GLk4hAR2M0psWzQLyvnEKHFm+xZmCOczo8SGeWfgWp7vgGnZxSjxbPVuNginhUni/MrD
        YFVsAtoSd6dvYQKxRQTcJG40djCBFDEL/GeS2NizjA0kISwQLTF/w2pmEJtFQFWid/VCFhCb
        V8BWYsb5GawQ6+QlVm84AFbDCRR/fXYe2E0SAls4JL62LmaCKHKR+PN4HSOELSzx6vgWqFul
        JD6/2wu0jAPIzpbo2WUMEa6RWDrvGAuEbS9x4MocFpASZgFNifW79EHCzAJ8Er2/nzBBdPJK
        dLQJQVSrSjS/uwrVKS0xsbsb6koPiVkf90DDYQKjxLL+8+wTGGVnIUxdwMi4ilEytaA4Nz21
        2LTAMC+1HB5Tyfm5mxjB6VTLcwfj3Qcf9A4xMnEwHmKU4GBWEuEtyH+VKMSbklhZlVqUH19U
        mpNafIjRFBhkE5mlRJPzgQk9ryTe0MTSwMTMzMzE0tjMUEmc93T6hkQhgfTEktTs1NSC1CKY
        PiYOTqkGptzmqA/mHC6yIQZ8Dn7T84S/eeX1Ssx74NjyaluS8gmln1ofI/6ef1MufWZGowWr
        dVtenV8720zvddl3l9+K2qv1+95GCR/77lPBB6fLyN8xmlolqf3W6HP93OUyX1lb9SIWFsrJ
        uT5i1dP8dt7ebcnqn1US+hN4/i/bJFokHiLq0nTvIuOhO88Uzi5L+9w9u8rloWNx5PtFXNu+
        G3msrZA+KfAsqeJuSOYezR8SX+ZvVrC18tqQ3cQz28l6UsatuyJHzr3/9EzxQNLrw1NdVFIq
        Vvzf7Jv2nj/X+rjXgq2Or2Ss649wVRy07p/ToyC2b9WdiMrKvlP8VzSCFE8tnKgeHPmvo2jL
        Y9uDaTeuKrEUZyQaajEXFScCAFx25PUwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSvK7hh1eJBos3K1g8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8bXpt/sBfM5K248ncjU
        wPiXvYuRk0NCwETi+Y4fLF2MXBxCAjsYJR4fXM8MkZCWuL5xAlSRsMTKf8/ZIYqamCS2nv/K
        BJJgE9CWuDt9C5gtIuAh0fbvHjNIEbPARGaJjXvPsoAkhAUiJbq37mYFsVkEVCV6Vy8Ei/MK
        2ErMOD+DFWKDvMTqDQfANnMCxV+fnQdmCwnYSDTP2so0gZFvASPDKkbJ1ILi3PTcYsMCo7zU
        cr3ixNzi0rx0veT83E2M4FjQ0trBuGfVB71DjEwcjIcYJTiYlUR4C/JfJQrxpiRWVqUW5ccX
        leakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXANOlU+ayvW9ZGse9N6XD5zeup
        +u51hscCzY68u0cnzf2sM2dPkJFBzJHUgk1NMUGT+OXm32T7dWfnl2tfOMTjBdqmvfnMKs5X
        4WhZ5cL5ObJ+2pavIYeCo9dt//eUd4925nHmPeLCq+fNvGBlXXDwjpbnztbwXXcuPXQSiuyo
        KmEXO15UxrlwpcaE+QxPd02t+lg9e+EOzQipfpYJT+a13V6+W0yrevPDC7zxidXP8o88Pe55
        pfx2iuwGk2uutW6bT0p9+prtncF36s1Xm5nJl5mqd1helFAOkvPXDs/7HlJQ0yGs2vZHU3kR
        Z8NqBgfuH2cf23nftZHXFJo0ty/gnnIqxxPhK6Ge560TK8R3K7EUZyQaajEXFScCAJrs8jn0
        AgAA
X-CMS-MailID: 20220121174105epcas5p4c2719b5f14d43cfa4f3b6dd160a74972
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174105epcas5p4c2719b5f14d43cfa4f3b6dd160a74972
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174105epcas5p4c2719b5f14d43cfa4f3b6dd160a74972@epcas5p4.samsung.com>
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
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 9e70edceb21b..81747b88b718 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -25,6 +25,7 @@ Required Properties:
   - "samsung,exynos7885-pinctrl": for Exynos7885 compatible pin-controller.
   - "samsung,exynos850-pinctrl": for Exynos850 compatible pin-controller.
   - "samsung,exynosautov9-pinctrl": for ExynosAutov9 compatible pin-controller.
+  - "tesla,fsd-pinctrl": for Tesla FSD SoC compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
-- 
2.25.1

