Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D664AC537
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381870AbiBGQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiBGQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:13:04 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A47C0401CC;
        Mon,  7 Feb 2022 08:13:03 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id n14so8085429vkk.6;
        Mon, 07 Feb 2022 08:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Tv1ZZY4U6OgiqoLVNvl9jUhYgfOvypYF9c1b+QKNGI=;
        b=nIUqw1ANYtCdvWO8+oRmPK9LEwEbDr76/ps4XFz+MSeiWKMSeN7iGK+L4pNr3iUtVR
         Mfv+EUmuFiEcoBfPz2i0JlwtahjcCDPau6eqzLWGYEKXkV4xcVzuLm7AzgJAomsQTtT7
         a3G2wUTie/U3tJje0YiqSFomykmD4kbIpmhOSLZmtHtrlJUt7qOBrT/Y4n31Pl0l1giT
         XSV3FlZ9JAoMAWj1AFFGXSDQl8jcVKEQM0+2hE2fs4Zc/4DF10/9Sps6C6NzsqbhmVD7
         G29IdoDKq+apZ/Qy0/1Ge2Di0iOj5tHNzLKQq4nSWzRBC5SWNo2MwWso8EpXKCk9Ijc3
         dGoQ==
X-Gm-Message-State: AOAM530uI/YGvtQ6z2+lbqKbIOOd2qYg/NWkY/eJTr6lyFRa/UfaRxfQ
        qAmFnKH9cTcNhwVik5sxBOVne82RSR7MvA==
X-Google-Smtp-Source: ABdhPJwtfh5ZPD0SOLKjIkRROc+8QJ1zH1gOpivDeR531ZNl2j3KkjmdxhrsODIVBxtdcDhMgp/QGQ==
X-Received: by 2002:a05:6122:550:: with SMTP id y16mr167028vko.31.1644250382797;
        Mon, 07 Feb 2022 08:13:02 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id d187sm2364269vke.14.2022.02.07.08.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:13:02 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 48so8159178vki.0;
        Mon, 07 Feb 2022 08:13:02 -0800 (PST)
X-Received: by 2002:a05:6122:c8f:: with SMTP id ba15mr162627vkb.39.1644250382198;
 Mon, 07 Feb 2022 08:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20220204161806.3126321-1-jjhiblot@traphandler.com> <20220204161806.3126321-5-jjhiblot@traphandler.com>
In-Reply-To: <20220204161806.3126321-5-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 17:12:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUU0AiMjP2fR4vYMbkBMqbj-v4L7DdzCDaZ9P8tS97h+g@mail.gmail.com>
Message-ID: <CAMuHMdUU0AiMjP2fR4vYMbkBMqbj-v4L7DdzCDaZ9P8tS97h+g@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: r9a06g032: Add the watchdog nodes
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> This SOC includes 2 watchdog controllers (one per A7 core).
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -184,6 +184,22 @@ gic: interrupt-controller@44101000 {
>                         interrupts =
>                                 <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
> +
> +               wdt0: watchdog@40008000 {

Please insert these nodes before the system-controller@4000c000
node, to preserve sort order (by unit address).

> +                       compatible = "renesas,rzn1-wdt";

"renesas,r9a06g032-wdt", "renesas,rzn1-wdt"
as per my comments on the DT bindings patch.

> +                       reg = <0x40008000 0x1000>;
> +                       interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
> +                       status = "disabled";
> +               };
> +
> +               wdt1: watchdog@40009000 {
> +                       compatible = "renesas,rzn1-wdt";
> +                       reg = <0x40009000 0x1000>;
> +                       interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
> +                       status = "disabled";
> +               };
>         };
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
