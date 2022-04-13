Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBDA4FFDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiDMS04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiDMS0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:26:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048224949
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:24:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r2so3222175ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2a3wbWov4ja8bGu9EbYHU1Qhcuzm1jktvfc7w0skBC8=;
        b=dOpaT0YDlzuuDrfVnCxhWnNIeMmJC//DHP7/D39zf2S0iawOpBL6kOFXwHX9uoOt7D
         BvOYOrWH1NQTegsf23OOiQ9ioIFocQn8CwJvqojc9PpR1T08rZsxjLFjZSYuzkqwJr+n
         DszhhEgCWM8YMJzPK/b435aROWPDjksQ2o75mRc5sWpQ44pLz9qTQH2pcFv7tG1kvCOY
         ayQb2gJH3sxX2/H57xZG2Rh69W4/ZLbIc1tas/vrPMnom5RHPe4Xx3Un6zt/05Dq0xUu
         oQJAmuUkQYhJTMB2C6425NLRaRA3DwyJ/P5C2PPKR3a4PkuyNpw/0I/AB2V4Bscwhe2Z
         JOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2a3wbWov4ja8bGu9EbYHU1Qhcuzm1jktvfc7w0skBC8=;
        b=fnI7pqYh8RTwDbaOikpHHRhqvB8oJXH+Ic2JW6BpKI6u5HT5k/G1gdibWfixyZCOOL
         N9HS58P/mrIAMbH4mgOdvZYfUnVHumIXUrYwWiBdv9e1wdryu1dNOoMQlmZk8pMsos/d
         iUrOEr2E+rpg4m2JKKSRIFcZ8LDh1zQSEdYmvz86LuySfb3Ih3QdDct8psIrEugY4u27
         PZqRUPHCZyIiAzwHDQ5n+V6n3KE+aNB3BbzNgqwESkCCHW8g0JxuFtHYhVoxNVOTiIiE
         XknLrSbfPhFOojTHnIIGkRvMb7n+Lwsnq0exfF65MoEBXpujXB+s+WgY6/Zrr6YksdmS
         7LBg==
X-Gm-Message-State: AOAM530Ae0zem5QuuQJbbgX7m4nlRfrzzo3xFq0/XVjowylztJDqKd33
        aTWAIOqsHdAaE9K0FxS+LeMdog==
X-Google-Smtp-Source: ABdhPJz4vXs9AouohzXFyqpmRdiZdSgntOpsBq/dFOabcBnbPW0Ohk7LjZA5IcL9bfQWgRSnqxbRUA==
X-Received: by 2002:a05:651c:2121:b0:24b:5d31:fcd with SMTP id a33-20020a05651c212100b0024b5d310fcdmr12499350ljq.19.1649874267258;
        Wed, 13 Apr 2022 11:24:27 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k5-20020a2e9205000000b0024b5545acb2sm1622198ljg.80.2022.04.13.11.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 11:24:26 -0700 (PDT)
Message-ID: <cf95b1b4-194b-09c0-5bd4-80c962c18818@linaro.org>
Date:   Wed, 13 Apr 2022 21:24:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 10/18] clk: qcom: krait-cc: drop hardcoded safe_sel
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-11-ansuelsmth@gmail.com>
 <af104d82-34bc-2ab6-75bf-e54aafb3ae83@linaro.org>
 <625709ca.1c69fb81.b4268.12bc@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <625709ca.1c69fb81.b4268.12bc@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 20:35, Ansuel Smith wrote:
> On Wed, Apr 13, 2022 at 08:25:31PM +0300, Dmitry Baryshkov wrote:
>> On 22/03/2022 02:15, Ansuel Smith wrote:
>>> Drop hardcoded safe_sel definition and use helper to correctly calculate
>>> it. We assume qsb clk is always present as it should be declared in DTS
>>> per Documentation and in the absence of that, it's declared as a fixed
>>> clk.
>>
>> Why? Can safe_sel (sec_mux index) change?
>>
> 
> No it can't but I think it would be better to have stuff that is based
> on real defined data instead of wrong struct that works just because a
> hardcoded value is used.
> 
> Example for the reason of using this hardcoded value, nobody notice that
> the mux list for the secondary mux was wrong. Now it didn't cause any
> problem as we use the secondary mux just to source out of qsb and we
> used the hardcoded value so the error was bypassed but as soon as the
> value was actually parsed from the defined table, bam secondary mux was
> sourcing out of pll8.
> 
> I honestly think that dropping the hardcoded value would make more clear
> what the safe sel is and what is referring to.

Can you define indices in the parents and use defined indice instead?

I see your point, but in my opinion adding an API to determine a 
compile-time constant value is a bit of overkill.

> 
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>    drivers/clk/qcom/krait-cc.c | 40 +++++++++++++++++++++++++------------
>>>    1 file changed, 27 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
>>> index e9508e3104ea..5f98ee1c3681 100644
>>> --- a/drivers/clk/qcom/krait-cc.c
>>> +++ b/drivers/clk/qcom/krait-cc.c
>>> @@ -26,6 +26,17 @@ static unsigned int pri_mux_map[] = {
>>>    	0,
>>>    };
>>> +static u8 krait_get_mux_sel(struct krait_mux_clk *mux, struct clk *safe_clk)
>>> +{
>>> +	struct clk_hw *safe_hw = __clk_get_hw(safe_clk);
>>> +
>>> +	/*
>>> +	 * We can ignore errors from clk_hw_get_index_of_parent()
>>> +	 * as we create these parents in this driver.
>>> +	 */
>>> +	return clk_hw_get_index_of_parent(&mux->hw, safe_hw);
>>> +}
>>> +
>>>    /*
>>>     * Notifier function for switching the muxes to safe parent
>>>     * while the hfpll is getting reprogrammed.
>>> @@ -116,8 +127,8 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
>>>    }
>>>    static struct clk *
>>> -krait_add_sec_mux(struct device *dev, int id, const char *s,
>>> -		  unsigned int offset, bool unique_aux)
>>> +krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
>>> +		  const char *s, unsigned int offset, bool unique_aux)
>>>    {
>>>    	int ret;
>>>    	struct krait_mux_clk *mux;
>>> @@ -144,7 +155,6 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
>>>    	mux->shift = 2;
>>>    	mux->parent_map = sec_mux_map;
>>>    	mux->hw.init = &init;
>>> -	mux->safe_sel = 0;
>>>    	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
>>>    	if (!init.name)
>>> @@ -166,6 +176,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
>>>    	if (IS_ERR(clk))
>>>    		goto err_clk;
>>> +	mux->safe_sel = krait_get_mux_sel(mux, qsb);
>>>    	ret = krait_notifier_register(dev, clk, mux);
>>>    	if (ret)
>>>    		clk = ERR_PTR(ret);
>>> @@ -204,7 +215,6 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
>>>    	mux->lpl = id >= 0;
>>>    	mux->parent_map = pri_mux_map;
>>>    	mux->hw.init = &init;
>>> -	mux->safe_sel = 2;
>>>    	init.name = kasprintf(GFP_KERNEL, "krait%s_pri_mux", s);
>>>    	if (!init.name)
>>> @@ -226,6 +236,7 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
>>>    	if (IS_ERR(clk))
>>>    		goto err_clk;
>>> +	mux->safe_sel = krait_get_mux_sel(mux, sec_mux);
>>>    	ret = krait_notifier_register(dev, clk, mux);
>>>    	if (ret)
>>>    		clk = ERR_PTR(ret);
>>> @@ -238,7 +249,9 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
>>>    }
>>>    /* id < 0 for L2, otherwise id == physical CPU number */
>>> -static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
>>> +static struct clk *
>>> +krait_add_clks(struct device *dev, struct clk *qsb, int id,
>>> +	       bool unique_aux)
>>>    {
>>>    	unsigned int offset;
>>>    	void *p = NULL;
>>> @@ -261,7 +274,7 @@ static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
>>>    		goto err;
>>>    	}
>>> -	sec_mux = krait_add_sec_mux(dev, id, s, offset, unique_aux);
>>> +	sec_mux = krait_add_sec_mux(dev, qsb, id, s, offset, unique_aux);
>>>    	if (IS_ERR(sec_mux)) {
>>>    		clk = sec_mux;
>>>    		goto err;
>>> @@ -301,18 +314,19 @@ static int krait_cc_probe(struct platform_device *pdev)
>>>    	int cpu;
>>>    	struct clk *clk;
>>>    	struct clk **clks;
>>> -	struct clk *l2_pri_mux_clk;
>>> +	struct clk *l2_pri_mux_clk, *qsb;
>>>    	id = of_match_device(krait_cc_match_table, dev);
>>>    	if (!id)
>>>    		return -ENODEV;
>>>    	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
>>> -	if (IS_ERR(clk_get(dev, "qsb")))
>>> -		clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
>>> +	qsb = clk_get(dev, "qsb");
>>> +	if (IS_ERR(qsb))
>>> +		qsb = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
>>> -	if (IS_ERR(clk))
>>> -		return PTR_ERR(clk);
>>> +	if (IS_ERR(qsb))
>>> +		return PTR_ERR(qsb);
>>>    	if (!id->data) {
>>>    		clk = clk_register_fixed_factor(dev, "acpu_aux",
>>> @@ -327,13 +341,13 @@ static int krait_cc_probe(struct platform_device *pdev)
>>>    		return -ENOMEM;
>>>    	for_each_possible_cpu(cpu) {
>>> -		clk = krait_add_clks(dev, cpu, id->data);
>>> +		clk = krait_add_clks(dev, qsb, cpu, id->data);
>>>    		if (IS_ERR(clk))
>>>    			return PTR_ERR(clk);
>>>    		clks[cpu] = clk;
>>>    	}
>>> -	l2_pri_mux_clk = krait_add_clks(dev, -1, id->data);
>>> +	l2_pri_mux_clk = krait_add_clks(dev, qsb, -1, id->data);
>>>    	if (IS_ERR(l2_pri_mux_clk))
>>>    		return PTR_ERR(l2_pri_mux_clk);
>>>    	clks[4] = l2_pri_mux_clk;
>>
>>
>> -- 
>> With best wishes
>> Dmitry
> 


-- 
With best wishes
Dmitry
