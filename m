Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66A53C8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbiFCKgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243752AbiFCKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:36:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E543BBEB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:36:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g4so12947276ybf.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zcr1s3ugeaE9p3nhhIdLCJU637n5hOiY3Yql49RPVHo=;
        b=ye/c5xFuBegN//8byZFYsM0JGxi8XQHnnDnHJeYnWzmaLAMnLWaHpwPsEEIQyArNM/
         ZX0sQvd/mDqx6tD04xoDIhL56ZDeSUb2IFYUHoOKgSELMqm2r9pcYwtrD3iUOHJnr0G9
         n7qDswsdpTzoEu/flnrb3i0fVFDffGF6DTu9+LUv7SP9ubaFb4IYPEnzKzFje6oKe5kn
         7pKtw7w5bSV9NRkDXhCt/VTPix+fKXvec1UvSegzCDQM04VpaaI9Lu4vyHjUMpKSVHUP
         p6IVaoHnf6gbbSgmeUFdbgdJVQdZ+ry3Lm+TZYMtdFL9N6iimJj9Exv5nuWXa6uzvfir
         1f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zcr1s3ugeaE9p3nhhIdLCJU637n5hOiY3Yql49RPVHo=;
        b=yUw/JKOvDQtp163E0s9Cw5DTsN8OGBlDgY2s47knPGSKvEBojMDaum67Wyve2J5CqU
         pAfAhelzy/f0H8c/dP5Klt50SU8OewSJk6L4Y9DBvWJ68nQMUrhZu9TZwXipbY4PqFPF
         ONWGZy7JZ64XYx+l72lISFLgHgPZBc6Y0Ak0x3dnRHrWaVKneepYggrA1uBQ42Uabf7N
         sAFdWZyddLVGXIFGYA1Ac6naECQggHz3O4CMn4u3+rn1POuxT07xPa41bJ/rXGsG44eq
         AxPbNaiczAfMb7VJvfrZBECZ/4LZwdFWkjbF3teBaWSWhBO7TOedyHS9LjQtL3W4ja02
         p6pQ==
X-Gm-Message-State: AOAM532+nQeGGkjb/9ElDNuLTf0wx/WbmIgcNWWDB0Q+NLyvM+34gdnq
        O2MzIber6s9yQb8j9M7KqitEWG78XD5mLZUwooMO3A==
X-Google-Smtp-Source: ABdhPJxl+08Zn/lYdSINCrN0AMJJoC21Ex/5MKiRcxgoQhyNTV2ssDVGcuudIFlulouWleLEtWVvAyJyT1x9WmwmgUk=
X-Received: by 2002:a25:df50:0:b0:65c:e053:3449 with SMTP id
 w77-20020a25df50000000b0065ce0533449mr10779582ybg.291.1654252568890; Fri, 03
 Jun 2022 03:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220427144620.9105-1-pmalgujar@marvell.com> <20220427144620.9105-3-pmalgujar@marvell.com>
 <CACRpkdaqeTs-jHPBmtdiz+LdMM0pz0zqt4diX=e+YpgaGr0Jbw@mail.gmail.com> <20220603090618.GA27121@Dell2s-9>
In-Reply-To: <20220603090618.GA27121@Dell2s-9>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Jun 2022 12:35:57 +0200
Message-ID: <CACRpkdaOd0-k_mt0ZrKT-DbVc3f0b5uXXmXpBNH=hq3BGCB+vQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: gpio: gpio-thunderx: Describe pin-cfg option
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rric@kernel.org,
        cchavva@marvell.com, wsadowski@marvell.com
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

On Fri, Jun 3, 2022 at 11:06 AM Piyush Malgujar <pmalgujar@marvell.com> wrote:

> The purpose of this pin-cfg entry is different than the standard GPIO pin config usage.
> It is to write a value to GPIO_BIT_CFG register which is used to configure fields like
> pin function, selecting which signal is reported to GPIO output or which signal GPIO
> input need to connect, filters, XOR and output mode.

Then implement pin control for this driver instead of inventing a custom hack?
https://docs.kernel.org/driver-api/pin-control.html

Several drivers implement pin control with a GPIO front-end, for example:
drivers/gpio/gpio-pl061.c is used as a front end with
drivers/pinctrl/pinctrl-single.c

There are also composite drivers in drivers/pinctrl that implement both
pincontrol (incl muxing) and GPIO, such as drivers/pinctrl/pinctrl-sx150x.c

Yours,
Linus Walleij
