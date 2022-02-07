Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8454AC534
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381816AbiBGQPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443857AbiBGQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:08:02 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21508C0401E6;
        Mon,  7 Feb 2022 08:07:56 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id r20so138116vsn.0;
        Mon, 07 Feb 2022 08:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IH36XLf83w5u+4nl2DlHKSEzZJZ+m1Rf3raz8J+6Itg=;
        b=1QzYjFazcmACfnMDQLrEufUJe9Y7DpWVdd6XmtQ9LJm9+m4a2EuFnno3gHAJ0Ld+bd
         SK10tf12+ZClghoCVLL+sHNipj+f01NhMCgtzlIxvObDNeX6X2dNYZi+EZEoJjryMNIE
         dKowQpS5N5JJrmHYMjaictmEq8yVWhjrz1aQfrvpmLKp/M4Kcdt+SBSsYTH22esV8Ce3
         GJWj63tpLmnM9Ues2QhQ4o1TqpCx3615eXM6VyD71CgQB+U/Q47BGf38awEU4p0w6n5y
         lxIq6vmGkj8Bo6FeOM4puRkLYqLA92DdkZMAQM2wDefHCjuoP530o3/bqXbrt6+S2s7r
         FsKA==
X-Gm-Message-State: AOAM532dy0vuW/jfUBWE/jGdCBJUzhBqgHfCv9Xv52OB3KAG4dxU2n1X
        OTRZaSJCzkxJ5fupvKLKgkraRdcpvqwyDg==
X-Google-Smtp-Source: ABdhPJyG+bsBR+XO8uk9FDGc3Q2JhjXtVGeLtOnf4iQNxV539yNPl1mNAbkFgkhdTD3tDub9YW3SOA==
X-Received: by 2002:a67:ec15:: with SMTP id d21mr95557vso.79.1644250075179;
        Mon, 07 Feb 2022 08:07:55 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id g20sm1015104vkq.46.2022.02.07.08.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:07:55 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id a7so138550vsc.6;
        Mon, 07 Feb 2022 08:07:54 -0800 (PST)
X-Received: by 2002:a67:b00e:: with SMTP id z14mr142941vse.57.1644250074734;
 Mon, 07 Feb 2022 08:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20220204161806.3126321-1-jjhiblot@traphandler.com> <20220204161806.3126321-3-jjhiblot@traphandler.com>
In-Reply-To: <20220204161806.3126321-3-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 17:07:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFs_G0ZENwRttxBbnUMZZyJ5Nks12FvNJnaJjbrXYcNg@mail.gmail.com>
Message-ID: <CAMuHMdUFs_G0ZENwRttxBbnUMZZyJ5Nks12FvNJnaJjbrXYcNg@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clock: r9a06g032: Add the definition of
 the watchdog clock
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> This clock is actually the REF_SYNC_D8 clock.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks for your patch!

> --- a/include/dt-bindings/clock/r9a06g032-sysctrl.h
> +++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
> @@ -74,6 +74,7 @@
>  #define R9A06G032_CLK_DDRPHY_PCLK      81      /* AKA CLK_REF_SYNC_D4 */
>  #define R9A06G032_CLK_FW               81      /* AKA CLK_REF_SYNC_D4 */
>  #define R9A06G032_CLK_CRYPTO           81      /* AKA CLK_REF_SYNC_D4 */
> +#define R9A06G032_CLK_WATCHDOG         82      /* AKA CLK_REF_SYNC_D8 */
>  #define R9A06G032_CLK_A7MP             84      /* AKA DIV_CA7 */
>  #define R9A06G032_HCLK_CAN0            85
>  #define R9A06G032_HCLK_CAN1            86

I couldn't find this in the documentation, so I have to trust you on this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
