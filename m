Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9903749822B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiAXO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:29:12 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:41730 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiAXO3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:10 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220124142908epoutp0305a9201b2ac0f39b15d0358306281d07~NOzdnJnsx1227312273epoutp03c
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220124142908epoutp0305a9201b2ac0f39b15d0358306281d07~NOzdnJnsx1227312273epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034548;
        bh=VTs4pezZK89zaRXir51JX7GQiNQXODvHZZBa1wpBqwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATyKd9xMeqyhzA5nQVc0B+Gx898qfaVt/Fw3Lu7UPki8mpE0ip3u3fvpDRebZnaD5
         Ky+uS08hdKg0VhfKB0H/PdFiLoUL7lOuqOtSVOsVcaKRF45az/qHuLngqiSH2DnEOQ
         TudQI/MGyIxI2AFMgtuP+UljH1k8d05IVhOweCaI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220124142907epcas5p2b1c6c34c7dd4067c76c57520414c96a0~NOzc13HLo1125211252epcas5p2W;
        Mon, 24 Jan 2022 14:29:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JjC6229yFz4x9Pp; Mon, 24 Jan
        2022 14:28:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.4D.46822.C46BEE16; Mon, 24 Jan 2022 23:23:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220124142857epcas5p4af44b43ce57414ad6667c84753c36f16~NOzTXj_5Y0105201052epcas5p4-;
        Mon, 24 Jan 2022 14:28:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124142857epsmtrp16998dc30836641021ffb612291878e8d~NOzTWm8wN2824028240epsmtrp1n;
        Mon, 24 Jan 2022 14:28:57 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-ed-61eeb64cb0e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.AB.08738.9A7BEE16; Mon, 24 Jan 2022 23:28:57 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142852epsmtip17adb0dfd3118bba81867028f8c6254ed~NOzO7xlcb1678816788epsmtip1v;
        Mon, 24 Jan 2022 14:28:52 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v5 01/16] dt-bindings: add vendor prefix for Tesla
Date:   Mon, 24 Jan 2022 19:46:29 +0530
Message-Id: <20220124141644.71052-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmlq7PtneJBqsOWFs8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMDZN8C9ayV7x8NY+5gXEVWxcjJ4eEgInEj89P
        WLoYuTiEBHYzSrya1cQE4XxilJjx5TYzhPOZUWLph+NMMC1Xl3WzQyR2MUpMO7INqqWFSaL3
        30lGkCo2AW2Ju9O3gHWICLhJ3GjsACtiFvjPJLGxZxnYdmEBJ4lJtyGKWARUJVq3TmUGsXkF
        bCRaX99hhlgnL7F6wwEwm1PAVmLewm9ggyQEtnBItEzexg5R5CJx6Uob1H3CEq+Ob4GKS0m8
        7G8DsjmA7GyJnl3GEOEaiaXzjrFA2PYSB67MYQEpYRbQlFi/Sx8kzCzAJ9H7+wkTRCevREeb
        EES1qkTzu6tQndISE7u7WSFsD4l9G3aBvS4kMIFR4kRH7QRG2VkIQxcwMq5ilEwtKM5NTy02
        LTDKSy2Hx1Nyfu4mRnAq1fLawfjwwQe9Q4xMHIyHGCU4mJVEeKtS3iUK8aYkVlalFuXHF5Xm
        pBYfYjQFhthEZinR5HxgMs8riTc0sTQwMTMzM7E0NjNUEuc9nb4hUUggPbEkNTs1tSC1CKaP
        iYNTqoFJ1ibqD2+ik4Cks6+128dG5z8Gigw9EfPetv8+5uU9Wb/ZxbyJM9DZrPhRxqUaiboa
        vz+nsw0SjF5G73COWLHneAIf1ye7ku06X/3MpzzcXRfSvj1dZI7M+nO/U8X1vur0mgcy1mdm
        bt1WJRW+XcJlyZGtL49tio8rU3vs1/6zt2LT7uaCdt0fWy8ImWyzXFIfv8f7X7vX/+a2CwkP
        uq0XbJlUdNyacSm/4afp23rXrJU9Kr5uaQC75d2ty49OfcKyuibHofP3/i6t1/bPOf+tK82Z
        tuN4/afe1fV2p/TfSD1YVcM0waSTbV+983YGk0Of/l95W7/bd7XBb4511h6XYt36ufyjFtwI
        OuQtxKvEUpyRaKjFXFScCACpHjqQLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnO7K7e8SDfZdYLN4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtHr4Kt7i8aw6bxYzz+5gsTl3/zGax
        aOsXdovWvUfYLQ6/aWe1+HdtI4vF4+t/2BwEPdbMW8Po8fvXJEaPWQ29bB6bVnWyedy5tofN
        Y/OSeo8rJ5pYPfq2rGL0+Nc0l93j8ya5AK4oLpuU1JzMstQifbsErowNk3wL1rJXvHw1j7mB
        cRVbFyMnh4SAicTVZd3sILaQwA5GiZ4vbhBxaYnrGyewQ9jCEiv/PQeyuYBqmpgk/j07yAqS
        YBPQlrg7fQsTiC0i4CHR9u8eM0gRs8BEZomNe8+ygCSEBZwkJt2GKGIRUJVo3TqVGcTmFbCR
        aH19hxlig7zE6g0HwGxOAVuJeQu/AdVzAG2zkTj3W2UCI98CRoZVjJKpBcW56bnFhgVGeanl
        esWJucWleel6yfm5mxjBUaCltYNxz6oPeocYmTgYDzFKcDArifBWpbxLFOJNSaysSi3Kjy8q
        zUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFJTdQ1csfXlsVKT3f2JQbfkO3l
        3t3Q7102S6NpzcH34qLGlSwve57cfSNmWed13kFmk+Q0HoFzPvJMXtffnC8QP2icbhdiGvWr
        OOeF+aHsslsWZmKv2/iXdP3Xeh517WCm8eb3V3ZPcF3O3iqY2WWXnrS2vveSzvsXcQx8JSJu
        as3Od8+GtNy0PVAgLbu1fFJNQG7buScyX613M+Xun/im9QPLlIObOlJP1Pd/C1zgUZ+u9tLh
        dXN4y3fb+oDEIM1lqxW8t7RLs+r+OfT2qErZBqk7UvtSdi5XjdznvSaCSfHQ/eMHeHaGTjvy
        eU7Uwc8vjDZv9SkuefmtcuOteT9YkxvadHfwzBBSfsaXpq3EUpyRaKjFXFScCAAWDh6E8QIA
        AA==
X-CMS-MailID: 20220124142857epcas5p4af44b43ce57414ad6667c84753c36f16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142857epcas5p4af44b43ce57414ad6667c84753c36f16
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142857epcas5p4af44b43ce57414ad6667c84753c36f16@epcas5p4.samsung.com>
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

