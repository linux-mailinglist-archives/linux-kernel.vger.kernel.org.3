Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B149824C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiAXOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42116 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbiAXO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:48 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220124142947epoutp034aad23fe1eacabdb9d3aa47e8ed86a4a~NO0ByqcN51245112451epoutp03k
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220124142947epoutp034aad23fe1eacabdb9d3aa47e8ed86a4a~NO0ByqcN51245112451epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034587;
        bh=IsUOpJL8ombE3d2kJBRoIHDQ/zVrAi2acH1a4CUB5eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjACFRtpkpwqFyomcg2ehKtnqTR3FVnxw1/Xh2/DEodPwVB18FdgEcX81B3eV59uZ
         3FRbiMFhDAzzhnP5F2LndZeTYqEm9HMSC2X0gojAaY5CqDCxi60malsnIGk9CISERw
         XtrqB84+6vcWpV038pwtwIJ4KpUdtQgNTTo5ub7Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220124142946epcas5p1d3842843eb79bfa88ff7122523bcaa4f~NO0BVTesP3199131991epcas5p1N;
        Mon, 24 Jan 2022 14:29:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JjC6t1c8dz4x9Pq; Mon, 24 Jan
        2022 14:29:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.9E.06423.6D7BEE16; Mon, 24 Jan 2022 23:29:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220124142941epcas5p4bbba53cfc2fc9862da9fd85d44de6e79~NOz8vEFZY0826308263epcas5p4H;
        Mon, 24 Jan 2022 14:29:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142941epsmtrp216dfff3f610ff97b180df1c80ca28831~NOz8uMpRN1656816568epsmtrp2-;
        Mon, 24 Jan 2022 14:29:41 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-94-61eeb7d62b59
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.EA.29871.5D7BEE16; Mon, 24 Jan 2022 23:29:41 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142938epsmtip1ed1f66c32c286ea1221781e0a581eeee~NOz6RpRND0831608316epsmtip1k;
        Mon, 24 Jan 2022 14:29:38 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v5 11/16] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Date:   Mon, 24 Jan 2022 19:46:39 +0530
Message-Id: <20220124141644.71052-12-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhu617e8SDb6vYLN4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HdtI4vF4+t/2BwEPdbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofN
        Y/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoH+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZuy49ZixYyV7x9cAZlgbGaWxdjJwcEgImEtPu
        n2HvYuTiEBLYzShxbs4vFgjnE6PEhIXbWEGqhAS+MUrMW2MB07HvTisjRNFeRok3N1qg2luY
        JM6u/ccCUsUmoC1xd/oWJhBbRMBN4kZjBxNIEbPAfyaJjT3LwJYLC0RLfJt4gBHEZhFQlZi5
        /RdYA6+ArcS5xY3MEOvkJVZvOABmcwLF5y38BjZIQmALh8TGHSegilwkPj9dwAphC0u8Or6F
        HcKWkvj8bi/QMg4gO1uiZ5cxRLhGYum8YywQtr3EgStzWEBKmAU0Jdbv0gcJMwvwSfT+fsIE
        0ckr0dEmBFGtKtH87ipUp7TExO5uqKUeEicndEEDZQKjxIvbnxgnMMrOQpi6gJFxFaNkakFx
        bnpqsWmBYV5qOTyikvNzNzGCk6mW5w7Guw8+6B1iZOJgPMQowcGsJMJblfIuUYg3JbGyKrUo
        P76oNCe1+BCjKTDIJjJLiSbnA9N5Xkm8oYmlgYmZmZmJpbGZoZI47+n0DYlCAumJJanZqakF
        qUUwfUwcnFINTJOuVpRXKVn7fRefOGmyyQ0r2yTNyWpTF2xbuOGX4J/8Hec8OBpa4s6+svc2
        6skLU9Ay3Bh555qcyY8nuZ4Hs+W0Th08Kbuu9vAeTTvR+cu4+wukGuqvzjHcUy5/IvSkg3q3
        ja6eUP3yv/kXnx156vp9/Sau6K316o/eNOvyMOxf6jWPlfuvSFbhOQXZ+ScFK9gMXtkVCoUo
        Plt1rvnGdMmmCezP+KPFjlbMmGCs5+Vspf2jpEYi5c+HTQ1d55SkWkWfljHeyuOZ2vRJrGCP
        bMY1G9OO+54mZxas3tFgpHrAeu+DnS89S0yDDPdn6v37OnPRhM+Mj/kWTDX+9Gq/0+YdGvkO
        D9L+Rs/f/yDvuxJLcUaioRZzUXEiAGw+7bcvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO7V7e8SDea1yls8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8auS48ZC1ayV3w9cIal
        gXEaWxcjJ4eEgInEvjutjF2MXBxCArsZJWYd62SHSEhLXN84AcoWllj57zk7RFETk0R/ww2w
        BJuAtsTd6VuYQGwRAQ+Jtn/3mEGKmAUmMkts3HuWBSQhLBApcWXqZjCbRUBVYub2X2ANvAK2
        EucWNzJDbJCXWL3hAJjNCRSft/AbUA0H0DYbiXO/VSYw8i1gZFjFKJlaUJybnltsWGCYl1qu
        V5yYW1yal66XnJ+7iREcCVqaOxi3r/qgd4iRiYPxEKMEB7OSCG9VyrtEId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiu6ire39N41lnmDdNKRwONlIDH
        i3X+iXgx51wKl9w/PTIqX8jy98dTHTICbxWWaS8ufbuui3FXbe/jTtsUR7U7UUoBj1147Frr
        P20Wrp96Nner0Udvb+kzypUrrtV6qbTUSfmGTXbO5PFYPeUy85vYneUz3zarmaVsOrtHM2jL
        qpUf71rzPbxbtMS0/8fRjoZjudx8XrHcLyaZ7uiuLr79e6P+wd7+nxPNb5Y+U9OxtrS1vR+S
        Zd0p7cgR9WP9kcfXrP5//tV2WNwqwUr51IXKU6/v5TWckXI4fa/m7+5ki1uas3winrw6Z3ry
        5aqUubHXOSZkbJy/aXGc+5T4xo/6i/i8/xt4Wz/NPv6y4q8SS3FGoqEWc1FxIgALJyNP8wIA
        AA==
X-CMS-MailID: 20220124142941epcas5p4bbba53cfc2fc9862da9fd85d44de6e79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142941epcas5p4bbba53cfc2fc9862da9fd85d44de6e79
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142941epcas5p4bbba53cfc2fc9862da9fd85d44de6e79@epcas5p4.samsung.com>
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

