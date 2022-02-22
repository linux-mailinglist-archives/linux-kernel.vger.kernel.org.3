Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F204BF730
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiBVLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBVLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:24:03 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 25508130185
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:23:38 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645529018; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=ykOz9QTcSokzbehPDZ8vrVEtjNsi5wpt4JO8Bvanv2M=; b=ZkdRZdQsB/dIHM5/n8+TnP/4qhjMr9VTe/ERht3V+izx1/UUPmBJJXHnh7hlaTaVNEeHEoHD
 NUWYrSg4EnpjlDJR+3ymZOn6WRowSazw4qBFJrDY+u5MOS6UUH+YjzGI/glrekEExKUf+4f+
 EUWrbKUh6fStvL9RvaV7xjPPlac=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6214c7b8afeb9481f5366978 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Feb 2022 11:23:36
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8958BC4361A; Tue, 22 Feb 2022 11:23:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from [192.168.0.102] (unknown [49.204.183.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFFD8C4338F;
        Tue, 22 Feb 2022 11:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CFFD8C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <99454f74-9166-b20a-cb3a-44bad30eed1b@codeaurora.org>
Date:   Tue, 22 Feb 2022 16:53:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for
 GDSCs
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220209172513.17873-1-tdas@codeaurora.org>
 <YgRBnExwlzI+lPlR@builder.lan> <20220210072842.3E796C004E1@smtp.kernel.org>
 <9f343332-9a0e-cbf9-9fb1-17127036b0b6@codeaurora.org>
 <YhP5MD+d8btWBUl8@ripper>
From:   Taniya Das <tdas@codeaurora.org>
In-Reply-To: <YhP5MD+d8btWBUl8@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

Thanks for your comments.

On 2/22/2022 2:12 AM, Bjorn Andersson wrote:
> On Mon 21 Feb 08:55 PST 2022, Taniya Das wrote:
> 
>> Hi Stephen, Bjorn,
>>
>> Thanks for your comments.
>>
>> On 2/10/2022 12:58 PM, Stephen Boyd wrote:
>>> Quoting Bjorn Andersson (2022-02-09 14:35:08)
>>>> On Wed 09 Feb 11:25 CST 2022, Taniya Das wrote:
>>>>
>>>>> Do not update the transition delay and use the default reset values.
>>>>>
>>>>> Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
>>>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>>>> ---
>>>>>    drivers/clk/qcom/gdsc.c | 6 +++++-
>>>>>    drivers/clk/qcom/gdsc.h | 1 +
>>>>>    2 files changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>>>> index 7e1dd8ccfa38..e7b213450640 100644
>>>>> --- a/drivers/clk/qcom/gdsc.c
>>>>> +++ b/drivers/clk/qcom/gdsc.c
>>>>> @@ -380,7 +380,11 @@ static int gdsc_init(struct gdsc *sc)
>>>>>          */
>>>>>         mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
>>>>>                EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
>>>>> -     val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
>>>>> +
>>>>> +     regmap_read(sc->regmap, sc->gdscr, &val);
>>>>> +
>>>>> +     if (!(sc->flags & DEFAULT_TRANSITION_DELAY))
>>>>
>>>> I dug a little bit more into this and noticed that on various platforms
>>>> CLK_DIS_WAIT_VAL for the GPU_CX GDSC is supposed to be 8 (whereas both
>>>> hw default and CLK_DIS_WAIT_VAL is 2).
>>>>
>>
>> Yes, only for certain GPU_CC these would be updated and that too in case the
>> design team suggests. Downstream we would set the value from probe itself,
>> or we can pick these from device tree as required and suggested.
>>
> 
> I don't expect that value to be "configurable", so pushing it to DT
> doesn't seem like the proper solution.
> 
>>>> I'm not able to find anything helpful in the git log describing what the
>>>> value does, but it seems that a "just use hw default" flag won't cut it
>>>> for this scenario.
>>>>
>>
>> This value is used for the number of clock cycles it would wait before the
>> GDSCR ACK signals/halting the clock.
>>
> 
> That makes sense.
> 
>>>
>>> I'd prefer we invert the logic so that we don't need to litter this flag
>>> all over the place. I recall that the wait values were incorrect a long
>>> time ago on early gdsc using designs but hopefully they've been fixed
>>> now and we can simply use the default power on reset (POR) values.
>>
>> I am okay to invert the logic, but I am not sure if they could cause any
>> issues to the older targets. They were broken in HW design long back, but
>> got fixed in most families of target and most GDSCs.
>>
> 
> I don't fancy us having a flag with the purpose of "don't set the
> timings to 2, 8 and 2" and then rely on open coded writes in probe to
> set it to something else where needed.
> 
> So I definitely would prefer to flip this around, to make the cases
> where we want to write different values explicit.
> 
> But as you say, unless we make sure that all existing platforms do write
> 2, 8 and 2 we risk introducing regressions from the current behavior.
> 
>> As mentioned if explicitly they need to be updated, it is best to do from
>> the probe.
>> This was done in SC7180 GPUCC driver.
>>          /* Configure clk_dis_wait for gpu_cx_gdsc */
>>          regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
>>                                          8 << CLK_DIS_WAIT_SHIFT);
> 
> But we call regmap_update_bits() from probe, which sets the CLK_DIS_WAIT
> to 8, then we call qcom_cc_really_probe() which will end up in
> gdsc_init() which replaces that with a 2.
> 
> Perhaps I'm missing something?
> 

It was my miss when I did a cleanup to move the DIS_WAIT_VAL before 
registering the clocks.

>>
>>
>> Please let me know if we are okay to add the invert logic.
>>
> 
> I'm still favoring a scheme where we add 3 integers to struct gdsc and
> in gdsc_init() we check if they are non-zero we write the value to the
> register.
> 
Sure, will update the gdsc_init() to default "2, 8, 2" in case of 
non-zero value.

> Although being a big patch, we could maintain the existing behaviour by
> giving all existing struct gdsc definitions the values 2, 8 and 2 to
> avoid regressions and we (everyone) can then go through the platforms
> one by one and remove the unnecessary assignments - but more
> importantly, double check with downstream if they need a different
> value.
> 

Sure, that would help.

> This will also have the side effect going forward that it will be more
> explicit and people writing gdsc definitions should double check these
> values.
> 
> Regards,
> Bjorn

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
