Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48BD5A20E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245016AbiHZGc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiHZGc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:32:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FBD11CF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:32:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d8so816786lfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+qU9ctcrY7mtJ7WOAIohkf0A848XGp2YRevCX8i4gts=;
        b=C7HaYeqFpX0lS9ll1R6ZCwBkm8QpDYZfuNWeuq8t0XEvQUmiGWlAwZ92EXwJeoD4J+
         HhrTOmbUp2lx/PBx34u5s9RtG5xGwYCqitwzWsE9tNWsKG4h4D9o4WCojuyM8IRP0AvA
         2Q3oTSAcRaBDuC05Vpm59LuL+Js5fRXqt+8lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+qU9ctcrY7mtJ7WOAIohkf0A848XGp2YRevCX8i4gts=;
        b=EI6POvrmL7hwJ1Zr5pXJDQuCP6H4r3Pi1PP1VXD3AAT/1mr/QeWtvp7jg7Glu7miqy
         1oJDYktgzPaT1tJFymZcw2XXI1ocFDALazoL8+fwmFV0zL+8DB0GTKgwikNmbJr5dq2u
         43Bxery2GUggahPem7tCH9ZFeqfOewCVzZJVdbvUcea5r/sR/IC+lc9OJTtAFdjMvZGe
         lyNvz0H/0b+iN14TDzVBm+xWO8lA5DrtOU39AcPs0k9T0vPuUaruy0DwB/leJYxYL+Fr
         KoecJGEOqvYOQLcvgEnxIy8OwXdiF+8ysmF+rffUo2FaZt466c6Nf+FG8oKrdNuwd0Jy
         mjtA==
X-Gm-Message-State: ACgBeo0p05QvQkQakDucCGiDg/moNnGPZYF1wl+pJ0mL87+L/pw6nwQF
        ia86Z8CiH/V4mGErJTSEIK+Jf9zjfi3jB4fFgraHoA==
X-Google-Smtp-Source: AA6agR6XzaZ+tjS2B38+xX/5fv3zVFoMbmEjVYn3rbhESLg5eHnuuhXweWowUZRe3isFIyyq67NglnbcGPdP3p8ht3c=
X-Received: by 2002:a05:6512:1694:b0:48a:9d45:763f with SMTP id
 bu20-20020a056512169400b0048a9d45763fmr1987125lfb.662.1661495571621; Thu, 25
 Aug 2022 23:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220820082936.686924-1-dario.binacchi@amarulasolutions.com>
 <20220820082936.686924-4-dario.binacchi@amarulasolutions.com> <c74b4464-ec28-eff6-86e2-2b0e5e9e992b@linaro.org>
In-Reply-To: <c74b4464-ec28-eff6-86e2-2b0e5e9e992b@linaro.org>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Fri, 26 Aug 2022 08:32:40 +0200
Message-ID: <CABGWkvryfr84eZyQzB4Cf17kBBNBRGRi3TxK24tesq=k56_uQw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] ARM: dts: stm32: add pin map for CAN
 controller on stm32f4
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        michael@amarulasolutions.com, Dario Binacchi <dariobin@libero.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Aug 23, 2022 at 3:43 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/08/2022 11:29, Dario Binacchi wrote:
> > Add pin configurations for using CAN controller on stm32f469-disco
> > board. They are located on the Arduino compatible connector CN5 (CAN1)
> > and on the extension connector CN12 (CAN2).
> >
> > Signed-off-by: Dario Binacchi <dariobin@libero.it>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> Do not ignore review. This is not correct. You are mixing copyright with
> SoC...

OK. I got it. I will drop one SOB in version 3.

>
> >
>
>
> > +                     can2_pins_b: can2-1 {
> > +                             pins1 {
> > +                                     pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
> > +                             };
> > +                             pins2 {
> > +                                     pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
> > +                                     bias-pull-up;
> > +                             };
> > +                     };
> > +
>
> Don't ignore review.

Sorry, I didn't want to ignore your review, I thought the blank line
to be removed was another.
Actually I had to remove two blank lines and I left out the one you suggested.

Thanks and regards,
Dario

>
> That's second one, so that's a no.. :(


>
> Best regards,
> Krzysztof



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
