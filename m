Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6734BDCB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381420AbiBUQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:56:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiBUQ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:56:32 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 7F25D22536
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:56:08 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645462568; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=DzZH06prTIghA5OnLx3lGCwq5J4ljZ83zScuiDwYEFA=; b=heqxE70vkLmcGXR19iDdjz5Cjx2KHZsz1xQVY20etOVnKj9bg3sQB94RFGSS78AF/HveP8EG
 ijHF+Dq1ANwJu0Fpr+iU7optawgxR+rAWf4tmpVFbnVOxWmczGFiHyqMmWLuPno5h6mQpAoW
 /O/qfTuOMclawUPfRyt5GV6vAP0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6213c4273047cf1c0ae46711 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Feb 2022 16:56:07
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F121C43618; Mon, 21 Feb 2022 16:56:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from [192.168.0.101] (unknown [49.204.183.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DC46C4338F;
        Mon, 21 Feb 2022 16:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6DC46C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <9f343332-9a0e-cbf9-9fb1-17127036b0b6@codeaurora.org>
Date:   Mon, 21 Feb 2022 22:25:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for
 GDSCs
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220209172513.17873-1-tdas@codeaurora.org>
 <YgRBnExwlzI+lPlR@builder.lan> <20220210072842.3E796C004E1@smtp.kernel.org>
From:   Taniya Das <tdas@codeaurora.org>
In-Reply-To: <20220210072842.3E796C004E1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Bjorn,

Thanks for your comments.

On 2/10/2022 12:58 PM, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2022-02-09 14:35:08)
>> On Wed 09 Feb 11:25 CST 2022, Taniya Das wrote:
>>
>>> Do not update the transition delay and use the default reset values.
>>>
>>> Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>> ---
>>>   drivers/clk/qcom/gdsc.c | 6 +++++-
>>>   drivers/clk/qcom/gdsc.h | 1 +
>>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>>> index 7e1dd8ccfa38..e7b213450640 100644
>>> --- a/drivers/clk/qcom/gdsc.c
>>> +++ b/drivers/clk/qcom/gdsc.c
>>> @@ -380,7 +380,11 @@ static int gdsc_init(struct gdsc *sc)
>>>         */
>>>        mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
>>>               EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
>>> -     val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
>>> +
>>> +     regmap_read(sc->regmap, sc->gdscr, &val);
>>> +
>>> +     if (!(sc->flags & DEFAULT_TRANSITION_DELAY))
>>
>> I dug a little bit more into this and noticed that on various platforms
>> CLK_DIS_WAIT_VAL for the GPU_CX GDSC is supposed to be 8 (whereas both
>> hw default and CLK_DIS_WAIT_VAL is 2).
>>

Yes, only for certain GPU_CC these would be updated and that too in case 
the design team suggests. Downstream we would set the value from probe 
itself, or we can pick these from device tree as required and suggested.

>> I'm not able to find anything helpful in the git log describing what the
>> value does, but it seems that a "just use hw default" flag won't cut it
>> for this scenario.
>>

This value is used for the number of clock cycles it would wait before 
the GDSCR ACK signals/halting the clock.

> 
> I'd prefer we invert the logic so that we don't need to litter this flag
> all over the place. I recall that the wait values were incorrect a long
> time ago on early gdsc using designs but hopefully they've been fixed
> now and we can simply use the default power on reset (POR) values.

I am okay to invert the logic, but I am not sure if they could cause any 
issues to the older targets. They were broken in HW design long back, 
but got fixed in most families of target and most GDSCs.

As mentioned if explicitly they need to be updated, it is best to do 
from the probe.
This was done in SC7180 GPUCC driver.
         /* Configure clk_dis_wait for gpu_cx_gdsc */
         regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
                                         8 << CLK_DIS_WAIT_SHIFT);


Please let me know if we are okay to add the invert logic.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
