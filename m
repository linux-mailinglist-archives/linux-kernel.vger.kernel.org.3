Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01E054566C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiFIVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFIVVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:21:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F226228703;
        Thu,  9 Jun 2022 14:21:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m25so24254208lji.11;
        Thu, 09 Jun 2022 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNuOwNPhLjnWOAOnqcPkV/eMqNfkcYlXT1/SBw7nhhM=;
        b=IKVOLtCX8dun+XfSPV/xksDt7j8FV3mh4EH9miGNyXh9L5CsOSUmiOUrjml+c6k7Fe
         sqg9Ok36D47MQwXGrmT7iRjU+jAg1PU7yGatFaZEMjcvJxFxqMLfZfrBtADnTxasIiwD
         aWHZkckw/0D+KVKoJt3R57uum0l0EMYEDalKP94erbG6e9VksQO1thykyNE1eMUVDoR4
         i8Wl37aKL6Zn6Sw+42S5xTOTsLlJw/VQs+bzjgUcZRJhWoxEaEKY1ByeGB2ecUFzvF6c
         Q1lERodwtolZpzNS4cP6zHrmt7k4L0X8TTucQxlmn+Lb6cKDMYrgNSF0ajePCUD6gqLP
         tEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNuOwNPhLjnWOAOnqcPkV/eMqNfkcYlXT1/SBw7nhhM=;
        b=3ugtVmozfpB7shsTef03MaETGTexmeRAIFIT+f+f7MTVQ+X1H/q+tzzhCbsnhU3+op
         Xd1+faOwVGVDXqLjzmYZ1AkkDWyUAxd9p5lsbMzNgufCNK5kn2iqCiz++fbTNC8Qh64p
         kBjZFJl/o1O3pQsWkvvcW8lF6knS7xtNaqw801VvDk7nMh6Ip2dR/s1XQiF8g7APy1c4
         r6gjVtBpKXyJG5qt3GTX0sHeuljyCFZyEbh5UAkbRT58W2dYWI7OcTQlURIT8GMAU/RX
         RMEl5P//oVre1Ya9JVtqZK+rcNuYcivV4+Kpy4k/4MRGH79CHHaB/fx1auqsQ8zkTNdP
         60Og==
X-Gm-Message-State: AOAM533q5ZjHgwSaDUjPjbc3A0PiV/yjg9Hfh3aJT4HyoWaJmcMoZsF8
        j57OeRpwsNt5x3rvQ/TAxp4yGUxRl74j24HZG2k=
X-Google-Smtp-Source: ABdhPJyzwpF4ifdZYNO7/4CtCtO58mzposH94NYnEFJp2aAeSm7a86mAY+CyaWEhnoJYk1Yt8ogT/MkZelblGU2YUts=
X-Received: by 2002:a2e:93c6:0:b0:24d:422f:f8f0 with SMTP id
 p6-20020a2e93c6000000b0024d422ff8f0mr62259055ljh.469.1654809701808; Thu, 09
 Jun 2022 14:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-7-tmaimon77@gmail.com>
 <f4899b6d-fec3-5940-709a-f5fbc7ae6233@linaro.org> <CAP6Zq1geJyaDrP2CBY3FHe5y-L=bCptX1pzAkNypY+TS5vXzMA@mail.gmail.com>
 <082366b0-6811-b492-c68c-12f9a9ee512e@linaro.org>
In-Reply-To: <082366b0-6811-b492-c68c-12f9a9ee512e@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 00:21:30 +0300
Message-ID: <CAP6Zq1jaUH9g+xRvgT0Xn---A9S9Linn-TKLMgnoTq+xgbi74Q@mail.gmail.com>
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


On Thu, 9 Jun 2022 at 16:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/06/2022 15:17, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > Thanks for your comments.
> >
> > On Wed, 8 Jun 2022 at 13:03, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/06/2022 11:56, Tomer Maimon wrote:
> >>> Add binding for the Arbel BMC NPCM8XX Clock controller.
> >>>
> >>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >>> ---
> >>>  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 63 +++++++++++++++++++
> >>>  .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 50 +++++++++++++++
> >>>  2 files changed, 113 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >>>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >>> new file mode 100644
> >>> index 000000000000..e1f375716bc5
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >>> @@ -0,0 +1,63 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Nuvoton NPCM8XX Clock Controller Binding
> >>> +
> >>> +maintainers:
> >>> +  - Tomer Maimon <tmaimon77@gmail.com>
> >>> +
> >>> +description: |
> >>> +  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
> >>> +  generates and supplies clocks to all modules within the BMC.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - nuvoton,npcm845-clk
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    items:
> >>> +      - description: 25M reference clock
> >>> +      - description: CPU reference clock
> >>> +      - description: MC reference clock
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: refclk
> >>> +      - const: sysbypck
> >>> +      - const: mcbypck
> >>> +
> >>
> >> I asked what is the suffix about and you replied "ck"... ok, so let's
> >> make clear. This should be:
> >>
> >>     items:
> >>       - const: ref
> >>       - const: sysbyp
> >>       - const: mcbyp
> >>
> >> or something similar, without the same suffix all over.
> > The clock names are the same clock name in our spec, this why we
> > prefer to leave the clock names as is.
>
> The naming with useless suffixes does not help. If your spec had
> "refclk_really_clock_this_is_a_clock" you also would insist on that? It
> does not make sense.
Sorry but I don't understand why the clock name cause an issue, we
prefer it will be the same as in our spec-clock diagram
BTW, the same naming found in NPCM7XX
https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt#L36
>
> >>
> >>> diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> >>> new file mode 100644
> >>> index 000000000000..229915a254a5
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> >>
> >> Same comment as before. No changes here...
> >>
> > about the comments from V1::
> > - Krzysztof: Filename - same as bindings, so nuvoton,npcm845-clk.h
> > In NPCM7XX we use the same include file and clock source
> > dt-binding
> > https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
> > dt-binding include
> > https://elixir.bootlin.com/linux/v5.19-rc1/source/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
> > we prefer to be align with our older BMC version
>
> Older has incorrect name, so do not align to incorrect one. What is the
> logic behind having header not matching the bindings file? It makes it
> only more difficult to connect these two.
Will modify the file name in V3 to be the same as dt-binding
>
> >
> > - Krzysztof: Dual license, same as bindings.
> > modified in the file * SPDX-License-Identifier: (GPL-2.0-only OR
> > BSD-2-Clause) */
> > the same license approved in en7523-clk include file and pushed to
> > Linux kernel 5.19 :
> > https://elixir.bootlin.com/linux/v5.19-rc1/source/include/dt-bindings/clock/en7523-clk.h
>
> I don't understand this comment at all. I am not commenting about
> en7523-clk.h. I am commenting about the header here - it should have
> dual license. What en7523-clk.h has to do with it?
>
> Best regards,
> Krzysztof

Best regards,

Tomer
