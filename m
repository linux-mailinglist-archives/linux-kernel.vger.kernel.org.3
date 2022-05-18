Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A922A52B8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbiERLPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiERLO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:14:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EFC16A258;
        Wed, 18 May 2022 04:14:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso3015697wma.0;
        Wed, 18 May 2022 04:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gFNS66ec9gzGKI85Itd6yknLQQ11of1G4AsWn4tUdXY=;
        b=CkLdqk4Ny+Y/JjI8jbwrmF6WX1kc57xVapnnA5pBfOCKv3wC/G3MieTuRMOx1XpGrx
         LpFkV9dAQQeNtqNROMFA58ZTPgonaSjabE0RMpbX/3N0ECOCDTSLHwknxhMj7AHlS80F
         BS8HBT19FF08UjZyYhHmUDIUWLG7QX9abDQ6zwtDhLgBjZEx0whVo//jBhGIDKoUASID
         ogDq5eSySJ8WnsJFpfsvXhexyAdnm8ivs7+rJZDBTfbNFbhzggzwqyye7Ean+VM0qvMA
         hi3M2odIPBRT8jSbHQArhUXXCOLlKORjNlu9eOQ38YOJT1NK19zEE4d8mnV7Swyd2CiI
         Q4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gFNS66ec9gzGKI85Itd6yknLQQ11of1G4AsWn4tUdXY=;
        b=p+cG1eATSQ+0cNgAiDu9/43xRxCgMFsMjuMwxKMAYGRtsL4PqXLt/F/lJ8WQ9AxfKj
         W76sJ6wWuOWJ/N+3HbgKCHP3+Cr0JdBjJLKPIpIokOv/XbQyMuC4SvGWQkQc+31Kco64
         ARCl8wc7pLOJRC7hc8zQZlCoVXmI1GLREahXL8E52e2CZ5I4sVHS5jDjT9i2cAVVzk9K
         DoGUp+wu5dltEdV+cR/+LTdejajIFNU1dCYucnmldDy/tEOmD+UvMCVygsD6OUR+mxwF
         KAiIMc2HvZNZux7V6HvxAjxqzj/M8tW/nEVaskA8TWMG6Z7RuyRO9cO1FBUKbxnNrdwI
         4uAQ==
X-Gm-Message-State: AOAM530abvX0vYK0rGDuNMdLGfGqd4LbnOPr++0VX4iqU0Ax7aI5F6Tf
        VQy2YwrEXY158PpbQ/g9iUc=
X-Google-Smtp-Source: ABdhPJxY7LzE1xl526m35BI0lDNeQjvtILc9BgznWBrEL+AOiyPYOBnQEWaUZTSUmlKMPnT4+q1aZA==
X-Received: by 2002:a1c:1947:0:b0:392:b883:aac9 with SMTP id 68-20020a1c1947000000b00392b883aac9mr24948193wmz.155.1652872494712;
        Wed, 18 May 2022 04:14:54 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm1631606wre.94.2022.05.18.04.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 04:14:54 -0700 (PDT)
Message-ID: <d00cfc46-86a6-c52b-6118-a4472e362c8e@gmail.com>
Date:   Wed, 18 May 2022 13:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-mediatek: Implement
 CPUXGPT timers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220509210741.12020-1-angelogioacchino.delregno@collabora.com>
 <20220509210741.12020-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220509210741.12020-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2022 23:07, AngeloGioacchino Del Regno wrote:
> Some MediaTek platforms with a buggy TrustZone ATF firmware will not
> initialize the AArch64 System Timer correctly: in these cases, the
> System Timer address is correctly programmed, as well as the CNTFRQ_EL0
> register (reading 13MHz, as it should be), but the assigned hardware
> timers are never started before (or after) booting Linux.
> 
> In this condition, any call to function get_cycles() will be returning
> zero, as CNTVCT_EL0 will always read zero.
> 
> One common critical symptom of that is trying to use the udelay()
> function (calling __delay()), which executes the following loop:
> 
>              start = get_cycles();
>              while ((get_cycles() - start) < cycles)
>                      cpu_relax();
> 
> which, when CNTVCT_EL0 always reads zero, translates to:
> 
>              while((0 - 0) < 0)  ==> while(0 < 0)
> 
> ... generating an infinite loop, even though zero is never less
> than zero, but always equal to it (this has to be researched,
> but it's out of the scope of this commit).
> 
> To fix this issue on the affected MediaTek platforms, the solution
> is to simply start the timers that are designed to be System Timer(s).
> These timers, downstream, are called "CPUXGPT" and there is one
> timer per CPU core; luckily, it is not necessary to set a start bit
> on each CPUX General Purpose Timer, but it's conveniently enough to:
>   - Set the clock divider (input = 26MHz, divider = 2, output = 13MHz);
>   - Set the ENABLE bit on a global register (starts all CPUX timers).
> 
> The only small hurdle with this setup is that it's all done through
> the MCUSYS wrapper, where it is needed, for each read or write, to
> select a register address (by writing it to an index register) and
> then to perform any R/W on a "CON" register.
> 
> For example, writing "0x1" to the CPUXGPT register offset 0x4:
> - Write 0x4 to mcusys INDEX register
> - Write 0x1 to mcusys CON register
> 
> Reading from CPUXGPT register offset 0x4:
> - Write 0x4 to mcusys INDEX register
> - Read mcusys CON register.
> 
> Finally, starting this timer makes platforms affected by this issue
> to work correctly.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/clocksource/timer-mediatek.c | 119 +++++++++++++++++++++++++++
>   1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 7bcb4a3f26fb..a3e90047f9ac 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -22,6 +22,19 @@
>   
>   #define TIMER_SYNC_TICKS        (3)
>   
> +/* cpux mcusys wrapper */
> +#define CPUX_CON_REG		0x0
> +#define CPUX_IDX_REG		0x4
> +
> +/* cpux */
> +#define CPUX_IDX_GLOBAL_CTRL	0x0
> + #define CPUX_ENABLE		BIT(0)
> + #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
> + #define CPUX_CLK_DIV1		BIT(8)
> + #define CPUX_CLK_DIV2		BIT(9)
> + #define CPUX_CLK_DIV4		BIT(10)
> +#define CPUX_IDX_GLOBAL_IRQ	0x30
> +
>   /* gpt */
>   #define GPT_IRQ_EN_REG          0x00
>   #define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
> @@ -72,6 +85,57 @@
>   
>   static void __iomem *gpt_sched_reg __read_mostly;
>   
> +static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
> +{
> +	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
> +	return readl(timer_of_base(to) + CPUX_CON_REG);
> +}
> +
> +static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
> +{
> +	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
> +	writel(val, timer_of_base(to) + CPUX_CON_REG);
> +}
> +
> +static void mtk_cpux_disable_irq(struct timer_of *to)
> +{
> +	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
> +	u32 val;
> +
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
> +	val &= ~(*irq_mask);
> +	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
> +}
> +
> +static void mtk_cpux_enable_irq(struct timer_of *to)
> +{
> +	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
> +	u32 val;
> +
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
> +	val |= *irq_mask;
> +	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
> +}

What about using a function like
mtk_cpux_set_irq(struct timer_of *to, bool enable)

Other then that things look fine.

Regards,
Matthias

> +
> +static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
> +{
> +	/* Clear any irq */
> +	mtk_cpux_disable_irq(to_timer_of(clkevt));
> +
> +	/*
> +	 * Disabling CPUXGPT timer will crash the platform, especially
> +	 * if Trusted Firmware is using it (usually, for sleep states),
> +	 * so we only mask the IRQ and call it a day.
> +	 */
> +	return 0;
> +}
> +
> +static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
> +{
> +	mtk_cpux_enable_irq(to_timer_of(clkevt));
> +	return 0;
> +}
> +
>   static void mtk_syst_ack_irq(struct timer_of *to)
>   {
>   	/* Clear and disable interrupt */
> @@ -281,6 +345,60 @@ static struct timer_of to = {
>   	},
>   };
>   
> +static int __init mtk_cpux_init(struct device_node *node)
> +{
> +	static struct timer_of to_cpux;
> +	u32 freq, val;
> +	int ret;
> +
> +	/*
> +	 * There are per-cpu interrupts for the CPUX General Purpose Timer
> +	 * but since this timer feeds the AArch64 System Timer we can rely
> +	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
> +	 */
> +	to_cpux.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
> +	to_cpux.clkevt.name = "mtk-cpuxgpt";
> +	to_cpux.clkevt.rating = 10;
> +	to_cpux.clkevt.cpumask = cpu_possible_mask;
> +	to_cpux.clkevt.set_state_shutdown = mtk_cpux_clkevt_shutdown;
> +	to_cpux.clkevt.tick_resume = mtk_cpux_clkevt_resume;
> +
> +	/* If this fails, bad things are about to happen... */
> +	ret = timer_of_init(node, &to_cpux);
> +	if (ret) {
> +		WARN(1, "Cannot start CPUX timers.\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Check if we're given a clock with the right frequency for this
> +	 * timer, otherwise warn but keep going with the setup anyway, as
> +	 * that makes it possible to still boot the kernel, even though
> +	 * it may not work correctly (random lockups, etc).
> +	 * The reason behind this is that having an early UART may not be
> +	 * possible for everyone and this gives a chance to retrieve kmsg
> +	 * for eventual debugging even on consumer devices.
> +	 */
> +	freq = timer_of_rate(&to_cpux);
> +	if (freq > 13000000)
> +		WARN(1, "Requested unsupported timer frequency %u\n", freq);
> +
> +	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +	val &= ~CPUX_CLK_DIV_MASK;
> +	val |= CPUX_CLK_DIV2;
> +	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +
> +	/* Enable all CPUXGPT timers */
> +	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
> +
> +	clockevents_config_and_register(&to_cpux.clkevt, timer_of_rate(&to_cpux),
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +
> +	return 0;
> +}
> +
>   static int __init mtk_syst_init(struct device_node *node)
>   {
>   	int ret;
> @@ -339,3 +457,4 @@ static int __init mtk_gpt_init(struct device_node *node)
>   }
>   TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>   TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> +TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
