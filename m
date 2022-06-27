Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1692255B5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiF0D3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiF0D3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:29:22 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2916C2DFA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:29:21 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220627032919epoutp04e1454f7d4570334ff00ac1ba023e3180~8XJVjZPX12495524955epoutp04K
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:29:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220627032919epoutp04e1454f7d4570334ff00ac1ba023e3180~8XJVjZPX12495524955epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656300559;
        bh=0Zir2TOrLPec4IhgCA/w7Csziv0B7jSkm3/emseDJRU=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=PHGzwO4wEcL9gzKXNIs15CjA0a+Q24kPFk1Rj8YVVoc1TQLWV+FmdoA5zCNKL11bW
         8llWWHB2nGLnwAk6Uztzyl8Hi7fgT3J6eHor9owabXsVge4xwMVd6jQKelZn/LsUfq
         J3jWaEO4Csqrz5ng+KnciihILQGDxPx65OlkJeV4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220627032919epcas2p492763ede5dcb9935739fdae9134348a3~8XJVKQvkG3233332333epcas2p4z;
        Mon, 27 Jun 2022 03:29:19 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LWY9p6hxQz4x9Pq; Mon, 27 Jun
        2022 03:29:18 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.F4.09642.E0429B26; Mon, 27 Jun 2022 12:29:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220627032918epcas2p1857d20843104e416d4b8cade63bf92a8~8XJUb_9qA1744917449epcas2p1b;
        Mon, 27 Jun 2022 03:29:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220627032918epsmtrp2b862cad4e2b9b313223ee58fb778fdfb~8XJUbSwNT3269532695epsmtrp2t;
        Mon, 27 Jun 2022 03:29:18 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-40-62b9240e57e8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.BE.08802.E0429B26; Mon, 27 Jun 2022 12:29:18 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220627032918epsmtip23402a8760bf220fba3f322693d9b18e2~8XJUNQoct0930109301epsmtip2F;
        Mon, 27 Jun 2022 03:29:18 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andi Shyti'" <andi@etezian.org>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20220626112838.19281-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] spi: dt-bindings: samsung: Add Exynos4210 SPI
Date:   Mon, 27 Jun 2022 12:29:18 +0900
Message-ID: <0f3c01d889d6$1567cb00$40376100$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHKhtylZLYgnAF5CFmPmMFzASK26QHtgmKtrW8yLMA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmmS6fys4kg2lPjSwW/3jOZDH14RM2
        i/lHzrFa7H29ld3i8q45bBYzzu9jsmj8eJPdonXvEXYHDo/rSz4xe2xa1cnmcefaHjaPz5vk
        Aliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
        UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIV
        JmRnfHvzlLHgBFPF2jW72BoYJzF1MXJySAiYSBy/2w9kc3EICexglDh6cTcbhPOJUaL7/g8W
        COczo8Tx90dZYFrO/nzBDJHYxSix+OEpKOcFo8T7h9vAqtgE9CVedmxjBUmICGxikmie1wm2
        kVPARWLa4ydgtrCAk8SrR3PAGlgEVCX27DvBCGLzClhKbO/8wARhC0qcnPkErIZZQF5i+9s5
        zBBnKEj8fLqMFcQWEbCS+HnyJRNEjYjE7M42sIskBHo5JDrOfod61UXi6twPUD8IS7w6voUd
        wpaS+PxuLxuEXSyxdNYnJojmBkaJy9t+QSWMJWY9awe6jgNog6bE+l36IKaEgLLEkVtQt/FJ
        dBz+yw4R5pXoaBOCaFSXOLB9OtRWWYnuOZ9ZIUo8JNq6IycwKs5C8uQsJE/OQvLMLIS1CxhZ
        VjGKpRYU56anFhsVGMNjOzk/dxMjOIlque9gnPH2g94hRiYOxkOMEhzMSiK8r69vTRLiTUms
        rEotyo8vKs1JLT7EaAoM9onMUqLJ+cA0nlcSb2hiaWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1
        OzW1ILUIpo+Jg1OqgSnDaetnU53iJq36naduJzVKcdmlcWbe3xj/Z0d17Iqty9hTz8w5dp3b
        I+NRR8ey87949NQWVQmIeF39HXE3/Q7D17Vl59K/d9Q23F7NbdmYNcOufnE2j7WFz26nPwY3
        gpr6dx7qaMx8+uK5qrxD0VZnv+1cpvLKf/aXPZp13Yg1rLjb9MjFWKHo5HNcW2OZ39SaL5YS
        +bgp1CDqW8UtkeQDMv3XzCT1X74TcJOcpenscM3gnovw7aCXl6/qvU0VqEh79XO9gsS5lZ2T
        D5yq+SiyRtWT3dhXyTx7/ZL5Ps/ezFw/t/6Wh8Kz5nle2T+Y1R2/NaStnbv4s3XZQhabZRWh
        pQ3yi+d93utWwDz1mRJLcUaioRZzUXEiAIkOdf4rBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvC6fys4kg8dnRS0W/3jOZDH14RM2
        i/lHzrFa7H29ld3i8q45bBYzzu9jsmj8eJPdonXvEXYHDo/rSz4xe2xa1cnmcefaHjaPz5vk
        AliiuGxSUnMyy1KL9O0SuDK+vXnKWHCCqWLtml1sDYyTmLoYOTkkBEwkzv58wdzFyMUhJLCD
        UeLWrtNsEAlZiWfvdrBD2MIS91uOsEIUPWOU6F1/F6yITUBf4mXHNrCEiMAOJol/s1+wgCSE
        BKYySkw8rwBicwq4SEx7/ARsnbCAk8SrR3PAalgEVCX27DvBCGLzClhKbO/8wARhC0qcnPkE
        rIZZQE9i/fo5jBC2vMT2t3OYIS5SkPj5dBkriC0iYCXx8+RLJogaEYnZnW3MExiFZiEZNQvJ
        qFlIRs1C0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw5Ghp7WDcs+qD3iFG
        Jg7GQ4wSHMxKIryvr29NEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFq
        EUyWiYNTqoEpVrsms+LvdovQNpe9MboTd53K9rN4+9MioXXNQXvfTBXXk8bqRVuiIlICRI9c
        fqrpMPmI3a4NoeeczG5IaF191LFr68nvT59OXXZIz3q1+DuJ1yFlh3YuNfxlqrbyq9DGvmV+
        PEtf/I72tbuxY05F5b2efi+7m49izdX1Z19ckFO4zCzmtLVYWYpfwRURjbI6+51PJ+u8sFH8
        cPgV51O2/vbGm1YqHvdUcs/qfAjdNVsscBOHyMraN5Ed+exxWlN+mDK/35ahL96xfO8zbiGP
        T15x/Qd/+pjuf/j765S9aycbx++1dxR/OHv14+WFzmFd5tq79ti/z5u7bYvj1+5Qs3rrXKeT
        gkoRtawzLZOVWIozEg21mIuKEwFTpNW3CwMAAA==
X-CMS-MailID: 20220627032918epcas2p1857d20843104e416d4b8cade63bf92a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220626113118epcas2p26b9fc5b2628e6ff307e2cc3bd9f5bf26
References: <CGME20220626113118epcas2p26b9fc5b2628e6ff307e2cc3bd9f5bf26@epcas2p2.samsung.com>
        <20220626112838.19281-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] spi: dt-bindings: samsung: Add Exynos4210 SPI
> 
> Document samsung,exynos4210-spi compatible which is already used on
> several Exynos SoCs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

