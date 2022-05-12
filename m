Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289BD52452F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbiELFwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiELFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:52:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E2C612AF;
        Wed, 11 May 2022 22:52:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x88so4218898pjj.1;
        Wed, 11 May 2022 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=DGLY4A5UTGv0a7yzBqJAfh9KTP0wMCV++B5Vy0N2jPU=;
        b=FCRf0ienq/DcUYFpsBkMlTs/eubLVN5LPCW4n224wvjxLE869U/RE++wC7EuGVxAU1
         tTs4873JG8JFvh/cgMhL5Ezyj5OrTIUQCJQ4+3i8fbNm+WLOjBf1qwXl1yfkxHE802SJ
         /Oyr2XN+HmxaLwDqP9oZ/AdhMiX0DKDoEa149+XwvFlH0rZRWQ2JrG7iRl9iYJMdzzKv
         sv+lGsEUfofN4aZdX90CY4f0agO9ZOegpF+eCUOaBoGgh6ExIeJU/fZg1oKUDSdhSYbI
         +q5uJCNn3aKZ3icCRxyCb3Y95Wgtc2AjMPFpWfjvm1XaI7Atgl+MV6QoEmOCTo4ROOq6
         atAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=DGLY4A5UTGv0a7yzBqJAfh9KTP0wMCV++B5Vy0N2jPU=;
        b=DfI5A4p6WTEKVMzpXdAw4pl+sXhHAUJqbQm1LkqiXhinyw13xOt5gabY7JZSGIsVXx
         ZjaNmgTJLBDTpVCHCvCFJImT9hBspx0ID6qE0EnytGgHhhOVC5RNSPXimclpi9iDGYb5
         oB9Gv71pRSKBn6GpRf9q+DmfaYhMHNTARap0e/A0CVcaKbriP+SbLbVzA59VLEVaRmEx
         Pidgp3Fo781SC1S7OxcUMjDriSCQOoDCwj5eJMnffXobssLN1oB07xC3gRe33CMag4gZ
         0c/QIIEc1wqlR9YFCCQUtqwlsC+fuwnJ5viF9AW/90HdA8UQUN+YlZGboKCqgtoX1Y0d
         jodA==
X-Gm-Message-State: AOAM5302C92ngLtverEKILz/xCp35crw9I/aKccko3WV+L4T4nNxcPuM
        f7GKOwsndNQo5tOx5Jw7ancpif0CzYsAWw==
X-Google-Smtp-Source: ABdhPJxvYpYCJjcHtbLdosQLV4sPGJdhivEr3hp56jeLHwqQYdHeh7s+Xl40GQi3XHGKdSs3hnedJQ==
X-Received: by 2002:a17:902:ef45:b0:156:1858:71fc with SMTP id e5-20020a170902ef4500b00156185871fcmr28125253plx.23.1652334767036;
        Wed, 11 May 2022 22:52:47 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f70d00b0015edb22aba1sm2859243plo.270.2022.05.11.22.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:52:46 -0700 (PDT)
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
 <20220510154236.88753-1-schspa@gmail.com>
 <CAJZ5v0gcOmd8fXG9_BYxr6rN7ncUWnfki7K9S5wK2Vvh9SxUCA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Date:   Thu, 12 May 2022 13:51:53 +0800
In-reply-to: <CAJZ5v0gcOmd8fXG9_BYxr6rN7ncUWnfki7K9S5wK2Vvh9SxUCA@mail.gmail.com>
Message-ID: <m2wner47ru.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Tue, May 10, 2022 at 5:42 PM Schspa Shi <schspa@gmail.com> 
> wrote:
>>
>> When cpufreq online failed, policy->cpus are not empty while
>> cpufreq sysfs file available, we may access some data freed.
>>
>> Take policy->clk as an example:
>>
>> static int cpufreq_online(unsigned int cpu)
>> {
>>   ...
>>   // policy->cpus != 0 at this time
>>   down_write(&policy->rwsem);
>>   ret = cpufreq_add_dev_interface(policy);
>>   up_write(&policy->rwsem);
>>
>>   down_write(&policy->rwsem);
>>   ...
>>   /* cpufreq nitialization fails in some cases */
>>   if (cpufreq_driver->get && has_target()) {
>>     policy->cur = cpufreq_driver->get(policy->cpu);
>>     if (!policy->cur) {
>>       ret = -EIO;
>>       pr_err("%s: ->get() failed\n", __func__);
>>       goto out_destroy_policy;
>>     }
>>   }
>>   ...
>>   up_write(&policy->rwsem);
>>   ...
>>
>>   return 0;
>>
>> out_destroy_policy:
>>         for_each_cpu(j, policy->real_cpus)
>>                 remove_cpu_dev_symlink(policy, 
>>                 get_cpu_device(j));
>>     up_write(&policy->rwsem);
>> ...
>> out_exit_policy:
>>   if (cpufreq_driver->exit)
>>     cpufreq_driver->exit(policy);
>>       clk_put(policy->clk);
>>       // policy->clk is a wild pointer
>> ...
>>                                     ^
>>                                     |
>>                             Another process access
>>                             __cpufreq_get
>>                               cpufreq_verify_current_freq
>>                                 cpufreq_generic_get
>>                                   // acces wild pointer of 
>>                                   policy->clk;
>>                                     |
>>                                     |
>> out_offline_policy:                 |
>>   cpufreq_policy_free(policy);      |
>>     // deleted here, and will wait for no body reference
>>     cpufreq_policy_put_kobj(policy);
>> }
>>
>> We can fix it by clear the policy->cpus mask.
>> Both show_scaling_cur_freq and show_cpuinfo_cur_freq will 
>> return an
>> error by checking this mask, thus avoiding UAF.
>
> So the UAF only happens if something is freed by ->offline() or
> ->exit() and I'm not sure where the mask is checked in the
> scaling_cur_freq() path.
>

In the current code, it is checked in the following path:
show();
  down_read(&policy->rwsem);
  ret = fattr->show(policy, buf);
    show_cpuinfo_cur_freq
      __cpufreq_get
        if (unlikely(policy_is_inactive(policy)))
          return 0;
  up_read(&policy->rwsem);

> Overall, the patch is really two changes in one IMO.
>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>>
>> ---
>>
>> Changelog:
>> v1 -> v2:
>>         - Fix bad critical region enlarge which causes 
>>         uninitialized
>>           unlock.
>> v2 -> v3:
>>         - Remove the missed down_write() before
>>           cpumask_and(policy->cpus, policy->cpus, 
>>           cpu_online_mask);
>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c 
>> b/drivers/cpufreq/cpufreq.c
>> index 80f535cc8a75..d93958dbdab8 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1337,12 +1337,12 @@ static int cpufreq_online(unsigned int 
>> cpu)
>>                 down_write(&policy->rwsem);
>>                 policy->cpu = cpu;
>>                 policy->governor = NULL;
>> -               up_write(&policy->rwsem);
>>         } else {
>>                 new_policy = true;
>>                 policy = cpufreq_policy_alloc(cpu);
>>                 if (!policy)
>>                         return -ENOMEM;
>> +               down_write(&policy->rwsem);
>>         }
>>
>>         if (!new_policy && cpufreq_driver->online) {
>> @@ -1382,7 +1382,6 @@ static int cpufreq_online(unsigned int 
>> cpu)
>>                 cpumask_copy(policy->related_cpus, 
>>                 policy->cpus);
>>         }
>>
>> -       down_write(&policy->rwsem);
>>         /*
>>          * affected cpus must always be the one, which are 
>>          online. We aren't
>>          * managing offline cpus here.
>
> The first change, which could and probably should be a separate 
> patch,
> ends here.
>
> You prevent the rwsem from being dropped in the existing policy 
> case
> and acquire it right after creating a new policy.
>
> This way ->online() always runs under the rwsem, which 
> definitely
> sounds like a good idea, and policy->cpus is manipulated under 
> the
> rwsem which IMV is required.
>
> As a side-effect, ->init() is also run under the rwsem, but that
> shouldn't be a problem as per your discussion with Viresh.
>
> So the above would be patch 1 in a series.
>
> The change below is a separate one and it addresses the 
> particular
> race you've discovered, as long as patch 1 above is present.  It 
> would
> be patch 2 in the series.
>
>> @@ -1533,7 +1532,7 @@ static int cpufreq_online(unsigned int 
>> cpu)
>>         for_each_cpu(j, policy->real_cpus)
>>                 remove_cpu_dev_symlink(policy, 
>>                 get_cpu_device(j));
>>
>> -       up_write(&policy->rwsem);
>> +       cpumask_clear(policy->cpus);
>
> It is OK to clear policy->cpus here, because ->offline() and 
> ->exit()
> are called with policy->cpus clear from cpufreq_offline() and
> cpufreq_remove_dev(), so they cannot assume policy->cpus to be
> populated when they are invoked.  However, this needs to be 
> stated in
> the changelog of patch 2.
>

OK, I will separate it into two patch.

>>  out_offline_policy:
>>         if (cpufreq_driver->offline)
>> @@ -1542,6 +1541,7 @@ static int cpufreq_online(unsigned int 
>> cpu)
>>  out_exit_policy:
>>         if (cpufreq_driver->exit)
>>                 cpufreq_driver->exit(policy);
>> +       up_write(&policy->rwsem);
>
> It is consistent to run ->offline() and ->exit() under the 
> rwsem, so
> this change is OK too.
>
>>  out_free_policy:
>>         cpufreq_policy_free(policy);
>> --
>
> That said, there still are races that are not addressed by the 
> above,
> so I would add patch 3 changing show() to check 
> policy_is_inactive()
> under the rwsem.
>

Yes, let me upload a new patch for this change.

> Thanks!

---
BRs
Schspa Shi
