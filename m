Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC648D7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiAMMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:16 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25392 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiAMMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:38 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220113122436epoutp03a00a05c40d548e0dd0234691747931dd~J1AmFLTh11524915249epoutp03_
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220113122436epoutp03a00a05c40d548e0dd0234691747931dd~J1AmFLTh11524915249epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076676;
        bh=gO5D2Xce5XFq8/WJ+w6Tn6jCeHMALXsWKmg8CK4wbJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHqvXjkl4vnpMoutLJLlbLyH+579Sx7hO8rZqHrFrNSFqtmHE8S4z1GFbmLbqO2yg
         TUmrC+r2k+R4BUnD+DoFKMpq+FzupMG/gQyZfUGxS/c2+KCKOH/2QREpKGQm7FE3x2
         DgQOFDrr7tgdZUzHJXbp86CYLefBWggs74mQdtn4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122436epcas5p37c8abe2fe6cbcf48d559a3a5d2c22492~J1AlnYd5N2339223392epcas5p3h;
        Thu, 13 Jan 2022 12:24:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JZNsS1kHBz4x9Py; Thu, 13 Jan
        2022 12:24:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.C6.06423.BF910E16; Thu, 13 Jan 2022 21:24:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122427epcas5p1885d8b3b735e8f127b6694a309796e5a~J1AeGJuzK2652426524epcas5p1u;
        Thu, 13 Jan 2022 12:24:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122427epsmtrp28e9526019818269cd8fdff94c051f120~J1AeFReUR3235332353epsmtrp2T;
        Thu, 13 Jan 2022 12:24:27 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-fd-61e019fb900d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.A8.29871.BF910E16; Thu, 13 Jan 2022 21:24:27 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122423epsmtip298768b2223b43fd5d57cfa740a145cdc~J1AaOHOXy1245212452epsmtip2z;
        Thu, 13 Jan 2022 12:24:23 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Adithya K V <adithya.kv@samsung.com>
Subject: [PATCH 17/23] Documentation: bindings: Add fsd spi compatible in
 dt-bindings document
Date:   Thu, 13 Jan 2022 17:41:37 +0530
Message-Id: <20220113121143.22280-18-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmpu5vyQeJBlu2G1scmPCK1eLBvG1s
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHrMaetk8Nq3qZPO4c20Pm8fmJfUeV040sXr0
        bVnF6PGvaS67x+dNcgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5
        qbZKLj4Bum6ZOUBfKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz
        0vXyUkusDA0MjEyBChOyMzqOzWEpWMRR8WbTSaYGxg72LkZODgkBE4kp7/aygdhCArsZJdqb
        HCHsT4wSrX8juhi5gOxvjBK/Xp5mhGlYtr2XFSKxl1Fi19ytTBBOC5PE3bPHwarYBLQl7k7f
        wgRiiwi4Sdxo7AArYhZoYZaYfHQmM0hCWCBB4s/8W2A2i4CqxOGtv8Fu4hWwlXj/qYUNYp28
        xOoNB4BqODg4geJ3V+WBzJEQWMohsfTzSxaIGheJSxNXQ9ULS7w6vgXqNymJz2C/cQDZ2RI9
        u4whwjUSS+cdg2q1lzhwZQ4LSAmzgKbE+l36IGFmAT6J3t9PmCA6eSU62oQgqlUlmt9dheqU
        lpjY3c0KYXtInFvwhRkSDBMYJb423GWewCg7C2HqAkbGVYySqQXFuempxaYFhnmp5fBoSs7P
        3cQITppanjsY7z74oHeIkYmD8RCjBAezkghvf9H9RCHelMTKqtSi/Pii0pzU4kOMpsAQm8gs
        JZqcD0zbeSXxhiaWBiZmZmYmlsZmhkrivKfTNyQKCaQnlqRmp6YWpBbB9DFxcEo1MAXEvQo8
        OdnQ4YoFz/eTFZNSp/J93bFIWufKx56CtJa1WjtKmB7lcdcvnSqbnKug557qvfAY33Pmkypd
        73nOR6lwbOxUNmX+eFvvx9Sns6ffyxWavpxBPYLBu7y4QvOmZBTDhN9GistLsjTTirWVaz2O
        Lg/oMpn0WzWi2CYzcKrZ7Ld7ys8sk0r7M7MoYqKIsQrTcvbjQWq2bJ03u29Nc0iUf1r+mc/b
        keeyun5rqufKjvrpFgxmcg5cHfUdX+QXbXV34pR3+1m296tS6R7hxTeY/5g7Mi/MORgyXeFy
        x/M0Tq0z8zqqkufX7e9MeczEEeZ6s2vRXqag1rxs7xcP4wwWWG/IkYtzce5ctkCJpTgj0VCL
        uag4EQBaNLr6IwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvO5vyQeJBk1vpS0OTHjFavFg3jY2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOKC6blNSczLLUIn27BK6MjmNzWAoWcVS82XSSqYGxg72LkZNDQsBE
        Ytn2XtYuRi4OIYHdjBLnpl1lg0hIS1zfOAGqSFhi5b/n7BBFTUwS975fZwZJsAloS9ydvoUJ
        xBYR8JBo+3ePGaSIWWAKs8Tm/9/BioQF4iTa721lBbFZBFQlDm/9DTaVV8BW4v2nFqht8hKr
        NxwAqufg4ASK312VBxIWErCROPdqPdsERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1
        kvNzNzGCg15Lcwfj9lUf9A4xMnEwHmKU4GBWEuHtL7qfKMSbklhZlVqUH19UmpNafIhRmoNF
        SZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTamkt24+mjidzgiYzzUxbL3E87uYtxY/SPNdP
        PVLbaXplvkTNPTPuB/9C7C8VP39YeET0y/JZJWmhdy+/XnDCsz1K//SN7OOylsxfU3le9qZ5
        X9l0iK0oqXHZ0Qs50xOUd+ayMDbtN3+baqvivMyA0ebvhI15HLvV1h57xul4iOuG4RQ9We4v
        vTHXapYUnnv8is/3v2XDdsdHxfs+iqx1P+p62mVPLPsJf/ufpzTCek9zHo2d03ewqlesY46Y
        6dHdq7bHVVyYuy5XZMozsZa7uSISehJFX17uUmjT99RiLv4yN5J1WdXujGO7xCL05+34+tap
        YJbRkpXzDjdMrEwsVgnSfVDI9bNO4vbj7aH7lViKMxINtZiLihMBUYWKCOkCAAA=
X-CMS-MailID: 20220113122427epcas5p1885d8b3b735e8f127b6694a309796e5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122427epcas5p1885d8b3b735e8f127b6694a309796e5a
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122427epcas5p1885d8b3b735e8f127b6694a309796e5a@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds spi controller dt-binding compatible information for
Tesla Full Self-Driving SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Adithya K V <adithya.kv@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 49028a4f5df1..3af2408454b4 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -11,6 +11,7 @@ Required SoC Specific Properties:
     - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
     - samsung,exynos5433-spi: for exynos5433 compatible controllers
     - samsung,exynos7-spi: for exynos7 platforms <DEPRECATED>
+    - tesla,fsd-spi: spi controller support for Tesla Full Self-Driving SoC
 
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
2.17.1

