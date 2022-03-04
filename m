Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB2D4CD458
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiCDMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCDMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:38:36 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246534E3B7;
        Fri,  4 Mar 2022 04:37:47 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id v128so4091484vsb.8;
        Fri, 04 Mar 2022 04:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOH735E+VucQT20j1gNC+hhSNDzASMXoPAxJOcmos/E=;
        b=XvcqEPfm243WJSfHHk3htCYvf2oJiOOaaf8tARvgeLE5mh52GBCHS7ls4p0VXgHNGY
         UkYTkE9f6HB2ON/eBusQUyPx+xsAKv9GbpIFcw+AnVQASDFPDBFGSDkuogJpdE5evfuP
         U4JCNA2a6o9zkRSTAHdSM/VUuzXIXMfuMN+wAEGIs4P8/5GuQFAv+qZJd4P/bw+ZU1Dl
         BHgJXfFfsJOx5lvDaIb5pLK3fOWhTDT6tf8rZKpmghTJ+P+5AOXhZzEMPbCFiGPdsCDl
         5H+gfnHLiPPMEBbFWpk8gdven7mABok/KGk5JNt2bsGAzOK/EzuYNtR2CyGthMNzs+WE
         sVSQ==
X-Gm-Message-State: AOAM532tKRNgRRwCecf6hWhxu7plhx1ULoPOdTh3mjgMnauQa2OEr8C4
        NbzGtoOiibBi7Q5Sc+AfzowkeAYsbVfq0A==
X-Google-Smtp-Source: ABdhPJxdrhoCnd6UV42jcAmA552wjS8d6HILavg79WLtmr+MOp1IsB6n6PigNUA1neNpas1o5F2pNg==
X-Received: by 2002:a05:6102:418a:b0:31a:1d33:6803 with SMTP id cd10-20020a056102418a00b0031a1d336803mr17846056vsb.40.1646397466085;
        Fri, 04 Mar 2022 04:37:46 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id e20-20020ab02b14000000b00345f0381ddcsm874030uar.0.2022.03.04.04.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 04:37:45 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id y4so8868542vsd.11;
        Fri, 04 Mar 2022 04:37:45 -0800 (PST)
X-Received: by 2002:a05:6102:2922:b0:31e:bd90:f1c3 with SMTP id
 cz34-20020a056102292200b0031ebd90f1c3mr6892512vsb.77.1646397465187; Fri, 04
 Mar 2022 04:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20220304114110.3939390-1-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20220304114110.3939390-1-kieran.bingham+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Mar 2022 13:37:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+sO+LAOxaSfN6aLa4ROnF71j=RQVqk_1jAfvjYyeCwA@mail.gmail.com>
Message-ID: <CAMuHMdU+sO+LAOxaSfN6aLa4ROnF71j=RQVqk_1jAfvjYyeCwA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: falcon-cpu: Use INTC_EX for SN65DSI86
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        open list <linux-kernel@vger.kernel.org>
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

Hi Kieran,

On Fri, Mar 4, 2022 at 12:41 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
> The INTC block is a better choice for handling the interrupts on the V3U
> as the INTC will always be powered, while the GPIO block may be
> de-clocked if not in use. Further more, it may be likely to have a lower
> power consumption as it does not need to drive the pins.
>
> Switch the interrupt parent and interrupts definition from gpio1 to
> intc_ex, allowing the PFC to configure the pin muxing accordingly.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
> @@ -198,8 +198,8 @@ bridge@2c {
>                 clocks = <&sn65dsi86_refclk>;
>                 clock-names = "refclk";
>
> -               interrupt-parent = <&gpio1>;
> -               interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-parent = <&intc_ex>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
>
>                 vccio-supply = <&reg_1p8v>;
>                 vpll-supply = <&reg_1p8v>;

The above is correct, but you forgot to configure pin control for the
irq0 pin.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
