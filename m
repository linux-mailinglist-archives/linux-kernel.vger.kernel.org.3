Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D777051541C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380103AbiD2S4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345601AbiD2S4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:56:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5FCC50F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:52:44 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id kj18so5976237qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kMONR8uP8o1V9wDmONNEpi44JYnbSaTBErCeX+Ef8mM=;
        b=MUwX5h8GHYTDN93S5LQ8HgipQCFvTgIJKkyQsoDuwUIJtqQlnvDOsWHlV05eaC8Ri/
         aj2P8a4Y7arfynDH3NX+WbPF34XjQ5ExG7rNPjVnk7NT0K1wQZG/W0mGYL1zbl88pmsU
         ojCPyRS//omI5vTAAO4qjW/XkOqvRD3PZzryTMb9Z7TL7+TxD2tFXUuhy+MlH5JeLgPp
         NILsPP4yFMrqjNKkp6zOegLylz9rgNharn+C6dUtPOMv/q2zNzyoODPWGprdgL1EbxMi
         zfz6WkTYuvk+Cpj1IWITDaZyqfbYl9YNoDgv6evqUEbZh2fhePEm38ELdY/mfd4WV6Uk
         Abqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kMONR8uP8o1V9wDmONNEpi44JYnbSaTBErCeX+Ef8mM=;
        b=voYGIJnWHwlFH3Lz3lLRNNnyBoZFTkxKMJRpS4SuilkKmZG5ddrrL7PVax9yyiTAhw
         opJabCPu4r+3YiFz2x+evEXRWfj+YiqdcJSM5aRgZcMVKjtxgBst9/omP+2uobWscUmK
         aWTfV1TfvdEMnQDdcIMstEUcEVG0HStRTrtGpUqONn4NbKSR+bb9P3zPc2eKJfBhDn7D
         FOon69GezxdjTzVz6WxQ6oGkpjbolrHFrZGgJa564CsoA2ID7af0EGVltIVgL13LP7jq
         Rjx6BanVOuVWcWDoCr8YiPclD7xlHZG32E+BkPBCX2U0NX+e/U9fBD0PULcttCQNwNVV
         MISQ==
X-Gm-Message-State: AOAM530I1PvLp9iJRvU1d+9USZoHNsv07ZsvsHDoEiiOZOmArHzGdAfQ
        Ha7bxSZjKY3kS+rgd/NlzSznqA==
X-Google-Smtp-Source: ABdhPJzb5oXknS64kuiz02rv4HWvkZbDRu3ubeC0w7hDduzsE6tvZcGKS9f3Lgfwig0zajCWBQ93Gg==
X-Received: by 2002:a05:6214:e4a:b0:446:6567:6554 with SMTP id o10-20020a0562140e4a00b0044665676554mr305731qvc.25.1651258363472;
        Fri, 29 Apr 2022 11:52:43 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id az14-20020a05620a170e00b0069fb6140d2fsm1374694qkb.45.2022.04.29.11.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 11:52:43 -0700 (PDT)
Message-ID: <f1a5a345-422a-e46a-3a83-2de4023762a9@linaro.org>
Date:   Fri, 29 Apr 2022 13:52:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] interconnect: Restore sync state by ignoring ipa-virt in
 provider count
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20220427013226.341209-1-swboyd@chromium.org>
 <fb1f9a17-9b27-b0ac-124d-66644851e204@linaro.org>
 <38149635-26ee-ab02-7c69-c5dd5f64fab5@kernel.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <38149635-26ee-ab02-7c69-c5dd5f64fab5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 3:52 PM, Georgi Djakov wrote:
> On 27.04.22 15:00, Alex Elder wrote:
>> On 4/26/22 8:32 PM, Stephen Boyd wrote:
>>> Ignore compatible strings for the IPA virt drivers that were removed in
>>> commits 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0
>>> interconnects") and 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0
>>> interconnects") so that the sync state logic can kick in again.
>>> Otherwise all the interconnects in the system will stay pegged at max
>>> speeds because 'providers_count' is always going to be one larger than
>>> the number of drivers that will ever probe on sc7180 or sdx55. This
>>> fixes suspend on sc7180 and sdx55 devices when you don't have a
>>> devicetree patch to remove the ipa-virt compatible node.
>>>
>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Cc: Doug Anderson <dianders@chromium.org>
>>> Cc: Alex Elder <elder@linaro.org>
>>> Cc: Taniya Das <quic_tdas@quicinc.com>
>>> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
>>> Fixes: 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0 
>>> interconnects")
>>> Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 
>>> interconnects")
>>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>
>> So of_count_icc_providers() counts the number of
>> interconnect providers defined in the DTB, regardless
>> of whether anything in the code supports it.
> 
> Yes, that's the case currently. There could be multiple provider drivers
> in different modules, and the modules may be loaded even not during boot,
> but later. So we rely on DT.

Georgi, do you have any other ideas about how to improve this?

What you say makes sense--you figure out the total number of
providers at init time based on what's defined in DT.

But when all is said and done, what if even *one* of those
has no provider driver?  Isn't that what causes the problem
here, that icc_sync_state assumes all providers specified in
DT will eventually have a driver that calls icc_sync_state()?

(I don't claim to know the interconnect code in detail, so
I might not be quite understanding how this works.)

					-Alex

> Thanks,
> Georgi
> 
>> This seems to be a more general problem, but I
>> suppose in practice it's not likely to occur.
>>
>> I think your solution looks fine, but I'm interested
>> in what Georgi has to say.
>>
>> Reviewed-by: Alex Elder <elder@linaro.org>
>>
>>
>>> ---
>>>   drivers/interconnect/core.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>> index 9050ca1f4285..c52915a58b22 100644
>>> --- a/drivers/interconnect/core.c
>>> +++ b/drivers/interconnect/core.c
>>> @@ -1087,9 +1087,15 @@ static int of_count_icc_providers(struct 
>>> device_node *np)
>>>   {
>>>       struct device_node *child;
>>>       int count = 0;
>>> +    const struct of_device_id ignore_list[] = {
>>> +        { .compatible = "qcom,sc7180-ipa-virt" },
>>> +        { .compatible = "qcom,sdx55-ipa-virt" },
>>> +        {}
>>> +    };
>>>       for_each_available_child_of_node(np, child) {
>>> -        if (of_property_read_bool(child, "#interconnect-cells"))
>>> +        if (of_property_read_bool(child, "#interconnect-cells") &&
>>> +            likely(!of_match_node(ignore_list, child)))
>>>               count++;
>>>           count += of_count_icc_providers(child);
>>>       }
>>>
>>> base-commit: 2fb251c265608636fc961b7d38e1a03937e57371
>>
> 

