Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC556A3D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiGGNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiGGNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:38:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BABE05
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:38:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so19422258pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LlviVCXS0LxCL+bJnFAHhOkhgq8+v6fBshCzSesvNtw=;
        b=oH9YyaoyUyKsvbZpmdcgvnpmbKNHrqgce3SbHbSYwKi3+h3pQeSsVnm6ysuQ8qOfde
         rkQHGHOndOVAcKf8VltPjUbp/I5Eyx3oIrnxNPXpKTnue2+/RH3kWAssInK/hUxSEHcR
         uokKs+ggA1xJOiRO8Kyt1vPsxar2OsHhcp0Okp8sRfGQRXHiX0epJsjL97a87R0vm6tz
         zPb+2KRq3MXn0prNxDg0ROoBrjgLHRNCAkVZKScK4qDVUFU/DR4I3czqG5zV9I2VpKV1
         HGUojTOtPPnQej3Pbbljm0UvQXgVyEX7QdEnaUmAHctfz31nFppFMXyaCcP38sPFTlwK
         Ft6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LlviVCXS0LxCL+bJnFAHhOkhgq8+v6fBshCzSesvNtw=;
        b=7i2SPqz/Pknaqf8nFDR9ZRaVczTpy2P4VCKqWC6hMiBe+F955lYcWay0ikvw4EUDLz
         9Vo9o7LAm99yEtckXynEQSlNCKszHYi+FXuN6JQirp8ntI3kR5Ob44/HP62n8yWIZOUx
         K/ZfqgK8VzldCt0NIdH0+OTvwZNb3U2LjbW4x8x76YZvcvJBEOMdvLqsj2aC+Y+mYLmT
         gWi4oXt+DNlq2ggOORhtR4dduKhW0+zzjGYeXayQlqdkAeUHXWoZJ8xKlKpuEbOWPvIp
         hE4uLFijH5sRxZV5pLlGzLXi08xIu12+rOwRHq75f/mz4PfYlV82bChUnv6NcBnlKnJB
         cU6w==
X-Gm-Message-State: AJIora9L0SClT9aSnlesoj7v+usyFvtFlVgSQ5rs6wSgE7xUut0pZBEN
        Qnq/kY8/TetyY6Rj0xFvc6i0mA==
X-Google-Smtp-Source: AGRyM1stU+QWyhSOHZT4PMsgUj7J2gqqMP3AKDLS5nWJRDvNbdTETCmhrTOs/U6K7gXJaF+U8nVRCw==
X-Received: by 2002:a17:903:3247:b0:16b:e386:dcc9 with SMTP id ji7-20020a170903324700b0016be386dcc9mr22830868plb.54.1657201110434;
        Thu, 07 Jul 2022 06:38:30 -0700 (PDT)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b0016c18f479d5sm999371pls.19.2022.07.07.06.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 06:38:29 -0700 (PDT)
Message-ID: <42bfd82c-b3fb-c942-d6f2-ae5adec90a26@bytedance.com>
Date:   Thu, 7 Jul 2022 21:38:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-3-zhengqi.arch@bytedance.com>
 <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/7 20:49, Arnd Bergmann wrote:
> On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Since softirqs are handled on the per-CPU IRQ stack,
>> let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
>> the core code to invoke __do_softirq() directly without
>> going through do_softirq_own_stack().
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> I think the idea is right, but the extra function pointer adds more complexity
> than necessary:
> 
>>   static __always_inline void __el1_irq(struct pt_regs *regs,
>>                                        void (*handler)(struct pt_regs *))
>>   {
>>          enter_from_kernel_mode(regs);
>>
>> -       irq_enter_rcu();
>> -       do_interrupt_handler(regs, handler);
>> -       irq_exit_rcu();
>> +       do_interrupt_handler(regs, handler, irq_handler);
>>
>>          arm64_preempt_schedule_irq();
>>
>> @@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>>          if (regs->pc & BIT(55))
>>                  arm64_apply_bp_hardening();
>>
>> -       irq_enter_rcu();
>> -       do_interrupt_handler(regs, handler);
>> -       irq_exit_rcu();
>> +       do_interrupt_handler(regs, handler, irq_handler);
>>
>>          exit_to_user_mode(regs);
>>   }
> 
> Would it be possible to instead pull out the call_on_irq_stack() so these
> two functions are instead called on the IRQ stack already?

Hi,

Do you mean to modify call_on_irq_stack()?

I have tried doing a conditional jump inside call_on_irq_stack() like
this:

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -888,13 +888,22 @@ SYM_FUNC_START(call_on_irq_stack)

         /* Move to the new stack and call the function there */
         mov     sp, x16
-       blr     x1
+
+       cmp     x2, #1
+       b.eq    99f
+
+       blr     x1
+       b       999f
+
+99:    bl      irq_enter_rcu
+       blr     x1
+       bl      irq_exit_rcu

         /*
          * Restore the SP from the FP, and restore the FP and LR from 
the frame
          * record.
          */
-       mov     sp, x29
+999:   mov     sp, x29
         ldp     x29, x30, [sp], #16
  #ifdef CONFIG_SHADOW_CALL_STACK
         ldp     scs_sp, xzr, [sp], #16

But this also requires a new parameter in do_interrupt_handler.

I also considered implementing call_on_irq_stack() for nmi and irq
separately, but later think it's unnecessary.

> 
>          Arnd

Thanks,
Qi
