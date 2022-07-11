Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB165705C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiGKOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGKOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:38:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03765D7D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:38:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y22so2825046qki.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Blomt85uNlJFKRzFdDf6WPS4oNZcEoc+RW9ZvBV0BXg=;
        b=PBfGUiXs+SZ0whqRgpSkB35i7Kyk9ocwf5YAgyfirVzthaeICJgeKznJOPyJyBmG/R
         ZKtfM3reD7LONy8l0sJG9Np2HSqnyB1wjLvdUBeHJ9hlhz3I5aHVTfDX14oDd+U8cjJu
         EhK54M0hUX1HZ83JmtE8dJE2UXaly3crWcgprO11Im9awTY7mGV0qHi3/7N1zBbEqhMz
         k3uYfpHFmgQ+aT1NTchgWgMthV1cBsdX4G5s/absXbmSOLZUBlNWuvUL/eZfnF34d/6G
         NaytaRMtirJejZZXdje9HE2lZ3fLh2H9MSXQJR8YTOULbnZ/nbTx0I1f6b0Z1zpsPEsK
         3KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Blomt85uNlJFKRzFdDf6WPS4oNZcEoc+RW9ZvBV0BXg=;
        b=5V6PHZhHEVO/pbzl2428PCByZrLG5zCDy0Vzk4SxNJ9TttI4OfnlZUREBHnu/bmfmk
         jrF0HykW5FJkXpppGFo/6C6EWt+nO8LWCwICzpi9sANWxMlewZ75mNQIWqput2G5yYic
         2zqbTveoo1wiEcMqopEUh+m4RQWqvsPMJ/VLpgiYd1fw/siCAHqT5NS6iVYoVQ7YZiDw
         +1dyIJs8WeszQnrP23LUcZW8CQWfmKd3zung/042ctYpiwQug6TetfebufLKsVV1z+EX
         m6QI749/8gOUos3SSPqj6ayFgZRSljtak0w3ai0CsFmsNU0ea1ntUkJv0DJjqF2nMcIW
         QcFg==
X-Gm-Message-State: AJIora9oTkIQMxDK2kKN1IqY1337XFh56EyY0CQJtSIUMD+t5HXQqIjO
        qeu1tbqbTltD3afB0ogdKNUzpr7lGmL3BcvhEJZ+Eg==
X-Google-Smtp-Source: AGRyM1vdLvsBn8IiFeoJegAqtKMkOsN5CIRJpKTXMiY3nMKIb78gvTnAc6NmUCQKDRI0YFdwgeQ6h+bKM96WL/ueQ74=
X-Received: by 2002:a05:620a:288c:b0:6b3:9d1:dbf1 with SMTP id
 j12-20020a05620a288c00b006b309d1dbf1mr11330803qkp.593.1657550304850; Mon, 11
 Jul 2022 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220711104719.40939-1-robimarko@gmail.com> <20220711104719.40939-2-robimarko@gmail.com>
 <CAA8EJprfAW7kFSPxs7=LEHLmAVrWhV8KRbUseg8jXyiUbyZuRQ@mail.gmail.com> <CAOX2RU7+f3vXdOmMNi6Dt=9jadrgVFhrU56vm=6dYKkhnPUJwQ@mail.gmail.com>
In-Reply-To: <CAOX2RU7+f3vXdOmMNi6Dt=9jadrgVFhrU56vm=6dYKkhnPUJwQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Jul 2022 17:38:13 +0300
Message-ID: <CAA8EJpr8b+UxmCjuXVj+DMrvsHkgEk=ZKw8Ktj_vRT4oRZRutQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: qcom: apss-ipq6018: fix apcs_alias0_clk_src
To:     Robert Marko <robimarko@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 at 16:23, Robert Marko <robimarko@gmail.com> wrote:
>
> On Mon, 11 Jul 2022 at 14:48, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 11 Jul 2022 at 14:22, Robert Marko <robimarko@gmail.com> wrote:
> > >
> > > While working on IPQ8074 APSS driver it was discovered that IPQ6018 and
> > > IPQ8074 use almost the same PLL and APSS clocks, however APSS driver is
> > > currently broken.
> > >
> > > More precisely apcs_alias0_clk_src is broken, it was added as regmap_mux
> > > clock.
> > > However after debugging why it was always stuck at 800Mhz, it was figured
> > > out that its not regmap_mux compatible at all.
> > > It is a simple mux but it uses RCG2 register layout and control bits, so
> >
> > To utilize control bits, you probably should also use
>
> Hi,
> I am not really sure what you mean here?

Ugh, excuse me. Sent the message too early.
I mean that to utilize RCG2 control bits, you probably also need to
use clk_rcg2_is_enabled, etc.

>
> >
> > > utilize the new clk_rcg2_mux_closest_ops to correctly drive it while not
> > > having to provide a dummy frequency table.
> >
> > Could you please clarify this. Your new rcg2 ops seems to be literally
> > equivalent to the clk_regmap_mux_closest_ops provided the shift and
> > width are set correctly..
>
> Well, I have tried playing with the clk_regmap_mux_closest_ops but I
> just cannot get it
> to work.
>
> The width like you pointed out should be 8, register offset is
> currently pointing at the RCG control
> register and not the CFG one, so it obviously does not work.
>
> Setting the register to 0x54 and shift to 8 will just fail silently,
> leaving the shift at 7 and correcting
> the register won't work as RCG control bits are not utilized at all
> with regmap_mux and DIRTY_CFG
> is active when I manually look at the register.

Ok, I missed the update_cfg part. So, yes, this looks correct.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> So, I am really not sure how clk_regmap_mux_closest_ops are supposed
> to work here at all.
>
> Regards,
> Robert
> >
> > > While we are here, use ARRAY_SIZE for number of parents.
> > >
> > > Tested on IPQ6018-CP01-C1 reference board and multiple IPQ8074 boards.
> > >
> > > Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > ---
> > >  drivers/clk/qcom/apss-ipq6018.c | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> > > index d78ff2f310bf..be952d417ded 100644
> > > --- a/drivers/clk/qcom/apss-ipq6018.c
> > > +++ b/drivers/clk/qcom/apss-ipq6018.c
> > > @@ -16,7 +16,7 @@
> > >  #include "clk-regmap.h"
> > >  #include "clk-branch.h"
> > >  #include "clk-alpha-pll.h"
> > > -#include "clk-regmap-mux.h"
> > > +#include "clk-rcg.h"
> > >
> > >  enum {
> > >         P_XO,
> > > @@ -33,16 +33,15 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
> > >         { P_APSS_PLL_EARLY, 5 },
> > >  };
> > >
> > > -static struct clk_regmap_mux apcs_alias0_clk_src = {
> > > -       .reg = 0x0050,
> > > -       .width = 3,
> > > -       .shift = 7,
> >
> > Judging from rcg2 ops, .shift should be set to 8.
> >
> > > +static struct clk_rcg2 apcs_alias0_clk_src = {
> > > +       .cmd_rcgr = 0x0050,
> > > +       .hid_width = 5,
> > >         .parent_map = parents_apcs_alias0_clk_src_map,
> > >         .clkr.hw.init = &(struct clk_init_data){
> > >                 .name = "apcs_alias0_clk_src",
> > >                 .parent_data = parents_apcs_alias0_clk_src,
> > > -               .num_parents = 2,
> > > -               .ops = &clk_regmap_mux_closest_ops,
> > > +               .num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
> > > +               .ops = &clk_rcg2_mux_closest_ops,
> > >                 .flags = CLK_SET_RATE_PARENT,
> > >         },
> > >  };
> > > --
> > > 2.36.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
