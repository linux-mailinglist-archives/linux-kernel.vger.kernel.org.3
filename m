Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5162C4974F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiAWTTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:19:53 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:45025 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiAWTTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:19:45 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220123191943epoutp024ccd2a5609390d0c3f8dd0a55eede1c7~M-H5N1CdE1706717067epoutp027
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220123191943epoutp024ccd2a5609390d0c3f8dd0a55eede1c7~M-H5N1CdE1706717067epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965583;
        bh=VTs4pezZK89zaRXir51JX7GQiNQXODvHZZBa1wpBqwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hem2mqHZTGWhqW1mexQS+HyGaBnOHaQQH+kV49jly6B1TfXXHCaiM0fBc/AmWoxNC
         VBIKQu+gzFWTEnOp3HC3IOOhH680lsSQ60ubdbAVfA7CilG7NU5FabbGVYnu4JxQd+
         OZbyZaS9h2pt0rcD9z9KhTVwvuIXo762c8AXh6PQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220123191942epcas5p25f095540c6b1cbf14e6fa57eef541bcb~M-H4Qw-gQ2292122921epcas5p2j;
        Sun, 23 Jan 2022 19:19:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jhjbs687tz4x9Pp; Sun, 23 Jan
        2022 19:19:37 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.73.46822.F09ADE16; Mon, 24 Jan 2022 04:14:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191937epcas5p166cfe0edea93cfd2941002c8ceadea0f~M-HzXlDjc0431504315epcas5p1g;
        Sun, 23 Jan 2022 19:19:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220123191937epsmtrp10a62c53137a007dc91019c3d4b8a94c4~M-HzWp7b52692626926epsmtrp1j;
        Sun, 23 Jan 2022 19:19:37 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-3c-61eda90fa935
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.C9.08738.84AADE16; Mon, 24 Jan 2022 04:19:37 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191934epsmtip125f5dff662a7f14a2c2f05392d7d3982~M-HxEZuHR0562105621epsmtip1F;
        Sun, 23 Jan 2022 19:19:34 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v4 01/16] dt-bindings: add vendor prefix for Tesla
Date:   Mon, 24 Jan 2022 00:37:14 +0530
Message-Id: <20220123190729.1852-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmli7/yreJBmd/s1g8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMDZN8C9ayV7x8NY+5gXEVWxcjB4eEgInEtXP1
        XYycHEICuxkl3pzy72LkArI/MUrM+76cFcL5zCix4O9MFpAqkIadb9cyQSR2MUo8vHgMqqqF
        SWLBvgPMIFVsAtoSd6dvYQKxRQTcJG40doB1MAv8Z5LY2LOMDSQhLOAkceXzZ1YQm0VAVWL3
        hAnsIDavgLXE9a1X2SHWyUus3gAxlFPARqL31QewbRICWzgkXjzoY4IocpHY/+U+M4QtLPHq
        +BaoZimJl/1t7BCPZkv07DKGCNdILJ13DOode4kDV+awgJQwC2hKrN+lDxJmFuCT6P39hAmi
        k1eio00IolpVovndVahOaYmJ3d2sELaHxL+Nrxgh4dAPDMYvE9gnMMrOQpi6gJFxFaNkakFx
        bnpqsWmBUV5qOTyakvNzNzGCE6mW1w7Ghw8+6B1iZOJgPMQowcGsJMJbkP8qUYg3JbGyKrUo
        P76oNCe1+BCjKTDIJjJLiSbnA1N5Xkm8oYmlgYmZmZmJpbGZoZI47+n0DYlCAumJJanZqakF
        qUUwfUwcnFINTDZXY49lNl0ub5os9v7S8e4HytLveXvaNofsWrWZy+6Jwxkp97M8/o5J0S7b
        WNW2dQq2Jgo3CqpN2HUkx/b/kTwN81VBAW4uC3zlz7ayR96/M9mMr7Hry8ta17JYlXddu/bM
        vPlLl1Hj28PnHnJ8R974GZ48VGJmydt7Z32Q1WfVwDm3DafWSR7o49U5+2vi/Jw9B/kLb5Zv
        y0pPSHe9XPLiXbSLV05YxS/bJ5eivXf99+h71d26OkFMPK07vuP8udnuCWuu69lud4t4+tzK
        WSjLL3aRXPBsi+QVtX5CJ4tPragOmmqXNC2ux/pbmNNvhfMPL5vy2gdNX2z0wUru7oQ9l1OU
        P9uU35RYvf+9EktxRqKhFnNRcSIAuLQn1i0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnK7nqreJBodPMVs8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8aGSb4Fa9krXr6ax9zA
        uIqti5GTQ0LARGLn27VMXYxcHEICOxglFr+eAZWQlri+cQI7hC0ssfLfc3aIoiYmibvX57GC
        JNgEtCXuTt/CBGKLCHhItP27xwxSxCwwkVli496zLCAJYQEniSufP4M1sAioSuyeADGVV8Ba
        4vrWq1Ab5CVWbzjADGJzCthI9L76AFTPAbTNWmLCUbkJjHwLGBlWMUqmFhTnpucWGxYY5aWW
        6xUn5haX5qXrJefnbmIEx4GW1g7GPas+6B1iZOJgPMQowcGsJMJbkP8qUYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamwtitqqIn+49MCXg6Y2uG56pJ
        ZVxncnNrN7wzCWVTUj7TPtfAw0Jw1ZLlS6/nLnz96o6Lre0X8w7xjSt/5pw85trwrO3Hp0+t
        Exa8f9gj/vXiakMJw7ecutrBJZ4rBOa+KvDjVFC/kbDtd4kCv7vcaeN9DyaZqTUYnjjzed+5
        /yv8GN6xu004+3G90fnoaxaSP34/TLD2zOMREK44/ZovcN/2Gfauwq/cwpxeLvvPMUdQQqjC
        XfJKX1KsbjaP9LVaL48Wg2Nxy6S+aE1f9FP83Qn+qAjFx4/2q/PZTfifuT1Y5Fv6tevCArab
        hRKDlsc+1zh7YT/nvLVh7DaKmsWB/ovm/Lr77Eq/1q06zn+CSizFGYmGWsxFxYkAmW1O2/IC
        AAA=
X-CMS-MailID: 20220123191937epcas5p166cfe0edea93cfd2941002c8ceadea0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123191937epcas5p166cfe0edea93cfd2941002c8ceadea0f
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123191937epcas5p166cfe0edea93cfd2941002c8ceadea0f@epcas5p1.samsung.com>
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
index 294093d45a23..e7a362c17df7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1205,6 +1205,8 @@ patternProperties:
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

