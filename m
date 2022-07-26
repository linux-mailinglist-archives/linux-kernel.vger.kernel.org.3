Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BF580BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGZGz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGZGzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:55:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A79586;
        Mon, 25 Jul 2022 23:55:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ss3so24348194ejc.11;
        Mon, 25 Jul 2022 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=930q3AVQXe2SjvhskE2h093jn5RSLc/y4eCPbFMcgwM=;
        b=ekU92XlLSz/QGh8I7Bjn0ZGOhEcdbXO4Etm4Y/NM7hgCklk8sWS3gdHTFIr0u6VxzV
         Ti2nYfKCZBeJG5RIMb/VzaXtK2sjIpWpvSTCBSJgnoS4ZbtaWHUObMCeQI0xBGo6btpT
         MbP7llPi+K/oT7KdXC5vWShkn782FcWxGzTiZlgbKVUwWfWZj4Sw6QLzKBA+IfGqYr4a
         kBpPb8CovZ+MZSWlkeNWed0PAnlQ8iCcYpo+SB9TkZz+dhsyqP1r4C3tU7CDVXaHWcdk
         s0XEK0OwXwupkqEFIV9J5ulwoFnc4oY2+ZkIVAN2r+bawwHmBq2qkeXKqc4/fgyxCv4G
         Sn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=930q3AVQXe2SjvhskE2h093jn5RSLc/y4eCPbFMcgwM=;
        b=D9xD3su0dGAHljkLloIdCqT8trlfmiWJHHHEPIzAjcO6FSMyAM1Xk2PbBUlVUY9QSK
         XcPzzqAocFrV7+Qn8WaicQD7lbZMR/BKZH1Fr3tqXWJ97eT5o81tTgsUZW6xBK5Ezo72
         irbfqg10qqyz3l/fKgXGa1mDnCmPz2HCXLkUkWDn4C+e3NsXDs9W8d1PDTXEavUl0uBy
         yFB9o77WcFNWFkLcJ24qyLhkPJ5L89gz1H/fpfp44TroC8qt+WG6d/+B+OA7IU6hZAkf
         BNlkM7i7eNpKYeS9ubVXJbvTobKL4N0TokVQzBAv/1GjmGeL+ZP6mlwgRDW2Fn4zbfAS
         tK+w==
X-Gm-Message-State: AJIora9p2a8H60oTcg4K2gzMvEVvJalNnXATAazjFd9k4LiP+rBLNP6M
        Vk7I1sjl5j+KZMoEt1P4rTc4nrGLk2u+S8VdSEo=
X-Google-Smtp-Source: AGRyM1sApmuCde+BK/ozC9iYIpUHcgy151W8Z89r/tkh8MEbz3boKMRma1lkGDOq9cvYVQdSFwoSwNy1b3offj1r8dk=
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr13071249ejc.740.1658818522212; Mon, 25
 Jul 2022 23:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
 <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
 <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com> <CACRpkdYHgD-fmt_2PWJrmyGY=AOP0Z+4jTkH=n3wJ+a0aApqcg@mail.gmail.com>
In-Reply-To: <CACRpkdYHgD-fmt_2PWJrmyGY=AOP0Z+4jTkH=n3wJ+a0aApqcg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 08:54:45 +0200
Message-ID: <CAHp75Vf_aDSocdB7R6zKFwEOBRwq0w2m6GdCM-5ujKoz4bGiqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 26, 2022 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jul 25, 2022 at 10:49 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jul 25, 2022 at 3:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Mon, Jul 25, 2022 at 11:32 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Jul 21, 2022 at 11:32 AM Marcus Folkesson
> > > > <marcus.folkesson@gmail.com> wrote:
> >
> > ...
> >
> > > > Sorry for my absence of understanding, but why?
> > > > SPI has MOSI, CLK, CS, where the last one is exactly for that. No?
> > >
> > > Forgive me if I misunderstand, but if you use CS that
> > > way, the way that the SPI framework works is to assert
> > > CS then transfer a few chunks over SPI (MOSI/CLK)
> > > then de-assert CS.
> >
> > No, CS here is used exactly for what it is designed for ("tell that
> > this message is *for me*"). Yes, hardware implementation here is a
> > latch register. Because otherwise ALL messages are "for me" which is
> > wrong. Is it wrong interpretation of the hardware and SPI?
>
> I was under the impression that the shift register has no idea
> if the message is "for me", and that there can only be one shift register
> on the bus if using ordinary SPI to control it.

Yes and no. Yes, the shift register in this HW is always 'for all'.
No, there are as many shift registers as you have chip selects on the same bus.

> I look at this data sheet:
> https://www.farnell.com/datasheets/2030250.pdf
>
> IIUC what you say is CS == STR?

Yes.

> > > If CS is used for strobe, it is constantly asserted
> > > during transfer and the sequence will be latched
> > > out immediately as you write the SPI transfers and
> > > the data is clocked through the register, making the
> > > whole train of zeroes and ones flash across the
> > > output pins before they stabilize after the SPI
> > > transfer is finished.
> >
> > I'm not sure I understand the stabilization issue here. It's how SPI
> > normally works and we have a lot of delays here and there related to
> > the phase of the CS in comparison to clock and data. We have a lot of
> > time to stabilize the outputs of the shift register before latching
> > it. Did I miss anything?
>
> STR (strobe) is latching out the data, and how is that happening
> when you connect it to CS? CS is asserted throughout the whole
> transaction...

Is it a problem? I consider it exactly what it's designed for, it
tells the chip: "hey, there is something for you".

> STR is supposed to be used like in the patch: to be toggled after
> the transfer is complete. CS does not behave like this at all.

How is CS different in this sense? Just longer? Who cares that it
starts early and latches exactly at the time it must latch the data.

> > > If you first do the SPI transfer, then strobe after
> > > finished, this will not happen.
> >
> > I have hardware, I have tested it and I understand what you mean by
> > "stabilizing", but finishing transfer _is_ CS toggling for _this_
> > chip. No?
>
> Well it will work, because all values come out, however *during*
> the transfer, not *after* the transfer as intended with the
> STR signal.

No. I think you missed one little but crucial detail. The strobe is
edge, not level, while you consider CS as a level signal (only).

> > > Then it should be a separate pin, so this doesn't
> > > happen, right?
> >
> > I think no, you don't need it. I.o.w. either I'm missing something
> > very interesting about both this kind of chips and SPI basics (shame
> > on me in this case) or...?
>
> SPI will assert CS, then make the transfer i.e. toggle the clock
> a few times with new data on MOSI each clock cycle, then
> de-assert CS.

Right.

> STR is supposed to be toggled after all this happened to latch
> out the data to the outputs, just like the patch does.

So...

> What happens if STR is connected to CS is that you will see
> the shift register contents change on the output. It will be
> fast so it will look fine if it is e.g. a LED. But if it is something
> more sensitive, there will be chaos.

See Figure 7 and Table 9 in the datasheet you linked to. When STR is
low, the data is not changed. Maybe it's not clear in this datasheet,
I found somewhere
in a more clear table.

> At least how I see it ...?

If what you are saying is true, the hardware is totally broken and I
wouldn't use it. I.o.w. if the strobe passes all data when it's at low
level and latches at low-to-high, it's broken by definition in my
point of view.

-- 
With Best Regards,
Andy Shevchenko
