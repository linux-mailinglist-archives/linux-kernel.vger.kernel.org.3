Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B532544D54
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbiFINSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiFINSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:18:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FCF3CBE2A;
        Thu,  9 Jun 2022 06:18:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so31821507lfg.5;
        Thu, 09 Jun 2022 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9H4dOb7IaIcY52Tw6WWiljInSfJiOJbeD3ghXohKUWk=;
        b=bxQvhZiJyJvGenAgd1C3qiVyZH4ml/Vnom25DFpoC731mCeBREubO4jUNTENKxajXI
         MR7U3ddjUCoMlr94nBmzEpBeJvuDXEB4HnnaYJ4xnZrR2sPFuLgxOuqrN4kkfkES6Iiw
         ti9BmmUPpa3hFl3+Zc/z/bPGNz3VCCT15NGOCugqxHdTW/AkKBAfV76k9CiaScYOKqHP
         KbgKcr377DEMvYCj0FOCu+WyDp6YuJOl1YptRleIGyBJJMESsuQX3KcpfOkmYJ/lzpku
         emeAUmFuDjlnZfTYGGf7DPIXv1uMZqHlgj1QLdeFtC+2zieBgGMkxqJejaLhPLJi/Efl
         q5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9H4dOb7IaIcY52Tw6WWiljInSfJiOJbeD3ghXohKUWk=;
        b=IsI8jgiNFNrkpBfZYaIq8P1FRHzm6EihbzZjOeOfIF+khwvJ1ppeumno3LLujJZevU
         IuFD256g9pFeoNxc2YitZm0O9pNVHNeV9t673TrDQVIQvZq9DJf5mi0/7rQAH2FScHoE
         /WQuUQgbfks+yMhHkivYaq9LGXX1oyy14gvYsv6IfmYESlAJkIyeeiro6/+Mz6Qs07Fq
         cxUnenC11rtDvIUlCm6aBMvIx3EeS2RK17bNCCIVCoz9j7YvQHClGurQ4GvHkUpvyeTg
         9Q91ZszDCYM4lAZ+8RL5uj4evZUkkIHN2tBecn/l3ydTeCpI5OV1nG7ZZmqPUMrwIwcp
         U6jQ==
X-Gm-Message-State: AOAM531DHiiK68nmwC5t8bX2ipXFMeVsFWi1b3UYuqFbVbWM/NSXZ8lL
        fbUv0e6JGGiOxAUVKGi/aQ8t3NXgkKGE9glmijo=
X-Google-Smtp-Source: ABdhPJxz9i9pVE0BdHMV70Vwi186ROVaHboigU3uL+CKro67Q69etkqlQSJOajfipTkSsc8z60rVUCQteSPARaV4mpI=
X-Received: by 2002:a05:6512:703:b0:479:157a:c18d with SMTP id
 b3-20020a056512070300b00479157ac18dmr21665529lfs.639.1654780678706; Thu, 09
 Jun 2022 06:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-7-tmaimon77@gmail.com>
 <f4899b6d-fec3-5940-709a-f5fbc7ae6233@linaro.org>
In-Reply-To: <f4899b6d-fec3-5940-709a-f5fbc7ae6233@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 9 Jun 2022 16:17:47 +0300
Message-ID: <CAP6Zq1geJyaDrP2CBY3FHe5y-L=bCptX1pzAkNypY+TS5vXzMA@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] dt-binding: clk: npcm845: Add binding for
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your comments.

On Wed, 8 Jun 2022 at 13:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/06/2022 11:56, Tomer Maimon wrote:
> > Add binding for the Arbel BMC NPCM8XX Clock controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 63 +++++++++++++++++++
> >  .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 50 +++++++++++++++
> >  2 files changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >  create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > new file mode 100644
> > index 000000000000..e1f375716bc5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > @@ -0,0 +1,63 @@
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
> > +  clocks:
> > +    items:
> > +      - description: 25M reference clock
> > +      - description: CPU reference clock
> > +      - description: MC reference clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: refclk
> > +      - const: sysbypck
> > +      - const: mcbypck
> > +
>
> I asked what is the suffix about and you replied "ck"... ok, so let's
> make clear. This should be:
>
>     items:
>       - const: ref
>       - const: sysbyp
>       - const: mcbyp
>
> or something similar, without the same suffix all over.
The clock names are the same clock name in our spec, this why we
prefer to leave the clock names as is.
>
> > diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> > new file mode 100644
> > index 000000000000..229915a254a5
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
>
> Same comment as before. No changes here...
>
about the comments from V1::
- Krzysztof: Filename - same as bindings, so nuvoton,npcm845-clk.h
In NPCM7XX we use the same include file and clock source
dt-binding
https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
dt-binding include
https://elixir.bootlin.com/linux/v5.19-rc1/source/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
we prefer to be align with our older BMC version

- Krzysztof: Dual license, same as bindings.
modified in the file * SPDX-License-Identifier: (GPL-2.0-only OR
BSD-2-Clause) */
the same license approved in en7523-clk include file and pushed to
Linux kernel 5.19 :
https://elixir.bootlin.com/linux/v5.19-rc1/source/include/dt-bindings/clock/en7523-clk.h

>
>
> Best regards,
> Krzysztof

Best regards,

Tomer
