Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF0F5AFE46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIGH74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiIGH7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:59:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB4F15FE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:59:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l10so465121plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QSPvFGqkc1CiFYAkXJQlAqzJJop8JAfn9innGv4dmkw=;
        b=iOZ5mGnWMKkZVP3y/zhPyWbapx8V0vA1sB3j/gxkeXA8TVDr5JLpiUDRklevMBsS8/
         FxV5YZmKDXpTmxvYAyK3Tmc/KxXr3E+sfSh8LTfhKSs4XGa/xEDyiR9gyPJa/wH+m0u9
         Q0Z1/WDzUMLdx70pbZz19F2nIuoyHrK6YrTTowdaG7zvyF3hAYHOECpiXkf9ZO1uurHT
         tM8ooP9NIqM69ztIt2Xgf8Itv1AEzaHbh0sQ5J1VO5p49djw9NJiuqyMnFY9bYIJWhyi
         WRIQ8dq/29GRQ3uc9gTD4XquT02/xeCnFb+rBn1nB/4xG4t5YZ2Ep+hLR5SIxA32AvRF
         G5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QSPvFGqkc1CiFYAkXJQlAqzJJop8JAfn9innGv4dmkw=;
        b=Jr2spYkDeDgvstPY6Wf17t9D1mIydLAeqIgy0NQCIes3psB5EAo7WUynllE5zOKhoj
         MuoP3G+QfyAHQae0pmwL552HYsdi0m5PUKmSc9UcgUyRG6En3+NRV/p39py+jx4B1WCx
         Z/n3p2NFWBJx/vUBH7PeUEge+eWgqWwZbyG/ky12ExFSsZiOXpyU8ATTv4B5Li6+1kI2
         RfNRJOfRZz5ec9UW35MN1h01nzwan2a8QazkkkevwCVMMnn7lbRhWbFwW8naH2XH4zf/
         KiRz+zIsleTruE7PpHy+3oA4bzFrug3YzPJjmuprPgzJQjeMkbU9ZNTpga9Yn47E+IQl
         up7A==
X-Gm-Message-State: ACgBeo1zlFm7XSZ4oYwPh37+zhjsAfuTYpC5vo5upAgBP1ZEWUvHl7HJ
        e6JMC8n1+CwNJ+4fohBtHQ/SlQ==
X-Google-Smtp-Source: AA6agR4oScyKOJomjMuSrcXLvNJbM0nW6lsg9XO5thbPas3+MCNXdiUK6aED71DnoLRAKO1BB3KZNg==
X-Received: by 2002:a17:90b:384e:b0:1fd:fc3e:a502 with SMTP id nl14-20020a17090b384e00b001fdfc3ea502mr29833890pjb.35.1662537578403;
        Wed, 07 Sep 2022 00:59:38 -0700 (PDT)
Received: from [10.4.43.134] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id a25-20020a62d419000000b0053640880313sm11631006pfh.46.2022.09.07.00.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:59:38 -0700 (PDT)
Message-ID: <6ab7ecbb-d0fb-dc44-cada-fcdc5b9676d0@bytedance.com>
Date:   Wed, 7 Sep 2022 15:59:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v2 5/5] sched/fair: cleanup for SIS_PROP
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20220901131107.71785-1-wuyun.abel@bytedance.com>
 <20220901131107.71785-5-wuyun.abel@bytedance.com>
 <20220901140311.xi3y72uxdwbpxzrq@suse.de>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220901140311.xi3y72uxdwbpxzrq@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 10:03 PM, Mel Gorman wrote:
> On Thu, Sep 01, 2022 at 09:11:07PM +0800, Abel Wu wrote:
>> The sched-domain of this cpu is only used when SIS_PROP is enabled,
>> and it should be irrelevant whether the local sd_llc is valid or
>> not, since all we care about is target sd_llc if !SIS_PROP.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> This could conceivably result in an uninitialised memory access if
> SIS_PROP was enabled while select_idle_cpu is running. I'm not sure if
> it can happen when jump labels are in use but I think it could happen
> for !CONFIG_JUMP_LABEL updating the sysctl_sched_features bitmap updated
> via sysctl.
> 
> The patch is still a good idea because it moves an unlikely rcu_deference
> out of the default path for sched features but either this_sd needs to
> be initialised to NULL and checked or the this_sd lookup needs to happen
> twice at a slight additional cost to the default-disabled SIS_PROP path.
> 

Hi Mel, please check the following resent patch, Thanks!

https://lore.kernel.org/lkml/20220902033032.79846-5-wuyun.abel@bytedance.com/
