Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5924559F5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiHXI4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiHXI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:56:33 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32778DF6C;
        Wed, 24 Aug 2022 01:56:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q8so12369205qvr.9;
        Wed, 24 Aug 2022 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aWr8f4K8EXYtnB+iVG3NkWp+4Wg8K6TUAFF51MM2dC0=;
        b=GptCKFyBLh3Sa6C3Rc32Tze5USSgb7dLMD69Y9/pwWGhasKq78oavkxSQWOW/34iPp
         if6FeCQtmrhu8rrY2veHnFLKPmj9ccFgQmfpRrhIeYqg8QINGkfmwdUaEc+tDxOm1mZx
         4ZKWwNMDxat1qYPW1uoMBGgBLX7iUGYaRkEt0Mcqq59gMhzRUM2v9S5kcyoZmmfc4Bsw
         NqOhvaMXns/sJfNft3+E2suL4dK2GGrHKqhNptr0nvi87n+zDdQPhaDe5sgkcW18TljQ
         JYfYXRSEbnqFNpT8gFOynPIlFzvZk0DPfd9yrBXSQQPlYf0zSAzv7BFfJK3w2SLlXRbp
         Aj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aWr8f4K8EXYtnB+iVG3NkWp+4Wg8K6TUAFF51MM2dC0=;
        b=zzQZYOHbPX7sbRpOWPeqqvdRblsKL4HxiNr62qFBIOSOF9EF2AKMDDiuNnr2kgwkmD
         tQSpuXJP72r+Wv2WUBzNjjF11E7uSqPrthPWrZRqNVb/uJ1MzIqP8TqD/QTe2EOgAP2f
         EYDQuCuAuDHbdlQWUquzq4v15kHHRDvc7SK/S8046/AkuuwocLPk5beIVSlGnXXZIImB
         Szddl/Hsieo+tRmkYPaCu2cJ7bbqfYRiyOuJr4AHDAc4Wh9j5vNiy4uioBeSAXSAZVw3
         erVi885tEILEsWqpSOeq0+XAHONCIKzN8IWNjWTGTzhNXkIUvUErayboBu7kzTQoH3n1
         9Agw==
X-Gm-Message-State: ACgBeo3kcT2SOaNTv6bBT05x9a7UvYWGwYuT/1s2QH4pOw4l6YlZpMyg
        YcXL0V0jBsvhw58B5pSHw4HsmAWEh+MLQSNA8GQ/GYTPxhE=
X-Google-Smtp-Source: AA6agR5mKXme5smwP3Kmrr9PLM+r9XvtU8kyNpAfK8WSSYrfQaZdlhGmPkaqRaMtH4bi5Glnko5MMaAYxP762c/PnjE=
X-Received: by 2002:a05:6214:c22:b0:497:10a8:3067 with SMTP id
 a2-20020a0562140c2200b0049710a83067mr2828504qvd.48.1661331391243; Wed, 24 Aug
 2022 01:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com> <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
 <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com> <20220804210412.GA30210@duo.ucw.cz>
 <0663c616-97c8-444c-f390-275fae402453@traphandler.com>
In-Reply-To: <0663c616-97c8-444c-f390-275fae402453@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 11:55:54 +0300
Message-ID: <CAHp75Vf1cT81cx38VQ80PbyG9i9xbiegMnQoMWwZEZf+7fWJuQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED controller
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 11:39 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> On 04/08/2022 23:04, Pavel Machek wrote:
> > On Thu 2022-08-04 22:23:00, Jean-Jacques Hiblot wrote:
> >> On 31/07/2022 21:28, Andy Shevchenko wrote:
> >>> On Fri, Jul 22, 2022 at 10:14 AM Jean-Jacques Hiblot
> >>> <jjhiblot@traphandler.com> wrote:

...

> >>> Sorry for my slowpokeness, but I just realized that this driver may
> >>> not be needed. What is the difference to existing gpio-74x164?
> >> It might work. However it might not be as practical and efficient as the
> >> dedicated LED driver.
> >>
> >> I'll give a try.
> > It is certainly preffered solution. If you decide to re-submit the
> > driver anyway, please mention that we already have GPIO driver for
> > compatible chip, and explain why this is superior.

> sorry for the delay. I tried with the  74x164 gpio driver and it works
> as expected.
>
> The only drawbacks are:
>
> - as-is the 74x164 gpio driver supports only one output-enable gpio.
> However in practice I don't think multiple OE GPIOs will ever be used.

Let's leave it to the case when it will be needed. So, we can skip this point.

> - with this approach, every time a LED status is changed the whole
> register has to be sent on the SPI bus. In other words, changes cannot
> be coalesced.

But isn't it the same as what you do in your driver? To me it looks
like you send the entire range of the values each time you change one
LED's brightness. I don't see any differences with the GPIO driver.

> I don't know if this is enough to make a dedicated TLC5925 driver
> desirable in the kernel.

I don't think you have enough justification for a new driver.

-- 
With Best Regards,
Andy Shevchenko
