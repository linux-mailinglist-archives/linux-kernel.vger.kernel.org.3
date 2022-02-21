Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196E4BE874
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiBURev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:34:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiBURem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:34:42 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981E11B79E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:34:15 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220221173411epoutp01a4fa1f5afa54ec4d0daea6bfc0c11db0~V3ZCUk74B0928409284epoutp01n
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:34:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220221173411epoutp01a4fa1f5afa54ec4d0daea6bfc0c11db0~V3ZCUk74B0928409284epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645464851;
        bh=czJXhhu7BKvM2wKopoIGmCQLR5jigccH7TKoGeuBU3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNaL6oOgZbA6PpkXodeO4AhHzyc86vqXNSkxHMG39xbKLxVvSccMxzZb0AtXHsq8+
         PBwviVtHPwMFCKkVVzpl7r/GDLMvCqgMg8cnwcTmUVvpFm2ZMENQcp504Z5QtZ8XpK
         oYW3z21wUscrOpJkgoJWdb4zYZGVVaIc6GZC0auY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220221173410epcas5p1b92b382e13b34682517d2914c47fd301~V3ZA9Km8I1540215402epcas5p1w;
        Mon, 21 Feb 2022 17:34:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K2Ttk0WN3z4x9Pq; Mon, 21 Feb
        2022 17:34:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.A0.06423.D0DC3126; Tue, 22 Feb 2022 02:34:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220221173404epcas5p44ceb57158d3df4808ec1f409f53a0e81~V3Y71--eY2548525485epcas5p49;
        Mon, 21 Feb 2022 17:34:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220221173404epsmtrp1dad9756e3a6408cc7a11508f9c7d57d5~V3Y71NOvs2875728757epsmtrp1C;
        Mon, 21 Feb 2022 17:34:04 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-ae-6213cd0d33b7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.DA.29871.C0DC3126; Tue, 22 Feb 2022 02:34:04 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220221173403epsmtip2e537cd01c5f19d10a80eaa8432ccc376~V3Y6itD6t0992909929epsmtip2N;
        Mon, 21 Feb 2022 17:34:03 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 2/3] clocksource/drivers/exynos_mct: bump up mct max irq
 number
Date:   Mon, 21 Feb 2022 23:15:46 +0530
Message-Id: <20220221174547.26176-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221174547.26176-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmui7vWeEkgz8L9SwezNvGZjHvs6zF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZrD1yl91i0dYv7BabN01lduD0mNXQy+Zx59oeNo93586x
        e2xeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjNmnGlgLnjKVtF4cjZbA+M11i5GTg4JAROJZTfPs3cxcnEICexm
        lDgz4zgrhPOJUeL2mzdsEM43RokZzZdZYFoOT/zOBJHYyyix9eAXqP4WJomva+aDVbEJaEvc
        nb6FCcQWEXCTuNHYAdbBLHCNUeLPxEOMIAlhgRCJo7d/ATVwcLAIqEq0XWIDMXkFbCQ+nTeE
        WCYvsXrDAWYQm1PAVuLEhH5GkDESAvfYJS7N/c4MUeQi8fDBayYIW1ji1fEt7BC2lMTL/jZ2
        kJkSAtkSPbuMIcI1EkvnHYN6xl7iwJU5YBcwC2hKrN+lDxJmFuCT6P39hAmik1eio00IolpV
        ovndVahOaYmJ3d3QUPSQmHN5GZgtJDCBUWLO3qQJjLKzEIYuYGRcxSiZWlCcm55abFpgmJda
        Do+m5PzcTYzghKbluYPx7oMPeocYmTgYDzFKcDArifDeYRdOEuJNSaysSi3Kjy8qzUktPsRo
        CgyvicxSosn5wJSaVxJvaGJpYGJmZmZiaWxmqCTOezp9Q6KQQHpiSWp2ampBahFMHxMHp1QD
        U29J4Mpev3k+nRY/1T50LrqRtGhB4jzB5tmHC47uOuDGrqBWy3Vkwg+JG9NuM5Z9Fn+TJMs9
        Z/NH/k2rq/YqekuKbbx3PSnTbavW65dJwVL3gvfda9/ZG3uJcb91euKLniNHl/y7eiRB9upp
        Ppm4wkWxt9WEjA5v7FrflvFwOUeCFq8Hq1jwj5cL6rX8ykpP3KtZ8FOK27dqyems1XwliV5R
        /9cUT5Y8o6S1LLdX911q4iY3uR13zUx/rTscM5cjZ5tq5eF7EzXvGq9fv1pPU/T7xbV6cuKh
        G35p3cv+unq37aKtSdt5L7obfzpxQuHX7y1Hkt89vrJTiNPnUb3Zbk/tcK9p2U+uK7jPOWCw
        /JESS3FGoqEWc1FxIgDph2Fj8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvC7PWeEkg+Z+E4sH87axWcz7LGux
        8e0PJotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYtPULu8XmTVOZHTg9ZjX0snncubaHzePduXPs
        HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxowzDcwFT9kqGk/OZmtgvMbaxcjJISFg
        InF44nemLkYuDiGB3YwSV3vms0MkpCWub5wAZQtLrPz3nB2iqIlJ4tjq9YwgCTYBbYm707cw
        gdgiAh4Sbf/uMYMUMQvcY5T43TINrEhYIEhi7peVQOs4OFgEVCXaLrGBmLwCNhKfzhtCzJeX
        WL3hADOIzSlgK3FiQj8jSIkQUMnpNp0JjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXr
        JefnbmIEB6OW5g7G7as+6B1iZOJgPMQowcGsJMJ7h104SYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmj8OLfuxje91xZrXiyn6evGy2OfLXvYOljuuk
        8N1K+304d0PAO/6Ein7HyWFt2jI6zn7RlhY+p358nHbhZIrE/urnHhz/FpzVrtZlNY14FFib
        aqS3+ce9j5Mvr65a4XZ2QtIhL8Gcu9J8IuFf5L4unyKakcQWNWGG1CGHPG6OxQeVTPInb1+6
        woklYafh3D1f28wXvZZiuMS9rnzJgVU3OJafmrtTdEnahTq/P8Wr353MSNT2bKzYtfrDy+ik
        Sb+z6t4sPr95i07jPP3zD3jnL1nC3HHldPikBxsmrvT5bXX2t+N/v/WL3/PVyFgbnl/0Zm3A
        563i9nlTCrZc7tiwRIHhmbD9+lbxH7q7bgexuiuxFGckGmoxFxUnAgChCF98tQIAAA==
X-CMS-MailID: 20220221173404epcas5p44ceb57158d3df4808ec1f409f53a0e81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220221173404epcas5p44ceb57158d3df4808ec1f409f53a0e81
References: <20220221174547.26176-1-alim.akhtar@samsung.com>
        <CGME20220221173404epcas5p44ceb57158d3df4808ec1f409f53a0e81@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump-up maximum number of MCT IRQ to match the binding
documentation. This make driver scalable for SoC which
has more than 12 timer irqs, like recently added FSD SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index b3f3d27a837b..0c7931f7f99a 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -64,7 +64,8 @@
 #define MCT_G0_IRQ	0
 /* Local timers count starts after global timer count */
 #define MCT_L0_IRQ	4
-#define MCT_NR_IRQS	12
+/* Max number of IRQ as per DT binding document */
+#define MCT_NR_IRQS	20
 
 enum {
 	MCT_INT_SPI,
-- 
2.25.1

