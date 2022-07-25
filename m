Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB757F873
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiGYDRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGYDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:16:54 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCDCCDF3B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 20:16:49 -0700 (PDT)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKeEWC95iDaw1AA--.30605S3;
        Mon, 25 Jul 2022 11:16:39 +0800 (CST)
Message-ID: <d98399c3-738c-e514-85e1-b278dc813cb9@loongson.cn>
Date:   Mon, 25 Jul 2022 11:16:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] LoongArch: Remove clock setting during cpu hotplug
 stage
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220720072152.3894559-1-maobibo@loongson.cn>
 <3324feed-e158-8c51-9915-85b0498f1888@xen0n.name>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <3324feed-e158-8c51-9915-85b0498f1888@xen0n.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxKeEWC95iDaw1AA--.30605S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1kKr48Zw15AFyxXryrZwb_yoWrGF1fpF
        n3Can3KrW8Kwn7uw1ktr1UAry5Gw4DJw47ZF17J3W8AFyDAF1jgFyDXryvgFW7JrZ7Xa1F
        qr1UXrsruFyUX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5PpnJUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/22 16:10, WANG Xuerui 写道:
> On 2022/7/20 15:21, Bibo Mao wrote:
>> On physical machine we can save power by disabling clock of hot removed cpu.
>> However there will be problem, since different platforms have different clock
>> setting methods, the code is platform relative. Also it can be in firmware/pmu
>> compoments or cpu regulator driver, rather than general loongarch cpu booting
>> flow.
>>
>> Also on qemu virt machine, device clock/freq setting is not
>> emulated, there is no such registers.
>>
>> This patch removes hard-coded register accessing in generic
>> loongarch cpu boot flow.
> 
> Improving a little on the wording (mostly fixing eyesore Chinglish):
> 
> "On physical machine we can save power by disabling clock of hot removed cpu. However as different platforms require different methods to configure clocks, the code is platform-specific, and probably belongs to firmware/pmu or cpu regulator, rather than generic arch/loongarch code.
> 
> Also, there is no such register on QEMU virt machine since the clock/frequency regulation is not emulated.
> 
> This patch removes the hard-coded clock register accesses in generic loongarch cpu hotplug flow."
> 
Xuerui,

Thanks for reviewing my patch, I will modify the issue in next patch.

regards
bibo, mao

>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kernel/smp.c | 29 -----------------------------
>>   include/linux/cpuhotplug.h  |  1 -
>>   2 files changed, 30 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>> index 73cec62504fb..98b3e059d344 100644
>> --- a/arch/loongarch/kernel/smp.c
>> +++ b/arch/loongarch/kernel/smp.c
>> @@ -359,35 +359,6 @@ void play_dead(void)
>>       play_dead_uncached(state_addr);
>>   }
>>   -static int loongson3_enable_clock(unsigned int cpu)
>> -{
>> -    uint64_t core_id = cpu_data[cpu].core;
>> -    uint64_t package_id = cpu_data[cpu].package;
>> -
>> -    LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
>> -
>> -    return 0;
>> -}
>> -
>> -static int loongson3_disable_clock(unsigned int cpu)
>> -{
>> -    uint64_t core_id = cpu_data[cpu].core;
>> -    uint64_t package_id = cpu_data[cpu].package;
>> -
>> -    LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
>> -
>> -    return 0;
>> -}
>> -
>> -static int register_loongson3_notifier(void)
>> -{
>> -    return cpuhp_setup_state_nocalls(CPUHP_LOONGARCH_SOC_PREPARE,
>> -                     "loongarch/loongson:prepare",
>> -                     loongson3_enable_clock,
>> -                     loongson3_disable_clock);
>> -}
>> -early_initcall(register_loongson3_notifier);
>> -
>>   #endif
>>     /*
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 19f0dbfdd7fe..b66c5f389159 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -130,7 +130,6 @@ enum cpuhp_state {
>>       CPUHP_ZCOMP_PREPARE,
>>       CPUHP_TIMERS_PREPARE,
>>       CPUHP_MIPS_SOC_PREPARE,
>> -    CPUHP_LOONGARCH_SOC_PREPARE,
>>       CPUHP_BP_PREPARE_DYN,
>>       CPUHP_BP_PREPARE_DYN_END        = CPUHP_BP_PREPARE_DYN + 20,
>>       CPUHP_BRINGUP_CPU,
> 
> Seems good. I should have noticed earlier the fact the clock control registers are, in every regard, model-specific, thus not appropriate for arch/loongarch. Proper drivers should be added afterwards, though I assume you must internally have something like that already.
> 
> Reviewed-by: WANG Xuerui <git@xen0n.name>

