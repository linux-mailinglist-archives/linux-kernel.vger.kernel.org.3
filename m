Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A045954B511
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiFNPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiFNPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:49:10 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F512E08F;
        Tue, 14 Jun 2022 08:49:09 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id hf10so6371872qtb.7;
        Tue, 14 Jun 2022 08:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Lz2xm2OeZO7pMrkyEsrx4M6KP6BHP9ACsFmmAuNdJE=;
        b=xVvu73MHUUEUj5+r+6n9WWuTseX4F2sccRHYu+YldWfqvA8mMn6/pXcQtD+jFJL1ui
         6cPQSeHEl9HSuqZq42zDFsnQI9Fwk4sM6/S6FIRj8sR1P/WwcRMXUN0V4jRNaJUYi/2k
         A0V2YLT7kEyM4jyCyIWI0PzCi6MHaxRRbDH2jcnpnMJwLL1JGsKI3S9fxcKqh1Q8F0Sq
         HsbmwP6eChRfVZgjXn9nKC0WYd+p2mhZAiPLnp2YjaMJ/urXbxbHNxA5vgDXSMrQCo37
         eaQj492q3ujuUSq3CKiWp0gZ00FDdIWQsFtcBI1KRuJ/+2+c4TRvBihUaeH6oM5U9AsM
         29dg==
X-Gm-Message-State: AOAM530gjNvijQSxjvAoVgb/zu0JptURiE9v2CWanc7F5vasq+S72d4C
        P7g2VIbRKacHhU75/GDpKHi6zv/JC9kF8A==
X-Google-Smtp-Source: ABdhPJyjZcL86ZtgiGvwCCHzMJs3/IaCrGdoWU8qbUZEZINAZox7I51VQVdQ2FJypRfyrO20F7QkBQ==
X-Received: by 2002:a05:622a:1393:b0:304:b6c8:bca2 with SMTP id o19-20020a05622a139300b00304b6c8bca2mr4637798qtk.642.1655221748403;
        Tue, 14 Jun 2022 08:49:08 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id j9-20020ae9c209000000b006a377a015d4sm9466708qkg.39.2022.06.14.08.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:49:08 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id v81so15942249ybe.0;
        Tue, 14 Jun 2022 08:49:08 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr5874556ybb.202.1655221747725; Tue, 14
 Jun 2022 08:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220613134914.18655-1-wsa+renesas@sang-engineering.com> <20220613134914.18655-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220613134914.18655-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 17:48:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJ9N1=X0O0LtpPrjH-uSbupKAVr+J3KwStL7xYgMxfWw@mail.gmail.com>
Message-ID: <CAMuHMdWJ9N1=X0O0LtpPrjH-uSbupKAVr+J3KwStL7xYgMxfWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: spider-cpu: Enable SCIF0 on
 second connector
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Mon, Jun 13, 2022 at 3:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The schematics label it as SCIF0 debug port.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
> @@ -68,6 +68,11 @@ i2c4_pins: i2c4 {
>                 function = "i2c4";
>         };
>
> +       scif0_pins: scif0 {
> +               groups = "scif0_data", "scif0_ctrl";
> +               function = "scif0";
> +       };
> +
>         scif_clk_pins: scif_clk {
>                 groups = "scif_clk";
>                 function = "scif_clk";
> @@ -79,6 +84,14 @@ &rwdt {
>         status = "okay";
>  };
>
> +&scif0 {
> +       pinctrl-0 = <&scif0_pins>;
> +       pinctrl-names = "default";
> +
> +       uart-has-rtscts;
> +       status = "okay";
> +};
> +
>  &scif_clk {
>         clock-frequency = <24000000>;
>  };

This needs a new serial alias under /aliases.
Mixing dynamic and static serial IDs may cause conflicts, cfr. commit
7678f4c20fa7670f ("serial: sh-sci: Add support for dynamic instances").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
