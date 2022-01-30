Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9D4A34D5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354308AbiA3HT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:19:56 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25147 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354298AbiA3HTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:19:48 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220130071947epoutp030a7a3450a1a8b71b18d1c7d1c86b0ae2~O_0TXya_C1928019280epoutp03I
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:19:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220130071947epoutp030a7a3450a1a8b71b18d1c7d1c86b0ae2~O_0TXya_C1928019280epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643527187;
        bh=9vgmPNJq/3WdbFnyXKzjrJwghVU4KdUHPkLn9EtMO8Q=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=E3U/xSijI46AWa7uAiIy0XW2m1qcj46Y3qZD+yXNsJ0/A6en2vet3981MvuomcOKK
         DfB8VXDr1pi+LVDzQyYuy79RKgHUF81dDg3Cks+oVsIg/lXQd7JKdEBHKN7eEkslur
         lgJgkjZqAt+ETRRWZaTJZa/JYadOoifGirxXYSDQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220130071946epcas5p121ee3031648a4f861647661ac54eb03d~O_0Sompa30960109601epcas5p1N;
        Sun, 30 Jan 2022 07:19:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JmjHz0Gghz4x9Pq; Sun, 30 Jan
        2022 07:19:43 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.E2.06423.E0C36F16; Sun, 30 Jan 2022 16:19:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220130071941epcas5p185123e164e54f617a30f218bd230bcdd~O_0OR803Y3033630336epcas5p1s;
        Sun, 30 Jan 2022 07:19:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220130071941epsmtrp1e799b3e0acbf613b0b06587078d4d288~O_0ORMK931988519885epsmtrp1F;
        Sun, 30 Jan 2022 07:19:41 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-96-61f63c0e09de
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.50.08738.D0C36F16; Sun, 30 Jan 2022 16:19:41 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220130071939epsmtip169c2542cfb57c3693cadf5fdc3d0eb0b~O_0MW9viT2036420364epsmtip1f;
        Sun, 30 Jan 2022 07:19:39 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'kernel test robot'" <lkp@intel.com>
In-Reply-To: <20220129173407.278591-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH] clk: samsung: fix missing Tesla FSD dependency on
 Exynos
Date:   Sun, 30 Jan 2022 12:49:38 +0530
Message-ID: <00d701d815a9$bf5cb590$3e1620b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbacB8xi39A4aNy2EMeqYq4MIzHwG19YigrGbP2AA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmli6fzbdEgwev1C2uf3nOarHx7Q8m
        i48991gtLu+aw2Yx4/w+JotXzY/YLC6ecrU4/Kad1eLftY0sFqt2/WF04PJ4f6OV3WNWQy+b
        x85Zd9k9Fu95yeSxaVUnm0ffllWMHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzlix4wRzwSz+iq4dSxkbGPt4uxg5OSQETCS2
        nD/I3MXIxSEksJtR4tGso0wgCSGBT4wSr08nQCQ+M0rsOX2RDabj+bJ/TBCJXYwSDxq3sUE4
        Lxkl2i/vZAapYhPQldixuA0sISLQyizxcnUjI0iCWUBTYsGsNywgNqeAh8T1I5fAbGEBf4mv
        d3+A7WYRUJW4cWQZmM0rYClx7dQrFghbUOLkzCcsEHPkJba/ncMMcZKCxM+ny1hBbBEBK4l7
        0x+zQ9SIS7w8eoQd5AgJgQMcEodmn2CCaHCRWHD9DCuELSzx6vgWdghbSuJlfxuQzQFkZ0v0
        7DKGCNdILJ13jAXCtpc4cGUOC0gJyC/rd+lDrOKT6P39hAmik1eio00IolpVovndVahOaYmJ
        3d1QSz0kds/7zj6BUXEWksdmIXlsFpIHZiEsW8DIsopRMrWgODc9tdi0wDAvtRwe38n5uZsY
        wYlXy3MH490HH/QOMTJxMB5ilOBgVhLhnbHpU6IQb0piZVVqUX58UWlOavEhRlNgaE9klhJN
        zgem/rySeEMTSwMTMzMzE0tjM0Mlcd7T6RsShQTSE0tSs1NTC1KLYPqYODilGpiszQpmOiYz
        v259bfTaZ86UNwdFZdguseYKLV8ZLbzwpUvI+8aZScXii0V8qhjXGX7K4PlgOYk91lToxJvk
        vi3lL3nq1LjXFcWwys2cJ1qwftmG2/ZLMreXZRj+27jnlP3thrfz1gcpb41TOB0e9Gar4ZaA
        W2eFf9oqln96yaSxVu6Sa47JbYElWxR9WRvaOK3ss0/Kp4WE/OCQKa54eXeV7wTNa/+Lf4uG
        bg1Zt6BFUH3+KTGLtovm8zPC2aYUdDK4LrnadHy6rVbcos8zBOs6VteFvDw42/tBhuGpv7em
        r9KqOzfPxCdapvTo+Xc73KVqDp4wiLnUdH4it8H6K7MOV6qsvXrhad2D65P9znEqsRRnJBpq
        MRcVJwIAisxKFkUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnC6vzbdEg1sLRSyuf3nOarHx7Q8m
        i48991gtLu+aw2Yx4/w+JotXzY/YLC6ecrU4/Kad1eLftY0sFqt2/WF04PJ4f6OV3WNWQy+b
        x85Zd9k9Fu95yeSxaVUnm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlrNhxgrlgFn9F146l
        jA2MfbxdjJwcEgImEs+X/WPqYuTiEBLYwShxbMcxFoiEtMT1jRPYIWxhiZX/nrNDFD1nlOhb
        +YoZJMEmoCuxY3EbG0hCRKCbWWLjj4tg3cwCmhILZr1hgeiYySjx5vpbsA5OAQ+J60cugRUJ
        C/hKtPzbyARiswioStw4sgzM5hWwlLh26hULhC0ocXLmEyCbA2ionkTbRkaI+fIS29/OYYa4
        TkHi59NlrCC2iICVxL3pj9khasQlXh49wj6BUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nz
        iw0LjPJSy/WKE3OLS/PS9ZLzczcxguNPS2sH455VH/QOMTJxMB5ilOBgVhLhnbHpU6IQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTKH5PQ271kziuOn1
        6r8m29WlsQsVOWTigzvXpWwI4eHa92lX2PmjU9JbP8kv9D/rrrwjZ3JXT41/rvGt6Jnr5+dx
        s5VvNbpS1xCpd6S2SsfcZKJGpIHg2xdbmQ7fsDhWd9aH0/RSg3pJx91vZ3gWPc/+J9VkUSb2
        wmexDN8fNTNNr99bTdRMQiavKThRduld7k+36s/zOks2cii9nryjxiG6kvvYpoZdN64v/5+V
        fuF0Ls+739ufpnZt1V6XcPhynt78lzNPN6/e8Dap6yRv2Q3eCE2zutlzOWSlJv7dqZgmrdsw
        ofL+kn38wQ/+d1RtWHpC5eS7otsJr3d/P9/5w1fHhXG35tbW63su7lm121uJpTgj0VCLuag4
        EQDV4KMILgMAAA==
X-CMS-MailID: 20220130071941epcas5p185123e164e54f617a30f218bd230bcdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220129173417epcas5p35f8f3497b6465c07c481b62ceeff0ef0
References: <CGME20220129173417epcas5p35f8f3497b6465c07c481b62ceeff0ef0@epcas5p3.samsung.com>
        <20220129173407.278591-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Saturday, January 29, 2022 11:04 PM
>To: Sylwester Nawrocki <s.nawrocki@samsung.com>; Tomasz Figa
><tomasz.figa@gmail.com>; Chanwoo Choi <cw00.choi@samsung.com>; Alim
>Akhtar <alim.akhtar@samsung.com>; Michael Turquette
><mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski@canonical.com>; linux-samsung-
>soc@vger.kernel.org; linux-clk@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: kernel test robot <lkp@intel.com>
>Subject: [PATCH] clk: samsung: fix missing Tesla FSD dependency on Exynos
>
>The Tesla FSD clock controller driver uses shared parts from Exynos
>ARM64 clock drivers, so add proper dependency to fix COMPILE_TEST build
>errors like:
>
>  /usr/bin/aarch64-linux-gnu-ld: drivers/clk/samsung/clk-fsd.o: in function
>`fsd_cmu_probe':
>  clk-fsd.c:(.init.text+0x9c): undefined reference to
>`exynos_arm64_register_cmu'
>
>Reported-by: kernel test robot <lkp@intel.com>
>Fixes: e3f3dc3810d3 ("clk: samsung: fsd: Add cmu_peric block clock
>information")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
Thanks Krzysztof for a quick patch 

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/clk/samsung/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index
>5f64c58f120f..8e8245ab3fd1 100644
>--- a/drivers/clk/samsung/Kconfig
>+++ b/drivers/clk/samsung/Kconfig
>@@ -129,6 +129,7 @@ config S3C2443_COMMON_CLK  config
>TESLA_FSD_COMMON_CLK
> 	bool "Tesla FSD clock controller support" if COMPILE_TEST
> 	depends on COMMON_CLK_SAMSUNG
>+	depends on EXYNOS_ARM64_COMMON_CLK
> 	help
> 	  Support for the clock controller present on the Tesla FSD SoC.
> 	  Choose Y here only if you build for this SoC.
>--
>2.32.0


