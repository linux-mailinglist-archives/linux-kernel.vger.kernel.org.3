Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880284E53FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiCWOJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiCWOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:09:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54E7E093;
        Wed, 23 Mar 2022 07:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42F41B81F15;
        Wed, 23 Mar 2022 14:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6011C340E8;
        Wed, 23 Mar 2022 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648044452;
        bh=hlAK85GWeZIiZUtHyCOQqLWZSNib4RZQ9MjZfUdypAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ORlt45dCzEAqKCiG4WzfiALVPc4/rPqz8Lt8ifVDWSr1sQHEeZ5/k6ed6dMw22kZQ
         8galVZwXj5MrlxrCo2PCPuA3ON5HbA6t+t8jOeCIpC+1oCNa4KaGujmgGuNfP3hM+v
         eTQHVR5lBgGKyVcg+zMDVcB2A8m5racEdqsRTSXeTI7WC0yHG8l6lC/uaV9cKcjYIa
         Rg5mro4VesTqfuWp3DigW6kE3tYPs8V6JH4hH4V5CUR20V8XlB96omglM4LWJav+Cf
         mGaP391sWWHhkc3uZYjaeHwJEzeoY7cC9BGuBZtTDf4cEoIp4wpApnREAmGWbl9m1c
         7HpLxy71WoJXA==
Received: by mail-ed1-f42.google.com with SMTP id w25so1958095edi.11;
        Wed, 23 Mar 2022 07:07:32 -0700 (PDT)
X-Gm-Message-State: AOAM530Ob5e2KjkdXu8c+J8b7Z4Fxn/ODyAtNhGaQ3dkxyl2XnHF4y6y
        6+mPgWBxuz3wDGFAbgXJeUxgAKm/5aG1PRhZMA==
X-Google-Smtp-Source: ABdhPJyqtH2wi69wtxMlEd0gUrDvXtAAZhqIdFHRMCXO5QGIr2NlWJpS6ir6FtDZgjkTS4FM7uOdfb/mrEXFiRGWVdQ=
X-Received: by 2002:a05:6402:686:b0:418:edaa:9cbc with SMTP id
 f6-20020a056402068600b00418edaa9cbcmr247094edy.67.1648044451245; Wed, 23 Mar
 2022 07:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220301190400.1644150-1-robh@kernel.org> <CAMuHMdXqsvQy_6+6w8DVCtqNiFERPV29xd3HRqtyz9RY3KXOYw@mail.gmail.com>
 <CAL_JsqKX7XrSS1OktT6OfPgyxte6_+AcGh4uV0Abdf2Wi4eCFg@mail.gmail.com> <CAMuHMdXzNpjSjhT3crdN3XzcFNXd8Uojqo8gA7Y=Qtz8utH6Mw@mail.gmail.com>
In-Reply-To: <CAMuHMdXzNpjSjhT3crdN3XzcFNXd8Uojqo8gA7Y=Qtz8utH6Mw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Mar 2022 09:07:19 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=2oibXA1otjaVoGY0GWdLZg2bmw1C9BACga5P99X35A@mail.gmail.com>
Message-ID: <CAL_Jsq+=2oibXA1otjaVoGY0GWdLZg2bmw1C9BACga5P99X35A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas: Make example 'clocks' parsable
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 3:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Mar 4, 2022 at 2:28 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Mar 4, 2022 at 3:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Mar 1, 2022 at 8:04 PM Rob Herring <robh@kernel.org> wrote:
> > > > 'clocks' in the example is not parsable with the 0 phandle value
> > > > because the number of #clock-cells is unknown in the previous entry.
> > > > Solve this by adding the clock provider node. Only 'cpg_clocks' is
> > > > needed as the examples are built with fixups which can be used to
> > > > identify phandles.
> > > >
> > > > This is in preparation to support schema validation on .dtb files.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Thanks for your patch!
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Do you want me to queue this in renesas-clk-for-v5.19, or do you
> > > want to take it yourself, together with the validation patches?
> > > Please let me know.
> >
> > You can take it.
>
> Thanks, queuing in renesas-clk-for-v5.19.

This needs to go in 5.18, not 5.19.

Rob
