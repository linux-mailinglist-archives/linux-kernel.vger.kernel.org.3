Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3126548E41F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiANGQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:16:17 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:49624 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiANGQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:16:15 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220114061613epoutp041cff07ae24e2ecc3d1213c7faa213561~KDoPQFD3I0057000570epoutp04N
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:16:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220114061613epoutp041cff07ae24e2ecc3d1213c7faa213561~KDoPQFD3I0057000570epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642140973;
        bh=/jJg+HLwuIlmsM6ENqFjZzDJD1HfIhHE7HBn+iaWwm4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=SFRMF0egY6dX6n3/7vKEOk/3dXckKAoW/r54gKD+Anp4RiuNHVsVt+9HXcl7lw8gP
         JDNMwAsZomBDDkNbk7E8uxQMhXLzZx+YK0R+hndQ9inCpfkin5eiSj9ilGFv8lhj63
         SqNFUV1jwqNL1N2Kmr0naQ643cYDbRc3+qZQr4Tk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220114061612epcas5p109458634755b92a6432019cefa2fd3e1~KDoOxf4BL1055410554epcas5p1m;
        Fri, 14 Jan 2022 06:16:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JZrf11L44z4x9Q8; Fri, 14 Jan
        2022 06:16:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.1C.05590.92511E16; Fri, 14 Jan 2022 15:16:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220114061608epcas5p2c16b3ad7c52a441f240d1d1ea93cc4a1~KDoKk_K4b2842728427epcas5p2M;
        Fri, 14 Jan 2022 06:16:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220114061608epsmtrp2129819ac708d9691c45f1aafd2897541~KDoKjllmq1575215752epsmtrp2P;
        Fri, 14 Jan 2022 06:16:08 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-eb-61e11529a639
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.9E.08738.82511E16; Fri, 14 Jan 2022 15:16:08 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114061605epsmtip18357d3467cbd8470473eac9672fb7a7c~KDoH3KHd03210332103epsmtip1t;
        Fri, 14 Jan 2022 06:16:05 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Jayati Sahu'" <jayati.sahu@samsung.com>,
        "'Ajay Kumar'" <ajaykumar.rs@samsung.com>
In-Reply-To: <b9fac286-9227-b26b-221b-7f54b63e6b0b@canonical.com>
Subject: RE: [PATCH 03/23] clk: samsung: fsd: Add initial clock support
Date:   Fri, 14 Jan 2022 11:46:04 +0530
Message-ID: <077d01d8090e$37f75da0$a7e618e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgIsF/K0AhOIyekBxha2S6qFgZWg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wbZRjed3e9Xklqzg7CN/BHbbYYMEArbb0uQ53O7Sb8QZyRDaPshBs0
        lLbptU50ZoWFKQME6jTadbVOBgRwQoENWyCzKzJAKQsIsiyOMRCZMEAwA0eYLceU/573/Z7n
        e5/n+0Ggkut4FKHVm1mTntHJ8DDs4pWYmLiYiFuMvLQdpy7P/YBRc9WlgPrK3y+g/L1VCNU0
        u4xQp1drEMp9e1hALZT+JqBu3UmjBj0OnPoi0IlQvSOLOHWudUlIFXX4hdSVmY8E1O2RVfxF
        km5wNgDabi3DaXddMU7fGG7H6eaq4/TQ1UIB/UlLHaDXCs8K6UX3E6mi9NxdOSyTxZqkrD7T
        kKXVZyfJkg9kvJyhUssVcQoN9ZxMqmfy2CTZnpTUuL1aXTCFTPouo7MEW6kMx8kSnt9lMljM
        rDTHwJmTZKwxS2dUGuM5Jo+z6LPj9ax5p0Iuf1YVJB7Ozbk2WQeMrdveG2yYFlhBIOIUEBGQ
        VMIFW0BwCoQREtILYF//5zhf/AVgV/PvGF8sAni2qAd5KOmcdwn5BQ+As733Eb6YBrDbvQJC
        LJyMg23fnFzfK5wsBrD+3so6CyWtKBxbuS4IsUTkbuh/YEdDeCu5D/7stwXVBIGRO6B1KSXU
        FpMa6B0dw3n8KOz5cgILYZR8El6adaC8JSlcmaxe3zKc3AsfrA4CnhMJp7v861YhuURAr7dW
        wAv2wIrWpQ3xVninu0XI4yi4eLcDD3mAZC4s9STy7WPwvPNHjMcvwMtDDixEQckY+J0ngR/1
        CCy7P4HwSjH8+KSEZ++AJ+7+sqGMhpUlJRsGaDi8XItVgKfsm4LZNwWzbwpg/3+YC2B1YBtr
        5PKyWU5lTNSzR/+78ExDnhusP/LY5DYwPjYf7wMIAXwAEqgsXFxuuslIxFlM/vusyZBhsuhY
        zgdUwcOuRKMiMg3BX6I3ZyiUGrlSrVYrNYlqhSxS3JvdyEjIbMbM5rKskTU91CGEKMqKsAP6
        txr6t2OeuZ6OWRFao0NHBhrDlrQ/FXzoij7DRWsx9cIWh3QcuTBnnwyw9bZX8mvXnqk7XFvm
        fXPq1al0Mfp0f7nvXKBz9OivF4bMXmiNbN3pruhm7n1/ZAY9GO4XuK5O+SsUZ1R/+tK6LB+o
        C9uW5/OnZtbIGKdHWKukLRM4Md/4+KcqYx/orOoI8+8uTzDZLjk1++mG3q5Df5tFqm/Pl+4T
        XnspOemQsei0q7nbGZEyV3DkWHHH/r7AxdHK9tea0hNuqKmS1/PJpvq03JvjM48NHH9bteVg
        rOPrauREyx+SAwXb/ykYna4peSMyuW/qs9RFW1TSO7oWYbhGhnE5jCIWNXHMv3W9yEBtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSnK6G6MNEgykrhCwOvD/IYvF+WQ+j
        xfwj51gtjpxawmSx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOKC6blNSczLLUIn27BK6Mi09XMRZslay4vOYlawPjedEuRk4OCQET
        iX0fFrB3MXJxCAnsYJR4Pm8yM0RCWuL6xgnsELawxMp/z6GKnjNKbDzcBZZgE9CV2LG4jQ0k
        ISLQzShxpWcmI4jDLNDHLHFv0w8miJYvjBKbri8Fa+EUcJQ48n8W2A5hAXeJs0cmAXVwcLAI
        qEo0fPEBCfMKWErsvvmADcIWlDg58wkLiM0soC3R+7CVEcKWl9j+dg7UqQoSP58uYwWxRQTc
        JP7/uQxVIy7x8ugR9gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOKK1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe/qL7iUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwHeKrUTkyl4Oz85P8jdbyDY9vFtmFsDPN
        eGqhc7dz3umvFZM09vHZvOdvy3sz+8h2/SCDNp5ZfII+m0TCDl6RC4qIllgd0azZWSAeen8T
        27sDjDlRbv8kDm3b43D/mAH7Lc5ilzXeDk4yd+YyiYmbP0qad3hT/jz/mee0/Nx1lk+wfp3+
        pzh98dnChIgWl/3q/584r9I6fPyJUvrzntgNXIw87x06bn6V2Ohx/tHkd5umbE29VDjjhg+/
        S2iZxi/HS4+XNj7y57rT1qa+d+2WpFP6atmP1Dhb7/BOuusswFY/LzmpTdifTVmqMWBt9scv
        fhyhbCs9p/9dItf1eRaH6D6LDUJ3dr07VFLhPkdQiaU4I9FQi7moOBEA1lcVD1cDAAA=
X-CMS-MailID: 20220114061608epcas5p2c16b3ad7c52a441f240d1d1ea93cc4a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122324epcas5p105c53b448b5801813a02a88c6107a2f3
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122324epcas5p105c53b448b5801813a02a88c6107a2f3@epcas5p1.samsung.com>
        <20220113121143.22280-4-alim.akhtar@samsung.com>
        <b9fac286-9227-b26b-221b-7f54b63e6b0b@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Thursday, January 13, 2022 6:20 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>Cc: soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>olof@lixom.net; linus.walleij@linaro.org; catalin.marinas@arm.com;
>robh+dt@kernel.org; s.nawrocki@samsung.com; linux-samsung-
>soc@vger.kernel.org; pankaj.dubey@samsung.com; linux-fsd@tesla.com;
>Jayati Sahu <jayati.sahu@samsung.com>; Ajay Kumar
><ajaykumar.rs@samsung.com>
>Subject: Re: [PATCH 03/23] clk: samsung: fsd: Add initial clock support
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> Add initial clock support for FSD (Full Self-Driving) SoC which is
>> required to bring-up platforms based on this SoC.
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  drivers/clk/samsung/Makefile  |   1 +
>>  drivers/clk/samsung/clk-fsd.c | 308
>++++++++++++++++++++++++++++++++++
>>  drivers/clk/samsung/clk-pll.c |   1 +
>>  drivers/clk/samsung/clk-pll.h |   1 +
>>  4 files changed, 311 insertions(+)
>>  create mode 100644 drivers/clk/samsung/clk-fsd.c
>>
>> diff --git a/drivers/clk/samsung/Makefile
>> b/drivers/clk/samsung/Makefile index c46cf11e4d0b..d66b2ede004c 100644
>> --- a/drivers/clk/samsung/Makefile
>> +++ b/drivers/clk/samsung/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-
>exynos-audss.o
>>  obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
>>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
>>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
>> +obj-$(CONFIG_ARCH_TESLA_FSD)         += clk-fsd.o
>
>It should be rather it's own CONFIG_TESLA_FSD_CLK option, just like other
>Exynos designs. This keeps unified approach with existing Samsung clock
>Kconfig.
>
Ok, will add a separate config for this 

>>  obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
>> obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
>> obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o diff --git
>> a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c new
>> file mode 100644 index 000000000000..e47523106d9e
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-fsd.c
>> @@ -0,0 +1,308 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Common Clock Framework support for FSD SoC.
>> + *
>> + * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
>> + *             https://www.samsung.com
>> + * Copyright (c) 2017-2022 Tesla, Inc.
>> + *             https://www.tesla.com
>> + *
>
>Drop the line break with empty * comment.
Will fix in next version
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of.h>
>> +
>> +#include "clk.h"
>> +#include <dt-bindings/clock/fsd-clk.h>
>
>dt-bindings headers before local clk.h.
>
Noted, thanks
>> +
>> +/* Register Offset definitions for CMU_CMU (0x11c10000) */
>
>
>
>Best regards,
>Krzysztof

