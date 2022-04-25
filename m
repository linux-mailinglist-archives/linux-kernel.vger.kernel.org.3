Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D6850E99E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244999AbiDYTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244983AbiDYTk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:40:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891D112447;
        Mon, 25 Apr 2022 12:37:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i38so9954765ybj.13;
        Mon, 25 Apr 2022 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sv8hAStxtYZLA7ttjMHDmBWNkg9R0he6yilL9E/on7U=;
        b=Rm3XivQgs/+qfHTgBRxz6EnqsR5YnGqXNq6SpUmHifFzrPauwn6vlgLyAEZRxGkVne
         NUaFb6Sw7lnrNY59Nk0EjE1hAHqwuQPTmDo19XR5IhO9RnkLG4gEUzH50njFyZm9sc/f
         jvwRM/jT2L4tq7uFD9+qrAOKMFp1CSeZaenkXELOGulEVO6y8F3JIEPpR/CxTkQAkYQC
         Bn8QW/c2vyY6sgOjIsJil8UIhvRGlwr0XIW0Eh+tA2qHxqrdyFdT0uTnK1X2ShxEq2zh
         le/736GlWszQIlmHgbntrvfmZVq9ZvbRkwcHcQlj4cvpTv5jCIiCYxxyl4ELBG6OhXzW
         jxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sv8hAStxtYZLA7ttjMHDmBWNkg9R0he6yilL9E/on7U=;
        b=r8CdvhKtDiIBp0d9co1ctSN25OpHKc4SdS4bV21llex/ZuNq/A9X93WEg8iNztEDvB
         OeO8x+lSlv3WpFNMbGKtj/ZpaSztkb+4IiEQAI01k9iug5af8oh+FbQCG+8bib61L48S
         Rywa+LyaY3gGPxXg5uY52XicztoDsDHHYjZlxPTKEBrGzWbSKoO/neJZ+9xy4/ynDXCT
         /1+xNAD1DJ6pPWkT5l7CFHSowj4SVCB5qi9Df1LAuEY65b8YKFSjtb6GmZGamXJQUyxE
         TTzOmLcF1lb4qSKOs+ywM37xRd55DmB8MFnq5d2w4/y1VFGum5dghC18Fvuhc2b3zcp/
         4IKw==
X-Gm-Message-State: AOAM532MJBO4w7SvUnOfjLHPZ3KKtJPiYqfBGTs+YO74aJHYbAWV8aQh
        iga5EXQ8+JKnMjiPFVRqVB67gKmL0J3eErSQN70=
X-Google-Smtp-Source: ABdhPJx+MAl3lvFKD1Qba4L7n1K5/ljEL1sT3HVJgvt1iDEvua5oqXeT4ma4s6OJVaASqyJ8hlGCcxr5ZDsfp4axFO8=
X-Received: by 2002:a25:af14:0:b0:645:36f1:c584 with SMTP id
 a20-20020a25af14000000b0064536f1c584mr17794206ybh.366.1650915472252; Mon, 25
 Apr 2022 12:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-19-sebastian.reichel@collabora.com>
 <36551341-60f5-8b61-59d1-176ece8204d6@arm.com> <20220425181407.lknemxqooz7yidcz@mercury.elektranox.org>
In-Reply-To: <20220425181407.lknemxqooz7yidcz@mercury.elektranox.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 25 Apr 2022 15:37:41 -0400
Message-ID: <CAMdYzYr4ZNDzLGn-ArT4dW+F5c598rsWpACNMpuJRMY7a0yb=A@mail.gmail.com>
Subject: Re: [PATCHv1 18/19] arm64: dts: rockchip: Add base DT for rk3588 SoC
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@lists.collabora.co.uk,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 2:14 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> Thanks for having a look.
>
> On Fri, Apr 22, 2022 at 07:16:13PM +0100, Robin Murphy wrote:
> > On 2022-04-22 18:09, Sebastian Reichel wrote:
> > > ...
> > > +           cpu_l0: cpu@0 {
> > > +                   device_type = "cpu";
> > > +                   compatible = "arm,cortex-a55";
> > > +                   reg = <0x0>;
> > > +                   enable-method = "psci";
> > > +                   capacity-dmips-mhz = <530>;
> > > +                   clocks = <&scmi_clk SCMI_CLK_CPUL>;
> > > +                   i-cache-size = <32768>;
> > > +                   i-cache-line-size = <64>;
> > > +                   i-cache-sets = <128>;
> > > +                   d-cache-size = <32768>;
> > > +                   d-cache-line-size = <64>;
> > > +                   d-cache-sets = <128>;
> > > +                   next-level-cache = <&l2_cache_l0>;
> > > +                   #cooling-cells = <2>;
> > > +                   dynamic-power-coefficient = <228>;
> > > +           };
> >
> > Is there any particular reason for not including more of the CPUs?
>
> Yes, see below.
>
> > > +           its: interrupt-controller@fe640000 {
> > > +                   compatible = "arm,gic-v3-its";
> > > +                   msi-controller;
> > > +                   #msi-cells = <1>;
> > > +                   reg = <0x0 0xfe640000 0x0 0x20000>;
> > > +           };
> > > +   };
> >
> > Does the ITS (and other bits related to GIC memory accesses) actually work,
> > or will we have more of the same issues as RK356x?
>
> The GIC in RK3588 is has the same shareability limitation as the RK356x,
> but fixed the 32bit limitation. That's why I just added the boot cpu core
> for now; adding any other cpu core breaks the boot without the downstream
> shareability patch and I'm still investigating.

There's no way to avoid this issue unfortunately.
See my awful hacked together patch:
https://gitlab.com/pine64-org/quartz-bsp/linux-next/-/commit/8b34fd2a74321f8f5d7731b63eee0f9e03d1393b

Considering the ITS exists pretty much just for MSIs, and my PCIe
series introduces support for legacy interrupts, you may get away with
doing the mbi-alias currently implemented in rk356x.
Note, there are *some* compatibility issues with mbi-alias MSIs,
particularly with high IRQ cards like the Intel x520.

>
> -- Sebastian
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
