Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE748BE24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350860AbiALFV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:21:59 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:58449 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350854AbiALFV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:21:57 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220112052155epoutp04757652437014a10ca433d4d892f617ad~JbmQd46Hn2430924309epoutp04a
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:21:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220112052155epoutp04757652437014a10ca433d4d892f617ad~JbmQd46Hn2430924309epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641964915;
        bh=0AdI4pWrRC3wso4/lf89APzJOnfapAQjvxZ+mHru3es=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DoMbbgyAXlKEUD+mXzBAaWH7odX98At1XHTt1xEnhuWxO5khC38M5ISCpTTkzWKIU
         Sf/TuZd1991ZWvnZI1hnrbcf1pG0OXzas52TgvFnK2sZun3WYvNYsy8MovLb6lAryk
         u7ExXTog08bB+H08TssAba2W6xiE8f4NISg98VCc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220112052154epcas2p39e2a19db0dcc69e630cfd07f5a4a4a17~JbmQA8slo2474724747epcas2p3N;
        Wed, 12 Jan 2022 05:21:54 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JYbXK2M4Hz4x9Q2; Wed, 12 Jan
        2022 05:21:53 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.BD.12141.D656ED16; Wed, 12 Jan 2022 14:21:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220112052149epcas2p1f7b6ccd45fba2e459713310fa4041462~JbmK8DBZg1320913209epcas2p1W;
        Wed, 12 Jan 2022 05:21:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220112052149epsmtrp2c41bc4686b47a26c80bd656b352235be~JbmK7Izhf0215102151epsmtrp2O;
        Wed, 12 Jan 2022 05:21:49 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-bf-61de656dccf8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.E7.29871.D656ED16; Wed, 12 Jan 2022 14:21:49 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220112052149epsmtip23854b118542407e6c8fd84709bc22e44~JbmKttmCj2838228382epsmtip2b;
        Wed, 12 Jan 2022 05:21:49 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@gmail.com>
In-Reply-To: <20220111201722.327219-20-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 26/28] pinctrl: samsung: add support for Exynos850
 and ExynosAutov9 wake-ups
Date:   Wed, 12 Jan 2022 14:21:49 +0900
Message-ID: <000101d80774$4cc9e450$e65dacf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEPsg0rhN1RyLWOER/EMv1WEdO3IgCyS1WtAbp/JHat3B4acA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmqW5u6r1Eg7VvrS2W3qq2mH/kHKvF
        xrc/mCym/FnOZLHp8TVWi83z/zBaXN41h81ixvl9TBZrj9xlt2jde4Td4vCbdlaL531AsVW7
        /jA68HrMauhl89g56y67x6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS
        81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgI5VUihLzCkFCgUkFhcr6dvZ
        FOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn3PtyiLFgNndF69/L
        zA2MNzm7GDk5JARMJGYu+M3excjFISSwg1Hi97U3UM4nRonTR+ewQjjfGCX6Hp1ghWnp3ruM
        HcQWEtjLKNG0xhmi6AWjxOEr55hBEmwC+hIvO7aBdYsILGKWWL3nNCOIwyzQxyjR2nQFrJ1T
        wFOi+exMNhBbWCBV4saKtWBxFgFVidV/XoJN4hWwlFhy8QsjhC0ocXLmExYQm1lAXmL72znM
        ECcpSPx8ugzsPBEBJ4nJrzexQtSISMzubGMGWSwhcIFD4ufdX4wQDS4SP/p/sUDYwhKvjm9h
        h7ClJD6/28sG0dDNKDHp5V2oxAxGiXc3cyBsY4lZz9qBBnEAbdCUWL9LH8SUEFCWOHIL6jY+
        iY7Df9khwrwSHW1CEI3qEge2T4faKivRPecz6wRGpVlIPpuF5LNZSD6YhbBrASPLKkax1ILi
        3PTUYqMCE3h0J+fnbmIEp2Qtjx2Ms99+0DvEyMTBeIhRgoNZSYS3LOZuohBvSmJlVWpRfnxR
        aU5q8SFGU2BYT2SWEk3OB2aFvJJ4QxNLAxMzM0NzI1MDcyVxXq+UDYlCAumJJanZqakFqUUw
        fUwcnFINTCbGHXN2dboF/31z5/mjZ0/2fvU/rqRSuf4GR1B8sFVYm+aiiswjPrK6T/bMvsn3
        zOG4z0c9/aU3/tc+na7ZIHYys26u5rqgdyr7NThPV6y8sD/6JEe07/XYn7euLBBj5PVOfpVh
        kW6zWzgx6JMY0/GPa9+kV9ksmui2zZu58XlaZce0lrkHU6NNjn9pTkr1/HV2zh0zObG6qzHM
        tU2p9+/xyJi7ZrZMWrCwfbV3yi6zm+3Mk9ZeOi+ib3jup6J6Dfce7sNnnn7fsVPlacyD+GiG
        CjOJOSdezReP3r485I2PXco5YfkHosrzgt8kvOv1frBevFXwlPK7gjL2T+KudcuUzhuc37Sa
        548mh+RJQyWW4oxEQy3mouJEAK6TTXNSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvG5u6r1Eg/dnJS2W3qq2mH/kHKvF
        xrc/mCym/FnOZLHp8TVWi83z/zBaXN41h81ixvl9TBZrj9xlt2jde4Td4vCbdlaL531AsVW7
        /jA68HrMauhl89g56y67x6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0S
        uDLufTnEWDCbu6L172XmBsabnF2MnBwSAiYS3XuXsXcxcnEICexmlGje8I0JIiEr8ezdDnYI
        W1jifssRVoiiZ4wSi7t2MoMk2AT0JV52bANLiAisYJb4/uQqG4jDLDCBUaL7xFZmiJZrjBKT
        +7+BzeIU8JRoPjuTDcQWFkiWeH3iOZjNIqAqsfrPS7CxvAKWEksufmGEsAUlTs58wtLFyAE0
        VU+ibSNYmFlAXmL72znMEOcpSPx8uowVxBYRcJKY/HoTK0SNiMTszjbmCYzCs5BMmoUwaRaS
        SbOQdCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcnVqaOxi3r/qgd4iRiYPx
        EKMEB7OSCG9ZzN1EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGpj8tNaEbZA1WnR4U5a3j9qWqprig9seRMT+PfOUY0kEi7StBOf07Q73HCKW7/LUWTxf
        +3rjE0+/hR9tauXXMn7OcDKcfPfEyo/yjrI8Thcm1p2wYiudwxFR/tLl0GLF/tu7tsS+VbON
        KZ3IMD/x36UZexvqnlWnCfdoTG981BvCvHpqcUh92lvTt2FsCXLGx+8YBDyP6s4237pANLIi
        l2XnSfGir6XbAyaq7FyZdZN5rfNC+ft6Fl+EZ69+J7XpVkNQ7kZgui3vMDTN+lZzIV7/6PUF
        Ui9j9ZkDWPJStGIy7Y/EOV3p27nsb8xeV6b5G/8q39+rZP+vXPPX5Ut8zv5G8l4WQYJx5171
        1nLfUGIpzkg01GIuKk4EAPIpsS49AwAA
X-CMS-MailID: 20220112052149epcas2p1f7b6ccd45fba2e459713310fa4041462
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220111201913epcas2p3208da25a15fe94b120706aa1c200c34f
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
        <CGME20220111201913epcas2p3208da25a15fe94b120706aa1c200c34f@epcas2p3.samsung.com>
        <20220111201722.327219-20-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Sent: Wednesday, January 12, 2022 5:17 AM
> To: Tomasz Figa <tomasz.figa@gmail.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com>; Sylwester Nawrocki
> <s.nawrocki@samsung.com>; Linus Walleij <linus.walleij@linaro.org>; Rob
> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; linux-gpio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>; Sam Protsenko
> <semen.protsenko@linaro.org>; Chanho Park <chanho61.park@samsung.com>;
> Alim Akhtar <alim.akhtar@gmail.com>
> Subject: [PATCH v2 26/28] pinctrl: samsung: add support for Exynos850 and
> ExynosAutov9 wake-ups
> 
> It seems that newer ARMv8 Exynos SoC like Exynos850 and
> ExynosAutov9 have differences of their pin controller node capable of
> external wake-up interrupts:
> 1. No multiplexed external wake-up interrupt, only direct, 2. More than
> one pin controller capable of external wake-up interrupts.
> 
> Add support for dedicated Exynos850 and ExynosAutov9 compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
And you can also put
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

