Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828D3538509
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiE3PgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbiE3Pey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:34:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA57D1F62D0;
        Mon, 30 May 2022 07:39:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z186so15087336ybz.3;
        Mon, 30 May 2022 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwYudAlsrV6L0E/1oct3kLnDMatMHOnVQrUxmfQHNp0=;
        b=nJb/D6o7T7a8Mb297LS5itZxyr9hhXOWE4cI1CS2gGTaAQcWmDs6sgxITAckTcsbqO
         aVjCnMiZTw+b4RHeeUOfs7ZZ8uhJu+9H3vrDwR8kDUeIJPmAAz+dNjR8nEL4TV+1QxDF
         u49vwV3izHOZZjnCA/h3xEh2LMtiihGNrkHxPVvfRH9pZsq1jJB+cD3l2YcOrZE/FHV3
         oO0LniQOktfpUCJyeRfpEKg9DDa8WBNFOctawAeqAkazISl11g4V/X/KrhW3BSqcXDpM
         rHmuPxyGLKaHOFGx+URNH8GUTtkCZhF8UINV8Pv9mO9GCiQtRvv2jNcgvDl1QzaFiII6
         59oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwYudAlsrV6L0E/1oct3kLnDMatMHOnVQrUxmfQHNp0=;
        b=aoPXoIOYdhP8cLmwgoLQBRKqKz87uOKGoGp2WRT8WCelpPCiyjAqqm/N/1Fyaqqj7i
         9EpRd4LnnfG24ufFc0WoLojpisWHGN5149fJqESDyTwNiG2uwu0eQ55j3mn+s0vacKHh
         eigz2zr5Yh8gEd1LwGqWYjOvMYznSQaoEXObuJsvU3G33SBEuRsEDun2bJWXjZFjL131
         hIJRv0sz+Yij7YJggW9sTQp/ilq/QkJjE6BMnnmeDHUBVV74KO6hwbnRUMs+N4HpgDoG
         98KW9XWstKZleeBhmwQz/E87cIcBmRfevhNteJjJZ+lPpJnys9C2zD5ls7ugGZlOY8hb
         5rSw==
X-Gm-Message-State: AOAM533KDGkmo1GnxSNfa5ZeMNdzyV3mJ/ced2T/4aotX++ACxFArTVa
        d/zufvtSTrCnNvvCZYWlZwAvgApjqI6jyDTYe7o=
X-Google-Smtp-Source: ABdhPJwrsgLQtAtWqwcrdq2e1TjIgoIDbrErxGbmJH2wa0Fkm6oxdLbvdkS+K4BYIuwE3er69f8iVYy5UEogxMtnFeI=
X-Received: by 2002:a25:21c3:0:b0:64a:b29a:9b0d with SMTP id
 h186-20020a2521c3000000b0064ab29a9b0dmr54184246ybh.59.1653921585005; Mon, 30
 May 2022 07:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-8-tmaimon77@gmail.com>
 <20220526192412.8ECAAC385A9@smtp.kernel.org>
In-Reply-To: <20220526192412.8ECAAC385A9@smtp.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 30 May 2022 17:39:34 +0300
Message-ID: <CAP6Zq1gtB_kiEutV=uE30nev_S0rAjs=9BdMnqQbAbi-M1W6iQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/19] dt-binding: clk: npcm845: Add binding for
 Nuvoton NPCM8XX Clock
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>, SoC Team <soc@kernel.org>,
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

Hi Stephen,

Thanks for your comments.

The patch will modify according to your comments and will be sent in
the next kernel revision 5.19.rc1

On Thu, 26 May 2022 at 22:24, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2022-05-22 08:50:34)
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > new file mode 100644
> > index 000000000000..f305c7c7eaf0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > @@ -0,0 +1,68 @@
> [...]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
>
> Are clocks not required because sometimes the reference clk isn't
> connected?
require, will be fixed
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # Clock Control Module node:
> > +  - |
> > +
> > +    ahb {
>
> drop ahb node please.
>
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        clk: clock-controller@f0801000 {
>
> Drop label 'clk' as well please.
>
> > +            compatible = "nuvoton,npcm845-clk";
> > +            reg = <0x0 0xf0801000 0x0 0x1000>;
> > +            #clock-cells = <1>;
> > +        };
> > +    };
> > +
> > +...

Best regards,

Tomer
