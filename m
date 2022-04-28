Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143375139B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349972AbiD1Q2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiD1Q2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:28:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B76D6C969
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:24:45 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f7b815ac06so59008917b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npUWFjZqoyfWgZt2xCkox9pqkZNjyzUk3a/rUuplAd4=;
        b=PuRWaDVuZC8SE2QM0VlAapuk/C1PkVBg/6AcdVUbhyVjCOQRKyT7QpJni6tVQb8o1X
         QDyXRcNpCl7tel+MmxUHBM0mI1ILYsPWCok3vOdzZWshm3fSMvP+ncKCbpaaUuZbp08m
         HHhDvy7RgfDN1dfSeefAjzQAFYJo+nOMqn6M0h6etxW9LXygPTVlNnEjd5rBgtVeaqbk
         iNaQcgh1NuojlC2pndctgEtSj0lorQHmY9Ul5rH2aNjjoAtzWxAhC88uXbImlP5fsA02
         Uh7j5qG/7E39c8mbjJYn/wIEGHejQloySjoB3rhK5kADHzTgbcv3j15GNpQqP260J5C2
         ohdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npUWFjZqoyfWgZt2xCkox9pqkZNjyzUk3a/rUuplAd4=;
        b=bZfuCmIpD6UY3HLBfHHVogI2emwmC1GsAKgyqopkbarkfYY9WlVqxDhNOtTDNA+or/
         AwRH2au/J/WlT0Y6qCIS6CU8fAdlBe0gWt10mMPoreD1rGS19Hb/f4ksqoJrz6Kr6Iz6
         i9sQyKzOaAMp4P5NznaOaPiAt2laCXmDuD1XitSe8SnNFw0QHUA7gzxAgsVcme60j16X
         ni7fGijzITzi97kYduOqDyCJyBlhNlzpwkR+rPAYMKByKjIjXjkKkmth/EUNXnvK/8J5
         ufweje2ie7rwXPro8sfXQQLjkIjEUIJ9VHFJ8tBBqlDAaD8r6epAyr4kwbljPD5WxWVR
         waBg==
X-Gm-Message-State: AOAM532AyYLbasfldKD87zW/Qkv680uix1sYqm73GhgZ0nK5SAtzCFzn
        7WB1qZHjb0dg3FjXXKHnzo/UsJV8WtTaOaCFce/jSQ==
X-Google-Smtp-Source: ABdhPJyUeOR16pP4IRbKe+31+w85vEDUq+38KGFLCPseR8T9vSCpitc2vOc6krsEjiXCJb4kdHhiOrYn3Csw0ZcJu1c=
X-Received: by 2002:a81:5603:0:b0:2f8:3187:f37a with SMTP id
 k3-20020a815603000000b002f83187f37amr12280902ywb.255.1651163084251; Thu, 28
 Apr 2022 09:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org>
 <20220423014824.912ACC385A0@smtp.kernel.org> <YmNsYSxLtwLpw98t@ripper>
 <20220423031350.01299C385A0@smtp.kernel.org> <YmN11qt/PqogYruQ@ripper>
 <20220425223426.BE973C385A4@smtp.kernel.org> <3fb043e6-2748-24f8-0115-b5372c747a12@linaro.org>
 <Ymq6UOjrYgFlzl/W@ripper>
In-Reply-To: <Ymq6UOjrYgFlzl/W@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Apr 2022 19:24:32 +0300
Message-ID: <CAA8EJpqBMzTNjTSWN1UMXM61-DmW22RKQJyWoMw3Rds=xEVQaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 at 18:59, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 28 Apr 08:44 PDT 2022, Dmitry Baryshkov wrote:
>
> > On 26/04/2022 01:34, Stephen Boyd wrote:
> > > Quoting Bjorn Andersson (2022-04-22 20:43:18)
> > > > On Fri 22 Apr 20:13 PDT 2022, Stephen Boyd wrote:
> > > > >
> > > > > I'd really rather not have clock-names at all because we spend a bunch
> > > > > of time comparing strings with them when we could just as easily use
> > > > > a number.
> > > >
> > > > I know that you would like to get rid of the clock-names for the clock
> > > > controllers. I've looked at it since and while it will be faster to
> > > > execute I still feel that it's going to be harder to write and maintain.
> > > >
> > > > E.g. look at gcc_pcie_4_pipe_clk_src, its parents today are
> > > > pcie_4_pipe_clk and bi_tcxo. Something I can reason about being correct
> > > > or not.
> > > >
> > > > If we ditch the clock-names I will have:
> > > >
> > > > static const struct clk_parent_data gcc_parent_data_14[] = {
> > > >          { .index = 30 },
> > > >          { .index = 0 },
> > >
> > > Those numbers could have some #define.
> > >
> > >     { .index = PCIE_4_PIPE_CLK_DT }
> > >     { .index = BI_TCXO_DT }
> > >
> > > > };
> > > >
> > > > Generally we would perhaps use some compile time constant, but that
> > > > won't work here because we're talking about the index in the clocks
> > > > array in the yaml.
> > > >
> > > >
> > > > But perhaps I'm missing something that would make this manageable?
> > >
> > > I dunno. Maybe a macro in the dt-binding header could be used to specify
> > > the 'clocks' property of the DT node that is providing the other side?
> > > The idea is to make a bunch of macros that insert the arguments of the
> > > macro in the right place for the clocks property and then define the
> > > order of arguments otherwise. It would be similar to how
> > > CREATE_TRACE_POINTS is used in include/trace/define_trace.h
> > >
> > > In the dt-bindings/qcom,gcc-soc.h file:
> > >
> > >     #ifdef IN_DTSI
> > >
> > >     #undef GCC_DT_NODE_CLOCKS
> > >     #define GCC_DT_NODE_CLOCKS
> > >             clocks = <BI_TCXO_DT>,
> > >                      <SLEEP_CLK_DT>;
> > >
> > >     #endif /* IN_DTSI */
> > >
> > >     #define BI_TCXO_DT 0
> > >     #define SLEEP_CLK_DT 1
>
> BI_TCXO_DT is not the value, its the index of the entry in the clocks
> array. And the actual values of the clock controller's clocks
> property is not a property of the clock controller, but the system
> definition.
>
> I.e. that should be clear and explicitly expressed in the dts.
>
> >
> > Isn't this being an overkill, to define exact properties in the bindings
> > header? Also this would mean that we'd have to add dt-binding headers for
> > all _consumers_ of clocks. And to make things more complex, e.g. for PCIe
> > devices different instances of the device would use different amount of
> > clocks. This would mean that we'd have to define SM8250_PCI0_CLOCKS,
> > SM8250_PCIE1_CLOCKS and SM8250_PCIE2_CLOCKS.
> >
> >
> > If we were to switch to this fragile path of using indices (yes I consider
> > it to be very fragile), I'd consider something like the following to work in
> > the platform dtsi file:
> >
> > clocks =
> > BEGIN_CLOCK
> > CLOCK(BI_TCXO_DT, &bi_tcxo)
> > CLOCK(SLEEP_CLK_DT, &sleep_clk)
> > END_CLOCK;
> >
> > While the following should give an error:
> > clocks =
> > BEGIN_CLOCK
> > CLOCK(SLEEP_CLK_DT, &sleep_clk)
> > CLOCK(BI_TCXO_DT, &bi_tcxo)
> > END_CLOCK;
> >
> > I think we can make this error out by using some additional tool (or
> > additional preprocessor pass over the sources)
> >
>
> Let's not invent some magical syntax for describing the clocks in the
> DT.
>
> These macros can't expand to sparse arrays anyways, so iiuc this would
> give a sense that the ordering might not be significant, when it really
> is.
>
> > > And then in the SoC.dtsi file have
> > >
> > >     #define IN_DTSI
> > >     #include <dt-bindings/qcom,gcc-soc.h>
> > >
> > >     #define BI_TCXO_DT      &xo_board
> > >     #define SLEEP_CLK_DT    &sleep_clk
> > >
> > >     ...
> > >
> > >     clock-controller@a000000 {
> > >             compatible = "qcom,gcc-soc";
> > >             reg = <0xa000000 0x10000>;
> > >             GCC_DT_NODE_CLOCKS
> > >     };
> > >
> > >
> > > and then in drivers/clk/qcom/gcc-soc.c file:
> > >
> > >     #include <dt-bindings/qcom,gcc-soc.h>
> > >
> > >     static const struct clk_parent_data gcc_parent_data_14[] = {
> > >             { .index = PCIE_4_PIPE_CLK_DT },
> > >             { .index = BI_TCXO_DT },
> > >     };
> > >
> > > The benefit I see to this is that the index for each clock is in the
> > > header file (BI_TCXO_DT is 0) and it's next to the clocks property.
> > > Someone could still mess up the index based on where the macro is used
> > > in the clocks property though.
> >
> > And actually might I suggest an alternative approach to manually using
> > indices everywhere? What about spending the time once during the boot to
> > convert .fw_name and clock_names to parent indices during clock registration
> > and then using them for all the further operations?
> >
>
> I'm pretty sure that's what clk_core_fill_parent_index() already does.

In this case I think we should go for clock-name in the DT and
auto-flled indices inside. Stephen, WDYT? Would that fix your concern
for comparing strings each and every time?


-- 
With best wishes
Dmitry
