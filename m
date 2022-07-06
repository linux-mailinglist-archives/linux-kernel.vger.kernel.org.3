Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D002C568571
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiGFKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiGFKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:23:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE26248E2;
        Wed,  6 Jul 2022 03:23:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lg18so6489634ejb.0;
        Wed, 06 Jul 2022 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=A9xeNdZDUIjr4l2jLGqq1SJhUmTfqKYqMsJa/JfV6ag=;
        b=MGaI+JsM9XJwL7VpB7yT/Oaz4A474xJtZQz5NEzLu+9WfWoK4TQlRBDHRfW8qbKSdc
         GA7/T3yW7vazdXBIpLnKhiU0pLqxuWc8lpHotv9baCvj5Bgwt1WsU5jweCEm25CzchXl
         2XE6d1IQsFAjT/8LuxxYSv8PrgMyAzlhBDiOPjsIeeegZfLwxBsvZ5DW2WY5on1snlSq
         LxuSxGOA+TYtKNPD9Dt85W+gKmwIHQw7ct/NT769ISTPlqF6uNhD8M/DXujRgIABePDr
         VFiq5fXuGBvud8h4T0442F3t94nsT5PcCZ/l0kObS9cNukhRS5yC4tsaft7aqTUg1j1k
         CWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=A9xeNdZDUIjr4l2jLGqq1SJhUmTfqKYqMsJa/JfV6ag=;
        b=Ee5hj6VDaM0SOqExC6k7vcVSvgI8KQIwsqBbBM4CPXly9y/oCe6DDn2tLuFo2/cMpd
         z9oUGkAmqEGTZbCEma+8/SqVZZ3vtJG8lUOaB0ZCnH6/arhtT+0gssAHhBE3d1gELBOp
         PlHOSlR8NX9Jo3GvJXcErDQnKgI6CfHyZu7ioGo5dOvyJtMFPevMVXah8aXpG5BOIj8v
         AryU/4VFlOQMyhqhI+eaMvctaPBIf4b0V5OwQfBeBPbKezJKBWzWHMrr5AkEaxifGz0r
         JIIsAvHygMsi0NKtA0G9QzEIKg9/vqPXv1iho+YINEPwlhiYzErFPMxh8KDtlhrmhfF8
         i5Ag==
X-Gm-Message-State: AJIora+CnENvccohGFJTtwo1oQ6Nx5TI+9tGQCaOKDFoxRCH4cUHAEPl
        RRZL36mm7Tzq4PC1OStUbGk=
X-Google-Smtp-Source: AGRyM1vG14ChU514xvqFxRVaxYHsajgsNZGdG9Vwh2mJxfoeSO8ko8QGjp0eczHjU6mfpOj75LWtXg==
X-Received: by 2002:a17:907:16a6:b0:726:574d:d31f with SMTP id hc38-20020a17090716a600b00726574dd31fmr37626967ejc.514.1657103029693;
        Wed, 06 Jul 2022 03:23:49 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id p17-20020a056402501100b0043787ad7cfasm20919288eda.22.2022.07.06.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:23:49 -0700 (PDT)
Message-ID: <62c562b5.1c69fb81.d69fc.4079@mx.google.com>
X-Google-Original-Message-ID: <YsVe0Pu4FooN5XYt@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:07:12 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clk: qcom: lcc-ipq806x: convert to parent data
References: <20220621163326.16858-1-ansuelsmth@gmail.com>
 <20220621163326.16858-3-ansuelsmth@gmail.com>
 <CAA8EJpqQTTevQa4pQg3E+x4_AOjYo8ajOqUrfwGsVtC8N=bpOw@mail.gmail.com>
 <62b228b6.1c69fb81.e4673.34a2@mx.google.com>
 <CAA8EJprb=xV9+gZMANAYrt_JnKAtC89h1RAosL+g517_-Ugd2g@mail.gmail.com>
 <62c4a38b.1c69fb81.4d58e.ce99@mx.google.com>
 <CAA8EJprGf6V9K1gFDCE+bnKwhjVgLvruTRAZ-AOqfPsbmmYRLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprGf6V9K1gFDCE+bnKwhjVgLvruTRAZ-AOqfPsbmmYRLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:34:04AM +0300, Dmitry Baryshkov wrote:
> On Tue, 5 Jul 2022 at 23:48, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 11:43:10PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 21 Jun 2022 at 23:23, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > On Tue, Jun 21, 2022 at 08:15:57PM +0300, Dmitry Baryshkov wrote:
> > > > > On Tue, 21 Jun 2022 at 19:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > >
> > > > > > Convert lcc-ipq806x driver to parent_data API.
> > > > > >
> > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > ---
> > > > > > v2:
> > > > > > - Fix Sob tag
> > > > > >
> > > > > >  drivers/clk/qcom/lcc-ipq806x.c | 79 +++++++++++++++++++---------------
> > > > > >  1 file changed, 44 insertions(+), 35 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> > > > > > index ba90bebba597..c07ca8dc6e3a 100644
> > > > > > --- a/drivers/clk/qcom/lcc-ipq806x.c
> > > > > > +++ b/drivers/clk/qcom/lcc-ipq806x.c
> > > > > > @@ -24,6 +24,10 @@
> > > > > >  #include "clk-regmap-mux.h"
> > > > > >  #include "reset.h"
> > > > > >
> > > > > > +static const struct clk_parent_data gcc_pxo[] = {
> > > > > > +       { .fw_name = "pxo", .name = "pxo" },
> > > > >
> > > > > I think you'd use .name = "pxo_board" here. You don't need to use the
> > > > > interim clock.
> > > > >
> > > >
> > > > In gcc and in the rest of this driver we use pxo. Wonder what is right?
> > >
> > > I'd use .fw_name = "pxo", .name = "pxo_board", like the rest of drivers do.
> > >
> >
> > Will do the change, but I need an explaination... Is the use of
> > pxo_board correct?
> >
> > I'm sending a patch that sets the pxo_board fixed clock in dts to output
> > "pxo". The only clock that still use pxo_board is rpm, everything else
> > at least for ipq806x use pxo and i'm sending a patch to use pxo for rpm.
> >
> > Considering pxo is always present and pxo_board should be dropped
> > because every ipq806x driver use "pxo".
> >
> > What is correct naming pxo or pxo_board? I assume pxo right?
> 
> This might be not the case for the ipq806x, but here is the story for
> all other (old) platforms:
> - gcc driver manually registered pxo/cxo/xo fixed factor clocks.
> - Then we started adding *xo_board clocks to the DT, as they represent
> the external oscillators
> -  PXO clock consumers receive a clocks entry with clock-names = "pxo"
> which points to the pxo_board
> - All clock drivers are now being switched to use .fw_name = "pxo",
> .name = "pxo_board" to use the DT-defined pxo_board clock.
> 
> Hopefully at some point we can then drop the manually registered pxo
> clock and always use the DT-based one.
>

Okok. I got confused since looking at the code factor clock is really
just a hack to handle both driver that use pxo_board and pxo cause from
what I notice it's the same clock with different naming.

Sooo keep using pxo_board with the fact that pxo is always present seems
to be redundant but if that's the pattern then I will just keep
pxo_board in .name where it's used.

> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
