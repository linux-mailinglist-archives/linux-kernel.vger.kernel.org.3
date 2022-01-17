Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0849088E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbiAQMUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:20:35 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:29669 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiAQMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:20:32 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220117122030epoutp03c91837f2135183e2f1a00b104313b483~LDiJ__GF20439804398epoutp03J
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:20:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220117122030epoutp03c91837f2135183e2f1a00b104313b483~LDiJ__GF20439804398epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642422030;
        bh=p28mpu+UhhDAsJxN5hx5T0EegAUdaGYN4Xh5Bl4SXFc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oJYGllZ8MrJDtyrGwPt08yCZjiQCHp8YQQzB28WneEIVRgQkN8wadE456Y7S+lvyd
         eg7P3c8CAsNC8gnSgrWMumpuHVqLTPJDgc6Wb0AXPyDpX6aBMbLwPCiBCxSXREPIR8
         ow8GmQIvp6Wvpn1Ygb2rRXLQu/dtosMWqhycwnlA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220117122029epcas5p126443cbfd86a063e572c8742deb014e6~LDiJhQCNU1253312533epcas5p1d;
        Mon, 17 Jan 2022 12:20:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JcrZx0rTVz4x9Q5; Mon, 17 Jan
        2022 12:20:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.77.06423.80F55E16; Mon, 17 Jan 2022 21:20:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220117122024epcas5p30804299cf49e8512b3149b37201d4864~LDiEP53Zi1158111581epcas5p3M;
        Mon, 17 Jan 2022 12:20:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220117122024epsmtrp21b0de4d9ed538c456670fc7d7f835a90~LDiEOG6ZN1623316233epsmtrp2c;
        Mon, 17 Jan 2022 12:20:24 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-c0-61e55f08bc50
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.A6.29871.80F55E16; Mon, 17 Jan 2022 21:20:24 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220117122021epsmtip2de53ff3ecae89dceb41f71edd59234b2~LDiBoH9N20070500705epsmtip2M;
        Mon, 17 Jan 2022 12:20:21 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Jonathan Cameron'" <jic23@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <olof@lixom.net>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <linux-iio@vger.kernel.org>,
        "'Tamseel Shams'" <m.shams@samsung.com>
In-Reply-To: <20220116111939.413ece7e@jic23-huawei>
Subject: RE: [PATCH 21/23] iio: adc: exynos-adc: Add support for ADC V3
 controller
Date:   Mon, 17 Jan 2022 17:50:19 +0530
Message-ID: <00b201d80b9c$9a3de160$ceb9a420$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgKiQ5pNAaVpUiICYznxwqqFdEWg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmui5n/NNEg7WbGC3eL+thtJh/5Byr
        xYOmVUwWG9/+YLKY8mc5k8Wmx9dYLT723GO1ePgq3GLekXcsFpd3zWGzmHF+H5PF3dbF7Ban
        rn9ms1i09Qu7ReveI+wWh9+0s1o8vv6HzUHQY828NYwesxp62Tw2repk87hzbQ+bx+Yl9R5X
        TjSxevRtWcXo8a9pLrvH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QK8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
        E3OLS/PS9fJSS6wMDQyMTIEKE7IzWq+9YyzYbVGx4NMy9gbGXXpdjJwcEgImEi0vuli7GLk4
        hAR2M0q8WPeOHSQhJPCJUWLquWyIxDdGiae/NjJ2MXKAdfR+YoKo2cso8WaTPkTNS6Ca7nlg
        zWwCuhI7FrexgdgiAtoSe98cZASxmQXuM0tcn54LYnMKGEvM/v6bGcQWFgiR+Dz3LBPIfBYB
        VYmTn2pBwrwClhJbOs4xQdiCEidnPmGBGCMvsf3tHGaIBxQkfj5dxgqxyk3iy/obTBA14hIv
        jx5hB7lNQuA/h0Tr162sEA0uEoffzGKCsIUlXh3fwg5hS0l8freXDeLHbImeXcYQ4RqJpfOO
        sUDY9hIHrsxhASlhFtCUWL9LH2IVn0Tv7ydMEJ28Eh1tQhDVqhLN765CdUpLTOzuZoUo8ZDo
        ++Q7gVFxFpK/ZiH5axaS+2ch7FrAyLKKUTK1oDg3PbXYtMAwL7UcHtXJ+bmbGMFpXMtzB+Pd
        Bx/0DjEycTAeYpTgYFYS4T3G/SRRiDclsbIqtSg/vqg0J7X4EKMpMKwnMkuJJucDM0leSbyh
        iaWBiZmZmYmlsZmhkjjv6fQNiUIC6YklqdmpqQWpRTB9TBycUg1MHRfDy3zP+F39bs0b+iz/
        ofvqx39D06pm6Dzb3/R7xyzbRZm7z8x5qbP/Qs3WBV3vg2zeb7GfvkbuwjLjxsPlnbMK9KJ2
        b5DdHvjd+IPyTq38uTwt4Qxyu08znhApWViz4YLZjRvbJq0oPX9T8aPxwh8395bwTwjZZDLP
        UzPoKdOBLh/3mkQGpttL7/xKv3/2W/NB5r381hIJjY+9Vc9MLnq01zZfiCfo5W61m5E3laO+
        HzHpUvKvvvyqh/daVuijR0sZzq+31N6W1eilcEBHdf+SiHqeKwceF/7RE2iXEvDZVXB17qaV
        hs0Lpj+87S8f4m475/YelsTXDAWvxCoW/5jYyBEcd2L6jqdpXwOt7yixFGckGmoxFxUnAgBB
        7Q5HbAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSvC5H/NNEg2OTOS3eL+thtJh/5Byr
        xYOmVUwWG9/+YLKY8mc5k8Wmx9dYLT723GO1ePgq3GLekXcsFpd3zWGzmHF+H5PF3dbF7Ban
        rn9ms1i09Qu7ReveI+wWh9+0s1o8vv6HzUHQY828NYwesxp62Tw2repk87hzbQ+bx+Yl9R5X
        TjSxevRtWcXo8a9pLrvH501yAZxRXDYpqTmZZalF+nYJXBmt194xFuy2qFjwaRl7A+MuvS5G
        Dg4JAROJ3k9MXYxcHEICuxklNnffZOxi5ASKS0tc3ziBHcIWllj57zmYLSTwnFGi7ZY+iM0m
        oCuxY3EbG4gtIqAtsffNQUaQQcwCH5kl5v9bBDUVqKF3ejszSBWngLHE7O+/wWxhgSCJp8d7
        WECuYBFQlTj5qRYkzCtgKbGl4xwThC0ocXLmE7ASZgE9ibaNYLcxC8hLbH87hxniNgWJn0+X
        sULc4CbxZf0NJogacYmXR4+wT2AUnoVk0iyESbOQTJqFpGMBI8sqRsnUguLc9NxiwwLDvNRy
        veLE3OLSvHS95PzcTYzgiNbS3MG4fdUHvUOMTByMhxglOJiVRHiPcT9JFOJNSaysSi3Kjy8q
        zUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFpl36NgPRJDodnrkuWc8hVews+
        kOfZn/N2/8EjEYJvJvjPDS8r1GKoOLhSrvCtyIqZ3l+nnlNY0c1xV/Jj/PG5fCk/OcVLunPm
        NC1Vsfp1dLKecsKetSlBil7NoVuWbYrOY/XwmBt52n62ttN+4bCNypPlNOWmz54+RfGUMG+S
        9+ddWu9jo+aLqBU5n3y3xVmp869Y3LUVNgmxy/8Gert+drlzzGFZ/GY9+WSHf3ELqiQ+L8s8
        5fnk3q43vNXxmgrvzTceZhZc6qjmNWXG6TObr0/p1jEPP2l4NeOH9+9IdiZn10sFKWqqlwq+
        BqqmSjKqFwmfrvxtdijlo8lzj32bJVa2uMdxfY0zZr/1S0mJpTgj0VCLuag4EQCSzu9tVwMA
        AA==
X-CMS-MailID: 20220117122024epcas5p30804299cf49e8512b3149b37201d4864
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122452epcas5p201a3a87d0e9c0e9f449a90ed62de1f1c
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122452epcas5p201a3a87d0e9c0e9f449a90ed62de1f1c@epcas5p2.samsung.com>
        <20220113121143.22280-22-alim.akhtar@samsung.com>
        <20220116111939.413ece7e@jic23-huawei>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan

>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@kernel.org]
>Sent: Sunday, January 16, 2022 4:50 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>olof@lixom.net; linus.walleij@linaro.org; catalin.marinas@arm.com;
>robh+dt@kernel.org; krzysztof.kozlowski@canonical.com;
>s.nawrocki@samsung.com; linux-samsung-soc@vger.kernel.org;
>pankaj.dubey@samsung.com; linux-fsd@tesla.com; linux-
>iio@vger.kernel.org; Tamseel Shams <m.shams@samsung.com>
>Subject: Re: [PATCH 21/23] iio: adc: exynos-adc: Add support for ADC V3
>controller
>
>On Thu, 13 Jan 2022 17:41:41 +0530
>Alim Akhtar <alim.akhtar@samsung.com> wrote:
>
>> Exynos's ADC-V3 has some difference in registers set, number of
>> programmable channels (16 channel) etc. This patch adds support for
>> ADC-V3 controller version.
>>
>> Cc: linux-fsd@tesla.com
>> Cc: jic23@kernel.org
>> Cc: linux-iio@vger.kernel.org
>> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>
>Hi Alim,
>
>A few minor suggestions below.  I'm not seeing a binding update though...
>
>I'd also suggest that it would be more appropriate to break this out as a
>separate mini series from the main support so that it can be reviewed and
>merge separately. It's not ideal when a list just gets patch 21 of
>23 with no cover letter etc sent to it.
>
Thanks for the detailed review, I agree, will send as a separate patch set
only related with ADC support.
And addressing rest of your comments in this patch.

>Jonathan
>
>> ---
>>  drivers/iio/adc/exynos_adc.c | 74
>> +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 72 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/exynos_adc.c
>> b/drivers/iio/adc/exynos_adc.c index 3b3868aa2533..61752e798fd6 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -55,6 +55,11 @@
>>  #define ADC_V2_INT_ST(x)	((x) + 0x14)
>>  #define ADC_V2_VER(x)		((x) + 0x20)
>>
>> +/* ADC_V3 register definitions */
>> +#define ADC_V3_DAT(x)			((x) + 0x08)
>> +#define ADC_V3_DAT_SUM(x)		((x) + 0x0C)
>> +#define ADC_V3_DBG_DATA(x)		((x) + 0x1C)
>> +
>>  /* Bit definitions for ADC_V1 */
>>  #define ADC_V1_CON_RES		(1u << 16)
>>  #define ADC_V1_CON_PRSCEN	(1u << 14)
>> @@ -92,6 +97,7 @@
>>
>>  /* Bit definitions for ADC_V2 */
>>  #define ADC_V2_CON1_SOFT_RESET	(1u << 2)
>> +#define ADC_V2_CON1_SOFT_NON_RESET	(1u << 1)
>>
>>  #define ADC_V2_CON2_OSEL	(1u << 10)
>>  #define ADC_V2_CON2_ESEL	(1u << 9)
>> @@ -100,6 +106,7 @@
>>  #define ADC_V2_CON2_ACH_SEL(x)	(((x) & 0xF) << 0)
>>  #define ADC_V2_CON2_ACH_MASK	0xF
>>
>> +#define MAX_ADC_V3_CHANNELS		16
>>  #define MAX_ADC_V2_CHANNELS		10
>>  #define MAX_ADC_V1_CHANNELS		8
>>  #define MAX_EXYNOS3250_ADC_CHANNELS	2
>
>Given we have a mixture of required an unrequired elements in this
structure
>it might be a good idea to add some documentation.  Kernel-doc for the
>whole structure preferred.  Note this isn't necessarily something that
needs
>to be in this patch given the lack of docs predates this and with the
change to
>make
>adc_isr() required that I suggest below things aren't made worse by this
>patch.
>
>> @@ -164,6 +171,7 @@ struct exynos_adc_data {
>>  	void (*exit_hw)(struct exynos_adc *info);
>>  	void (*clear_irq)(struct exynos_adc *info);
>>  	void (*start_conv)(struct exynos_adc *info, unsigned long addr);
>> +	irqreturn_t (*adc_isr)(int irq, void *dev_id);
>>  };
>>
>>  static void exynos_adc_unprepare_clk(struct exynos_adc *info) @@
>> -484,6 +492,59 @@ static const struct exynos_adc_data exynos7_adc_data =
>{
>>  	.start_conv	= exynos_adc_v2_start_conv,
>>  };
>>
>> +static void exynos_adc_v3_init_hw(struct exynos_adc *info) {
>> +	u32 con2;
>> +
>> +	writel(ADC_V2_CON1_SOFT_RESET, ADC_V2_CON1(info->regs));
>> +
>> +	writel(ADC_V2_CON1_SOFT_NON_RESET, ADC_V2_CON1(info-
>>regs));
>> +
>> +	con2 = ADC_V2_CON2_C_TIME(6);
>> +	writel(con2, ADC_V2_CON2(info->regs));
>> +
>> +	/* Enable interrupts */
>> +	writel(1, ADC_V2_INT_EN(info->regs)); }
>> +
>> +static void exynos_adc_v3_exit_hw(struct exynos_adc *info) {
>> +	u32 con2;
>> +
>> +	con2 = readl(ADC_V2_CON2(info->regs));
>> +	con2 &= ~ADC_V2_CON2_C_TIME(7);
>> +	writel(con2, ADC_V2_CON2(info->regs));
>> +
>> +	/* Disable interrupts */
>> +	writel(0, ADC_V2_INT_EN(info->regs)); }
>> +
>> +static irqreturn_t exynos_adc_v3_isr(int irq, void *dev_id) {
>> +	struct exynos_adc *info = (struct exynos_adc *)dev_id;
>
>Shouldn't need the cast as cast from void * to another pointer is always
valid
>in C without the explicit cast.
>
>> +	u32 mask = info->data->mask;
>> +
>> +	info->value = readl(ADC_V3_DAT(info->regs)) & mask;
>> +
>> +	if (info->data->clear_irq)
>> +		info->data->clear_irq(info);
>
>Don't need this currently as v3_isr() is always matched with clear_isr()
being
>provided.  Having the check implies otherwise which is probably not a good
>thing to do until some future device support (maybe) needs it.
>
>> +
>> +	complete(&info->completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static const struct exynos_adc_data exynos_adc_v3_adc_data = {
>> +	.num_channels	= MAX_ADC_V3_CHANNELS,
>> +	.mask		= ADC_DATX_MASK, /* 12 bit ADC resolution */
>> +
>> +	.init_hw	= exynos_adc_v3_init_hw,
>> +	.exit_hw	= exynos_adc_v3_exit_hw,
>> +	.clear_irq	= exynos_adc_v2_clear_irq,
>> +	.start_conv	= exynos_adc_v2_start_conv,
>> +	.adc_isr	= exynos_adc_v3_isr,
>> +};
>> +
>>  static const struct of_device_id exynos_adc_match[] = {
>>  	{
>>  		.compatible = "samsung,s3c2410-adc", @@ -518,6 +579,9 @@
>static
>> const struct of_device_id exynos_adc_match[] = {
>>  	}, {
>>  		.compatible = "samsung,exynos7-adc",
>>  		.data = &exynos7_adc_data,
>> +	}, {
>> +		.compatible = "samsung,exynos-adc-v3",
>> +		.data = &exynos_adc_v3_adc_data,
>>  	},
>>  	{},
>>  };
>> @@ -719,6 +783,12 @@ static const struct iio_chan_spec
>exynos_adc_iio_channels[] = {
>>  	ADC_CHANNEL(7, "adc7"),
>>  	ADC_CHANNEL(8, "adc8"),
>>  	ADC_CHANNEL(9, "adc9"),
>> +	ADC_CHANNEL(10, "adc10"),
>> +	ADC_CHANNEL(11, "adc11"),
>> +	ADC_CHANNEL(12, "adc12"),
>> +	ADC_CHANNEL(13, "adc13"),
>> +	ADC_CHANNEL(14, "adc14"),
>> +	ADC_CHANNEL(15, "adc15"),
>>  };
>>
>>  static int exynos_adc_remove_devices(struct device *dev, void *c) @@
>> -885,8 +955,8 @@ static int exynos_adc_probe(struct platform_device
>> *pdev)
>>
>>  	mutex_init(&info->lock);
>>
>> -	ret = request_irq(info->irq, exynos_adc_isr,
>> -					0, dev_name(&pdev->dev), info);
>> +	ret = request_irq(info->irq, info->data->adc_isr ?
info->data->adc_isr
>:
>> +				exynos_adc_isr, 0, dev_name(&pdev->dev),
>info);
>
>I'd rather see the slightly larger change of providing adc_isr for existing
parts
>and the conditional part here going away.
>
>Jonathan
>
>
>>  	if (ret < 0) {
>>  		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
>>  							info->irq);


