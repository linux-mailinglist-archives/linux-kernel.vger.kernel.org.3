Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05F5AFE23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIGHws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIGHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:52:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4114D481D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:52:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b144so9022651pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EWu9/O9lXgrU4t+flicMRFgDAKMIHK/msUSgnOlEMZ8=;
        b=mTOJEZLr+nXrpEW46JkNYXhHrt9bhAnZJWtXuV9ZYuFckzNGXZlyj7vQri39GNAoJ5
         RYkjv88On0vXKSo/Ui2XH/t20LMeAbRTYZRzUp2m41ExY6XS1fDGYDIO9v+W8nJ9NGgt
         KdfzEGXKjnmacZG51fyGJQ9a8J6wsj3C29sq6S/re3f34ZGa6jQolRpXMLTnDWgxGoer
         u6zUPPW1m/JiyJnpMRW6sRnIq5Ny42WyKxqDtf8VRTFtIKn+g+Taoxqa9bhjm1pUofV4
         AkndX2okWCtqKEbu6n28ov9hR2DKhbg+KFGmN6n6IjxHilifuYX2O2tS/Wmx15MzldFx
         q3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EWu9/O9lXgrU4t+flicMRFgDAKMIHK/msUSgnOlEMZ8=;
        b=hP1oHWoM+KlxV+JxDatQhmIPXMlN5ifIg3gAhEHptFYY6Gl5A8Nm6pa84Z7C2GwJjJ
         oaCddZiWjwJGzz4aaWbhlT4G193gi/mfG27Bkg0w1Qoq5kwmnM0u1dW3hYc2HlOCGQQR
         K1+JJNVki30kDgm/czGC94Mox+8VTCr1anwTIJcuqxMlYErWdpbgegrCjI/Rp4T7iHjw
         iBH1PBZ7Uf4FDmICY21EWaQwXCHgHW8R+p3kQB+6NwW8QpnLK/Mvl0KBoeYVOzFk9OD+
         QgLU9ZdI+cPsmLfrXf3jAQB6fZ7awzmYlDB3UdcRHvTjH6tz1UbG1bpccpYxs8GknMUE
         VMWw==
X-Gm-Message-State: ACgBeo1azLSs+opLI95MrqcJHVxVoGHotbPkmaZpKJo+aUO64pbk0qkC
        UUZZ5YHb3lgyjRREW+SJyOtCDQ==
X-Google-Smtp-Source: AA6agR5xEunV/fJ/qJd2GeATEkA+8chL46jTXczJz0rZtV+EFpg5bHnfGkoByAvDF2pLRbRASQahtg==
X-Received: by 2002:a05:6a00:1805:b0:53e:67fb:54aa with SMTP id y5-20020a056a00180500b0053e67fb54aamr2730236pfa.65.1662537157655;
        Wed, 07 Sep 2022 00:52:37 -0700 (PDT)
Received: from [10.4.43.134] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b0017684444f57sm9280025plb.224.2022.09.07.00.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:52:37 -0700 (PDT)
Message-ID: <fa6a22d3-6dbf-0ffc-088b-68b3c241f2d0@bytedance.com>
Date:   Wed, 7 Sep 2022 15:52:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
 <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
 <20220902102528.keooutttg3hq3sy5@techsingularity.net>
 <1fc40679-b7c3-24f2-aa27-f1edab71228e@bytedance.com>
 <20220906095717.maao4qtel4fhbmfq@techsingularity.net>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220906095717.maao4qtel4fhbmfq@techsingularity.net>
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

On 9/6/22 5:57 PM, Mel Gorman wrote:
> On Mon, Sep 05, 2022 at 10:40:00PM +0800, Abel Wu wrote:
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 6089251a4720..59b27a2ef465 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6427,21 +6427,36 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>    		if (sd_share) {
>>>    			/* because !--nr is the condition to stop scan */
>>>    			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
>>> -			/* overloaded LLC is unlikely to have idle cpu/core */
>>> -			if (nr == 1)
>>> -				return -1;
>>> +
>>> +			/*
>>> +			 * Non-overloaded case: Scan full domain if there is
>>> +			 * 	an idle core. Otherwise, scan for an idle
>>> +			 * 	CPU based on nr_idle_scan
>>> +			 * Overloaded case: Unlikely to have an idle CPU but
>>> +			 * 	conduct a limited scan if there is potentially
>>> +			 * 	an idle core.
>>> +			 */
>>> +			if (nr > 1) {
>>> +				if (has_idle_core)
>>> +					nr = sd->span_weight;
>>> +			} else {
>>> +				if (!has_idle_core)
>>> +					return -1;
>>> +				nr = 2;
>>> +			}
>>>    		}
>>>    	}
>>>    	for_each_cpu_wrap(cpu, cpus, target + 1) {
>>> +		if (!--nr)
>>> +			break;
>>> +
>>>    		if (has_idle_core) {
>>>    			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>>    			if ((unsigned int)i < nr_cpumask_bits)
>>>    				return i;
>>>    		} else {
>>> -			if (!--nr)
>>> -				return -1;
>>>    			idle_cpu = __select_idle_cpu(cpu, p);
>>>    			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>>>    				break;
>>
>> I spent last few days testing this, with 3 variations (assume
>> has_idle_core):
>>
>>   a) full or limited (2cores) scan when !nr_idle_scan
>>   b) whether clear sds->has_idle_core when partial scan failed
>>   c) scale scan depth with load or not
>>
>> some observations:
>>
>>   1) It seems always bad if not clear sds->has_idle_core when
>>      partial scan fails. It is due to over partially scanned
>>      but still can not find an idle core. (Following ones are
>>      based on clearing has_idle_core even in partial scans.)
>>
> 
> Ok, that's rational. There will be corner cases where there was no idle
> CPU near the target when there is an idle core far away but it would be
> counter to the purpose of SIS_UTIL to care about that corner case.

Yes, and this corner case (that may become normal sometimes actually)
will be continuously exist if scanning in a linear fashion while scan
depth is limited (SIS_UTIL/SIS_PROP/...), especially when the LLC is
getting larger nowadays.

> 
>>   2) Unconditionally full scan when has_idle_core is not good
>>      for netperf_{udp,tcp} and tbench4. It is probably because
>>      the SIS success rate of these workloads is already high
>>      enough (netperf ~= 100%, tbench4 ~= 50%, compared to that
>>      hackbench ~= 3.5%) which negate a lot of the benefit full
>>      scan brings.
>>
> 
> That's also rational. For a single client/server on netperf, it's expected
> that the SIS success rate is high and scanning is minimal. As the client
> and server are sharing data on localhost and somewhat synchronous, it may
> even partially benefit from SMT sharing.
> 
> So basic approach would be "always clear sds->has_idle_core" + "limit
> scan even when has_idle_core is true", right?

Yes, exactly the same as what you suggested at first place.

> 
> If so, stick a changelog on it and resend!

I will include this in the SIS_FILTER patchset.

> 
>>   3) Scaling scan depth with load seems good for the hackbench
>>      socket tests, and neutral in pipe tests. And I think this
>>      is just the case you mentioned before, under fast wake-up
>>      workloads the has_idle_core will become not that reliable,
>>      so a full scan won't always win.
>>
> 
> My recommendation is leave this out for now but assuming the rest of
> the patches get picked up, consider posting it for the next major kernel
> version (i.e. separate the basic and clever approaches by one major kernel
> version). By separating them, there is less chance of a false positive
> bisection pointing to the wrong patch. Any regression will not be perfectly
> reproducible so the changes of a false positive bisection is relatively high.

Makes sense. I will just include the basic part first.

Thanks,
Abel
