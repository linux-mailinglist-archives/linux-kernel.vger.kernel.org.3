Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957974FFD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiDMR4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiDMR4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:56:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5421238C;
        Wed, 13 Apr 2022 10:54:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bh17so5498949ejb.8;
        Wed, 13 Apr 2022 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=i2RJ6d/8BCF+jmN6yU2UbVKxMZnB1UcfgAmDeMXHyrY=;
        b=Nr+TvYGhvsu0zAmYKHlg7d+xkwdz+xwrtMU4Y4Pl5KJSBmTraEoZjNqtwKwgmyRhsm
         fNgbvGSSN41ADSF6G5rMmAS9GOdq54ZEwNr5BpHzicHLSJqV+NlhEumTIPfMqytbdUTY
         px1hRcvaXZliFOaJeALkZxxwUck4vlfLL9D/PnZUhXDpMKqt+GRDpF1P7vhNQeodyT15
         ixoZj5hGMlP5rY2798Bo02lOpumHgHRjzTQqZ39JzjV8I7XEn5Bf+kZaj/itIcN6tdZh
         zBJjk27KMRo3wDzzoYwh0NmfShdcCEqn7Bwr4hIw8cUP5S501Yxh/kutel5SVMicCUch
         IuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=i2RJ6d/8BCF+jmN6yU2UbVKxMZnB1UcfgAmDeMXHyrY=;
        b=5Cxj1ZhsuUS4pr/aT3tt+9laTe48fMkg8uNNQob1Vc+5OYAXnSfbVl68lhEUF3wGGP
         ItWZ3DhoM+3COg4GrBwxaWFx4cI6//VrRDgCfNKJ6r/YZDHGilNzssbIVJESEXPRDSLp
         8tbWgvgq+0XfTNoDsqYJBm1Ezc9TiW/hdlBznsz7/d0QCylFQiSL8QLw4fGXOiuxgfMA
         1+QOyHhhHquh7sThVAJtpDQqqgycEqAKbgv6xzzkNH9aIWBmVn7s+HNws6xghmTFkecz
         itYoVnDRYbdPmHZR/F63eL6zc21OfCsyF5+Lw4hF+COxd4IAo4G2ek6KUASz5a4QQB5m
         C7ug==
X-Gm-Message-State: AOAM532yVnVW8mQNwlPlM2AFREvKJioig6282pVkBBDsVbMQBEDwILld
        sVoGT0pJOigoHKtwkBaOCBA=
X-Google-Smtp-Source: ABdhPJyPE4vLRs3CuC3UtwYKUKXEMTbt7e2CpdF/ZDz7U9ASsekxlQE2QSRn6NqmPoNw0evi9K1jcg==
X-Received: by 2002:a17:907:1c0c:b0:6e0:9b15:29d5 with SMTP id nc12-20020a1709071c0c00b006e09b1529d5mr40538344ejc.416.1649872456728;
        Wed, 13 Apr 2022 10:54:16 -0700 (PDT)
Received: from Ansuel-xps. (host-80-182-176-248.retail.telecomitalia.it. [80.182.176.248])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm215308ejy.37.2022.04.13.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:54:16 -0700 (PDT)
Message-ID: <62570e48.1c69fb81.49fb8.143b@mx.google.com>
X-Google-Original-Message-ID: <YlcOR5+FbKSJ8/uU@Ansuel-xps.>
Date:   Wed, 13 Apr 2022 19:54:15 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-4-ansuelsmth@gmail.com>
 <20220325011037.03173C340EC@smtp.kernel.org>
 <Yj0XTYgoMScoiUHP@Ansuel-xps.localdomain>
 <20220325012231.899FBC340EC@smtp.kernel.org>
 <62570197.1c69fb81.c3de2.7b70@mx.google.com>
 <CAA8EJpp2uipTtV=gitiL0g-ywOirC=-UGrQ4tZMwc42jy2TK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp2uipTtV=gitiL0g-ywOirC=-UGrQ4tZMwc42jy2TK1Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:32:21PM +0300, Dmitry Baryshkov wrote:
> On Wed, 13 Apr 2022 at 20:00, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > On Thu, Mar 24, 2022 at 06:22:29PM -0700, Stephen Boyd wrote:
> > > Quoting Ansuel Smith (2022-03-24 18:13:49)
> > > > On Thu, Mar 24, 2022 at 06:10:35PM -0700, Stephen Boyd wrote:
> > > > > Quoting Ansuel Smith (2022-03-21 16:15:33)
> > > > > > PXO_SRC is currently defined in the gcc include and referenced in the
> > > > > > ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
> > > > > > panic if a driver starts to actually use it.
> > > > > >
> > > > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > > > ---
> > > > >
> > > > > What is this patch about? clk providers shouldn't be calling clk_get().
> > > > >
> > > >
> > > > If pxo is passed as a clock in dts and defined as a fixed clock, what
> > > > should be used?
> > >
> > > clk_parent_data
> >
> > Sorry but I'm not following you. No idea if you missed the cover letter
> > where i describe the problem with PXO_SRC.
> >
> > The problem here is that
> > - In DTS we have node that reference <&gcc PXO_SRC>
> > But
> > - gcc driver NEVER defined PXO_SRC
> > As
> > - PXO_SRC is actually pxo_board that should be defined as a fixed-clock
> >   in dts or is defined using qcom_cc_register_board_clk.
> >
> > So in theory we should just put in PXO_SRC the clk hw of the
> > fixed-clock. That is why I'm using clk_get(). I can use __clk_lookup()
> > as an alternative but I really can't find a way to get the clock defined
> > from DTS or qcom_cc_register_board_clk.
> >
> > (I have the same exact problem with the cpu qsb clock where is defined
> > using fixed-clock API but can also defined directly in DTS and I have to
> > use clk_get())
> >
> > I'm totally missing something so I would love some hint on how to solve
> > this.
> 
> When we were doing such conversion for other  platforms, we pointed
> clock consumers to the board clocks directly. There is no need to go
> through the gcc to fetch pxo.
> Instead you can use a <&pxo_board> in the dts directly. Typically the
> sequence is the following:
> - Minor cleanup of the clock-controller driver
> (ARRAY_SIZE(parent_data), removal of unused clock sources, unused enum
> entries, etc)
> - update drivers to use both .name and  .fw_name in replacement of
> parent_names. Use parent_hws where possible.
> - update dtsi to reference clocks using clocks/clock-names properties.
> Pass board/rpmh/rpm clocks directly to their consumers without
> bandaids in the gcc driver.
> - (optionally) after several major releases drop parent_data.name
> completely. I think we mostly skipped this, since it provides no gain.
> 
> This way you don't have to play around clk_get to return PXO_SRC from
> gcc clock-controller.
> 
> -- 
> With best wishes
> Dmitry

Thanks for the list of steps to do this kind of cleanup.
From what I'm reading this series is ""stuck"" in the sense that I first
have to fix the wrong PXO_SRC reference and then I can continue the
conversion work. A bit sad considering most of the time DTS proposal got
ignored :(

-- 
	Ansuel
