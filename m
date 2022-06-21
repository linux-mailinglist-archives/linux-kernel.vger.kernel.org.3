Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D70553835
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiFUQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFUQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:50:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115925E88;
        Tue, 21 Jun 2022 09:50:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s21so12817091lfs.13;
        Tue, 21 Jun 2022 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI9vr7TQPqxwZb2z/IMuFAGZ9nSwT2vz/9F9w7eTiWQ=;
        b=TDZvDdbimBZ9N0fLFWDfy5OD6MDoKJOihMspOG15unZ0NEuqew7BxxnIchsQ+PhHgO
         T6BOw+9I5o+nWV8GHYUlnmqC+25cRk2bRt31Sc+I1WeaCzEkH27k1pFQkjegG+u6RUbZ
         NYshk6amV0oCvL+VLUH1aUrGk9ZXlGqO+qWVXg53sWiZVL5HWjoBFEeycbez/tIBgMXp
         gPMQYSRgl1EKHv1J59+lDXS6L7p2YrxryNavQDhzbaRxJggnIGMpKyV34oEeJAKcBART
         5POeFytTtnDoXGngY+PeLZdWFYmIpr54Nka/grGGjwy4k7+rI8Sb84PX+aE1vwNeKS/K
         kzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI9vr7TQPqxwZb2z/IMuFAGZ9nSwT2vz/9F9w7eTiWQ=;
        b=RtQve16AUsYx0IxlGUW/iDksdi9wQPUCq52Yrv7WK7eoucTTfJ6ZFruIzggg2Clp4a
         w5XNfJrv0FeAr6yQyK8ZKE0PvJrpiqGOwHvfn/FVN/qdlSttWswOb1l8oC2vPVquKUpW
         FAk9hcpEWXZp5X/QXJWbVYkX9G4CkomPB1woPApfJ2guEdkUfEaze/taqQdjV6lVQ2Dl
         7pUCOYT4Uc24KX7yFB6wEU097gMggkK57TbZFH/prq+a6GJZNUO7XkjMwfbojBjwIkXr
         xAZrt0iBKAAfGzOhvSh6GM3YwuwixbvLfuxQ0Kk+sdEiDacIrXgkzkpFNM4ZSR5kZ9x6
         COhQ==
X-Gm-Message-State: AJIora9Wu2TjHLm+kAotpNNmeP5PcKknxiBoa+1iJSL/Jprpck0+P/JE
        b5jGhbKIlkGN53XzmIugepJX7/0vsLdPaxvBCLlN1agV2gSIlA==
X-Google-Smtp-Source: AGRyM1skPQQLpMHGrrtCYFJIKwZltL1tW6qpkSB1j4XHK/bat+sYAi+niUvvWjRNyH+0E//6sHWS5YsdxF42Ge3teJA=
X-Received: by 2002:a05:6512:3d1a:b0:47f:79df:2ea8 with SMTP id
 d26-20020a0565123d1a00b0047f79df2ea8mr3853154lfv.610.1655830225857; Tue, 21
 Jun 2022 09:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220621131424.162355-1-tmaimon77@gmail.com> <20220621131424.162355-6-tmaimon77@gmail.com>
 <5832f7f1-3c8f-d88d-3b72-99effc1e2e83@linaro.org>
In-Reply-To: <5832f7f1-3c8f-d88d-3b72-99effc1e2e83@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 21 Jun 2022 19:50:14 +0300
Message-ID: <CAP6Zq1itHGFw9ZV9cMr-9Fhx8fqYVGYXhmTOiLbGVjoV7TQ5hA@mail.gmail.com>
Subject: Re: [PATCH v4 05/18] dt-binding: clk: npcm845: Add binding for
 Nuvoton NPCM8XX Clock
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

On Tue, 21 Jun 2022 at 18:40, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/06/2022 15:14, Tomer Maimon wrote:
> > Add binding for the Arbel BMC NPCM8XX Clock controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 49 +++++++++++++++++++
> >  .../dt-bindings/clock/nuvoton,npcm845-clk.h   | 49 +++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >  create mode 100644 include/dt-bindings/clock/nuvoton,npcm845-clk.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > new file mode 100644
> > index 000000000000..3d4fddc090ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM8XX Clock Controller Binding
> > +
> > +maintainers:
> > +  - Tomer Maimon <tmaimon77@gmail.com>
> > +
> > +description: |
> > +  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
> > +  generates and supplies clocks to all modules within the BMC.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,npcm845-clk
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +    description:
> > +      See include/dt-bindings/clock/nuvoton,npcm8xx-clock.h for the full
> > +      list of NPCM8XX clock IDs.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
>
> You fixed one comment and ignore second. The same was with v3.
Sorry, I missed the quotes comment, will be addressed next version.
>
> This is still no. Implement all the comments you received. I have to
> double check your patchsets every time because I cannot trust that you
> implemented what I asked for.
>
>
> Best regards,
> Krzysztof

Best regards,

Tomer
