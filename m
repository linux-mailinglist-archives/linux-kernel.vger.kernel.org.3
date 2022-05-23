Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE21530E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiEWJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiEWJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:40:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC421EED9;
        Mon, 23 May 2022 02:40:19 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MCayD-1o152Q2tDn-009keD; Mon, 23 May 2022 11:40:17 +0200
Received: by mail-yb1-f179.google.com with SMTP id x2so24035398ybi.8;
        Mon, 23 May 2022 02:40:17 -0700 (PDT)
X-Gm-Message-State: AOAM533jYsDxsPXRyDKVdyfflbydYmIwRi4A/bU3dlBPnBtiArvpWuWn
        PT6IYiRzFL4Slp6ai/6YYmEjSael8VOAdtFhr9w=
X-Google-Smtp-Source: ABdhPJwPSWjf0+4YNJaSIgYV3+A8L+w17pCRPMTjSGU6t40/PC+JSliP4KqFNtyVOp/6cKrGh1RaU8G2YIBlaJLXrPQ=
X-Received: by 2002:a25:c747:0:b0:64f:62fb:f55e with SMTP id
 w68-20020a25c747000000b0064f62fbf55emr13651825ybe.106.1653298805675; Mon, 23
 May 2022 02:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-19-tmaimon77@gmail.com>
In-Reply-To: <20220522155046.260146-19-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 11:39:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1LCkM-w_Oi2qUqgq_Qxsg64uoGg5aaz=X8pBENHBhj0A@mail.gmail.com>
Message-ID: <CAK8P3a1LCkM-w_Oi2qUqgq_Qxsg64uoGg5aaz=X8pBENHBhj0A@mail.gmail.com>
Subject: Re: [PATCH v1 18/19] arm64: dts: nuvoton: Add initial NPCM845 EVB
 device tree
To:     Tomer Maimon <tmaimon77@gmail.com>
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
        gregkh <gregkh@linuxfoundation.org>,
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
        robert.hancock@calian.com,
        "nathan=20Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:n7zvqzJoyeIQrt0t+bbdn3QVYisX2S5bXfz3u0VUhVzjsm2+x+o
 659/sfSLnFqNBG7X7VtbYSKUHJCRzLZl40EszBTEYhCu20ZCEsrGsEmNe7Ab7THLuGp+tMJ
 grFXdUbW4oucpYzpzItMge4A6IxrrQMX94YKma6DD8XWZYfzC70RbHiunite5+fqf89+eXN
 LIbl0pJkO4UAdKfAmCifw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Z5BTVOu2s8=:cPSYfOv2MjhdvbMxTorHlS
 rLOLv/JIQN8ZNLEEprUL4opOISkNGyOHPLhQKpnatFNPTFFK02SGwqdbwGA0rASndK3H8NgsF
 LZN/NZTFC3UWBK9dYkR+3nhaYyNEBsujW6GSyVgBo4qjC3thY8Y7VHbAbIq4yKL5TFmEejH/c
 rxSVFWZNU9ayduqPmLC0YauJf9eSOUEumcaGtfToKFbiLxH3PpzVdPP+mNqVH627ZJPcLyH1/
 pZWGY73x5YfhQOG8wH2pRENhz2XhpJGDtPYQdOPRI0qEQy9B3feuoXtBT8nk4vs0RthkhUjVG
 YTMcCHeG+PGuvjeq1PW7hCCppuC56oraAaein7sADyfAA/hkici9fEeglyVbU73OHFNqNrQqC
 o3QzyBh6ySmIZoIMOt0GNUm8i4QF+zHvhlYKDQb/Bs1WnMv7NIj36tNEJQx6SJ/x7kGE+/+oq
 n/QUiVPXGaEfRoxpLDRDxk6IYWCAVX0ZTbIryM7UUsH7ZWCpYlPXDmpGUBLDVxXRIMm59HZ1z
 Pt4zHYKLBv6RwUu/+ybaRsPbj+WCF8QeUz8E+57JEvpuHEuB8dhV3GX6tlUQr4WPzKecDqqz4
 T32am9CBSUCwexZ1cSPdYtC5Q/Trv951eX9cSIIaoujwBZAOQcvFLVj7djbC/M6ZNUgSm0WMe
 CRMLZxuiIRLiSk990cWjlHcSxnpkVyf3vjbUChAduqG+XGP2T3WYkoUq0APyG5N4yq1GQr6Tb
 mq6s0kHhLW6onkYm489d0lZtKdHS3W3AkyjFaMovTV7mqs5ywNjC/fIsp17D1OtR9M6boXjPy
 OO1nH20/LhOtiqXq99IR9CUpxNLN1GkRgqFVx9OQsVJWROkdKXtTn+ST8u8/5SCfR+l+8/pJs
 Rgkjp4U1VhoUWZ7g6s3dnRWuluTCjnnmNDLILdiVg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 5:50 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> +/ {
> +       model = "Nuvoton npcm845 Development Board (Device Tree)";
> +       compatible = "nuvoton,npcm845";
> +
> +       aliases {
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +               serial2 = &serial2;
> +               serial3 = &serial3;
> +       };

> +               apb {
> +                       serial0: serial@0 {
> +                               status = "okay";
> +                       };
> +
> +                       serial1: serial@1000 {
> +                               status = "disabled";
> +                       };
> +
> +                       serial2: serial@2000 {
> +                               status = "disabled";
> +                       };
> +
> +                       serial3: serial@3000 {
> +                               status = "disabled";
> +                       };

Please drop the aliases for disabled uarts. It probably also makes
sense to have the status="disabled" properties in the .dtsi file and
only override them when you explicitly want to enable a uart for a
board.

       Arnd
