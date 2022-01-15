Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595CA48F953
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 21:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiAOUiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 15:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiAOUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 15:38:49 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A638C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:38:49 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id y4so23258238uad.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yO8dTPrmPRXVrjQIMnFZqGd29yzkjusF/zgJOiaD7Wg=;
        b=f8qTvbOG4o9caP0liBKVTeiqM7cP4NXuoC3zCUVmjb40xDo/8Ha5Dn+Dp2HKEivUkd
         mO1gSKE1TxoHCs6Q7C2gaMhKzOdIrX4VajFraLwVM10R90tkhtrBTm8/LsZxwL5fQKWt
         KPFwAMw7ROv5o8CZAw33d4A2aRFfAi8Ocom/XkqQAZpqAfIlE3+0QRr8h2JIBlv9H50Q
         hHuWP76pzoHEbvmi3tX4Kn843ZlUhbdrBFYzQwvztnZYzIsHo2vuP1wu1Su8SR1a2Fgp
         XN+kz54Gb9fYFC5kGAmT41mHaZ+SBdx5od0riY/ZxBv+PKemEAQOEuxWW4wzN8SVEecu
         NKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yO8dTPrmPRXVrjQIMnFZqGd29yzkjusF/zgJOiaD7Wg=;
        b=1Jy7MrQ7NSe8xSDtetUjA9mD3k4tX+UL5Ga3wkBPpt8K1o0lgNJwvVn/Bft46JDq0N
         ofmWY1y/AF1VF2snMWiVgwjSH2rTc7gdxmOXGwY346Uw0h5WHPrae0+wZGKCujKeXiPM
         pyacl71OcLMTLTFkb3txqGmsB3m8Xi0IA98FixS3zWOdcvNDBKTA6So2zZa5i1ingspH
         EXJrl7kUAM14uAdSBjjPrO34/w2t27Ss4QhPyFVd+FF6BRGirmIZsDjOBGHzjFXi5/Ew
         KV5UFprB1GRNRqBU3M4jDut028uw5T2Lq2/rAowjTWqdkP99wjn7VOVmY/kWfgfCKo2F
         2Z3Q==
X-Gm-Message-State: AOAM532YX+nn73CmyK4yb6XNU83St1MYgh/WZYisIqtN6aYk74nfiXib
        IEf3kY7kE92vIkFzf/i5KxOZw41Aj+2iWvomJFeUpA==
X-Google-Smtp-Source: ABdhPJzn0ZcUlXuX8W+bbu7cwMymCpFiuBYTixLtFqfJguAcAFEzEHwdTrujX/GrVejpXZE47kvqqE43aEHBPCQJSlE=
X-Received: by 2002:ab0:3c4a:: with SMTP id u10mr7062958uaw.139.1642279128502;
 Sat, 15 Jan 2022 12:38:48 -0800 (PST)
MIME-Version: 1.0
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
 <CAPLW+4nrPKA66GrF4XukyHWHJ=wBycjyK3ZPLCofEFe-VJ9wWg@mail.gmail.com>
 <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com> <CAPLW+4=xD5hM_tYDD+kwqkiVq5h0tjO+7q6Akbd6iO_Ou-g=0A@mail.gmail.com>
 <1a09cd4e-71da-43e6-9732-33d704e1744e@canonical.com>
In-Reply-To: <1a09cd4e-71da-43e6-9732-33d704e1744e@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 15 Jan 2022 22:38:36 +0200
Message-ID: <CAPLW+4kEQYrTvMwodbha4SV9mDS36sjxdsiCwVQptmoShb_5hQ@mail.gmail.com>
Subject: Re: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 at 17:46, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 14/01/2022 21:32, Sam Protsenko wrote:
> > On Fri, 7 Jan 2022 at 10:16, Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> On 03/01/2022 21:59, Sam Protsenko wrote:
> >>> On Thu, 30 Dec 2021 at 21:34, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@canonical.com> wrote:
> >>>>
> >>>> Hi Chanho and Sam,
> >>>>
> >>>> I am slowly finishing dtschema for Samsung pinctrl drivers [1] and I
> >>>> noticed that Exynos850 and Auto v9 do not define interrupt in pinctrl
> >>>> node with: wakeup-interrupt-controller. This is an interrupt muxing
> >>>> several external wakeup interrupts, e.g. EINT16 - EINT31.
> >>>>
> >>>> For Exynos5433 this looks like:
> >>>> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/exynos/exynos5433.dtsi#L857
> >>>>
> >>>> Missing muxed interrupt for Exynos850 and Autov9 might be fine, although
> >>>> you should see in dmesg error log like:
> >>>>     "irq number for muxed EINTs not found"
> >>>>
> >>>> Can you check that your wakeup-interrupt-controller is properly defined
> >>>> in DTSI? If yes, I will need to include such differences in the dtschema.
> >>>>
> >>>
> >>> In case of Exynos850, no muxed interrupts exist for wakeup GPIO
> >>> domains. Basically, "pinctrl_alive" and "pinctrl_cmgp" domains are
> >>> wake-up capable, and they have dedicated interrupt for each particular
> >>> GPIO pin. All those interrupts are defined in exynos850-pinctrl.dtsi
> >>> file, in next nodes:
> >>>   - pinctrl_alive: gpa0..gpa4 (interrupt numbers 1..36)
> >>>   - pinctrl_cmgp: gpm0..gpm7 (interrupt numbers 39..46)
> >>>
> >>> All mentioned interrupts are wakeup interrupts, and there are no muxed
> >>> ones. So it seems like it's not possible to specify "interrupts"
> >>> property in pinctrl nodes with wakeup-interrupt-controller. The PM is
> >>> not enabled in Exynos850 platform yet, so I can't really test if
> >>> interrupts I mentioned are able to wake up the system.
> >>
> >> Thanks for confirming, I'll adjust the schema.
> >>
> >>>
> >>> After adding this patch ("arm64: dts: exynos: Add missing gpm6 and
> >>> gpm7 nodes to Exynos850"), I can't see this error message anymore:
> >>>
> >>>     samsung-pinctrl 11c30000.pinctrl: irq number for muxed EINTs not found
> >>>
> >>> That's because exynos_eint_wkup_init() function exits in this check:
> >>>
> >>>     if (!muxed_banks) {
> >>>         of_node_put(wkup_np);
> >>>         return 0;
> >>>     }
> >>>
> >>> But I actually can see another error message, printed in
> >>> exynos_eint_gpio_init() function (for wake-up capable pinctrl nodes,
> >>> because those nodes don't have "interrupts" property now -- you
> >>> removed those in your patch):
> >>>
> >>>     samsung-pinctrl 11850000.pinctrl: irq number not available
> >>>     samsung-pinctrl 11c30000.pinctrl: irq number not available
> >>>
> >>> which in turn leads to exynos_eint_gpio_init() function to exit with
> >>> -EINVAL code in the very beginning, and I'm not sure if it's ok? As I
> >>> said, those errors only appear after your patch ("arm64: dts: exynos:
> >>> drop incorrectly placed wakeup interrupts in Exynos850").
> >>
> >> Yeah, I replied to this next to my patch. I think my patch was not
> >> correct and you need one - exactly one - interrupt for regular GPIO
> >> interrupts.
> >>
> >
> > I just need to remove ".eint_gpio_init" in exynos850_pin_ctrl[] for
> > pinctrl_alive and pinctrl_gpmc. Those already have ".eint_wkup_init",
> > which is enough to handle all interrupts (per-pin). GPIO_ALIVE and
> > GPIO_GPMC lack EINT capabilities: judging from TRM, there are no EINT
> > interrupts (like EINT_SVC, which is accessed in EINT ISR), and there
> > are no EINT interrupts wired to GIC (like INTREQ__GPIO_ALIVE or
> > INTREQ__GPIO_GPMC). With removed ".eint_gpio_init", I can see in
> > "/proc/interrupts" that corresponding interrupts are still handled
> > properly (because of .eint_wkup_init), and the error message is gone.
>
> This would mean that my dts patch removing all interrupts for alive and
> cmgp was correct:
> https://lore.kernel.org/linux-samsung-soc/66754058-187e-ffd5-71ba-4720101f5d98@canonical.com/T/#mf0b06ebdac554d57d8230dc546c3d57d59d7bd6b
> Was it?
>

Yep. But patches [1,2] I sent recently should be probably applied
before yours -- they belong together. Please take those in your patch
series (when sending the next version).

Thanks!

[1] https://lkml.org/lkml/2022/1/14/861
[2] https://lkml.org/lkml/2022/1/3/680

> > Will send the patch soon -- please add it to the beginning of your
> > series along with my other patch I already submitted.
>
> Sure.
>
>
>
>
>
> Best regards,
> Krzysztof
