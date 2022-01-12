Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5944648BE59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350882AbiALF3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:29:07 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:33637 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350877AbiALF3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:29:05 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220112052903epoutp02498528dcd3a93c6289e9bb35e2d071d7~Jbse_ln0Z0202702027epoutp02W
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:29:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220112052903epoutp02498528dcd3a93c6289e9bb35e2d071d7~Jbse_ln0Z0202702027epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641965343;
        bh=I5mC0Am323qhOo8VOwmF1RZGCCEQxTEwvXuXF9GRz9c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rWLgQoUOXNew3q4E1bfhKrwPKXpbMc0qJ8B9t4Ly640+QUM65V9eYroXwJ6ZXOAeW
         caBS3xcv3JtqILfXxTpK3o8jbmAqpwummpe3fUP1QYxwTmZUOwZKOQW92LYUIrTXJM
         QJVcfTjSqq+WJg5rnYYblaDcS4LVFQ1apmxhxLc0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220112052902epcas2p4dce79e256120a8fe6db334a81acf45e1~JbsefM7CZ0058800588epcas2p4B;
        Wed, 12 Jan 2022 05:29:02 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JYbhX1B0sz4x9QJ; Wed, 12 Jan
        2022 05:29:00 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.A8.10018.9176ED16; Wed, 12 Jan 2022 14:28:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220112052857epcas2p32c81889d27e8cf5de3143bcc13e3f9e1~JbsZHJ7kn0072700727epcas2p3B;
        Wed, 12 Jan 2022 05:28:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220112052856epsmtrp1d7cceb5c5ad4cc17821d18814d323baf~JbsZD4TcJ2373723737epsmtrp1V;
        Wed, 12 Jan 2022 05:28:56 +0000 (GMT)
X-AuditID: b6c32a46-a25ff70000002722-4e-61de6719da38
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.E8.29871.8176ED16; Wed, 12 Jan 2022 14:28:56 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220112052856epsmtip2347092b529cb387e9aabfacc3d3b9f6d~JbsYy6eNP3225432254epsmtip2W;
        Wed, 12 Jan 2022 05:28:56 +0000 (GMT)
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
In-Reply-To: <20220111201722.327219-22-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 28/28] arm64: dts: exynos: use dedicated wake-up
 pinctrl compatible in ExynosAutov9
Date:   Wed, 12 Jan 2022 14:28:56 +0900
Message-ID: <000301d80775$4b8f7310$e2ae5930$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEPsg0rhN1RyLWOER/EMv1WEdO3IgGaoiyGAlSTFcCt0Ay+MA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmma5k+r1Eg62T5S2W3qq2mH/kHKvF
        xrc/mCym/FnOZLHp8TVWi83z/zBaXN41h81ixvl9TBZrj9xlt2jde4Td4vCbdlaL531AsVW7
        /jA68HrMauhl89g56y67x6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS
        81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgI5VUihLzCkFCgUkFhcr6dvZ
        FOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnbHm1h7HgLG/Fkauv
        WRsYb3B3MXJySAiYSKxZ/oaxi5GLQ0hgB6PE7gM72UASQgKfGCW+vPeDSHxjlFj2eCc7TMfq
        fyfYIRJ7GSUmnG5hg3BeMEpM3L+GCaSKTUBf4mXHNlaQhIjAImaJ1XtOgy1hFuhjlGhtugI2
        i1PAU6J7bxcLiC0skCMxacssVhCbRUBVYuKHhWCTeAUsJaYc28oGYQtKnJz5BKyeWUBeYvvb
        OcwQNylI/Hy6DKxXRMBJouPVbDaIGhGJ2Z1tzCCLJQSucEjsunuACaLBReLR11ssELawxKvj
        W6Cek5J42d/GDtHQzSgx6eVdqMQMRol3N3MgbGOJWc/agd7hANqgKbF+lz6IKSGgLHHkFtRt
        fBIdh/+yQ4R5JTrahCAa1SUObJ8OtVVWonvOZ9YJjEqzkHw2C8lns5B8MAth1wJGllWMYqkF
        xbnpqcVGBUbw6E7Oz93ECE7JWm47GKe8/aB3iJGJg/EQowQHs5IIb1nM3UQh3pTEyqrUovz4
        otKc1OJDjKbAsJ7ILCWanA/MCnkl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KL
        YPqYODilGpgU+pJEw7PDinrulMc1/V7zTvJx8f/env/KNm/q9L2rfbtce9iVZ3t77LLoufz/
        9J51K21dp2v+SdbvjleZ2RjVvGJ7t3rHjKgqD+85HYKmKur8V11jN379EDf39Ptnhd2tsyZv
        fLldfmOYtuXJyCzV6sqJc014jt9ZHPypMVAq5pzPPpM+9lLjohMGjUb5D1qlohZ0JVt45SVL
        Fd48I7qB5V9ouF7Wt6h5r7PvH00/dc1/0fQNi6YckJ4S6RtcPj3oi6PApgdV738xZOdc2z7b
        /dKnZqFTJ5o+bk27lzHpfKBe7J51k3WW1B9YfDfJc9n7QJHF984tsJryu3nSkkm9NSf/M8mH
        pQkkzby6dLsSS3FGoqEWc1FxIgBNG6dyUgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvK5E+r1Eg3/nTSyW3qq2mH/kHKvF
        xrc/mCym/FnOZLHp8TVWi83z/zBaXN41h81ixvl9TBZrj9xlt2jde4Td4vCbdlaL531AsVW7
        /jA68HrMauhl89g56y67x6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0S
        uDK2vNrDWHCWt+LI1desDYw3uLsYOTkkBEwkVv87wd7FyMUhJLCbUeL4sRXsEAlZiWfvdkDZ
        whL3W46wQhQ9Y5TYcuUxWIJNQF/iZcc2sISIwApmie9PrrKBOMwCExgluk9sZYZoucYo0bri
        AFgLp4CnRPfeLhYQW1ggS+Lo4+WMIDaLgKrExA8LmUBsXgFLiSnHtrJB2IISJ2c+AarnAJqq
        J9G2EaycWUBeYvvbOcwQ5ylI/Hy6jBXEFhFwkuh4NZsNokZEYnZnG/MERuFZSCbNQpg0C8mk
        WUg6FjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5OLc0djNtXfdA7xMjEwXiI
        UYKDWUmEtyzmbqIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwc
        nFINTPH7nnKuVi9pknn1bRH3w4K9Z1ZKJq2qOf4j9rHlIhH1BbOUDvR5Vtplz4zUmbGgsGDB
        pwtfTyrOlWDdukc+ff6Jhfcfp9458OXleaZzF89E+4j+3uvA4OMjv8/o13b1wJdHCo8VnnKP
        1w53FLWQXX+z8dJeufMdpVZhZ2uPszxOzdSz/bxG5/HVRQV2Kt7tFYHKX6bPe9/jOOeq26aM
        MyePnEv/brlXOkNnd3hUqiazquEuDfXjLmLJIs7enne8Pb2ct1x8b1nseUd3pk1B+ZICMc1O
        ySkWIoIzbr9YUza7Y/OeUrlDbwynfV1huY11aqfKmW2fLlsd/X3f/iKTvObV5jOLZu98xmRu
        VreUvUeJpTgj0VCLuag4EQDY0OJTPQMAAA==
X-CMS-MailID: 20220112052857epcas2p32c81889d27e8cf5de3143bcc13e3f9e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220111201838epcas2p313dbfd5a364c64f5286e332b434abf49
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
        <CGME20220111201838epcas2p313dbfd5a364c64f5286e332b434abf49@epcas2p3.samsung.com>
        <20220111201722.327219-22-krzysztof.kozlowski@canonical.com>
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
> Subject: [PATCH v2 28/28] arm64: dts: exynos: use dedicated wake-up
> pinctrl compatible in ExynosAutov9
> 
> Older Samsung Exynos SoC pin controller nodes (Exynos3250, Exynos4,
> Exynos5, Exynos5433) with external wake-up interrupts, expected to have
> one interrupt for multiplexing these wake-up interrupts.  Also they
> expected to have exactly one pin controller capable of external wake-up
> interrupts.
> 
> It seems however that newer ARMv8 Exynos SoC like Exynos850 and
> ExynosAutov9 have differences:
> 1. No multiplexed external wake-up interrupt, only direct, 2. More than
> one pin controller capable of external wake-up interrupts.
> 
> Use dedicated ExynosAutov9 compatible for its external wake-up interrupts
> controller to indicate the differences.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
And you can also put
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

