Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299A5805F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiGYUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiGYUtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:49:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C191EEDB;
        Mon, 25 Jul 2022 13:49:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z23so22483513eju.8;
        Mon, 25 Jul 2022 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1sQSHwWsz6Sfwn/nw5m5qGb/V8KmFsQdNiXy1s2J4A=;
        b=W6LQBYpYc9r0gZTP+KjajSNtzgYjp0/W2wVeAlBo5qX18C2YIIAN+mkPZ2k25X0vQH
         D5oLTPfisi9KkMr8vadRjvyneg4i1dl+sz7DXPqL0XaCuJk30rxo0H2aSea12gZy/4NR
         IOJDxxSOzPwbkNiiCyLrjbHPhdhxQDq5E4kYKJLWVsd0aeAazrt0fOtbC4jQmTtdp3Qm
         PYqpSLmGcz6URRVp1+olPkUVxFc4CtH47lxnyL6bUnnvBdD5M21q+kZI+2GEmZIC4Z59
         4SicQIcK9zBuo6xVm/SHK9rNDeKI2Y7aiKF6PD38NwOEBeujYYYXEU72gHfrhP0UvkkA
         yK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1sQSHwWsz6Sfwn/nw5m5qGb/V8KmFsQdNiXy1s2J4A=;
        b=QXXGQTe/LXvHnK7ykNcvJfASj7iZz1jZh2m49Z06JXS3zojB3+fUYVXL7RN+k2GMe8
         ZGnCwlz8lRxJ0OdLUatWRNk0AUvFgMBEYs0Nj/dT4AdjQmnRXWFRnx7/oYMDpcJGcxZH
         WX+7y/8Qsbg0zmdeom/DkAtr8GUeHQ5oGzR5wmxUbv3k0s55L5BVM9dcDLvf/WpOzQYF
         N7LIXFVDlVIlnl+qZy0NNkmqHtEK+UU5Z0sD5seslMugRSufiw18mbAPuu58lRaocLFz
         sz4prN/DAroxpDvP3xlje515OXQr3HYDeJoZ0W1MkgUHC06XdzYCzzIBXB1PElc0DzRK
         1VvQ==
X-Gm-Message-State: AJIora/Ha4Pph7LpX9DoOKUWAQVAfA6149NONXY27GRTLvA1UV8M0/Cz
        vPUOgTKAOunzkQ/zeXQYIplxutMYfoR5b7CLWH0CSLs2dcU=
X-Google-Smtp-Source: AGRyM1v8uNsvvjdJ96eRk3dnw3sMBVwfFmLN8sslNZ3kPcNgk3WfNeienkmUBExxzF5QOMHyQ0VLaHIXE+p+WboqWSw=
X-Received: by 2002:a17:906:9b09:b0:72b:9612:d373 with SMTP id
 eo9-20020a1709069b0900b0072b9612d373mr11208248ejc.606.1658782139887; Mon, 25
 Jul 2022 13:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com> <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
In-Reply-To: <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 22:48:23 +0200
Message-ID: <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com>
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

On Mon, Jul 25, 2022 at 3:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 25, 2022 at 11:32 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jul 21, 2022 at 11:32 AM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:

...

> > Sorry for my absence of understanding, but why?
> > SPI has MOSI, CLK, CS, where the last one is exactly for that. No?
>
> Forgive me if I misunderstand, but if you use CS that
> way, the way that the SPI framework works is to assert
> CS then transfer a few chunks over SPI (MOSI/CLK)
> then de-assert CS.

No, CS here is used exactly for what it is designed for ("tell that
this message is *for me*"). Yes, hardware implementation here is a
latch register. Because otherwise ALL messages are "for me" which is
wrong. Is it wrong interpretation of the hardware and SPI?

> If CS is used for strobe, it is constantly asserted
> during transfer and the sequence will be latched
> out immediately as you write the SPI transfers and
> the data is clocked through the register, making the
> whole train of zeroes and ones flash across the
> output pins before they stabilize after the SPI
> transfer is finished.

I'm not sure I understand the stabilization issue here. It's how SPI
normally works and we have a lot of delays here and there related to
the phase of the CS in comparison to clock and data. We have a lot of
time to stabilize the outputs of the shift register before latching
it. Did I miss anything?


> If you first do the SPI transfer, then strobe after
> finished, this will not happen.

I have hardware, I have tested it and I understand what you mean by
"stabilizing", but finishing transfer _is_ CS toggling for _this_
chip. No?

> Then it should be a separate pin, so this doesn't
> happen, right?

I think no, you don't need it. I.o.w. either I'm missing something
very interesting about both this kind of chips and SPI basics (shame
on me in this case) or...?


-- 
With Best Regards,
Andy Shevchenko
