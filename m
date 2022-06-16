Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E671454E23A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377182AbiFPNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376928AbiFPNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:41:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4B2CDF2;
        Thu, 16 Jun 2022 06:41:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c2so2328855lfk.0;
        Thu, 16 Jun 2022 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnC/bn4zCDRVtxGAXcuOdFyiM3OcQ+RFU6fn2CEQYEQ=;
        b=TtMVX1VLo5vsivX4rnR7hdNC/WiFF6rf5FY+MRkwb0kvFHYUzlHoOhwg5TTgUUGQll
         SE7kQXSWU31CPtm0Vv4e9lQo9PU3MWLWgM60oM2i4k+R4oEByNQ5cai/d1ERWACQtXDM
         xMY7/ig/TAVcVVOBe9q6kRNPg4qWH4y0n6yb4tXjSv+3TyRzXyBi4WOXJbRv9JAFTbsO
         /1cPkMg+4tYWIPrVNz96R2E5CvgdpRXX3IHyyB4FvHyFTbNU8pk4/EYVxqtbbgIOJjQs
         nix/qd2GA8c46pfGmBA/Jrg9ExTGqVNUwbVyhmMRm2yaZKa/ksKnAhO0VsFAzmEqWjMY
         DT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnC/bn4zCDRVtxGAXcuOdFyiM3OcQ+RFU6fn2CEQYEQ=;
        b=QJ5VFaV5yWqZRmLFmjTyha6s2zq+YLEAnY2pTzEj58G0I5SIwBKGc+mS/n7DcXtDrd
         z7vL+Q450JtavQxsMheTLAdPsb6p82ez4fpjO77w3EYbcHXR8NEPO7aOY1H1aJXC1wM0
         4uxY7C7pu5UTBabIoR9TKvSBVfwSSeQ7ICqyJfdm6pXUqF3oGtUB2gtiyxCLVw4KmEOv
         Tx+FkOKJGK1fEnxpHu93h92of53+fyyVayLPa04aETeSvwlAgDYSTM5ulXGYbrn+2D9C
         4Dih9N1+ogANXdU3/mg6uCA2J7/32+aesyTWyDVkLe8Jw8iIAmeAJds+EzB7wmFGo3Jz
         krKw==
X-Gm-Message-State: AJIora+ziHEfDrP9Mt1dNR6uoZFvnnPSFUIIVA8mLUjSAw9f6vpkX/ZI
        dfYoocnhFmduLeqtN6yP47nrZWuiFpAzwVd40a0=
X-Google-Smtp-Source: AGRyM1s/Dh6yb9xotZBJUCK7BE+lDY27S0mfWoIr8Ej/Tbl1Ityqd1e+MbFpp7JtPxXsp7GsnULEMIn5+25S9rTiTpM=
X-Received: by 2002:a05:6512:3d8c:b0:479:51be:727f with SMTP id
 k12-20020a0565123d8c00b0047951be727fmr2762721lfv.289.1655386896126; Thu, 16
 Jun 2022 06:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-13-tmaimon77@gmail.com>
 <add025b6-c622-b204-d39e-67b31878d37f@linaro.org> <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
 <381ff739-e898-8812-d549-df7101f0eaa2@linaro.org> <CAP6Zq1j=x3OcOPSOjJJmOcze7ziM=oWcKdbYzoHhGnvZipu_UQ@mail.gmail.com>
 <e6e478a5-9080-fb2f-9ccd-2490cdfab4c7@linaro.org> <CAP6Zq1gy=rj-wyqqNQF+Pt1dtHsf+90AnTGTqt-v9madj8tfGA@mail.gmail.com>
 <d3432cce-079e-3d6d-91df-6da10bd69d08@linaro.org>
In-Reply-To: <d3432cce-079e-3d6d-91df-6da10bd69d08@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 16 Jun 2022 16:41:25 +0300
Message-ID: <CAP6Zq1jdMN_vB1Uoi6rb_E1DydS7+-A0sWMRNUhDPF4pzkr2kA@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] dt-bindings: reset: npcm: Add support for NPCM8XX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 16 Jun 2022 at 16:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/06/2022 06:24, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > On Wed, 15 Jun 2022 at 20:03, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 13/06/2022 02:25, Tomer Maimon wrote:
> >>> Hi Krzysztof,
> >>>
> >>> Thanks for your clarification.
> >>>
> >>> We can remove the dt-binding file and use numbers in the DTS,
> >>> appreciate if you can answer few additional questions:
> >>> 1. Do you suggest adding all NPCM reset values to the NPCM reset
> >>> document or the reset values should describe in the module
> >>> documentation that uses it?
> >>
> >> What is "NPCM reset document"? Are these reset values anyhow different
> >> than interrupts or pins?
> > No, they represent the same values.
>
>
> We do not document in the bindings actual pin or interrupt numbers...
>
> >>
> >>> 2. Some of the NPCM7XX document modules describe the reset value they
> >>> use from the dt-binding for example:
> >>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/adc/nuvoton%2Cnpcm750-adc.yaml#L61
> >>
> >> This is NPCM750
> >>
> >>> If we remove the NPCM8XX dt-binding file should we describe the
> >>> NPCM8XX values in the NPCM-ADC document file?
> >>
> >> What is NPCM-ADC document file? What do you want to describe there?
> >> Again - how is it different than interrupts?
> > It is not different from the interrupts.
> > I will remove the dt-binding reset include file, the reset property
> > will use numbers and not macro's.
>
> I have no clue what are you referring now... This is NPCM8xx and it has
> no binding header with reset values. What to remove then?
I refer nuvoton,npcm8xx-reset.h file, we don't need it.
>
>
> Best regards,
> Krzysztof
