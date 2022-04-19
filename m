Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D33507672
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353030AbiDSR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355747AbiDSR0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:26:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC473CFDC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:23:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r64so11123925wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=kXvSKXWClajeK1qES+zdMMc7Jyz9N8shBliP+K3BmWg=;
        b=k+UAvNDjaCv9Q9oQs2JwtpFZjtNcIm36E6OR2YYD/cF3bPg7LUbh2hj/QgQCCPhPH3
         grpTBuuyxMKhAk4iR0hRyhr+bRHkWlC2w7Y9InHd4+O6LSyOfhtdYOW6JMfIS3wL7D8k
         4GP70l5KSRZ9mOlyBA4IMZGehQ1EQAhZWe3VNW7Zr8YercxW9ygtUKmgdMv0TUZPK00c
         WhePf7FW25Dm1VVAuW2L1rl7t1RHwCpp941JiaWdX9ocVp8e35V55wQdU7MhTIjYUPs4
         2t7bqdiaWLiQLxOx7l/nPk+rgvESIIT5/v19HU4BuAWBvBXQKsMvAYoUE+6A5XHQw8I9
         5QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=kXvSKXWClajeK1qES+zdMMc7Jyz9N8shBliP+K3BmWg=;
        b=j56TcEu+D40PJawkT88OY0QUMG+Lu/tE+ineo+aqeV1cXX8dVqf132NvGzXUErRVAD
         nqEof5O3sSup6PeDLk8F1BfPp0trqmCLrV9Bl4nS0W/aLBfsht71o/zA3epPo3+x+C12
         9fAT8DNS/5w3XJyUlhA1bBeF4kM4NG6J0+fC9+Q7yFGcFTf6DRnQfV+8okK4p8adSSQM
         LfherDmbgvKzMArCcI+/A3tuB7b1eG05sY1t3qNcEiG6jpM9ta7F3lMZrCtJUXV7a3fU
         Z/jnLI0gvd+OeRX+cnytwTk/rkshQ/sJ+PPYmCUBxkfk4mZCAZ5hZP8jFck+3DHXC4HE
         tiMQ==
X-Gm-Message-State: AOAM533G/Ysogfp3XPPoGYwYo96+99FIrWjaJZJnvpt+6SYq+7lWLwma
        to5xmp3sKqoviRMYczuUxqQZ8A==
X-Google-Smtp-Source: ABdhPJzh5du4e3tPb0Cc7Asfdx839bAY3gH8FQ39qaw4IgF/TIdnFr7APykqhGCLEOiOkrFJWZQYkw==
X-Received: by 2002:a1c:4c05:0:b0:38e:b736:350 with SMTP id z5-20020a1c4c05000000b0038eb7360350mr21553329wmf.65.1650389004743;
        Tue, 19 Apr 2022 10:23:24 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm13150740wrg.62.2022.04.19.10.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:23:23 -0700 (PDT)
Message-ID: <0af9a609-ff21-2aca-26dd-8c92e197a2b7@linaro.org>
Date:   Tue, 19 Apr 2022 19:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-5-j-keerthy@ti.com>
Content-Language: en-US
In-Reply-To: <20220412101409.7980-5-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kheerty,

On 12/04/2022 12:14, Keerthy wrote:


[ ... ]

> +/**
> + * struct err_values - structure containing error/reference values
> + * @refs: reference error values for -40C, 30C, 125C & 150C
> + * @errs: Actual error values for -40C, 30C, 125C & 150C read from the efuse
> + */
> +struct err_values {
> +	int refs[4];
> +	int errs[4];
> +};
> +
> +static void create_table_segments(struct err_values *err_vals, int seg,
> +				  int *ref_table)
> +{
> +	int m = 0, c, num, den, i, err, idx1, idx2, err1, err2, ref1, ref2;
> +
> +	if (seg == 0)
> +		idx1 = 0;
> +	else
> +		idx1 = err_vals->refs[seg];
> +
> +	idx2 = err_vals->refs[seg + 1];
> +	err1 = err_vals->errs[seg];
> +	err2 = err_vals->errs[seg + 1];
> +	ref1 = err_vals->refs[seg];
> +	ref2 = err_vals->refs[seg + 1];
> +
> +	/*
> +	 * Calculate the slope with adc values read from the register
> +	 * as the y-axis param and err in adc value as x-axis param
> +	 */
> +	num = ref2 - ref1;
> +	den = err2 - err1;
> +	if (den)
> +		m = num / den;
> +	c = ref2 - m * err2;
> +
> +	/*
> +	 * Take care of divide by zero error if error values are same
> +	 * Or when the slope is 0
> +	 */
> +	if (den != 0 && m != 0) {
> +		for (i = idx1; i <= idx2; i++) {
> +			err = (i - c) / m;
> +			if (((i + err1) < 0) || ((i + err1) > 1023))
> +				continue;

Should the test being against 'err' not 'err1' ?

> +			derived_table[i] = ref_table[i + err];
> +		}
> +	} else { /* Constant error take care of divide by zero */
> +		for (i = idx1; i <= idx2; i++) {
> +			if (((i + err1) < 0) || ((i + err1) > 1023))
> +				continue;
> +			derived_table[i] = ref_table[i + err1];
> +		}
> +	}
> +}
> +
> +static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
> +{
> +	int inc, i, seg;
> +
> +	/*
> +	 * Fill up the lookup table under 3 segments
> +	 * region -40C to +30C
> +	 * region +30C to +125C
> +	 * region +125C to +150C
> +	 */
> +	for (seg = 0; seg < 3; seg++)
> +		create_table_segments(err_vals, seg, ref_table);
> +
> +	/* Get to the first valid temperature */
> +	i = 0;
> +	while (!derived_table[i])
> +		i++;
> +
> +	/*
> +	 * Get to the last zero index and back fill the temperature for
> +	 * sake of continuity
> +	 */
> +	if (i) {
> +		/* 300 milli celsius steps */
> +		while (i--)
> +			derived_table[i] = derived_table[i + 1] - 300;
> +		/* case 0 */
> +		derived_table[i] = derived_table[i + 1] - 300;
> +	}

memset ?

> +
> +	/*
> +	 * Fill the last trailing 0s which are unfilled with increments of
> +	 * 100 milli celsius till 1023 code
> +	 */
> +	i = 1023;
> +	while (!derived_table[i])
> +		i--;

All those loop can be replaced by addresses variant IMO. Up to you if 
you want to use mem* variants.

eg. void *flz = memrchr(derived_table, 0, size); /* find last zero */

> +
> +	i++;
> +	inc = 1;
> +	while (i < 1024) {
> +		derived_table[i] = derived_table[i - 1] + inc * 100;
> +		i++;
> +	}
> +
> +	return 0;
> +}

Please replace all the 1024-ish literals everywhere by a macro

> +struct k3_thermal_data;
> +
> +struct k3_j72xx_bandgap {
> +	struct device *dev;
> +	void __iomem *base;
> +	void __iomem *cfg2_base;
> +	void __iomem *fuse_base;
> +	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
> +};
> +
> +/* common data structures */
> +struct k3_thermal_data {
> +	struct k3_j72xx_bandgap *bgp;
> +	u32 ctrl_offset;
> +	u32 stat_offset;
> +};
> +
> +static int two_cmp(int tmp, int mask)
> +{
> +	tmp = ~(tmp);
> +	tmp &= mask;
> +	tmp += 1;
> +
> +	/* Return negative value */
> +	return (0 - tmp);
> +}
> +
> +static unsigned int vtm_get_best_value(unsigned int s0, unsigned int s1,
> +				       unsigned int s2)
> +{
> +	int d01 = abs(s0 - s1);
> +	int d02 = abs(s0 - s2);
> +	int d12 = abs(s1 - s2);
> +
> +	if (d01 <= d02 && d01 <= d12)
> +		return (s0 + s1) / 2;
> +
> +	if (d02 <= d01 && d02 <= d12)
> +		return (s0 + s2) / 2;
> +
> +	return (s1 + s2) / 2;
> +}
> +
> +static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
> +				   int *temp)
> +{
> +	struct k3_j72xx_bandgap *bgp;
> +	unsigned int dtemp, s0, s1, s2;
> +
> +	bgp = devdata->bgp;
> +	/*
> +	 * Errata is applicable for am654 pg 1.0 silicon/J7ES. There
> +	 * is a variation of the order for certain degree centigrade on AM654.
> +	 * Work around that by getting the average of two closest
> +	 * readings out of three readings everytime we want to
> +	 * report temperatures.
> +	 *
> +	 * Errata workaround.
> +	 */
> +	s0 = readl(bgp->base + devdata->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	s1 = readl(bgp->base + devdata->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	s2 = readl(bgp->base + devdata->stat_offset) &
> +		K3_VTM_TS_STAT_DTEMP_MASK;
> +	dtemp = vtm_get_best_value(s0, s1, s2);
> +
> +	if (dtemp < 0 || dtemp > 1023)
> +		return -EINVAL;
> +
> +	*temp = derived_table[dtemp];
> +
> +	return 0;
> +}
> +
> +/* Get temperature callback function for thermal zone */
> +static int k3_thermal_get_temp(void *devdata, int *temp)
> +{
> +	struct k3_thermal_data *data = devdata;
> +	int ret = 0;
> +
> +	ret = k3_bgp_read_temp(data, temp);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
> +	.get_temp = k3_thermal_get_temp,
> +};
> +
> +static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
> +{
> +	int low = 0, high = 1023, mid;
> +
> +	if (temp > 160000 || temp < -50000)
> +		return -EINVAL;
> +
> +	/* Binary search to find the adc code */
> +	while (low < (high - 1)) {
> +		mid = (low + high) / 2;
> +		if (temp <= derived_table[mid])
> +			high = mid;
> +		else
> +			low = mid;
> +	}
> +
> +	return mid;
> +}
> +
> +static void get_efuse_values(int id, struct k3_thermal_data *data, int *err,
> +			     struct k3_j72xx_bandgap *bgp)
> +{
> +	int i, tmp, pow;
> +	int ct_offsets[K3_VTM_CORRECTION_TEMP_CNT];
> +	int ct_bm[K3_VTM_CORRECTION_TEMP_CNT];
> +
> +	/* Populate efuse reg offsets & Bit masks for -40C, 30C, 125C */
> +	switch (id) {
> +	case 0:
> +		ct_offsets[0] = 0x0;
> +		ct_offsets[1] = 0x8;
> +		ct_offsets[2] = 0x4;
> +		ct_bm[0] = 0x3f;
> +		ct_bm[1] = 0x1fe000;
> +		ct_bm[2] = 0x1ff;
> +		break;
> +
> +	case 1:
> +		ct_offsets[0] = 0x0;
> +		ct_offsets[1] = 0x8;
> +		ct_offsets[2] = 0x4;
> +		ct_bm[0] = 0xfc0;
> +		ct_bm[1] = 0x1fe00000;
> +		ct_bm[2] = 0x3fe00;
> +		break;
> +
> +	case 2:
> +		ct_offsets[0] = 0x0;
> +		ct_offsets[1] = -1;
> +		ct_offsets[2] = 0x4;
> +		ct_bm[0] = 0x3f000;
> +		ct_bm[1] = 0x7f800000;
> +		ct_bm[2] = 0x7fc0000;
> +		break;
> +
> +	case 3:
> +		ct_offsets[0] = 0x0;
> +		ct_offsets[1] = 0xC;
> +		ct_offsets[2] = -1; /* Spread across 2 registers */
> +		ct_bm[0] = 0xfc0000;
> +		ct_bm[1] = 0x1fe0;
> +		ct_bm[2] = 0x1f800000;
> +		break;
> +
> +	case 4:
> +		ct_offsets[0] = 0x0;
> +		ct_offsets[1] = 0xc;
> +		ct_offsets[2] = 0x8;
> +		ct_bm[0] = 0x3f000000;
> +		ct_bm[1] = 0x1fe000;
> +		ct_bm[2] = 0x1ff0;
> +		break;
> +	}

The way this is initialized looks strange to me

Why not:

int ct_offsets[][] = {
	{ 0x0, 0x8, 0x4 },
	{ 0x0, 0x8, 0x4 },
	{ 0x0, -1,  0x4 },
	{ 0x0, 0xC, -1 }
	{ 0x0, 0xc, 0x8 }
  };

int ct_bm[][] = {
	{ 0x3f, 0x1fe000, 0x1ff },
	{ 0xfc0, 0x1fe000, 0x3fe00 },
	{ 0x3f000, 0x7f800000, 0x7fc0000 },
	{ 0xfc0000, 0x1fe0, 0x1f800000 },
	{ 0x3f000000, 0x1fe000, 0x1ff0 }
};

And then : ct_offsets[id][i] below ?

> +	for (i = 0; i < 3; i++) {

ARRAY_SIZE on ct_offsets ?

> +		/* Extract the offset value using bit-mask */
> +		if (ct_offsets[i] == -1 && i == 1) {
> +			/* 25C offset Case of Sensor 2 split between 2 regs */
> +			tmp = (readl(bgp->fuse_base + 0x8) & 0xE0000000) >> (29);
> +			tmp |= ((readl(bgp->fuse_base + 0xC) & 0x1F) << 3);
> +			pow = tmp & 0x80;
> +		} else if (ct_offsets[i] == -1 && i == 2) {
> +			/* 125C Case of Sensor 3 split between 2 regs */
> +			tmp = (readl(bgp->fuse_base + 0x4) & 0xF8000000) >> (27);
> +			tmp |= ((readl(bgp->fuse_base + 0x8) & 0xF) << 5);
> +			pow = tmp & 0x100;
> +		} else {
> +			tmp = readl(bgp->fuse_base + ct_offsets[i]);
> +			tmp &= ct_bm[i];
> +			tmp = tmp >> __ffs(ct_bm[i]);
> +
> +			/* Obtain the sign bit pow*/
> +			pow = ct_bm[i] >> __ffs(ct_bm[i]);
> +			pow += 1;
> +			pow /= 2;
> +		}
> +
> +		/* Check for negative value */
> +		if (tmp & pow) {
> +			/* 2's complement value */
> +			tmp = two_cmp(tmp, ct_bm[i] >> __ffs(ct_bm[i]));
> +		}
> +		err[i] = tmp;
> +	}
> +
> +	/* Err value for 150C is set to 0 */
> +	err[i] = 0;
> +}
> +
> +static void print_look_up_table(struct device *dev, int *ref_table)
> +{
> +	int i;
> +
> +	dev_dbg(dev, "The contents of derived array\n");
> +	dev_dbg(dev, "Code   Temperaturei\n");

Typo: "Temperaturei"

> +	for (i = 0; i <= 1023; i++)
> +		dev_dbg(dev, "%d       %d %d\n", i, derived_table[i], ref_table[i]);
> +}
> +
> +static const struct of_device_id of_k3_j72xx_bandgap_match[];

Pointless forward declaration

> +
> +struct k3_j72xx_bandgap_data {
> +	unsigned int has_errata_i2128;
> +};
> +
> +static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
> +{
> +	int ret = 0, cnt, val, id, table_size = 1024;

table_size to be replaced by the macro mentioned above

> +	int high_max, low_temp;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct k3_j72xx_bandgap *bgp;
> +	struct k3_thermal_data *data;
> +	int workaround_needed = 0;
> +	const struct k3_j72xx_bandgap_data *driver_data;
> +	struct thermal_zone_device *ti_thermal;
> +	int *ref_table;
> +	struct err_values err_vals;

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
