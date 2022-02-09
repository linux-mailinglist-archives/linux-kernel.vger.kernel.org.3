Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7514AEC82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiBIIdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:33:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiBIIdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:33:37 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC9FC05CBAE;
        Wed,  9 Feb 2022 00:33:39 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id e17so906695uad.9;
        Wed, 09 Feb 2022 00:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cmJ9+iftbcItsda29+GYKCYqcATXXpvITWHsOZgkB8=;
        b=Ce4XWaRZ/lMYTGvOvSI/kF0nIc+Y+kLYTGO8Fd6w6AY3MOw9K0nzB4zJp5vuOpzIOO
         frzdvwB4B3cQcF6KhUJK3eelYtVmcHDkVQ0zQWMDlqlQ4qgHb5zZLhuEjaA/z70nVNG6
         raqLsXJrQMCQ60OETi9saccQ6uGl/6Pn2yBD1eCCt3Gf3Glt9Zu16yPdnw97qwyCxX7w
         i1AC6B3ciIFboe1TmJTnjioicDWeyzDTU9lqtW2WA0jaGZSe+hjzaDqc9d0ip20FUkGs
         fAijxwAmBWWfeDCUyQGZIut6Nb/vF5RRWQL8xuarjjUyKQO6PBydMhJr1Zg32BXik1Yx
         ayWg==
X-Gm-Message-State: AOAM532m64GLNlFrj2za6ji/tGfscKzOz1IoiQ35U9Ecd1mEeKj8L7/l
        L2wlxpWiJaX4NO2H3VE/S3ikDlhOWD72dw==
X-Google-Smtp-Source: ABdhPJyZOaxLIm9pmbmei5G1yb27rRKfLnYUyzMfxFUxpI3+ZHZBhPRP9+nh70DAxiscIuE5iD17SQ==
X-Received: by 2002:ab0:3053:: with SMTP id x19mr373850ual.5.1644395596589;
        Wed, 09 Feb 2022 00:33:16 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id q6sm3221437vkd.50.2022.02.09.00.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:33:16 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 48so772358vki.0;
        Wed, 09 Feb 2022 00:33:16 -0800 (PST)
X-Received: by 2002:a1f:294c:: with SMTP id p73mr429038vkp.0.1644395595913;
 Wed, 09 Feb 2022 00:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20220208183511.2925304-1-jjhiblot@traphandler.com> <20220208183511.2925304-4-jjhiblot@traphandler.com>
In-Reply-To: <20220208183511.2925304-4-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 09:33:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPA+8CS371Ekx_d3Muze4CzgxwdrHO_jRg7+Vc+B+U_A@mail.gmail.com>
Message-ID: <CAMuHMdWPA+8CS371Ekx_d3Muze4CzgxwdrHO_jRg7+Vc+B+U_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: dts: r9a06g032: Add the watchdog nodes
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> This SOC includes 2 watchdog controllers (one per A7 core).
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -66,6 +66,22 @@ soc {
>                 interrupt-parent = <&gic>;
>                 ranges;
>
> +               wdt0: watchdog@40008000 {
> +                       compatible = "renesas,r9a06g032-wdt";

compatible = "renesas,r9a06g032-wdt", "renesas,rzn1-wdt";

> +                       reg = <0x40008000 0x1000>;
> +                       interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
> +                       status = "disabled";
> +               };
> +
> +               wdt1: watchdog@40009000 {
> +                       compatible = "renesas,r9a06g032-wdt";

compatible = "renesas,r9a06g032-wdt", "renesas,rzn1-wdt";

> +                       reg = <0x40009000 0x1000>;
> +                       interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
> +                       status = "disabled";
> +               };
> +
>                 sysctrl: system-controller@4000c000 {
>                         compatible = "renesas,r9a06g032-sysctrl";
>                         reg = <0x4000c000 0x1000>;
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
