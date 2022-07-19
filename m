Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D16579361
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiGSGm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiGSGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:42:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA821D0E8;
        Mon, 18 Jul 2022 23:42:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DC5EF32004E7;
        Tue, 19 Jul 2022 02:42:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Jul 2022 02:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658212969; x=
        1658299369; bh=/GcQTqnB2ExgalRjmVV8XkUuxgcyJVL6766PkWjqgyc=; b=I
        4nLQvXlSPceoku3CMa/zXjocV9d7ngPSRWkIYe7C+/aJpMuwwV+4FyL3A/tekWZ2
        8NqCCamttp3wfvFJ6j1LEA1JPesQal797n3Gs96aQvBBANcveWvdFb7Zj5UsF2rR
        NZuqs4nt3v1Ar7vcPKvSZg12ynTOjyeu7+wEDcVCggT4izQRKl7BRGvePND5nEdi
        2HWefHhE15tVQ801T8wilA8h5Ndt8RqoK7rOAL6UhX3M/BV3CF1iaZRuGjQ7zdjd
        C5IL8kwJq/Xng9UJNK1QqgRD5MHMbxG4Mk1PbrWumxQjRy9rFVFSSMz4E+ZY2c2X
        p2sFcmTVEa/oT2YsaN7tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658212969; x=
        1658299369; bh=/GcQTqnB2ExgalRjmVV8XkUuxgcyJVL6766PkWjqgyc=; b=r
        TkQEOJ6NJxkfyptcCjFZiG3Mw2Uj77BopsXua/wPn6z9wvN1Cvn9HDk7dxmHDIhM
        pHQHoRB6OJQAMRlN1Yf6iAPjK8yO2fD7X7t0ZsTvUUaGkTEeNtmIBVhfco0Gckf/
        frtVOzw4DYYHDn6Xkr9LKjNov04enG22YUrh+JDqnOwMCUlDaWc6TbHG51F8TyG8
        P5JZq8APxceziPXvOlLvvW0VVoLkLbUzFlqgjzpHQ+SNKPX6EbIkkQFTk4mGTk4/
        1QLqbCZjl+uj1gmE9C15UMpXPtiEKLWaJeBkRSA+jJrjdQb9Yuaf049jX9iXOFP2
        n3EK5q6l6PsLaAq9E8Qiw==
X-ME-Sender: <xms:aFLWYsfGgd2LjRlGEiBkRKN4UXEK8pK9_6lfya8PqKPsCsEHABiKPw>
    <xme:aFLWYuOIQgLdXIzH7BmsUYTFwpgvlPgWDOpZSDkileXd-qJYSaVRrHiEqPUbEz9BW
    dQ_EqMv6nyfLB7JWQ>
X-ME-Received: <xmr:aFLWYtiS9L_s2GultdftWuPlEZtyjqBooO89Q7zE46tFwd64xGY7xe-LkERjh2VfAVIvl210i-V72aVp6_gv9Annd2xwk95C2a6x7DINkPIUb_5Oe6_wigRXow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:aFLWYh8CFGvqNWiJWzxiC5Vt6NhPAIF7XZAH9X65dnkipd7JMbs7Dw>
    <xmx:aFLWYouFRKTtdq2JgQI_Od2YAfDs4WyhMrWDf_yQu0RO2dhI3JW6eg>
    <xmx:aFLWYoFaMqjCIwwPodOSUYyuX0M4Pwa5CDVTYDsnoFcNttyGDRUrUw>
    <xmx:aVLWYpmQ03E4TCTDLhPkNsFEtU63dMqJGyfrV2UKJagozTsiNoV8tg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Jul 2022 02:42:47 -0400 (EDT)
Subject: Re: [PATCH 2/2] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP
 based on DT property
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220719054729.2224766-1-apatel@ventanamicro.com>
 <20220719054729.2224766-3-apatel@ventanamicro.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <315d9850-e660-f71e-2321-b0684f7df950@sholland.org>
Date:   Tue, 19 Jul 2022 01:42:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220719054729.2224766-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On 7/19/22 12:47 AM, Anup Patel wrote:
> We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only when
> riscv,timer-always-on DT property is not present for the corresponding
> CPU.

The timer maintaining its context (and continuing to count) during non-retentive
CPU suspend is not sufficient to drop CLOCK_EVT_FEAT_C3STOP.

Another requirement is that the timer interrupt is generated and routed outside
the CPU's power/reset domain, to whatever hardware is responsible for turning
the CPU back on. It does not matter if the timer interrupt fires, if that
interrupt cannot wake up the CPU.

So something closer to "riscv,timer-can-wake-cpu" would be a more accurate
property name for how you are using it.

And even then, that ability is a property of the SBI implementation, not just
the hardware. In the motivating example for the flag (Allwinner D1), the CLINT
cannot wake the CPU from reset, but the SoC contains other MMIO timers that can.
So the capability of the SBI timer extension depends on which timer hardware the
SBI implementation chooses to use. So I am not sure that the property belongs in
the CPU node.

Maybe it makes sense to report this capability via a function in the SBI timer
extension?

Regards,
Samuel

> This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> based on RISC-V platform capabilities rather than having it set for
> all RISC-V platforms.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 593d5a957b69..3015324f2b59 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>  	.name			= "riscv_timer_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
>  	.rating			= 100,
>  	.set_next_event		= riscv_clock_next_event,
>  };
> @@ -65,9 +65,13 @@ static struct clocksource riscv_clocksource = {
>  static int riscv_timer_starting_cpu(unsigned int cpu)
>  {
>  	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
> +	struct device_node *np = of_get_cpu_node(cpu, NULL);
>  
>  	ce->cpumask = cpumask_of(cpu);
>  	ce->irq = riscv_clock_event_irq;
> +	if (!of_property_read_bool(np, "riscv,timer-always-on"))
> +		ce->features |= CLOCK_EVT_FEAT_C3STOP;
> +	of_node_put(np);
>  	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>  
>  	enable_percpu_irq(riscv_clock_event_irq,
> 

