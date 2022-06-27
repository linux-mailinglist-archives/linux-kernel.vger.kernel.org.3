Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A828155D6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiF0QLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiF0QLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:11:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2114030;
        Mon, 27 Jun 2022 09:11:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o43so15424895qvo.4;
        Mon, 27 Jun 2022 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1NJPIKLHbTXa2vM0EDGBoEmGuf1QI+UV3bnJ53gNgN0=;
        b=FwDVRUobbeBHofANfiLj/fi4gmO87yzwYXdiiNOWE21/FOGckt+Ry8v68EaZ5bwAvS
         1A9DzKKTqT3Qp7IOz2ZRvaTrg8m/Z73qh+2A/Z9f2FnwOq99fRE5hhqYxvkRsSDI2TF3
         Qpcwgwsq8s9lRU8Jbx6IUHvrTb2CfMGZxI5kA9s0fZK6A2rGhiLLm0A1LC44huF5Xxuq
         ops80Y11sU1l6sN11FnvSk60ZtyB58ZcBSqU1016mvyROa2WgnzU73r+ujMt06605chL
         Bv/P+GrwpKklCv5ithhqopuqGcp/J2MuEYfkUMMTgMkQOYKli8W7zK+mbll1KYK6cvu+
         10IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1NJPIKLHbTXa2vM0EDGBoEmGuf1QI+UV3bnJ53gNgN0=;
        b=X/fHVHXC2eZQppsMVxpHYqknf78YAZ8uTFUrfDc58gFVkn4HMqEW5boc75xAKrEccT
         SWINeuL3d45rQIv3g3XYA72TjzpoXqdmCUoFng1C4c+e+Q/dRkmSkyov0rgaxaSwSZUc
         ZDKAmOysqLuSYXA6Su2V2iopVunnk8miOQSD0J8VH4CWnV3ctoRkyGiSQ2XWQOhYQcb9
         DAZXp0YsopuPQC1Lscx7GtPOBhq7gEh4BnC30wL5QeTj2lRujvMjM533L6MUj4RZpOrv
         Gh0j2C+mNDeiZAgrYNkcqvR8adp3UAWMsOkyUJ/9L0upEF1dF9Zpo5SerfIFgwqctdX2
         30OA==
X-Gm-Message-State: AJIora8vNkUh8wiL4zlMMnbfZ5LDvFBLL1u1t1t+lHeAVrHJ1C/pd06r
        ikN5YZcH2Y+KfLWulwbHGFk=
X-Google-Smtp-Source: AGRyM1v61ZWMRpoNeMWg3mhp2g7soeAFuYG/4efOwpPRH+BiBWWYjGVfw6kRAp9hlKTpat2BSi/YGg==
X-Received: by 2002:ac8:5b03:0:b0:317:c6f3:c61d with SMTP id m3-20020ac85b03000000b00317c6f3c61dmr9629431qtw.196.1656346294461;
        Mon, 27 Jun 2022 09:11:34 -0700 (PDT)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006af271aad37sm3337702qkp.72.2022.06.27.09.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 09:11:33 -0700 (PDT)
Message-ID: <c8f13238-c927-4aab-e54d-3a1a5c031877@gmail.com>
Date:   Mon, 27 Jun 2022 12:11:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 08/13] clk: imx: Update pllv3 to support i.MXRT1170
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, olof@lixom.net,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
 <20220626064523.3683775-9-Mr.Bossman075@gmail.com>
 <YrmxdaSqHnEg28uG@linaro.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <YrmxdaSqHnEg28uG@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/22 09:32, Abel Vesa wrote:
> On 22-06-26 02:45:18, Jesse Taube wrote:
>> The i.MXRT1170 has a pll that has the multiplier bits inverted and
>> cannot be changed add IMX_PLLV3_GENERICV2.
>>
>> The i.MXRT1170 also has the lock bit moved as well as the
>> power bit inverted the power bit also is in different locations on each
>> pll control register.
>>
>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>> ---
>> V1 -> V2:
>>   - Nothing done
>> V2 -> V3:
>>   - Nothing done
>> V3 -> V4:
>>   - Nothing done
>> ---
>>   drivers/clk/imx/clk-pllv3.c | 57 +++++++++++++++++++++++++++++++++++--
>>   drivers/clk/imx/clk.h       |  4 +++
>>   2 files changed, 59 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
>> index eea32f87c60a..740412ea2f7e 100644
>> --- a/drivers/clk/imx/clk-pllv3.c
>> +++ b/drivers/clk/imx/clk-pllv3.c
>> @@ -23,6 +23,7 @@
>>
>>   #define BM_PLL_POWER		(0x1 << 12)
>>   #define BM_PLL_LOCK		(0x1 << 31)
>> +#define BM_PLL_LOCK_V2		(0x1 << 29)
>>   #define IMX7_ENET_PLL_POWER	(0x1 << 5)
>>   #define IMX7_DDR_PLL_POWER	(0x1 << 20)
>>
>> @@ -34,6 +35,7 @@
>>    * @base:	 base address of PLL registers
>>    * @power_bit:	 pll power bit mask
>>    * @powerup_set: set power_bit to power up the PLL
>> + * @lock_bit:	 pll lock bit mask
>>    * @div_mask:	 mask of divider bits
>>    * @div_shift:	 shift of divider bits
>>    * @ref_clock:	reference clock rate
>> @@ -48,6 +50,7 @@ struct clk_pllv3 {
>>   	void __iomem	*base;
>>   	u32		power_bit;
>>   	bool		powerup_set;
>> +	u32		lock_bit;
>>   	u32		div_mask;
>>   	u32		div_shift;
>>   	unsigned long	ref_clock;
>> @@ -65,7 +68,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>>   	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
>>   		return 0;
>>
>> -	return readl_relaxed_poll_timeout(pll->base, val, val & BM_PLL_LOCK,
>> +	return readl_relaxed_poll_timeout(pll->base, val, val & pll->lock_bit,
>>   					  500, PLL_LOCK_TIMEOUT);
>>   }
>>
>> @@ -101,7 +104,7 @@ static int clk_pllv3_is_prepared(struct clk_hw *hw)
>>   {
>>   	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>>
>> -	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
>> +	if (readl_relaxed(pll->base) & pll->lock_bit)
>>   		return 1;
>>
>>   	return 0;
>> @@ -155,6 +158,39 @@ static const struct clk_ops clk_pllv3_ops = {
>>   	.set_rate	= clk_pllv3_set_rate,
>>   };
>>
>> +static int clk_pllv3_genericv2_set_rate(struct clk_hw *hw, unsigned long rate,
>> +		unsigned long parent_rate)
>> +{
>> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>> +	u32 val, div;
>> +
>> +	div = (readl_relaxed(pll->base) >> pll->div_shift) & pll->div_mask;
>> +	val = (div == 0) ? parent_rate * 22 : parent_rate * 20;
>> +
>> +	if (rate == val)
>> +		return 0;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static unsigned long clk_pllv3_genericv2_recalc_rate(struct clk_hw *hw,
>> +					   unsigned long parent_rate)
>> +{
>> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>> +	u32 div = (readl_relaxed(pll->base) >> pll->div_shift)  & pll->div_mask;
>> +
>> +	return (div == 0) ? parent_rate * 22 : parent_rate * 20;
>> +}
>> +
>> +static const struct clk_ops clk_pllv3_genericv2_ops = {
>> +	.prepare	= clk_pllv3_prepare,
>> +	.unprepare	= clk_pllv3_unprepare,
>> +	.is_prepared	= clk_pllv3_is_prepared,
>> +	.recalc_rate	= clk_pllv3_genericv2_recalc_rate,
>> +	.round_rate	= clk_pllv3_round_rate,
>> +	.set_rate	= clk_pllv3_genericv2_set_rate,
>> +};
>> +
>>   static unsigned long clk_pllv3_sys_recalc_rate(struct clk_hw *hw,
>>   					       unsigned long parent_rate)
>>   {
>> @@ -407,6 +443,13 @@ static const struct clk_ops clk_pllv3_enet_ops = {
>>   	.recalc_rate	= clk_pllv3_enet_recalc_rate,
>>   };
>>
>> +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift)
>> +{
>> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>> +
>> +	pll->power_bit = shift;
>> +}
>> +
> 
> I can see why you need this, but I think the approach is not quite
> right.

I wasn't sure if modifying the function like that was appropriate for 
this, but sense it is I will do like you said.

> I suggest we rename the imx_clk_hw_pllv3 to __imx_clk_hw_pllv3 and add
> the power_bit parameter to it (and set it accordingly inside).
> 
> Then we should do the following in imx/clk.h:
> 
> #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,	\
> 				bypass1, bypass2, base, flags)		\
> 	__imx_clk_hw_pllv3(name, parent_names, num_parents, parent,	\
> 				bypass1, bypass2, base, flags, BM_PLL_POWER)

One problem BM_PLL_POWER will have to be in imx/clk.h, but then it will 
be the only macro like it in the file, is line 9 ok for it.
I could also make a function instead of a macro.

thanks,
Jesse Taube
> And then, the i.MXRT1170 can use the __imx_clk_hw_pllv3 and pass the
> right power_bit shift.
> 
>>   struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>>   			  const char *parent_name, void __iomem *base,
>>   			  u32 div_mask)
>> @@ -422,10 +465,20 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>>   		return ERR_PTR(-ENOMEM);
>>
>>   	pll->power_bit = BM_PLL_POWER;
>> +	pll->lock_bit = BM_PLL_LOCK;
>>   	pll->num_offset = PLL_NUM_OFFSET;
>>   	pll->denom_offset = PLL_DENOM_OFFSET;
>>
>>   	switch (type) {
>> +	case IMX_PLLV3_GENERICV2:
>> +		pll->lock_bit = BM_PLL_LOCK_V2;
>> +		pll->powerup_set = true;
>> +		ops = &clk_pllv3_genericv2_ops;
>> +		break;
>> +	case IMX_PLLV3_SYSV2:
>> +		pll->lock_bit = BM_PLL_LOCK_V2;
>> +		pll->powerup_set = true;
>> +		fallthrough;
>>   	case IMX_PLLV3_SYS:
>>   		ops = &clk_pllv3_sys_ops;
>>   		break;
>> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
>> index 5061a06468df..31e017248602 100644
>> --- a/drivers/clk/imx/clk.h
>> +++ b/drivers/clk/imx/clk.h
>> @@ -242,6 +242,8 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
>>
>>   enum imx_pllv3_type {
>>   	IMX_PLLV3_GENERIC,
>> +	IMX_PLLV3_GENERICV2,
>> +	IMX_PLLV3_SYSV2,
>>   	IMX_PLLV3_SYS,
>>   	IMX_PLLV3_USB,
>>   	IMX_PLLV3_USB_VF610,
>> @@ -253,6 +255,8 @@ enum imx_pllv3_type {
>>   	IMX_PLLV3_AV_IMX7,
>>   };
>>
>> +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift);
>> +
>>   struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>>   		const char *parent_name, void __iomem *base, u32 div_mask);
>>
>> --
>> 2.36.1
>>
