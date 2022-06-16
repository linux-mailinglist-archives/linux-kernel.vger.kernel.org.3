Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E63B54E1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiFPNZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiFPNZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:25:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9BA3BBF9;
        Thu, 16 Jun 2022 06:25:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l20so1525984lji.0;
        Thu, 16 Jun 2022 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVAdZ2cu7L3Nr+75vrL+6JqYK3CgcW1j0SYA+lfIJLQ=;
        b=qc5RA3CqMtq7kity/XbtWctiL0VY0iVEy8yUIvYPUfxdQNePbUsmntBMMVFiGci3++
         BW4fxPxP9Vf1Cai8MSQEfWoqAuFjQHrFrPAtdrscmRGdZLloFzTZ9ka2ZOh6scvRIY6k
         tcdmh/6avsxXWIWtxpOsltIW5QjQAElzto8X6biQtuTX3wgpBh9/m2OVHME2+9H4EiVE
         VnXmDAudrQMAooZ9J4gfl2D205JnNZlUq2bEdkcVbdFseye2DjqVz8iW17cp1IW4/zdW
         ZNTKd6BlXwAzMAuSLm9NxKlNNvcEEvNCEAAfnyzBOmuANPws5zTOzdlqm10tXZ69Tl7r
         wwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVAdZ2cu7L3Nr+75vrL+6JqYK3CgcW1j0SYA+lfIJLQ=;
        b=Cp4w/ljNWfqN7CEUtCTkef49j8qUTUYQ9VVQnEUjAFcQAEva4mqa/NUZNodKPw4Jnw
         Zg0p4S0AQ+v9zI9lucV4aROX8acdtZPDwQHKNCBN5Md0OQHzBI0Jw4ilKI7XJjmShJNM
         thsI3Fpyq0i7gIUEJsel/2W3ezFLNvQP6z9fN+2Ny+GZoTKFDLzuW47XZYuePQOwxwz2
         AEhi6L9gH4vNsFxNCH+/yyKvGYgmMYlXHUF8xY+smGq4U89GwWSr8/7fOi+oeAts5Uwh
         esfO5BTXyoMUmcaRnrVwud9k62d+INEBmDmJM5Z0krVpgqNDn/hiNpV5C2T/rJOBBFNl
         FLRw==
X-Gm-Message-State: AJIora/EGZ7DwEU0C/CMs3T/3rr8ebid/dR/VJ+PPgXepeGtEzo9Sns6
        Uwgl0xWcKM6zf7pHiETdrnDh99OUx9il/RjSxWY=
X-Google-Smtp-Source: AGRyM1sMIqhxO0a1eovqh9hUTJBdq4SnBO6X8MSu1qVhrgr5+6Viw7wFZSIoHnhV7Ij/CuwAW4lkNFj5d8MDUPe9o4I=
X-Received: by 2002:a2e:6817:0:b0:258:b235:7812 with SMTP id
 c23-20020a2e6817000000b00258b2357812mr2526199lja.83.1655385902856; Thu, 16
 Jun 2022 06:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-13-tmaimon77@gmail.com>
 <add025b6-c622-b204-d39e-67b31878d37f@linaro.org> <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
 <381ff739-e898-8812-d549-df7101f0eaa2@linaro.org> <CAP6Zq1j=x3OcOPSOjJJmOcze7ziM=oWcKdbYzoHhGnvZipu_UQ@mail.gmail.com>
 <e6e478a5-9080-fb2f-9ccd-2490cdfab4c7@linaro.org>
In-Reply-To: <e6e478a5-9080-fb2f-9ccd-2490cdfab4c7@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 16 Jun 2022 16:24:51 +0300
Message-ID: <CAP6Zq1gy=rj-wyqqNQF+Pt1dtHsf+90AnTGTqt-v9madj8tfGA@mail.gmail.com>
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

On Wed, 15 Jun 2022 at 20:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/06/2022 02:25, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > Thanks for your clarification.
> >
> > We can remove the dt-binding file and use numbers in the DTS,
> > appreciate if you can answer few additional questions:
> > 1. Do you suggest adding all NPCM reset values to the NPCM reset
> > document or the reset values should describe in the module
> > documentation that uses it?
>
> What is "NPCM reset document"? Are these reset values anyhow different
> than interrupts or pins?
No, they represent the same values.
>
> > 2. Some of the NPCM7XX document modules describe the reset value they
> > use from the dt-binding for example:
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/adc/nuvoton%2Cnpcm750-adc.yaml#L61
>
> This is NPCM750
>
> > If we remove the NPCM8XX dt-binding file should we describe the
> > NPCM8XX values in the NPCM-ADC document file?
>
> What is NPCM-ADC document file? What do you want to describe there?
> Again - how is it different than interrupts?
It is not different from the interrupts.
I will remove the dt-binding reset include file, the reset property
will use numbers and not macro's.
>
>
>
> Best regards,
> Krzysztof

Best regards,

Tomer
