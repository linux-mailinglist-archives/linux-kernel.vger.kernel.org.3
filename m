Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5448D7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiAMMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:29 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59612 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiAMMY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:56 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220113122455epoutp04cc39b3cc992611a9a3eefa21e94cc950~J1A3f7BXM2463124631epoutp04G
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220113122455epoutp04cc39b3cc992611a9a3eefa21e94cc950~J1A3f7BXM2463124631epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076695;
        bh=927+YPERn0Yeos9XjRXp71ttbFLIYVlal3QuH3AKvic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEpRwbURPNNV0aSQ2u1EqiqC8FKKXsGpdu+9Hi3LAPvjU972kZWp5kkkBJhwSjENM
         IWjy7g60GG0XitMN13QY8JA5MM3VhLzhNEDsB/sBK5cyqqypqstkAw+Knz0KbfqKv5
         ELpslFKZCA8ITc2QCBgNBoBdxQ2TqC/nEjtYLf/g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122454epcas5p329834b70ee4ea36b9a4ffd867f785a14~J1A2-HNUP1006210062epcas5p3j;
        Thu, 13 Jan 2022 12:24:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JZNsq6hGVz4x9Pr; Thu, 13 Jan
        2022 12:24:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.31.46822.01A10E16; Thu, 13 Jan 2022 21:24:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122447epcas5p266d44c8df143229d22dfa700c285a786~J1AwWQDos0949509495epcas5p2q;
        Thu, 13 Jan 2022 12:24:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122447epsmtrp1e2680c4d350b073e6192b8fe5c44d809~J1AwVjv3y1991219912epsmtrp1y;
        Thu, 13 Jan 2022 12:24:47 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-d7-61e01a10e44a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.A8.29871.F0A10E16; Thu, 13 Jan 2022 21:24:47 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122443epsmtip2015c63604999f1c4f8f68a32b71e32a0~J1AtBdtnA1246412464epsmtip2r;
        Thu, 13 Jan 2022 12:24:43 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH 20/23] dt-bindings: iio: adc: exynos-adc: Add ADC-V3 variant
Date:   Thu, 13 Jan 2022 17:41:40 +0530
Message-Id: <20220113121143.22280-21-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmlq6A1INEg7PbOSwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcbd1MbvFqeuf2SwW
        bf3CbtG69wi7xeE37awWj6//YXMQ8Fgzbw2jx6yGXjaPTas62TzuXNvD5rF5Sb3HlRNNrB59
        W1Yxevxrmsvu8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtAXSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
        dL281BIrQwMDI1OgwoTsjB13t7EXnGWveP9jHXMD41S2LkZODgkBE4lJf5cC2VwcQgK7GSU+
        z2qCcj4xSvx9MpcVwvnGKLHwxwsmmJb1T7YzQiT2Mkos/vCVBcJpYZLoe7mEGaSKTUBb4u70
        LWAdIgJuEjcaO5hAipgFmpkl5k08yAKSEBbwkXgycTVYA4uAqsS0/9fBGngFbCUWLXrCDLFO
        XmL1hgNANgcHJ1D87qo8kDkSAis5JF6eaGWFqHGRmL73BQuELSzx6vgWdghbSuJlfxs7SK+E
        QLZEzy5jiHCNxNJ5x6DK7SUOXJnDAlLCLKApsX6XPkiYWYBPovf3EyaITl6JjjYhiGpVieZ3
        V6E6pSUmdndDHeAhMW/3MWjITQCG3JEDrBMYZWchTF3AyLiKUTK1oDg3PbXYtMAoL7UcHlHJ
        +bmbGMGJU8trB+PDBx/0DjEycTAeYpTgYFYS4e0vup8oxJuSWFmVWpQfX1Sak1p8iNEUGGIT
        maVEk/OBqTuvJN7QxNLAxMzMzMTS2MxQSZz3dPqGRCGB9MSS1OzU1ILUIpg+Jg5OqQYmreeJ
        8y7wTUqWfXzdzuXJqwVPZZ4VNdg6Tkhm/X7S+FzrtDAdnZT/svwHZheIWq02OWiZbRYz4/Ln
        RbdTfnJM1IvYovx9dz5/8Z9Z1ZZb8icfEXmeaCAYvy6B2WKm+Lyru5gudwY2PdjxMGgFb2Pv
        9WuiLvN/RD6/r/nqf8HELTc/ytQ4e/IFLr7aJsX84mlztbhlUNsf16nxfMWcbxwNt21iqv69
        M1HN80neZz2Ogi9nHhyt0Z/Q7rRy8opLR8VsbTOOl9yYne2nWef3z56Fd5Zm1k3Zx6FfJjqL
        /PnCyXvUmdE3jyN3wdabZwKj71xf+bBg/ayHd1M+bPkfEXh/6YXjMSd5T79emPDZrdr8phJL
        cUaioRZzUXEiALdp1rolBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvC6/1INEg54fHBYP5m1js3i/rIfR
        Yv6Rc6wWG9/+YLKY8mc5k8Wmx9dYLT723GO1ePgq3OLyrjlsFjPO72OyuNu6mN3i1PXPbBaL
        tn5ht2jde4Td4vCbdlaLx9f/sDkIeKyZt4bRY1ZDL5vHplWdbB53ru1h89i8pN7jyokmVo++
        LasYPf41zWX3+LxJLoAzissmJTUnsyy1SN8ugStjx91t7AVn2Sve/1jH3MA4la2LkZNDQsBE
        Yv2T7YxdjFwcQgK7GSUentzECJGQlri+cQI7hC0ssfLfc3aIoiYmif+PvoIVsQloS9ydvoUJ
        xBYR8JBo+3ePGaSIWWAys8T0F7NZQRLCAj4STyauZgaxWQRUJab9vw7WwCtgK7Fo0RNmiA3y
        Eqs3HACyOTg4geJ3V+WBhIUEbCTOvVrPNoGRbwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8
        dL3k/NxNjOCg19Lcwbh91Qe9Q4xMHIyHGCU4mJVEePuL7icK8aYkVlalFuXHF5XmpBYfYpTm
        YFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwHRGxf13nV3ah6RZTWIFXPPMj/fxySy/ysPz
        6uZ25+TXa3tq3B3jXy53Ta71fXXGUTpAV+t52QWtF41b7211tJJv0qhudL9d0fcprFryQLNU
        RnXpBx7xNzOuz7QsN7s785Scp6rn6gM+WrHyXr+UD55dO1n09qLTIkdsfJ60TzRZOTVq9vWb
        K+q2XzKYzdDjPXex/MTdZv1ndYT7rZ5H2jxlVn/3UMPo6dS7s+fP816kxtciyZ/3/bx02VEt
        wx2qHzuF3nMvafrBM3nOioOvr3X6ft+tcfNxc5goa9GeK5P2JBU+e5qkElZisOslT/PP8Cd8
        RZIvV3ockS7lFTzgJ1O86RfvhCOz7606sej8ngolluKMREMt5qLiRAAj1Nio6QIAAA==
X-CMS-MailID: 20220113122447epcas5p266d44c8df143229d22dfa700c285a786
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122447epcas5p266d44c8df143229d22dfa700c285a786
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122447epcas5p266d44c8df143229d22dfa700c285a786@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new compatible string for exynos's ADC-V3 variant.

Cc: linux-fsd@tesla.com
Signed-off-by: Tamseel Shams <m.shams@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 81c87295912c..9303053759ca 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - samsung,exynos-adc-v1                 # Exynos5250
       - samsung,exynos-adc-v2
+      - samsung,exynos-adc-v3
       - samsung,exynos3250-adc
       - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
       - samsung,exynos7-adc
-- 
2.17.1

