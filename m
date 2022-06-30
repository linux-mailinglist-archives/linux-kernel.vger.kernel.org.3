Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF2561A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiF3Mjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiF3Mjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:39:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6273ED0C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:39:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c65so26383320edf.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=o2a6H8lLmS6esD7AdFI+joYZM4ZY+Jh9URm6Gpkidk8=;
        b=bwBGpzVnDihjlLeINbn9FxHt7qfh2fHgI8lxeh+AzZHUZxeHL8D6HFwHIVQbhKsKR3
         hrmFa7ky2P7E0eCvBrC3hdEb10bo9MSnVzHviYnFFP0T4h5Hz4z0BkwVOcEdhbWOHEzo
         nVsRa/z99wrSruRqN1EwOVT6o+e2F5R80Xl4KNYO77s2/YcG9eEtbOH38nVNruln0fv8
         uqvfzRmPxjrlg4V0vtCP3ZBLtv4NxnbaJZ2aioDfB9Sibs3BU+mRdUadaghLvhp+ixQP
         EXihdNBcMy1uknz3MAAqEfhX3WfrPgqHZfBoBuirghXfjj4XqWN7qcePKm3TzysvdDJx
         +Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=o2a6H8lLmS6esD7AdFI+joYZM4ZY+Jh9URm6Gpkidk8=;
        b=Ku+T/hEhx2maBia6DZVvAbc+yZit8V8+2IS41Xdcmav0LFLpPTuIBPGNayV71BlZDr
         Rrsv8VuS9hg8OJz6IkvGo4Bay0+9qEwHotwzRyLkTw/F11P0ERolE8jR1BevnBDVN1Og
         PdsZC3CnCYXU4DScaXzIET+zrfiMDTfeCL+RzKNgHUBV9zY2Ilc52aSMMg9pC+hyQ/xP
         iGEG/2eDzKMAD8rWLNRrDaygbU/3Nt9J/IOnyQj+6GaoC0sp24a3s7bdcZF1xVvzUrcA
         xhTwJZchPITcXasgKwZz2Hlzj2XVWiLtBFZvelS9ADGSuhIwHYEd3Gt0b53Vue0QbjTY
         Ba/w==
X-Gm-Message-State: AJIora/llTGRNUtSCxajKjsijJyEmIrQFbuWW0xruePJFJnti9+I6+5L
        xzMq5EnHmrbuezQsFwL8s0X72Q==
X-Google-Smtp-Source: AGRyM1s8YtffbgEFe0m+WsWnEqrdAUI9m/G/4SPZzRwKbo7IN0F9onr8t0Fq4KKR2x4kX2cxJm56zQ==
X-Received: by 2002:a05:6402:4244:b0:437:726c:e1a with SMTP id g4-20020a056402424400b00437726c0e1amr11658997edb.107.1656592785076;
        Thu, 30 Jun 2022 05:39:45 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n4-20020aa7c784000000b00437e08d319csm1927025eds.61.2022.06.30.05.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 05:39:44 -0700 (PDT)
Message-ID: <4cac6c79-ea9a-1f48-c6f1-2e04b54590a4@linaro.org>
Date:   Thu, 30 Jun 2022 14:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <de13cca4-3a33-6482-7b02-f89796f45325@linaro.org>
In-Reply-To: <de13cca4-3a33-6482-7b02-f89796f45325@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 14:32, Krzysztof Kozlowski wrote:
> On 10/06/2022 10:20, Viresh Kumar wrote:
>> This patch adds support to allow multiple clocks for a device.
>>
>> The design is pretty much similar to how this is done for regulators,
>> and platforms can supply their own version of the config_clks() callback
>> if they have multiple clocks for their device. The core manages the
>> calls via opp_table->config_clks() eventually.
>>
>> We have kept both "clk" and "clks" fields in the OPP table structure and
>> the reason is provided as a comment in _opp_set_clknames(). The same
>> isn't done for "rates" though and we use rates[0] at most of the places
>> now.
>>
>> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> (...)
> 
>> +	rates = kmalloc_array(count, sizeof(*rates), GFP_KERNEL);
>> +	if (!rates)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u64_array(np, "opp-hz", rates, count);
>> +	if (ret) {
>> +		pr_err("%s: Error parsing opp-hz: %d\n", __func__, ret);
>> +	} else {
>> +		/*
>> +		 * Rate is defined as an unsigned long in clk API, and so
>> +		 * casting explicitly to its type. Must be fixed once rate is 64
>> +		 * bit guaranteed in clk API.
>> +		 */
>> +		for (i = 0; i < count; i++) {
>> +			new_opp->rates[i] = (unsigned long)rates[i];
>> +
>> +			/* This will happen for frequencies > 4.29 GHz */
>> +			WARN_ON(new_opp->rates[i] != rates[i]);
>> +		}
>> +	}
>> +
>> +	kfree(rates);
>> +
>> +	return ret;
>> +}
>> +
>>  static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
>>  		    struct device_node *np, bool peak)
>>  {
>> @@ -812,19 +859,13 @@ static int _read_opp_key(struct dev_pm_opp *new_opp,
>>  			 struct opp_table *opp_table, struct device_node *np)
>>  {
>>  	bool found = false;
>> -	u64 rate;
>>  	int ret;
>>  
>> -	ret = of_property_read_u64(np, "opp-hz", &rate);
>> -	if (!ret) {
>> -		/*
>> -		 * Rate is defined as an unsigned long in clk API, and so
>> -		 * casting explicitly to its type. Must be fixed once rate is 64
>> -		 * bit guaranteed in clk API.
>> -		 */
>> -		new_opp->rate = (unsigned long)rate;
>> +	ret = _read_rate(new_opp, opp_table, np);
>> +	if (ret)
>> +		return ret;
>> +	else if (opp_table->clk_count == 1)
> 
> Shouldn't this be >=1? I got several clocks and this one fails.

Actually this might be correct, but you need to update the bindings. Now
you require opp-level for case with multiple clocks.

Best regards,
Krzysztof
