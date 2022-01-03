Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248D0483825
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiACU7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiACU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:59:23 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43AC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:59:22 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id i5so44702710uaq.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 12:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DI7U33XnwqMBqIYYTvY19UtR18aJdkAMIqCMnWY6O8=;
        b=uWmTvM9lJIr1+KHyjNcMXJUC571AxiXGhpJKCO94UujqnDReRrxk3QqtSDFEPnkwFk
         mU+y9+j9FjMR0AIAZnXfWISDfFf+F1FuWi4GV4mIrguP71w4NqFwyaOnJtf2Tiiddefk
         7ktYER/Jg23rRejddi9cj1wH3lCyADoYqi6xbXdYoBbwMSRuRFsFfpdMiM3cnbxwG0f/
         Q7GVE+FGdkskwr5po5SJ/90rBRdvffKQOY71iZ6W+Vmt3VOYOwj0eW+fyeJ1IVQeLPqJ
         8uuLlGqMqYicbiolFKAZLyr/PZed6XVseIfia3hPlliN2g/K59MpEX8dYyXbnU0Xi3VM
         tf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DI7U33XnwqMBqIYYTvY19UtR18aJdkAMIqCMnWY6O8=;
        b=mRMxq1vY3Ga261avrTQc4Lsf11aOraeSeMpLRyH+iSYrOBGH3ZLvWo/y0fjTVkMqSM
         ZtN7Tc2EUO322l3g6g1NX2P7TOwbiNtQjhGRXg9hdq3nmxHQXGDoRiFpW6qDW6EP8zVe
         nf+OOr92KHe6AoZolNQdqxNZUFeS1bXkUy2y5JHry/8+Fp7y6TiT6eYpXoW+XJLm441p
         Arl83oo8lDWUS1+VbPdb7lrcA/vxYVjYb4J7agqtRUasgmQpdBjayLYvp2BQ/njSFywS
         N05n/OVl8QoMXCLAfksha6+R5l6hRURGhyu01eQtMj05fLadrnlqVw3HiESkoZ7U36Co
         BzoQ==
X-Gm-Message-State: AOAM533vJZeehkDpjCCq8cObm8PiOlPeQzl8r3DYKMU9RS1rkC1kHPwR
        /8FUbwVAi+ceQ5/vM/xMXCWcXXylzmN8/1iEgIcuNQ==
X-Google-Smtp-Source: ABdhPJz565d48havHy/Fmp/TH4dis1kq3/Wnv+KXzc+hm2za8waxX8fvzxdpx/tqIvMh9wV2Vt2R9ZePnPbk02nbMKE=
X-Received: by 2002:ab0:1d8c:: with SMTP id l12mr9711603uak.114.1641243561934;
 Mon, 03 Jan 2022 12:59:21 -0800 (PST)
MIME-Version: 1.0
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
In-Reply-To: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 3 Jan 2022 22:59:10 +0200
Message-ID: <CAPLW+4nrPKA66GrF4XukyHWHJ=wBycjyK3ZPLCofEFe-VJ9wWg@mail.gmail.com>
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

On Thu, 30 Dec 2021 at 21:34, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Hi Chanho and Sam,
>
> I am slowly finishing dtschema for Samsung pinctrl drivers [1] and I
> noticed that Exynos850 and Auto v9 do not define interrupt in pinctrl
> node with: wakeup-interrupt-controller. This is an interrupt muxing
> several external wakeup interrupts, e.g. EINT16 - EINT31.
>
> For Exynos5433 this looks like:
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/exynos/exynos5433.dtsi#L857
>
> Missing muxed interrupt for Exynos850 and Autov9 might be fine, although
> you should see in dmesg error log like:
>     "irq number for muxed EINTs not found"
>
> Can you check that your wakeup-interrupt-controller is properly defined
> in DTSI? If yes, I will need to include such differences in the dtschema.
>

In case of Exynos850, no muxed interrupts exist for wakeup GPIO
domains. Basically, "pinctrl_alive" and "pinctrl_cmgp" domains are
wake-up capable, and they have dedicated interrupt for each particular
GPIO pin. All those interrupts are defined in exynos850-pinctrl.dtsi
file, in next nodes:
  - pinctrl_alive: gpa0..gpa4 (interrupt numbers 1..36)
  - pinctrl_cmgp: gpm0..gpm7 (interrupt numbers 39..46)

All mentioned interrupts are wakeup interrupts, and there are no muxed
ones. So it seems like it's not possible to specify "interrupts"
property in pinctrl nodes with wakeup-interrupt-controller. The PM is
not enabled in Exynos850 platform yet, so I can't really test if
interrupts I mentioned are able to wake up the system.

After adding this patch ("arm64: dts: exynos: Add missing gpm6 and
gpm7 nodes to Exynos850"), I can't see this error message anymore:

    samsung-pinctrl 11c30000.pinctrl: irq number for muxed EINTs not found

That's because exynos_eint_wkup_init() function exits in this check:

    if (!muxed_banks) {
        of_node_put(wkup_np);
        return 0;
    }

But I actually can see another error message, printed in
exynos_eint_gpio_init() function (for wake-up capable pinctrl nodes,
because those nodes don't have "interrupts" property now -- you
removed those in your patch):

    samsung-pinctrl 11850000.pinctrl: irq number not available
    samsung-pinctrl 11c30000.pinctrl: irq number not available

which in turn leads to exynos_eint_gpio_init() function to exit with
-EINVAL code in the very beginning, and I'm not sure if it's ok? As I
said, those errors only appear after your patch ("arm64: dts: exynos:
drop incorrectly placed wakeup interrupts in Exynos850").

It raises next questions, which I'm trying to think over right now.
Krzysztof, please let me know if you already have answers to those:

1. Regarding "wakeup-interrupt-controller" node (and
exynos_eint_wkup_init() function): is it ok to not have "interrupts"
property in there? Would corresponding interrupts specified in child
nodes (gpa0..gpa4) function as wake-up interrupts in this case? Or
pinctrl driver should be reworked somehow?

2. Regarding missing interrupts in pinctrl nodes (and corresponding
error in exynos_eint_gpio_init() function): should it be reworked in
some way for Exynos850? Error message seems invalid in Exynos850 case,
and I'm not even sure if it's ok exynos_eint_gpio_init() fails. Should
it be modified to work that error around, in case of Exynos850?

All other pinctrl nodes have a muxed interrupt (except pinctrl_aud,
but that's probably fine).

Thanks!

> [1] https://github.com/krzk/linux/tree/n/dt-bindings-samsung-pinctrl-schema
>
> Best regards,
> Krzysztof
