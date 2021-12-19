Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0135B47A0FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 15:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhLSOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 09:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhLSOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 09:37:19 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66EC061574;
        Sun, 19 Dec 2021 06:37:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so27962947edu.4;
        Sun, 19 Dec 2021 06:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=u2C58Qi3vb54QmI4e1AHKNijekgERo9skjEIXUUovfk=;
        b=d+xFCA0DmryqNr7Q2/XOn6ZcLLwYoPgTigUHBKiFiDvLu/W3lbTZi0rBLjioW/Gzcr
         xXm1LSdJg/vJf6iJkMN4qKqshQjrUi+P1bxEavtjgO+AhAomRX22AB1l75xPI9ubkzhW
         W3jiVoPsg7LLudUB23e4iGPEuqTkG1SsT3dpVZbbgbYQOLEpxqbO8iRUjrHNmszwfjdk
         rh8kJ59csG3IHaaXK/1yUXPCKpcTpY0/4D9xa8r22aLg1AUg730BdhW7H2lk+8+dvDcz
         wQZkokR8Oc8G/CQF1bcE/rnbGxsSQUMjNsAv6K99m4p/J6IZtoqSWThM4AefOlXKGEzK
         WCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=u2C58Qi3vb54QmI4e1AHKNijekgERo9skjEIXUUovfk=;
        b=aw7jryvoReS3rYUNtPdQj68NudO9l+H88rsP/SMiEE48rUc1SaeDQhUm/dJTtZaDTB
         v3pgdz99JmS4xhzd4gGi7yfjLQWNRSxLnd24W0fQ9aMgwN+Jaau0ieVAJ97wcYpGFZFC
         HvHgA7seAcW31Ja6PlFfA+zkCTBPYMW6BnHFU+1oBAGdfv3B4IClRKu2PheM18xJsMq3
         ipPE34D1jLEwT22sFfU56Z7kVAMDkE3jpI/r5xsGnhvIIQjYeQFYvdUKZdI6n8Ze0s00
         EoNBO/APM5Bnl7mmSLyjMDmxkhHTJFL4tk4uDfRzy06d88WdZUFfYOdeKTBdzdDxf0ra
         Jk9A==
X-Gm-Message-State: AOAM5316yPgs4A0C6E75IbgyZpEkJRZxouFDpkiKtNMZzUnFCeDWX7gj
        cJIlGtQsoyzabG6Ly1lli/0=
X-Google-Smtp-Source: ABdhPJzTD5T7sNxYkWs3Xb1a9cHuHPhEG7tWJB9oARXo+VmyQsN3aR/Loo/BAps3N7FB2XfybEnIBA==
X-Received: by 2002:a05:6402:2814:: with SMTP id h20mr11746954ede.288.1639924637585;
        Sun, 19 Dec 2021 06:37:17 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id cs12sm4512689ejc.15.2021.12.19.06.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 06:37:16 -0800 (PST)
Message-ID: <cc27e22d9945b1ab5ccc7ef20eb36af63402ef54.camel@gmail.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
From:   David Virag <virag.david003@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Sun, 19 Dec 2021 15:36:20 +0100
In-Reply-To: <b0f95b77e335596ee567ae83c1cbe549@misterjones.org>
References: <20211206153124.427102-1-virag.david003@gmail.com>
         <20211206153124.427102-8-virag.david003@gmail.com>
         <b0f95b77e335596ee567ae83c1cbe549@misterjones.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-07 at 19:42 +0000, Marc Zyngier wrote:
> On 2021-12-06 15:31, David Virag wrote:
> > Add initial Exynos7885 device tree nodes with dts for the Samsung 
> > Galaxy
> > A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> > Currently this includes some clock support, UART support, and I2C 
> > nodes.
> > 
> > Signed-off-by: David Virag <virag.david003@gmail.com>
> 
> [...]
> 
> > +       psci {
> > +               compatible = "arm,psci";
> > +               method = "smc";
> > +               cpu_suspend = <0xc4000001>;
> > +               cpu_off = <0x84000002>;
> > +               cpu_on = <0xc4000003>;
> 
> Aren't these the standard PSCI 0.2 function numbers? Can't you
> make the compatible "arm,psci-0.2" instead?

This is not a proper PSCI 0.2 implementation. For example 0.2 has a get
version call which is definitely not implemented properly as after
setting the compatible to 0.2 I get the following:

[    0.000000] psci: PSCIv65535.65535 detected in firmware.

Which is obviously not right.

> 
> > +       };
> > +
> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               /* Hypervisor Virtual Timer interrupt is not wired
> > to GIC */
> 
> I don't understand this comment. You seem to have a bunch of
> ARMv8.0 cores, for which there is no such thing as a hypervisor
> virtual timer (this is an ARMv8.1 addition).

My bad, will remove it! Should have read docs better.

> 
> > +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | 
> > IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) |
> > IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) |
> > IRQ_TYPE_LEVEL_LOW)>;
> > +       };
> 
> Thanks,
> 
>          M.

