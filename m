Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C93052B8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiERLUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiERLUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:20:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F260817490B;
        Wed, 18 May 2022 04:20:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so861094wms.5;
        Wed, 18 May 2022 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oifcGu/wBIFujV3M4+LF022wfIfIsx3++oPD8PzMcqY=;
        b=N9SNePuXf5WbjXfMxBu/yGNs4MutoJweY+6B+WtZgFHx4+//6BpHtFAN4vbxlkmSwW
         CprwhfMPBijt3VpJxQL3dn0rYsfD9W5nKSMj8CU40bMzyu/qvU5rNcE3HGrCTCvVgQEg
         TsqKZUCsmixVHVANdgxwShIJI+N4SW5CVWVPxT7JH61Oy9hPghK50wpgMm5rcx+t7B1C
         jzYsT6h7cyEvmCglzfCekVLGnLGsz215aUxNurb4A1wtIp6gt3GuTMa11jIGmXqmMWSZ
         Pqg3rr32gl0BJqmweQqNbTHphBMXPR5CiEQyS55C8CO115aaSe0b7l8e6kYDwB6zPBun
         Hdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oifcGu/wBIFujV3M4+LF022wfIfIsx3++oPD8PzMcqY=;
        b=Kb1cnWsAvUZgqYdFJnqHjcTqWeu5zBiH351FwujeKABYm2R3O1XrRvUzKMoaSZlnda
         /mH74seEQSAUlvWxjPiD8YBluTdLLv7sP9e9m0uW+L8ac8b6JZDfMIIXosJamjhHrlxk
         x7o6DoEgEOG1pF2uWKJ8tqHxEv7beDdWA8TuZMietJQYm3WJ3tls3bY03bFpZNAh4Mf7
         BIjeOKaiGIwMxWCjhSnwtmjHaTRFeNPPXZyhJT+MPP7masulU8rOQLGR55pRTZEp5F7T
         1FswVIuuaH6JqcjJFfGqetWtDiJbYiJt2sPiQTWGjcGTArz27m+66LYpjLrAfL2YOTqT
         TYCQ==
X-Gm-Message-State: AOAM531p1vykeUKdm28vpl5UHlD7K4ocIC4lcfAnIHLxtWMJnMoaziRb
        g/EZ6oFVqliI2rmJujwa/ig=
X-Google-Smtp-Source: ABdhPJxTdoJHmZxhLXgmc4WLVrKyFQ/WkTPc6NtT1aGinrO7WxU3gZn55dFiMyzlWWrn0XGm3CEaXA==
X-Received: by 2002:a05:600c:3d09:b0:394:7224:e6c4 with SMTP id bh9-20020a05600c3d0900b003947224e6c4mr25505459wmb.60.1652872803364;
        Wed, 18 May 2022 04:20:03 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
        by smtp.gmail.com with ESMTPSA id k13-20020a05600c1c8d00b003971fc23185sm1401427wms.20.2022.05.18.04.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 04:20:02 -0700 (PDT)
Message-ID: <084e5990-b970-360d-cef5-d9875a0e97b6@gmail.com>
Date:   Wed, 18 May 2022 13:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-mediatek: Implement
 CPUXGPT timers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220509210741.12020-1-angelogioacchino.delregno@collabora.com>
 <20220509210741.12020-3-angelogioacchino.delregno@collabora.com>
 <20220517204705.GA1597201-robh@kernel.org>
 <e3f1fe5b-b031-10b7-6e17-bc11e98cf5a3@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e3f1fe5b-b031-10b7-6e17-bc11e98cf5a3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2022 10:08, AngeloGioacchino Del Regno wrote:
> Il 17/05/22 22:47, Rob Herring ha scritto:
>> On Mon, May 09, 2022 at 11:07:40PM +0200, AngeloGioacchino Del Regno wrote:
>>> Some MediaTek platforms with a buggy TrustZone ATF firmware will not
>>> initialize the AArch64 System Timer correctly: in these cases, the
>>> System Timer address is correctly programmed, as well as the CNTFRQ_EL0
>>> register (reading 13MHz, as it should be), but the assigned hardware
>>> timers are never started before (or after) booting Linux.
>>
>> I believe the upstream position in regards to arch timer work-arounds is
>> fix the firmware.
>>
> 
> Hello Rob,
> 
> unfortunately, this is not possible for all boards and/or all devices: while
> it's really straightforward to add a register write in TrustZone, and MT6795
> even has ATF support upstream, the major blocker for this is consumer devices.
> 
> There, you cannot simply flash a new ATF firmware because some partitions and
> some firmwares are checked against an obviously not public OEM signature:
> taking as an example the device that I'm using for development (a Sony Xperia M5
> smartphone), a firmware fix would imply that Sony needs to release a new TZ
> fw, which is not going to happen because that device was *abandoned* years ago.
> 
> Though, Sony is not the only OEM that is affected by that issue: all smartphones
> have this signature check against the OEM's keys, which is 99.9% of the MT6795
> boards.
> Now there's also another catch: MT6795 is *not* the only SoC that requires this
> fix... it's many others as well, both ARM and ARM64, and the count is very large!
> ...and there's more: some of the OEMs/ODMs that produced MT6795 devices don't
> even exist anymore!!!
> 
> Hence, the only way to avoid turning a very large pile of electronics into
> e-waste is to give a new life to those abandoned deices by actually providing
> a way to boot them - and this is the only way, as this commit is not just
> for SMP, but also for the boot CPU, and Linux won't work without. At all.
> 
> If there was any way to get the firmware fixed, I would've gone for that,
> but this is *really* the only option.
> 

I agree with Angelo, we should make sure that we can run Linux on these devices, 
as they are the only available for the general public.

Actually we were forced to do something similar for arm32 devices as well [1].

Regards,
Matthias

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-mediatek/mediatek.c?h=v5.18-rc7#n19

> Regards,
> Angelo
> 
>> Rob
>>
>>>
>>> In this condition, any call to function get_cycles() will be returning
>>> zero, as CNTVCT_EL0 will always read zero.
>>>
>>> One common critical symptom of that is trying to use the udelay()
>>> function (calling __delay()), which executes the following loop:
>>>
>>>              start = get_cycles();
>>>              while ((get_cycles() - start) < cycles)
>>>                      cpu_relax();
>>>
>>> which, when CNTVCT_EL0 always reads zero, translates to:
>>>
>>>              while((0 - 0) < 0)  ==> while(0 < 0)
>>>
>>> ... generating an infinite loop, even though zero is never less
>>> than zero, but always equal to it (this has to be researched,
>>> but it's out of the scope of this commit).
>>>
>>> To fix this issue on the affected MediaTek platforms, the solution
>>> is to simply start the timers that are designed to be System Timer(s).
>>> These timers, downstream, are called "CPUXGPT" and there is one
>>> timer per CPU core; luckily, it is not necessary to set a start bit
>>> on each CPUX General Purpose Timer, but it's conveniently enough to:
>>>   - Set the clock divider (input = 26MHz, divider = 2, output = 13MHz);
>>>   - Set the ENABLE bit on a global register (starts all CPUX timers).
>>>
>>> The only small hurdle with this setup is that it's all done through
>>> the MCUSYS wrapper, where it is needed, for each read or write, to
>>> select a register address (by writing it to an index register) and
>>> then to perform any R/W on a "CON" register.
>>>
>>> For example, writing "0x1" to the CPUXGPT register offset 0x4:
>>> - Write 0x4 to mcusys INDEX register
>>> - Write 0x1 to mcusys CON register
>>>
>>> Reading from CPUXGPT register offset 0x4:
>>> - Write 0x4 to mcusys INDEX register
>>> - Read mcusys CON register.
>>>
>>> Finally, starting this timer makes platforms affected by this issue
>>> to work correctly.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/clocksource/timer-mediatek.c | 119 +++++++++++++++++++++++++++
>>>   1 file changed, 119 insertions(+)
>>>
>>> diff --git a/drivers/clocksource/timer-mediatek.c 
>>> b/drivers/clocksource/timer-mediatek.c
>>> index 7bcb4a3f26fb..a3e90047f9ac 100644
>>> --- a/drivers/clocksource/timer-mediatek.c
>>> +++ b/drivers/clocksource/timer-mediatek.c
>>> @@ -22,6 +22,19 @@
>>>   #define TIMER_SYNC_TICKS        (3)
>>> +/* cpux mcusys wrapper */
>>> +#define CPUX_CON_REG        0x0
>>> +#define CPUX_IDX_REG        0x4
>>> +
>>> +/* cpux */
>>> +#define CPUX_IDX_GLOBAL_CTRL    0x0
>>> + #define CPUX_ENABLE        BIT(0)
>>> + #define CPUX_CLK_DIV_MASK    GENMASK(10, 8)
>>> + #define CPUX_CLK_DIV1        BIT(8)
>>> + #define CPUX_CLK_DIV2        BIT(9)
>>> + #define CPUX_CLK_DIV4        BIT(10)
>>> +#define CPUX_IDX_GLOBAL_IRQ    0x30
>>> +
>>>   /* gpt */
>>>   #define GPT_IRQ_EN_REG          0x00
>>>   #define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
>>> @@ -72,6 +85,57 @@
>>>   static void __iomem *gpt_sched_reg __read_mostly;
>>> +static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
>>> +{
>>> +    writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
>>> +    return readl(timer_of_base(to) + CPUX_CON_REG);
>>> +}
>>> +
>>> +static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
>>> +{
>>> +    writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
>>> +    writel(val, timer_of_base(to) + CPUX_CON_REG);
>>> +}
>>> +
>>> +static void mtk_cpux_disable_irq(struct timer_of *to)
>>> +{
>>> +    const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
>>> +    u32 val;
>>> +
>>> +    val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
>>> +    val &= ~(*irq_mask);
>>> +    mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
>>> +}
>>> +
>>> +static void mtk_cpux_enable_irq(struct timer_of *to)
>>> +{
>>> +    const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
>>> +    u32 val;
>>> +
>>> +    val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
>>> +    val |= *irq_mask;
>>> +    mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
>>> +}
>>> +
>>> +static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
>>> +{
>>> +    /* Clear any irq */
>>> +    mtk_cpux_disable_irq(to_timer_of(clkevt));
>>> +
>>> +    /*
>>> +     * Disabling CPUXGPT timer will crash the platform, especially
>>> +     * if Trusted Firmware is using it (usually, for sleep states),
>>> +     * so we only mask the IRQ and call it a day.
>>> +     */
>>> +    return 0;
>>> +}
>>> +
>>> +static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
>>> +{
>>> +    mtk_cpux_enable_irq(to_timer_of(clkevt));
>>> +    return 0;
>>> +}
>>> +
>>>   static void mtk_syst_ack_irq(struct timer_of *to)
>>>   {
>>>       /* Clear and disable interrupt */
>>> @@ -281,6 +345,60 @@ static struct timer_of to = {
>>>       },
>>>   };
>>> +static int __init mtk_cpux_init(struct device_node *node)
>>> +{
>>> +    static struct timer_of to_cpux;
>>> +    u32 freq, val;
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * There are per-cpu interrupts for the CPUX General Purpose Timer
>>> +     * but since this timer feeds the AArch64 System Timer we can rely
>>> +     * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
>>> +     */
>>> +    to_cpux.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
>>> +    to_cpux.clkevt.name = "mtk-cpuxgpt";
>>> +    to_cpux.clkevt.rating = 10;
>>> +    to_cpux.clkevt.cpumask = cpu_possible_mask;
>>> +    to_cpux.clkevt.set_state_shutdown = mtk_cpux_clkevt_shutdown;
>>> +    to_cpux.clkevt.tick_resume = mtk_cpux_clkevt_resume;
>>> +
>>> +    /* If this fails, bad things are about to happen... */
>>> +    ret = timer_of_init(node, &to_cpux);
>>> +    if (ret) {
>>> +        WARN(1, "Cannot start CPUX timers.\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    /*
>>> +     * Check if we're given a clock with the right frequency for this
>>> +     * timer, otherwise warn but keep going with the setup anyway, as
>>> +     * that makes it possible to still boot the kernel, even though
>>> +     * it may not work correctly (random lockups, etc).
>>> +     * The reason behind this is that having an early UART may not be
>>> +     * possible for everyone and this gives a chance to retrieve kmsg
>>> +     * for eventual debugging even on consumer devices.
>>> +     */
>>> +    freq = timer_of_rate(&to_cpux);
>>> +    if (freq > 13000000)
>>> +        WARN(1, "Requested unsupported timer frequency %u\n", freq);
>>> +
>>> +    /* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
>>> +    val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
>>> +    val &= ~CPUX_CLK_DIV_MASK;
>>> +    val |= CPUX_CLK_DIV2;
>>> +    mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
>>> +
>>> +    /* Enable all CPUXGPT timers */
>>> +    val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
>>> +    mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
>>> +
>>> +    clockevents_config_and_register(&to_cpux.clkevt, timer_of_rate(&to_cpux),
>>> +                    TIMER_SYNC_TICKS, 0xffffffff);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int __init mtk_syst_init(struct device_node *node)
>>>   {
>>>       int ret;
>>> @@ -339,3 +457,4 @@ static int __init mtk_gpt_init(struct device_node *node)
>>>   }
>>>   TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>>>   TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
>>> +TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
>>> -- 
>>> 2.35.1
>>>
>>>
> 
> 
