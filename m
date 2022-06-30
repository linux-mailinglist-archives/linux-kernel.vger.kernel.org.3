Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185D2561416
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiF3IDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiF3ICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:02:48 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066534132A;
        Thu, 30 Jun 2022 01:02:46 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31772f8495fso171102057b3.4;
        Thu, 30 Jun 2022 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wryy9746UaaGxV4FOLo7kKFh4EpIsQh9KMPdBAHP8Z0=;
        b=EuqGaFPUEjQeNovEFyIsPzEevrE/MyEERD8z6GV/KX+v8SZLmmoKF99fCL1Tc8OzSY
         NCI8GtLKjbJhst1BQ6klzruatF3NI38f7A6HoGL7U+aWkhSBVBxR0X4MKJtlOcjKAB/C
         9H2peAEDN1eDhy5ic1slnnIeJ1yGD+KQNOb3Tzsjb4ZcgldL5HgG6AihQI9wJFIvWk90
         8xZKVPnqaskPj90bptVjhmIYZogXpMUTlun/wSR/YCGfhC3Tc0vzlk1ORBe9bkapGc8p
         tv3gsDFh8bHhGp+WWkt5GDJNkzLknsdlxPQgJnz7NyRWQL5I+tosJSI1lRcgoHqNOdBX
         JdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wryy9746UaaGxV4FOLo7kKFh4EpIsQh9KMPdBAHP8Z0=;
        b=oGDXxXLctprrQ8uQWYaeFKCLIDFM/5Wh1cSXj85pG61olCb36FYQex8nLAhAFQLrTG
         ZrSQaYpDIgMxDcPPn1nHpR81h013Gixi3Xg/l6OxTDHEuFJET9X+Fbmsd6cL6fOng6GM
         jQLo2JyQkr8SWe+3kbLOfiv1SrfjTfV3NT3+9zAN6DFVgApi5i1Mle2LeAyumqkS6V2V
         GnNmV0BZEbYlLBcJVAyuOvrFwdrDjeJ3bc+Sg92WUgpnnBEFqpqoEEuwanLLWvUb4XoU
         NbUOQ9fTz8WGEH7Gt90WzSgIDAtOnFi+PSMn2iC3LSE1mEso2QoPaVckQKiBYjo8wOx2
         R3Gg==
X-Gm-Message-State: AJIora+FoLhJ2GuBJ/YYFavO3E68/VmsGvBV9b6Gfqow3w53jPSBleCI
        CPL79Y8X9L56w2cDmIJzcW2bidieMXet2A7hm5c=
X-Google-Smtp-Source: AGRyM1tQjxmbD422jLcHIB0ewRpbtEaFVyHc3AuXiZDShY6jeHf515TJp/d6+dz8eUSii25nd5yw8hg9NywapvMWtu0=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr8832602ywj.195.1656576165059; Thu, 30
 Jun 2022 01:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vc=PWXauEKDNX+vmqv=oO1LDv8-GgU3OFZXjf8yJrG8wA@mail.gmail.com>
 <CAHp75VeqvCnWtWLF1zySPGkfBT5obosu0h_pZEhz+pOQWzMdWQ@mail.gmail.com> <Yr1W/m6UV3792GvF@google.com>
In-Reply-To: <Yr1W/m6UV3792GvF@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 10:02:08 +0200
Message-ID: <CAHp75VdC=Dw_YnTuzZ+PMLfr0y1NcH2DQ1bRccU8e=cGLWznuQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for AXP192 PMIC
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 9:55 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
> > On Wed, Jun 29, 2022 at 11:14 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Jun 29, 2022 at 4:29 PM Aidan MacDonald
> > > <aidanmacdonald.0x0@gmail.com> wrote:
> > > >
> > > > Changes in v4:
> > > >
> > > > * Drop regmap-irq patches and rebase on top of the regmap-irq
> > > >   refactoring series[1], which implements the same functionality.
> > > > * Reorder mfd_cells, putting one-line entries at the bottom.
> > > > * Fix incorrect example in axp192-gpio device tree bindings.
> > > > * Perform adc_en2 flag -> adc_en2_mask conversion in axp20x_adc
> > > >   as a separate patch.
> > > > * Simplify axp192_usb_power_set_current_max().
> > > > * Drop unneeded OF dependency in pin control driver, and document
> > > >   tables used for describing register layouts.
> > > > * Various style fixups suggested by Andy Shevchenko.
> > >
> > > For patches 6-11
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Ditto for patches 13-15.
>
> Not sure `b4` will pick these up!

No it won't. But it's not an issue, one may use `git msg-filter` for
that, esp. taking into account that series most likely will be resent
due to patch 12 (`but not fully sure it will be the case).

For your convenience I have added on per patch basis.

-- 
With Best Regards,
Andy Shevchenko
