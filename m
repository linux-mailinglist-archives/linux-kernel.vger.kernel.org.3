Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C41E548343
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiFMJZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiFMJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:25:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEB12AC1;
        Mon, 13 Jun 2022 02:25:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a29so7885267lfk.2;
        Mon, 13 Jun 2022 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUYF6Y1hCqd5t8WxA/+uJZZHaISwa+qUcLkVEX3FDtY=;
        b=OZRK4j4GfMvvujegmLuiiyQfatSbywM4kRdRc1tMAOzluF9+R3ROjAPU3l7ABr8vnN
         jYtnDvoHI2bSR7Kn4LK8/ztorjpVQXZ2uSDdgpxBZhlEi2T9raelsgwGWpgrCmVTF1ng
         +jtfpdHxAxBWbneZjvuPphDXeVMYqaI7GuHnfR/C9zsLfnkFjud27cobWdzB8VQCmmf7
         CUqYCzZDZac86aaP53eZzM6opXQBwDLw0lkE/+JhAnd0rjVfdtJLXqWYI/7dX/nxVL7B
         6oAE7Xd3AmopNE8kT4f8CY9HGoy/EEkLZuu4y4iGct6vRqeb8A+Agl+ljt2/6CRdvDGF
         W5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUYF6Y1hCqd5t8WxA/+uJZZHaISwa+qUcLkVEX3FDtY=;
        b=jCfGaR9EhmtmrGq19XLLS2LQymZPC9QkkvQwyzmTmszJ7aOvm04dsmUt/lYG2dpHDF
         ACoqEZmr34IDvsexmDrvLt0IFTmKU12aCkskwF7w+ab1Tp2ABAhF3jmT21vcMZad66zu
         BTKtg6PKcpm7U2jX/u9m1zl2MZ0EC+p3WdQvwn6HgnVEqazrn4kyse0+3CJfuw94cuFn
         94bJtCYyimjNhfNtGDYUDiuhEGUibgSxFcIs6LymLtXtDDVb7r4lBTxJ867tku+5kSyP
         h42E43hHXfoARWdpi8kDfRBMDnwYIrcMew6qqJX/yCMkEn0QBOOVINKkpY7XSbAmrL2l
         u7Sw==
X-Gm-Message-State: AOAM532FpcBbl+Rs6UmKKv1kfIhbruI1OqPMEM0+kMEePEU1icOV70wl
        PgJC71w7jNMWxE+p2oim2X8pNgGCRzJ113vZx0o=
X-Google-Smtp-Source: ABdhPJxXc679feoHAf2D/GisUYLrlv1MVhsVhMMqlkvsfBNlHHdqjK5/eafARXLQjX3HPF+NV1BKVh2veyAWJgShjls=
X-Received: by 2002:a05:6512:1052:b0:479:1f92:13b4 with SMTP id
 c18-20020a056512105200b004791f9213b4mr27864941lfb.200.1655112316061; Mon, 13
 Jun 2022 02:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-13-tmaimon77@gmail.com>
 <add025b6-c622-b204-d39e-67b31878d37f@linaro.org> <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
 <381ff739-e898-8812-d549-df7101f0eaa2@linaro.org>
In-Reply-To: <381ff739-e898-8812-d549-df7101f0eaa2@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 13 Jun 2022 12:25:05 +0300
Message-ID: <CAP6Zq1j=x3OcOPSOjJJmOcze7ziM=oWcKdbYzoHhGnvZipu_UQ@mail.gmail.com>
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

Thanks for your clarification.

We can remove the dt-binding file and use numbers in the DTS,
appreciate if you can answer few additional questions:
1. Do you suggest adding all NPCM reset values to the NPCM reset
document or the reset values should describe in the module
documentation that uses it?
2. Some of the NPCM7XX document modules describe the reset value they
use from the dt-binding for example:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/adc/nuvoton%2Cnpcm750-adc.yaml#L61
If we remove the NPCM8XX dt-binding file should we describe the
NPCM8XX values in the NPCM-ADC document file?

Best regards,

Tomer

On Fri, 10 Jun 2022 at 12:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/06/2022 00:05, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > Sorry, but I thought the fix is only to add an explanation to the
> > dt-binding file as was done in V2.
> >
> > The NPCM8XX binding is done in the same way as the NPCM7XX and both
> > use the same reset driver and use the same reset method in upstreamed
> > NPCM reset driver.
> >
> > Can you please explain again what you suggest to do?
>
> If you want abstract IDs, they must be abstract, so not representing
> hardware registers. Then they start at 1 and are incremented by 1.
>
> Other option is to skip such IDs entirely and use register
> offsets/addresses directly, like Arnd suggested in linked documents. I
> think he expressed it clearly, so please read his answers which I linked
> in previous discussion.
>
> There is no single reason to store register addresses/values/offsets as
> binding headers. These are not bindings.
>
> Best regards,
> Krzysztof
