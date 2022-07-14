Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A04574EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiGNNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiGNNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:06:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEEEB493
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:06:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 23so1483989pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kOi68CytFffHO0RimXC4N0IHB4tCpAjHnaniPIaOy/Y=;
        b=lf+szN39jU/DUMr44LBJmSYDdPTEJ/QhMHsnO9/CS0qWVmYRcmYeSV3fctOYBomU0f
         nFVeRFnqV5vPBR8jiit7wUqxOrg/pMC3w87y60BGrHtd+8vFhYG5oJOsmd/Y9XgDjkKp
         VA51hx+tmqPxhLh8uSdwvlZ+qD4qF7ZJ3mJOgDbMszAJuXOIH7LtKoJIY8HmsXymnpGI
         Mw2hm4IuDZyvdFwBs4H1EDuYfRePtiuejOwSjvBv0RAG6Xf+zpysWyvKa7eCM2SjDCig
         gw2D/ysFQfbcOhSiRO2lsqBecKomuI5733AB8AlaMK9yZKS6sMIZuXlVoDcSF/3/vcSz
         +N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kOi68CytFffHO0RimXC4N0IHB4tCpAjHnaniPIaOy/Y=;
        b=hTntlqiLQoFVlzZ7/s2+kuKN4XKC2KdwZFznn/kZNzDVCXyIIqn6nfyOYOGLy6i6sa
         ytHwcNTNSfcOOU7NSbLLWDucTl9Anu+P7+Kg1YUCMyzb0LEBFoPsC8pE/XyoGCfeBI37
         9aWivhTHimOnJCSzqplL8ukahIdM2XvIiFFgb5vVU+XwXMUqg/dEoHDHPfjYkMBwPuZz
         9xtxhYaLTyh4gAOwUwG6MWMqFd8fcL2yTBhYutlMOeamZ+RGEuiXGh+79552pnyzIB4G
         alxcq7qno8vGHaPmDi/gFLTIYZN+h9I3ycKEdrZ80xY8SUqYZKflNkLoJ28x7lDDCEol
         4J2Q==
X-Gm-Message-State: AJIora9BaUYECigSV1IZGnco2d4lvQHi3z2pzcg+XccphUXIn+ir28u2
        ZFJNGzGp9ZJgfDajsqHzYt+d6w==
X-Google-Smtp-Source: AGRyM1stanSj0l0H2GFPVQdbD14wIvOxVN8F5GObtKv3mp3x3ahSpxVTDKJzlhPQNoTtgdPwEcGwDQ==
X-Received: by 2002:a63:1803:0:b0:40d:159e:91af with SMTP id y3-20020a631803000000b0040d159e91afmr7787653pgl.371.1657803969714;
        Thu, 14 Jul 2022 06:06:09 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id 64-20020a620443000000b005289a50e4c2sm1615839pfe.23.2022.07.14.06.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:06:09 -0700 (PDT)
Message-ID: <00d2373c-4b80-64a7-740c-dae87a565fe3@bytedance.com>
Date:   Thu, 14 Jul 2022 21:06:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 04/10] sched/fair: remove redundant
 cpu_cgrp_subsys->fork()
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-5-zhouchengming@bytedance.com>
 <fa74892c-2956-6ddf-e022-398b89056e5a@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <fa74892c-2956-6ddf-e022-398b89056e5a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/14 20:31, Dietmar Eggemann wrote:
> On 13/07/2022 06:04, Chengming Zhou wrote:
>> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
>> in cgroup_post_fork().
>>
>> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
>> has already set task group for the new fair task in sched_cgroup_fork(),
>> so cpu_cgrp_subsys->fork() can be removed.
>>
>>   cgroup_can_fork()	--> pin parent's sched_task_group
>>   sched_cgroup_fork()
> 
> Don't we set the task group (`p->sched_task_group = tg`) now directly in
> sched_cgroup_fork() and not in __set_task_cpu()?

Correct, it's my fault, what I want to say is "__set_task_cpu() --> set_task_rq()".
I will fix it next version.

> 
>>     __set_task_cpu	--> set task group
>>   cgroup_post_fork()
>>     ss->fork() := cpu_cgroup_fork()	--> set again
> 
> nit pick:
> 
> cpu_cgroup_fork() -> sched_change_group(..., TASK_SET_GROUP)

Ok, will add this.

Thanks.

> 
>> After this patch's change, task_change_group_fair() only need to
>> care about task cgroup migration, make the code much simplier.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> LGTM too.
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> [...]
