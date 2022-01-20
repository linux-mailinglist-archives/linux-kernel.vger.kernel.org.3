Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FC4954F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377470AbiATTg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:36:28 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:63889 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377474AbiATTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:36:22 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220120193620epoutp03ff09cb09ac77eb8e5f8b3f30d18809a2~MEaiymH4g0819108191epoutp03m
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 19:36:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220120193620epoutp03ff09cb09ac77eb8e5f8b3f30d18809a2~MEaiymH4g0819108191epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642707380;
        bh=ZaATJYNM+pYyB6UGZpbkBKxRtYM6TyQxfTwupOucWS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwiAzZ8gDX/dEZVr5eGiTBu5s5N+XeUdH/cVxLucmq300FEFg2JNUv3SrHqIHM1Sc
         HKTRPx+TQvIXW18XGWwce1EvGqD3GwQzeoxmBTG91OTr5hoP2IL8xae0KFfFDwybq6
         IsJe9mX+6UTDSMid/vkpsSjybOwBT0gXQaiLU0Uo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220120193619epcas5p1bd021ea54b6a54ff0b8c3067aa01f900~MEahjO7VJ0970309703epcas5p1B;
        Thu, 20 Jan 2022 19:36:19 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jft6Q47LLz4x9Pp; Thu, 20 Jan
        2022 19:36:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.26.46822.5F8B9E16; Fri, 21 Jan 2022 04:33:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220120193613epcas5p238851849d212e01d7d830d78ca7d6379~MEaclnd-j0131201312epcas5p2z;
        Thu, 20 Jan 2022 19:36:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220120193613epsmtrp2d5d0a34142d266cfc7b65b743027db9d~MEackyaVo1490214902epsmtrp2v;
        Thu, 20 Jan 2022 19:36:13 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-c2-61e9b8f5f312
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.94.08738.DA9B9E16; Fri, 21 Jan 2022 04:36:13 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220120193611epsmtip2c11195d1c2afc63cd78c0936eaf33f44~MEaamuP1z1544215442epsmtip2D;
        Thu, 20 Jan 2022 19:36:11 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
Subject: [PATCH v2 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
Date:   Fri, 21 Jan 2022 00:54:36 +0530
Message-Id: <20220120192438.25555-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120192438.25555-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTU/frjpeJBhfvcFkcmPCK1eLBvG1s
        Fot/PGeymPrwCZvF/CPnWC02vv3BZDHlz3Imi02Pr7FaPHwVbnF51xw2ixnn9zFZNH68yW6x
        aOsXdovWvUfYHfg8ZjX0snlcX/KJ2WPTqk42jzvX9rB5bF5S79G3ZRWjx7+muewenzfJBXBE
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2tpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO
        +PCzkaXgP1vFnTNr2RsY77F2MXJwSAiYSEz67tLFyMUhJLCbUeLE9jOMEM4nRomnLQtYIZzP
        jBI7Jrxi6mLkBOu403sBqmoXo0TL5plQVS1MEmfnL2cDqWIT0Ja4O30LWIeIgJvEjcYOJpAi
        ZoGbTBK/G16zgSwXFvCUmH6mAqSGRUBVYtrXe2C9vAI2EuevvmaF2CYvsXrDAWYQm1PAVuL7
        4x9gmyUEpnJILDy8ix2iyEWitbcZyhaWeHV8C5QtJfH53V42iEezJXp2GUOEaySWzjvGAmHb
        Sxy4MocFpIRZQFNi/S59kDCzAJ9E7+8nTBCdvBIdbUIQ1aoSze+uQnVKS0zs7oa60kPixdPN
        zJBgmMAocfLRPbYJjLKzEKYuYGRcxSiZWlCcm55abFpglJdaDo+n5PzcTYzgxKjltYPx4YMP
        eocYmTgYDzFKcDArifBK1T9LFOJNSaysSi3Kjy8qzUktPsRoCgyyicxSosn5wNScVxJvaGJp
        YGJmZmZiaWxmqCTOezp9Q6KQQHpiSWp2ampBahFMHxMHp1QDU/qr2DKzar1JzEf3pZvu+Xv8
        4MWumrPOK8+FnjJml0z3v3xy9or3nbNvxM5pWSt2yjxz3pezx6ezXki41aGQNYPDqkU12b/p
        S+YCE74JS5Q3xoZtSJyaHn/99LfC+P+7FvcbLZpaxeB6ZFEk7+SjJ7a0R7T1r3sf8WeH2Ud+
        LxHhdZ5cjwX4k9cu+L7NUW5xyL2af2l3njOeLp/35379RKXuiXcZzzs1yOzNdBGe/mbmy6T9
        lTuC39u51Nd5TPLc67naavm6d6tTNx4NUzzZ2FDfc+tzaF8SY3KEWz3XpmSl++XOTV9WWGWt
        WsTJeFj5ucORzyr8dpbXrYJ4rRIlF7btM0v4+XP5tJL+Lwvv5CmxFGckGmoxFxUnAgCxp1+g
        FQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvO7anS8TDRp/KlgcmPCK1eLBvG1s
        Fot/PGeymPrwCZvF/CPnWC02vv3BZDHlz3Imi02Pr7FaPHwVbnF51xw2ixnn9zFZNH68yW6x
        aOsXdovWvUfYHfg8ZjX0snlcX/KJ2WPTqk42jzvX9rB5bF5S79G3ZRWjx7+muewenzfJBXBE
        cdmkpOZklqUW6dslcGV8+NnIUvCfreLOmbXsDYz3WLsYOTkkBEwk7vReYOxi5OIQEtjBKHFs
        4S2ohLTE9Y0T2CFsYYmV/56zQxQ1MUn0v1vLApJgE9CWuDt9CxOILSLgIdH27x4zSBGzwFMm
        iSs32oDGcnAIC3hKTD9TAVLDIqAqMe3rPTYQm1fARuL81ddQy+QlVm84wAxicwrYSnx//IMR
        xBYCqnl4fzvzBEa+BYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgsNaS2sH455V
        H/QOMTJxMB5ilOBgVhLhlap/lijEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs
        1NSC1CKYLBMHp1QDU19ZlOiHJUbp5xkf+2Q63Qr2EA91s31qNzmZ6WnL5kzrB3+k2+XnJfWv
        //fliIjMiifWLlNE2b7tMtunGPfybpqyFT/L+ZDrf5U6fou3Jc083uoefXb5AY+2FTy35bQr
        O9akmUbMf/bvn+WidYqbncU64+Zv/cwfsNMpW8JYNftA9IcdDXFf/gS9uxazen+oQt7NS5M3
        rfPYfTH4zq01v658bik7YPijxOZDx6NZ298sDbggYzV9/c4LTOHhr4V/+bKxTord93u7z+6L
        l/6e4mq5MW++4WXHe5l9C6Yo905LCfSNS9w8UcJnn4rNtFcX37bPXM5+vnyGcPcRv76itJ16
        6l+eB3hv/czowu/w8LISS3FGoqEWc1FxIgDkDutl2gIAAA==
X-CMS-MailID: 20220120193613epcas5p238851849d212e01d7d830d78ca7d6379
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220120193613epcas5p238851849d212e01d7d830d78ca7d6379
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
        <CGME20220120193613epcas5p238851849d212e01d7d830d78ca7d6379@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds spi controller dt-binding compatible information for
Tesla Full Self-Driving (FSD) SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Adithya K V <adithya.kv@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 61c77088e8ee..bf9a76d931d2 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -21,6 +21,7 @@ properties:
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos5433-spi
+          - tesla,fsd-spi
       - const: samsung,exynos7-spi
         deprecated: true
 
-- 
2.25.1

