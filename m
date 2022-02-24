Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2B4C2884
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiBXJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiBXJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:50:10 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228012819B2;
        Thu, 24 Feb 2022 01:49:40 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id p33so609901uap.8;
        Thu, 24 Feb 2022 01:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IkiN0VIfOnYW5l2ddoLdbKXjFAORIEW7LEcXcst+cU=;
        b=W7Jc42pt22ZkEpdnueYEPN7U/0bcpQgFvPDq0tNlhrn6ZmfeDp8ieB0YLCYZUyookc
         H2+H+FHS/7yFiiZ1Y48nj9namidksaxQHyp/6msHeDIxPXaEO9BGvM5IZfSEiIOERTeA
         CB1QDfZgTOUnweMnG0TuNDJSHF6HEJP9xAg5RvzllKYCojK/34cuJz+oR0pqOnoCKtDU
         H7zIsWVcApnxhI1WF3Z917xDTtzhAiAiGoAXxw88XQaBPSf2A+ktpUmIEGqZPxeR9Sx8
         A3/9T06T4SeQYtSBfwx4qxyKbGBoS+PwiSrjFjgeUmzGl14iKJxEvBXnHpwNC2gJfOdS
         iniw==
X-Gm-Message-State: AOAM53149u0ntyYC1qqBiJO9bRlmUcCd1D7mJPJhjUpzeS/sA8XGvdWW
        qdcxIsMbxbY9kUWPCGC2EUbyApUg/rPruA==
X-Google-Smtp-Source: ABdhPJxWI0W/CyVSr5GWmiGwIMIRNdaGuMDum0EpH4QRfsA9DlmWB46r/KgbqAXgfSahbTiyIZ9YnA==
X-Received: by 2002:ab0:b05:0:b0:342:2961:37ee with SMTP id b5-20020ab00b05000000b00342296137eemr735920uak.29.1645696179094;
        Thu, 24 Feb 2022 01:49:39 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id l187sm322879vke.6.2022.02.24.01.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:49:38 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id t22so1513805vsa.4;
        Thu, 24 Feb 2022 01:49:38 -0800 (PST)
X-Received: by 2002:a05:6102:4411:b0:31b:6df1:3b80 with SMTP id
 df17-20020a056102441100b0031b6df13b80mr761507vsb.5.1645696178512; Thu, 24 Feb
 2022 01:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20220224092114.25737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220224092114.25737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 10:49:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWebGqoLeDcTYM9vKkdVpC0wCfcUSpV6gr+4wphzkacCg@mail.gmail.com>
Message-ID: <CAMuHMdWebGqoLeDcTYM9vKkdVpC0wCfcUSpV6gr+4wphzkacCg@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Introduce ARCH_RZG2L config option
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Thu, Feb 24, 2022 at 10:21 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/G2L, RZ/G2LC, RZ/G2UL and RZ/V2L SoC's have identical IP blocks
> for which drivers are common. To avoid updating the Kconfig files for
> drivers in common to each SoC, introduce the ARCH_RZG2L config option.
> ARCH_RZG2L config option will be selected by the above mentioned SoC's and
> ARCH_RZG2L config option will be used as a dependency for the drivers in
> common.
>
> While at it, move PM and PM_GENERIC_DOMAINS under the ARCH_RZG2L
> config option instead of adding it to individual SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18, so you can start updating
dependencies after v5.18-rc1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
