Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376D94D2A73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiCIISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiCIISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:18:18 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31AC166E0E;
        Wed,  9 Mar 2022 00:17:18 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id a14so1238069qtx.12;
        Wed, 09 Mar 2022 00:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35/fzUJmyZh70VM9SdFaR6MnuP0bGFW2YUKkfdLZvtY=;
        b=zzG6gwLgkifK3NHs5l5W1mPnbMjdYn46UtmzYYMPZwdQYD5couPR/uUPBm6t1YFirv
         7XK2BGCegVzuGKhXW5HrfdY0T17+rUlK1Xu6cVM+Z35CSrr/ClJmPo9p5t7jchZota2w
         bujy7xf/E2lKqnLbLY9PCFvFmluLy/SSCnTe3uz7QQ6RqCbBhs4RtOJ3nzs3Zexo9APq
         QS52b3LfRs4mwTbgHcZMOZSjNaOPVM6IZOSRMqmIcwOrVIEbJpCyUp4ZYqX/Wh4RLRjT
         IA9XVtYa0nVHUJx+0rtIzbsCqamR5CeaifdjPDT05tlW3/7rlTsuyuvJ7G3ybzYouxZH
         x5zg==
X-Gm-Message-State: AOAM532VRFC/uIT2I+wBdNGokQlY7aKh4ZhPexkVjuyXniLeTt5H50py
        XOQ74GeWyUR+7T0kjD1v0v/POdzCrv3/6Q==
X-Google-Smtp-Source: ABdhPJy5NUZ1e22kMEvbrC3NoR38LNeI0GEHpPtEAwp6L8m2FR1dzz9+fYtJomuTQ1sat7Z0f5zxRw==
X-Received: by 2002:ac8:59d5:0:b0:2e0:775e:ed9e with SMTP id f21-20020ac859d5000000b002e0775eed9emr4385680qtf.419.1646813837622;
        Wed, 09 Mar 2022 00:17:17 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a04c800b002e06d7c1eabsm925904qtx.16.2022.03.09.00.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:17:16 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2dbfe58670cso14305817b3.3;
        Wed, 09 Mar 2022 00:17:16 -0800 (PST)
X-Received: by 2002:a81:6dd1:0:b0:2dc:56d1:1dae with SMTP id
 i200-20020a816dd1000000b002dc56d11daemr15691271ywc.479.1646813836049; Wed, 09
 Mar 2022 00:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20220308212315.4551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220308212315.4551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Mar 2022 09:17:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpZrfuXBh1-mfv2z9aaUpUEjotCgr-i70sv72WN55_dw@mail.gmail.com>
Message-ID: <CAMuHMdXpZrfuXBh1-mfv2z9aaUpUEjotCgr-i70sv72WN55_dw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rzg2l-thermal: Document RZ/V2L bindings
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Tue, Mar 8, 2022 at 10:23 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L TSU bindings. The TSU block on RZ/V2L is identical to one
> found on RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-tsu" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
