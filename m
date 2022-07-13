Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D989A5733E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiGMKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbiGMKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:11:29 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE3F5120;
        Wed, 13 Jul 2022 03:11:28 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31d7db3e6e5so76726947b3.11;
        Wed, 13 Jul 2022 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LeYTOcBl1KcyEE6qMBdpFz4IjR8g/mMkkjNEYXiBijo=;
        b=CkOtb1e2NkOoOWO4eC0nG3wf+Obj9M7KQ9soTjaH4E7lyMygR+8UZAHwmOOa8mhS+L
         Dy2QEMDHuZGZxtHB3x6ObvxWtG7ZLRC2ff/l15QkVhTFnpcbkJFmQVBhP8dQ7LBLLnzl
         LSPa7jP0sjnx1pPSMdr/RXGR8FeJkND3b6xb2KRqugd97MEZEBvvSLLwIUKbvsR1VrT7
         H0ilXOgfq2eWh4V+cYLFx1+4GOd6cuCKz2S+Vn8C/UzhdECAagZa/W/ihZw2KHw28qJl
         zQNtzOllOUZdyJSFniaXEO7p2fX8Jk1RS6MItQU06X7Trt6rQxCJr22mOmLIBsW/oiEv
         yFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeYTOcBl1KcyEE6qMBdpFz4IjR8g/mMkkjNEYXiBijo=;
        b=yQn99ULTmkqhpjBTtqGNuJM28WzJ/qcbYu5rDzYMoWSky1N4+k6nF2yqjQ0jSm0pAK
         c46j5r8pYLf0MWeP+Uqq/NPzqmRk+vZollgOv3p/XM3fvZFEiLPwOJ8fz6Q61YOLccMh
         cfifoi/IH54ir7LQtl9FqovOSAkfwCtazU6BuBGWjGaPtcgW3uxyblCG2IfPzrRbenSg
         tm+pcQwD43zEfC/FLgPG7CONwL+j26AogHI/k5J3WUX191hGB8AxDncii9sNudZW30m/
         l9Na050Ws3kw4xz2IQzrhwIV4ILGhvowxB/faANEP+SZ8/idEpSfCDUhUnZXRjw2VEhF
         hEBw==
X-Gm-Message-State: AJIora8/pG5bVLvfTOlgWFTqgHuzOl6PUErJbpkDwn7ApCWbrnCGS/5F
        xO/w9RbiyPNEy06tZ90GGpN72khXX2Kln4N4Pkc=
X-Google-Smtp-Source: AGRyM1tiwaD7QXnaWfuhjINBDlyp9zcw8kySfLWr85n4tJa6KapoZYXptI+ThUyz2fxegNJ6o8OvE8qMXqQIqHCA6ug=
X-Received: by 2002:a81:72c4:0:b0:31c:b309:c4e8 with SMTP id
 n187-20020a8172c4000000b0031cb309c4e8mr3281222ywc.520.1657707087635; Wed, 13
 Jul 2022 03:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657216200.git.william.gray@linaro.org> <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
 <CACRpkdZn-PV6H+uBcoONt=SThGBAODy-YG=rkx5OX-rcpeE+aw@mail.gmail.com>
 <YszlP1+sBhxvz3Fo@fedora> <CAMRc=Mc0=nL_t9Fwmb1uNbsa_v4L4M5BJm2y-vZ8PV47Ryk+Sw@mail.gmail.com>
In-Reply-To: <CAMRc=Mc0=nL_t9Fwmb1uNbsa_v4L4M5BJm2y-vZ8PV47Ryk+Sw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 12:10:51 +0200
Message-ID: <CAHp75Vd5QThEE9S+iL0e3rG+FHoPdts082R4H_beMv990ouGzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
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

On Wed, Jul 13, 2022 at 9:40 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Tue, Jul 12, 2022 at 5:06 AM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> > On Mon, Jul 11, 2022 at 03:02:10PM +0200, Linus Walleij wrote:

...

> > I think I'll move this to gpio/driver.h as per Andy Shevchenko's
>
> I don't think this is what Andy meant. I think he suggested moving
> this header into drivers/gpio/ because it doesn't make sense for it to
> be publicly accessible for anyone else than the GPIO drivers.
>
> Andy: correct me if I'm wrong.

No, you are right. I was talking about localizing the header to drivers/gpio.

-- 
With Best Regards,
Andy Shevchenko
