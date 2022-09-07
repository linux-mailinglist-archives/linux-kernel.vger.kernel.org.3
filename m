Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8762E5AFD0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiIGHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGHE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:04:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B12DA8D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:04:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h188so12716798pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=I3AMR95LQUDdRhrOrYRzL4GU0R24ExtqObbx/U3NJaw=;
        b=FENiitxHMZhG0oeEMBaszeMnyMZccIVDSON/SeyX1BVWZBDkwOV+YJPr5hfR5Yr/rQ
         eV8iqs38Nmdj8rvzdXM5DYEA5m6Bo6FIWXTG/Q6dZsebcRVRUu4L2UGI3GFrpArdTBwV
         hZuxUhQPdDOlnO7svMxpLzz3aADVF+g9AKh/a47ArxQ7JuLDksFVC/C8mWa6z8Cr2Vhn
         WUJSW2yiW9tCd6z3sUAKHuFneQzqeG2PN/i9rRgzH0Nv4g1eJMxxEd8zcx9GbKCkAAZV
         Vwm4U7uTsri7dKxIIe2sjfcJk6fygHLVAFGF9wvYOqub/MB6h/Jde4jqLnQ5jXMeJd36
         UnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I3AMR95LQUDdRhrOrYRzL4GU0R24ExtqObbx/U3NJaw=;
        b=OozODKOfLAGSqckq/11fFAineQmk2YxGKDhD66q6ry0RQhl9HuGs0aK5Jox6EttWn2
         oS/FJpiMvd/QJh5XocWvOuWVAgwxIASBmZn2oWqZJZQ9rwA23VP4eJWufhPITIpD8l4p
         +LAZwna3e/nWu3GHxmSpotOZ4OzL7KmTFfGwy7/awgER1oY7PdgRNt7J9HKC/yNPA+6O
         d3Bi+VmoJLwFzOyphZyU9yUV02W1v8IeoAdVPFmiSDnq8R5MUDKXld6vH5zfVVNQ+M/G
         u191dgOIZR9+XBhXbqUsEmtF6+5S/aQPX6F9+KsUQOwwfYkTCIHHFBMg6VLXnwPr0R9i
         rSSg==
X-Gm-Message-State: ACgBeo3rx3zNk0eIRDqwP8NnDQVNTAsi1IP4b1Y6Jb8AX7jpUSSbFp62
        JfB3JhAS8OyTi6NiMsZeshoEOA==
X-Google-Smtp-Source: AA6agR7e+Hd4TYG0M71fMY0QD/aaID7FwhVT9S+fic6nUDDoGELZ0M7dIJ3rmdDFMnEfEOzIbSb6BA==
X-Received: by 2002:a63:6b44:0:b0:434:ad17:5e1a with SMTP id g65-20020a636b44000000b00434ad175e1amr2279570pgc.452.1662534295456;
        Wed, 07 Sep 2022 00:04:55 -0700 (PDT)
Received: from [10.4.126.121] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b00172ea8ff334sm1233384plf.7.2022.09.07.00.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:04:54 -0700 (PDT)
Message-ID: <430e3e5f-d446-6307-cba0-6f859bce560f@bytedance.com>
Date:   Wed, 7 Sep 2022 15:04:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v3] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
 <595c912a-1503-d420-f32f-297b824decae@bytedance.com>
In-Reply-To: <595c912a-1503-d420-f32f-297b824decae@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/26 12:16, Qi Zheng wrote:
> 
> 
> On 2022/8/15 20:47, Qi Zheng wrote:
>> Currently arm64 supports per-CPU IRQ stack, but softirqs
>> are still handled in the task context.
>>
>> Since any call to local_bh_enable() at any level in the task's
>> call stack may trigger a softirq processing run, which could
>> potentially cause a task stack overflow if the combined stack
>> footprints exceed the stack's size, let's run these softirqs
>> on the IRQ stack as well.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Will Deacon <will@kernel.org>
>> ---
>> v2: 
>> https://lore.kernel.org/lkml/20220802065325.39740-1-zhengqi.arch@bytedance.com/
>> v1: 
>> https://lore.kernel.org/lkml/20220708094950.41944-1-zhengqi.arch@bytedance.com/
>> RFC: 
>> https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/
>>
>> Changelog in v2 -> v3:
>>   - rebase onto the v6.0-rc1

Hi Will,

Are we good to merge this patch? Or if there is anything else I need to
do, please let me know. :)

Looking forward to your reply.

Thanks,
Qi

> 
> Gentle ping.
> 
> Thanks,
> Qi
> 
>>
>> Changelog in v1 -> v2:
>>   - temporarily discard [PATCH v1 2/2] to allow this patch to be 
>> merged first
>>   - rebase onto the v5.19
>>   - collect Reviewed-by and Acked-by
>>
>> Changelog in RFC -> v1:
>>   - fix conflicts with commit f2c5092190f2 ("arch/*: Disable softirq 
>> stacks on PREEMPT_RT.")
>>
>>   arch/arm64/Kconfig      |  1 +
>>   arch/arm64/kernel/irq.c | 13 +++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 571cc234d0b3..ee92f5887cf6 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -230,6 +230,7 @@ config ARM64
>>       select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
>>       select TRACE_IRQFLAGS_SUPPORT
>>       select TRACE_IRQFLAGS_NMI_SUPPORT
>> +    select HAVE_SOFTIRQ_ON_OWN_STACK
>>       help
>>         ARM 64-bit (AArch64) Linux support.
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index bda49430c9ea..c36ad20a52f3 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/vmalloc.h>
>>   #include <asm/daifflags.h>
>>   #include <asm/vmap_stack.h>
>> +#include <asm/exception.h>
>>   /* Only access this in an NMI enter/exit */
>>   DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
>> @@ -71,6 +72,18 @@ static void init_irq_stacks(void)
>>   }
>>   #endif
>> +#ifndef CONFIG_PREEMPT_RT
>> +static void ____do_softirq(struct pt_regs *regs)
>> +{
>> +    __do_softirq();
>> +}
>> +
>> +void do_softirq_own_stack(void)
>> +{
>> +    call_on_irq_stack(NULL, ____do_softirq);
>> +}
>> +#endif
>> +
>>   static void default_handle_irq(struct pt_regs *regs)
>>   {
>>       panic("IRQ taken without a root IRQ handler\n");
> 

-- 
Thanks,
Qi
