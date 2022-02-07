Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5F4AC54B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbiBGQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385851AbiBGQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:15:17 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53AC0401CC;
        Mon,  7 Feb 2022 08:15:17 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id b37so23465513uad.12;
        Mon, 07 Feb 2022 08:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVSjaW0Us1eT+X5Ib/YRElv3mU0go0SgAeSCTVz31wY=;
        b=4QP9/1CAsQ2p59BKZcTbKkHSG8AlzOao/oXfpGFFTvKm5LM0ne/2lAZ7kdoZP4f+nj
         9dMBbXaoanevqNssBzYGbbC2DktsKUHnHx71Na4e2RgEcWEF1vEaSUpMgf6A6mCGBeYW
         h1kD6/0YZ/ehBcqjWhTnhYOK4/JlFImO4YESTXEG1V7QdbjIAFoiwCiPxtwNqRw9g7CW
         0tgjHwPmxgDpMnxNbBdadIBThazhzWrPwVpXnxeokDObw9fsMlCfOvStWkA1ZQUiGPM4
         vQGz42ypZ5aw7oZnDQxakqi8pvJYB6vuyWg09asBu7xTA9gZDpcWEfTcI9Od99Y9i0Oo
         H68A==
X-Gm-Message-State: AOAM530j18g5OX9EFvJYbM9UY1NJCl8DZDyC0K/LLsszqxlLwD1uV19u
        cKgiCK0l/HfJoT3nqBM5l1+YzIwVo0Skww==
X-Google-Smtp-Source: ABdhPJyB0wxpAgCqZ1gyHqQpudLR5onBuOtVu9FH3JQwPAs4y6H8SmNaNPuj71MJbTBQ870uOO1WVQ==
X-Received: by 2002:ab0:3c86:: with SMTP id a6mr171191uax.6.1644250516393;
        Mon, 07 Feb 2022 08:15:16 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id k20sm2190317vsg.14.2022.02.07.08.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:15:16 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id l14so8095714vko.12;
        Mon, 07 Feb 2022 08:15:15 -0800 (PST)
X-Received: by 2002:a05:6122:1254:: with SMTP id b20mr197626vkp.0.1644250515772;
 Mon, 07 Feb 2022 08:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20220204161806.3126321-1-jjhiblot@traphandler.com> <20220204161806.3126321-6-jjhiblot@traphandler.com>
In-Reply-To: <20220204161806.3126321-6-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 17:15:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSxdjvWnZ9wC4uejBsiEauTeioij66W2uOODRv-FwnPg@mail.gmail.com>
Message-ID: <CAMuHMdWSxdjvWnZ9wC4uejBsiEauTeioij66W2uOODRv-FwnPg@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: r9a06g032-rzn1d400-db: Enable watchdog0
 with a 10s timeout
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

Thanks for your patch!

On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> 10s seems a reasonable value for a watchdog.

All other Renesas DTS files use 60s. Would 60s be OK for you?

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

> --- a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> @@ -23,6 +23,11 @@ aliases {
>         };
>  };
>
> +&wdt0 {

Please insert below "uart0", to preserve sort order (alphabetically).

> +       timeout-sec = <10>;
> +       status = "okay";
> +};
> +
>  &uart0 {
>         status = "okay";
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
