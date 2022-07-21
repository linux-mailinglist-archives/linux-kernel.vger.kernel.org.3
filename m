Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC72957C951
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiGUKrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiGUKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:47:05 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FDF82FA0;
        Thu, 21 Jul 2022 03:47:04 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id r24so930788qtx.6;
        Thu, 21 Jul 2022 03:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtAClvava5OaVvxoLmcOvbk7139s85HNiEWroOEbaeA=;
        b=GGdpwtW2ohMebBjwJ7cgCG58a1O1wyT0bKmOgBZX1RTl2hyorlJoRmT5eUu/+Bu/ii
         VZIzHjIX3BH2OHqF7iWMFVaUAH2QM6u4EQ/cgspUWOumckUF9l3RX+mZEPt4v2O99fpY
         YciwgvLnEYLQLEnzwVcUs6eSx2PsxQXI+yFF2oUD6y04TEiYOnSEfpby2gsaF5A2SEfo
         ThSBTHpg2cy045Yf8OXKLUSygteS830EORlENsIy2+x8WKD2AXgC7WNrV8CJqtqTLRt5
         A2MmcBdDELebwFANTIk+XqZqZrcAyFscVcTecZXv01+4NvJ05LzWHsp7u+NBgH+6+Snj
         DKnQ==
X-Gm-Message-State: AJIora9bEi3VF6BtOASY7wOwkHcP7y1Tat0rjn0oww3pN0ucUdYHQ6+j
        D2xEj90RfqVPXmFYsAby84RJeUGmE3bOiQ==
X-Google-Smtp-Source: AGRyM1tEGbUXH8fdoUhEGXKnzid2V5Dg2EdjoJUqBYzh2T2gQ3Y8VuNpu16/xV50ufLYGMlXzs3tvg==
X-Received: by 2002:a05:622a:5d4:b0:31e:e357:f843 with SMTP id d20-20020a05622a05d400b0031ee357f843mr20162227qtb.588.1658400423627;
        Thu, 21 Jul 2022 03:47:03 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id fd9-20020a05622a4d0900b0031ef21aec36sm1094845qtb.32.2022.07.21.03.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:47:03 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31e47ac84daso13110797b3.0;
        Thu, 21 Jul 2022 03:47:03 -0700 (PDT)
X-Received: by 2002:a0d:dd15:0:b0:31e:6ce3:e67f with SMTP id
 g21-20020a0ddd15000000b0031e6ce3e67fmr6929763ywe.316.1658400422915; Thu, 21
 Jul 2022 03:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220718195651.7711-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220718195651.7711-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 12:46:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com>
Message-ID: <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: rzg2l-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
> and ETH1 respectively.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> @@ -94,6 +94,8 @@ phy0: ethernet-phy@7 {
>                 compatible = "ethernet-phy-id0022.1640",
>                              "ethernet-phy-ieee802.3-c22";
>                 reg = <7>;
> +               interrupt-parent = <&irqc>;
> +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;

2?

"The first cell should contain external interrupt number (IRQ0-7)"

>                 rxc-skew-psec = <2400>;
>                 txc-skew-psec = <2400>;
>                 rxdv-skew-psec = <0>;
> @@ -120,6 +122,8 @@ phy1: ethernet-phy@7 {
>                 compatible = "ethernet-phy-id0022.1640",
>                              "ethernet-phy-ieee802.3-c22";
>                 reg = <7>;
> +               interrupt-parent = <&irqc>;
> +               interrupts = <4 IRQ_TYPE_LEVEL_LOW>;

3?

>                 rxc-skew-psec = <2400>;
>                 txc-skew-psec = <2400>;
>                 rxdv-skew-psec = <0>;
> @@ -171,7 +175,8 @@ eth0_pins: eth0 {
>                          <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
>                          <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
>                          <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
> -                        <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
> +                        <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
> +                        <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
>         };
>
>         eth1_pins: eth1 {
> @@ -189,7 +194,8 @@ eth1_pins: eth1 {
>                          <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
>                          <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
>                          <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
> -                        <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
> +                        <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
> +                        <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
>         };
>
>         gpio-sd0-pwr-en-hog {
> --
> 2.25.1
>


-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
