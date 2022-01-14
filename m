Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B048E447
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiANGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:30:35 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10785 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiANGae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:30:34 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220114063032epoutp04e8ec1e8417b1ec5c4b8ad5fa5770dddd~KD0vTi-N-1295612956epoutp04n
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:30:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220114063032epoutp04e8ec1e8417b1ec5c4b8ad5fa5770dddd~KD0vTi-N-1295612956epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642141832;
        bh=dDDasz5As6a6ZWbaZ6Lz1FDKPGXFQGxc6T+whEJ4i2I=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HzaLTMJcfHwXqa/BRB7FuF5KcW6in5jLx3XwOFNXaN/tF7icm57lva2MuVrTqojd+
         4Of1o9y18JWLcFVf5NQCXmwgo1pWrHu7aWuTRyDnXaw+S+zTyMfhvKdNm9jCrNv93b
         7LKc6pJVbXv10QhxJqkZphReZSi05pYqVcb620Mk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220114063030epcas5p1b4f464291a23aa05b4765bbd5bf47390~KD0tz2_Yz2598625986epcas5p1Y;
        Fri, 14 Jan 2022 06:30:30 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JZryS3YrBz4x9QV; Fri, 14 Jan
        2022 06:30:24 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.63.46822.08811E16; Fri, 14 Jan 2022 15:30:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220114063024epcas5p34983bd562a3d48915f715980be10954f~KD0ncAZZH2082320823epcas5p3G;
        Fri, 14 Jan 2022 06:30:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220114063024epsmtrp2c4fef0fba1a3f56776ee98d74f784ed0~KD0nazqnL2481424814epsmtrp20;
        Fri, 14 Jan 2022 06:30:24 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-07-61e11880844e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.FF.08738.F7811E16; Fri, 14 Jan 2022 15:30:23 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114063018epsmtip2b0dd87399018059d0aab72f9a1bb5504~KD0isYCwY1803418034epsmtip2Q;
        Fri, 14 Jan 2022 06:30:18 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Aswani Reddy'" <aswani.reddy@samsung.com>,
        "'Niyas Ahmed S T'" <niyas.ahmed@samsung.com>,
        "'Chandrasekar R'" <rcsekar@samsung.com>,
        "'Jayati Sahu'" <jayati.sahu@samsung.com>,
        "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Ajay Kumar'" <ajaykumar.rs@samsung.com>
In-Reply-To: <1b246ad6-5b65-a02f-e887-5a07e8f12ec7@canonical.com>
Subject: RE: [PATCH 04/23] clk: samsung: fsd: Add cmu_peric block clock
 information
Date:   Fri, 14 Jan 2022 12:00:17 +0530
Message-ID: <077e01d80910$35ecd5b0$a1c68110$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgIx1O+sAeG8es4CSRBet6qCzbEg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVwDNfW1fX0lqnrWEKyPaNbAMEpBKwYuBbUZhZaIhQzExI/BG36AB
        2q4t6DbNGoYVoeVjIwzLxxBEJxLUUhyUjyAwtkmGoAguViYDZUhBkGXAQLO2Dzf+nXvvOfec
        cz8IlsCBexMKpY7WKKkMMe7BvtnrHxCohxNU8D2DD+p+fouNeppbuOj5JSNA3/UNclDf7YsY
        ujG3gqHS9csYskyOctCicZyDJp4dQ/dslTgqv9OFoanSPzjo9tgSjmpb/uIi81ArB53p7OOi
        XsdZDpocW8fRQ0cT5z2hrLG6EcjMehMuszScw2X20Q5c1nzxS9nIzzkcWaG1Ache5VRxZUuW
        HXG84+kRaTQlpzUiWpmikiuUqZHig/FJ+5NCw4IlgZJwtEcsUlKZdKT4QGxcYLQiw9lMLMqm
        MrKcU3GUVive9U6ERpWlo0VpKq0uUkyr5RlqqTpIS2Vqs5SpQUpat1cSHLw71ElMTk97WtQG
        1BVBJx8U2Tl60PBWPuARkJTCtvYZLB94EAKyHcDcARvODF4AeKH+T8zFEpBLAForkl4rrlQ9
        AQzJBmBlfy2bIc0AOGY47sI4GQhb6wzunYTkOQCvLq+6PVhkGxtazfedKwTBI/fBtQp3jm3k
        UVhWYXK7sUk/eLamBbgwnwyHA9MTXAZvhb+cn3Kbscid8Ie5ShaTSARXn1ziuLCQjIb/PMrH
        GI4XnPmxj+vyheS3PNhdZeQwggOwzlLGZvA2+OwnK5fB3nBpvtOdDZLp0GgLYaZPwfrq/g36
        u7B7pJLtorBIf3jNtoux2gJNa1MYo+TDPIOAYfvBr+bvbyjfgCUFBRsBZLC1Ro8VgzfNm4qZ
        NxUzbypg/t+sBrAbwHZarc1MpbWh6t1K+sR/152iyrQA97MP+KAVTDxeCOoBGAF6ACRYYiG/
        SPM7JeDLqc8+pzWqJE1WBq3tAaHO0y5heXumqJz/RqlLkkjDg6VhYWHS8JAwidiLP5B6nRKQ
        qZSOTqdpNa15rcMInrce+7TU4fDZsjJXeHdY9ch0Ld4y2HnemFisvpLQ7qG7rCgOf/kye0Gx
        UpKbZ+j6CMs+sTD8WAc+TpxTHNPZZwKGl78/nGA6RAx90ZTwIEp8RDtfPbV3sfPtDn5dT8Tf
        HSHXy4XSbJ8d8gR9Tmi+IXD/dNeq59BvvouSnacVD+1XwZ7msuTi8kLfsoTl7S8Uo/n+BSWz
        1ijR7K9K62Ti4bzuaP2RD432pkGTMObrrZ+86m1Ozl0fL78VW3O0cSLq6Z2Y2diSBaHfN56Z
        N+/qxu03iHEfo96x2m++sLB6OvdMb8ipg2g0Bd/HC9Hkvq/MHvI1jdRPH1qT18ZHeg3FzFtP
        BtjFbG0aJQlgabTUvxOkmK1/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSvG69xMNEgzVzTC0OvD/IYnFo81Z2
        i/fLehgt5h85x2px5NQSJouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVk8
        mfKI1eLU9c9sFou2fmG3mHVhB6tF694j7BaH37SzWjy+/ofN4vabdawOIh5r5q1h9JjV0Mvm
        sWlVJ5vHnWt72Dw2L6n3uHKiidWjb8sqRo9/TXPZPT5vkgvgjOKySUnNySxLLdK3S+DKeNa/
        k7Fgtl7Fjf47rA2Mq9S6GDk5JARMJFbOfcrYxcjFISSwg1FiyaS9jBAJaYnrGyewQ9jCEiv/
        PWeHKHrOKHHnxUGwIjYBXYkdi9vYQBIiAt2MEld6ZoKNYhY4ySKxYfoNVoiWL4wSa/+vZu5i
        5ODgFHCU+D0bbLewQLDExr1HWUBsFgFVifYFW8Gm8gpYSpx+/pAdwhaUODnzCVgNs4C2RO/D
        VkYIW15i+9s5zBDnKUj8fLqMFcQWEXCT+HW3iwmiRlzi5dEj7BMYhWchGTULyahZSEbNQtKy
        gJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcORrae1g3LPqg94hRiYOxkOMEhzM
        SiK8/UX3E4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        mqF4o+6wzfRPO2t0Nddr3nimzHD7za6GrcILuI/cT0/7+7Kl/Zro3tJbjxrPtBrnrNaWC7ny
        kX3Wsg+H3KZcu89z6y5XXenE0vqpzhWSqT/4H01oaDmbWjp1U5/gkZYp7zkEvl3pagorfWXl
        LOKasPWvo0+H6+RN/9oPNp7mXdv4X6vxwgN9gSTzPacXdfbwHVx4NGaCzImrUydsnesR6Bqs
        9XLP/+6ULxbXasxP12YkNP6fXv1z9YHiTxNf7RK+lONbePbo+ZSug/mXuusV81aud6rZv6/G
        9bGznlTTITPFdcWhzPwr2k78+VbUxXcy73Ws8+zdySaidx93+iws8shZaLTGQF3qVWZ4Q+iq
        N0osxRmJhlrMRcWJADDZ5o5rAwAA
X-CMS-MailID: 20220114063024epcas5p34983bd562a3d48915f715980be10954f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122330epcas5p46ae5cd30950b1d9126479231dcf5da49
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122330epcas5p46ae5cd30950b1d9126479231dcf5da49@epcas5p4.samsung.com>
        <20220113121143.22280-5-alim.akhtar@samsung.com>
        <1b246ad6-5b65-a02f-e887-5a07e8f12ec7@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Thursday, January 13, 2022 6:25 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>Cc: soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>olof@lixom.net; linus.walleij@linaro.org; catalin.marinas@arm.com;
>robh+dt@kernel.org; s.nawrocki@samsung.com; linux-samsung-
>soc@vger.kernel.org; pankaj.dubey@samsung.com; linux-fsd@tesla.com;
>Aswani Reddy <aswani.reddy@samsung.com>; Niyas Ahmed S T
><niyas.ahmed@samsung.com>; Chandrasekar R <rcsekar@samsung.com>;
>Jayati Sahu <jayati.sahu@samsung.com>; Sriranjani P
><sriranjani.p@samsung.com>; Ajay Kumar <ajaykumar.rs@samsung.com>
>Subject: Re: [PATCH 04/23] clk: samsung: fsd: Add cmu_peric block clock
>information
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> This patch adds CMU_PERIC block clock information needed for various
>> IPs functions found in this block.
>
>Here and in all other commits, please do not use "This patch". Instead:
>https://protect2.fireeye.com/v1/url?k=5ec41fe1-015f26dc-5ec594ae-
>0cc47a31309a-72c796795ac37ef5&q=1&e=2a1e171b-f066-48ff-95a7-
>12605dbbf8a9&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.13%2Fso
>urce%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L89
>
Noted
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
>> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
>> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
>> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-fsd.c | 464
>> +++++++++++++++++++++++++++++++++-
>>  1 file changed, 463 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-fsd.c
>> b/drivers/clk/samsung/clk-fsd.c index e47523106d9e..6da20966ba99
>> 100644
>> --- a/drivers/clk/samsung/clk-fsd.c
>> +++ b/drivers/clk/samsung/clk-fsd.c
>> @@ -9,12 +9,59 @@
>>   *
>>   */
>>
>> -#include <linux/clk-provider.h>
>>  #include <linux/of.h>
>> +#include <linux/clk.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>
>Please order the includes alphabetically.
>
Sure will fix this
>>
>>  #include "clk.h"
>>  #include <dt-bindings/clock/fsd-clk.h>
>>
>> +/* Gate register bits */
>> +#define GATE_MANUAL		BIT(20)
>> +#define GATE_ENABLE_HWACG	BIT(28)
>> +
>> +/* Gate register offsets range */
>> +#define GATE_OFF_START		0x2000
>> +#define GATE_OFF_END		0x2fff
>> +
>> +/**
>> + * fsd_init_clocks - Set clocks initial configuration
>> + * @np:			CMU device tree node with "reg" property
>(CMU addr)
>> + * @reg_offs:		Register offsets array for clocks to init
>> + * @reg_offs_len:	Number of register offsets in reg_offs array
>> + *
>> + * Set manual control mode for all gate clocks.
>> + */
>> +static void __init fsd_init_clocks(struct device_node *np,
>> +		const unsigned long *reg_offs, size_t reg_offs_len)
>
>The same as exynos_arm64_init_clocks - please re-use instead of duplicating.
>
Will re-base on latest tree to have these common functions
>> +{
>> +	void __iomem *reg_base;
>> +	size_t i;
>> +
>> +	reg_base = of_iomap(np, 0);
>> +	if (!reg_base)
>> +		panic("%s: failed to map registers\n", __func__);
>> +
>> +	for (i = 0; i < reg_offs_len; ++i) {
>> +		void __iomem *reg = reg_base + reg_offs[i];
>> +		u32 val;
>> +
>> +		/* Modify only gate clock registers */
>> +		if (reg_offs[i] < GATE_OFF_START || reg_offs[i] >
>GATE_OFF_END)
>> +			continue;
>> +
>> +		val = readl(reg);
>> +		val |= GATE_MANUAL;
>> +		val &= ~GATE_ENABLE_HWACG;
>> +		writel(val, reg);
>> +	}
>> +
>> +	iounmap(reg_base);
>> +}
>> +
>
>(...)
>
>> +/**
>> + * fsd_cmu_probe - Probe function for FSD platform clocks
>> + * @pdev: Pointer to platform device
>> + *
>> + * Configure clock hierarchy for clock domains of FSD platform  */
>> +static int __init fsd_cmu_probe(struct platform_device *pdev) {
>> +	const struct samsung_cmu_info *info;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +
>> +	info = of_device_get_match_data(dev);
>> +	fsd_init_clocks(np, info->clk_regs, info->nr_clk_regs);
>> +	samsung_cmu_register_one(np, info);
>> +
>> +	/* Keep bus clock running, so it's possible to access CMU registers */
>> +	if (info->clk_name) {
>> +		struct clk *bus_clk;
>> +
>> +		bus_clk = clk_get(dev, info->clk_name);
>> +		if (IS_ERR(bus_clk)) {
>> +			pr_err("%s: could not find bus clock %s; err = %ld\n",
>> +			       __func__, info->clk_name, PTR_ERR(bus_clk));
>> +		} else {
>> +			clk_prepare_enable(bus_clk);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>
>Please re-use exynos_arm64_register_cmu(). This will also solve my previous
>comment about exynos_arm64_init_clocks().
>
ok
>> +
>> +/* CMUs which belong to Power Domains and need runtime PM to be
>> +implemented */ static const struct of_device_id fsd_cmu_of_match[] = {
>> +	{
>> +		.compatible = "tesla,fsd-clock-peric",
>> +		.data = &peric_cmu_info,
>> +	}, {
>> +	},
>> +};
>> +
>> +static struct platform_driver fsd_cmu_driver __refdata = {
>> +	.driver	= {
>> +		.name = "fsd-cmu",
>> +		.of_match_table = fsd_cmu_of_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = fsd_cmu_probe,
>> +};
>> +
>> +static int __init fsd_cmu_init(void)
>> +{
>> +	return platform_driver_register(&fsd_cmu_driver);
>> +}
>> +core_initcall(fsd_cmu_init);
>>
>
>
>Best regards,
>Krzysztof

