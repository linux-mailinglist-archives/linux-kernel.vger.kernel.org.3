Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E349290F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiARPA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:00:27 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28258 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiARPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:22 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220118150021epoutp013c26f60036d4be9a199ffde1392f6ecc~LZXATaMNH2722827228epoutp01-
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:00:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220118150021epoutp013c26f60036d4be9a199ffde1392f6ecc~LZXATaMNH2722827228epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518021;
        bh=6/sht/J3vL6KHT6G7ayiMbwhGBtFe7fMeK4nY3zeflg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxsD5sPisucU22TCOwxZ/1obclm7Ppb2a1zWDB2E7rN7Ktq/3/U+PY/VKKNui3GX2
         Di+iqHR6yRnz0SBzhyVATUhLgs5zeHZfIsVy02DDCwPtbQd+cswDwIrYfE8q0YQvTN
         gfP+QgFv2CUKTzSye0k1rxkT/6xR+deQP5kSs4EY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220118150020epcas5p492b8def59846813f480ddc20cddab647~LZW-i3Z692208322083epcas5p4F;
        Tue, 18 Jan 2022 15:00:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JdX4t5k99z4x9Pt; Tue, 18 Jan
        2022 15:00:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.9E.46822.4A5D6E16; Tue, 18 Jan 2022 23:58:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220118150014epcas5p2ac07759961be616d01de76026e58d4f5~LZW568Mtg2967629676epcas5p2S;
        Tue, 18 Jan 2022 15:00:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118150014epsmtrp1c7165ec4ac8822556c6e82fc5235e423~LZW55Iqc-2079320793epsmtrp1T;
        Tue, 18 Jan 2022 15:00:14 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-dc-61e6d5a44078
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.E0.08738.EF5D6E16; Wed, 19 Jan 2022 00:00:14 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150011epsmtip1bbee9f2857086e319085dc20cce105e9~LZW3vyY1q1211512115epsmtip1k;
        Tue, 18 Jan 2022 15:00:11 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH v2 01/16] dt-bindings: add vendor prefix for Tesla
Date:   Tue, 18 Jan 2022 20:18:36 +0530
Message-Id: <20220118144851.69537-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu6Sq88SDc58FbB4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1eHz9D5uDgMeaeWsYPX7/msToMauhl81j06pONo871/aweWxeUu9x
        5UQTq0ffllWMHv+a5rJ7fN4kF8AVlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE7Y8eyOewFa9krJp49y9rAuIqti5GTQ0LAROLpzC/sXYxc
        HEICuxkl5j54CuV8YpTY1nePCcL5zCixuOk8O0zLtqO7GSESuxglXlx9wQSSEBJoYZKY3O0A
        YrMJaEvcnb4FLC4i4CZxo7EDbBKzwFsmien7voMtFxZwkpj9bRmYzSKgKnF2ynQWEJtXwEZi
        8aw/UAfKS6zecIAZxOYUsJWY2jCVDWSQhMBKDomukyuhilwk1n/rZoSwhSVeHd8CdaqUxMv+
        NiCbA8jOlujZZQwRrpFYOu8YC4RtL3HgyhwWkBJmAU2J9bv0QcLMAnwSvb+fMEF08kp0tAlB
        VKtKNL+7CtUpLTGxu5sVwvaQmHpjOzSwJjBKrNt1mHUCo+wshKkLGBlXMUqmFhTnpqcWmxYY
        5aWWwyMqOT93EyM4hWp57WB8+OCD3iFGJg7GQ4wSHMxKIrxS9c8ShXhTEiurUovy44tKc1KL
        DzGaAoNsIrOUaHI+MInnlcQbmlgamJiZmZlYGpsZKonznk7fkCgkkJ5YkpqdmlqQWgTTx8TB
        KdXAxLI1ZPKlfIGwbpYP32f8t/oULvd58v4v+rKnbY9Uv+g+rr3zlYFGhGY6s+OkPJvk2RfK
        1vh3c7+au/rQWr61nxwkmxJZtpcUz9P98XVJQiuLK1tEzzv7xKPMasxc8hFTFt1yf8VnrMsi
        7WDzz+kLh8FrFlOehfvVsou/i2q0Cgt9fb9nw5JvAYK/ovWYHk2VP34o6POXqvluL6Sl3pRd
        +izrIRSlt4bh+Vp/ZfUPW7O9PebJTLkw2/hB95SXMtcLnJZe7jyx8flhjvqf9vJzspauOb99
        t2ysxEdfxj2aFjJXpqaYim7oW/Sp0taJe0bZpKvZIj1JXFdcL5WW65f3ySWGKwbW59qG7XlU
        GcCkxFKckWioxVxUnAgA1CpDkCoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSnO6/q88SDb5/5bF4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1eHz9D5uDgMeaeWsYPX7/msToMauhl81j06pONo871/aweWxeUu9x
        5UQTq0ffllWMHv+a5rJ7fN4kF8AVxWWTkpqTWZZapG+XwJWxY9kc9oK17BUTz55lbWBcxdbF
        yMkhIWAise3obkYQW0hgB6PE/2WZEHFpiesbJ7BD2MISK/89Z4eoaWKSeH9NFcRmE9CWuDt9
        CxOILSLgIdH27x5zFyMXB7PAXyaJr68fgg0VFnCSmP1tGdgyFgFVibNTprOA2LwCNhKLZ/2B
        OkJeYvWGA8wgNqeArcTUhqlsEMtsJC6unMY8gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi
        0rx0veT83E2M4ODX0trBuGfVB71DjEwcjIcYJTiYlUR4peqfJQrxpiRWVqUW5ccXleakFh9i
        lOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAFH9sUtn/+kSX7QI6HocfrH+d2bul82nt
        o8hHt38tF3At3ynzVLJH7hVLGueGN7O8Dp3lfm7yxYjhiUjIsXNhVz/lpjhtd9P9ahW5u+fe
        q2vL4q6c5+V4mfXY4jMrh3M7z4oVkgtuWYROv55pZD4n/f/i68VyC6R+nen45TJ9yex7Z1qd
        1/V95khos6/s0fpyrUnx23/Z25pH2RNnbzl8RDkjbFKFXZXoHr0ra/QYmC8XJwcW30k//PRI
        Sd1LgdCdIbc3/9zVKrJnm+KapK7+W78l/k++4GMj+63s58JVPPeO3JRQr9/gbqZ4hsdeMUYg
        iz3RSDK+1XDyokVSi/Ud1LR5FJ5o2y0vvXFk1bPVgUosxRmJhlrMRcWJACGYlXrtAgAA
X-CMS-MailID: 20220118150014epcas5p2ac07759961be616d01de76026e58d4f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150014epcas5p2ac07759961be616d01de76026e58d4f5
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150014epcas5p2ac07759961be616d01de76026e58d4f5@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for the Tesla (https://www.tesla.com)

Cc: linux-fsd@tesla.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 64c604752052..09fbef521394 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1209,6 +1209,8 @@ patternProperties:
     description: Shenzhen Techstar Electronics Co., Ltd.
   "^terasic,.*":
     description: Terasic Inc.
+  "^tesla,.*":
+    description: Tesla, Inc.
   "^tfc,.*":
     description: Three Five Corp
   "^thead,.*":
-- 
2.25.1

