Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8DB4C87EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiCAJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiCAJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:09 -0500
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB7238C;
        Tue,  1 Mar 2022 01:32:26 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id k15so6511315vkn.13;
        Tue, 01 Mar 2022 01:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmBuEeEkNgyglmoF77tgJNw395jGGrywHF1cLG5KpiI=;
        b=bSri+fCHU68MpYa7QsSX/FnJEw4OlqHwZXjV4p6re6uh35j8sjJ06CmHUWqSgFXn/S
         kwQmLf4YGZ44p1/LX+JAp1//skylIJsIT6/ksIg+wr1I6PP6+Jz6PFTy50og9ijBdZzc
         I3xX8DZTDk5DHCCWa17H06GKWlDlbuGJHgZ+7HRUfXSLHkAHJ2wb0AEiIkaTvta6QSH7
         8PZu0z1sIHArNp8p7z9xZPQta+ZmeurjtJfdCTs9jPHxxPPEmop14w+iAleKzrBMlfty
         dNx2Xiz31OBogO2ttnLlzJMFYMuaffkXvlfv3XhJCNyS3EYBzE+e6pvAChMRGyKdw1aO
         fwRA==
X-Gm-Message-State: AOAM533UGIUCtzSqh5F/EZEFfy/WRBhFwohgH30Oy2EaTwqYdH+JTWj3
        39zDdL5fmfDEJpTCX7T5w6OpFGFh12uDDA==
X-Google-Smtp-Source: ABdhPJwk6oxJlenxS8qvGnnPtXGcRwaRjwU/0XKAcKf8QsA+EKL7Q5OEpuC0M9zCrj2N0EWI76KVdg==
X-Received: by 2002:a05:6122:20aa:b0:32d:4894:f680 with SMTP id i42-20020a05612220aa00b0032d4894f680mr10516021vkd.1.1646127145042;
        Tue, 01 Mar 2022 01:32:25 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 127-20020a1f0085000000b0032d19f4946esm2045012vka.28.2022.03.01.01.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:24 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id g20so15877273vsb.9;
        Tue, 01 Mar 2022 01:32:24 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr9523062vsl.68.1646127144326; Tue, 01 Mar
 2022 01:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWKWOF_4mqDj8J2C2KN=EZ6+7zYA8hh35YkR435hvepwg@mail.gmail.com>
Message-ID: <CAMuHMdWKWOF_4mqDj8J2C2KN=EZ6+7zYA8hh35YkR435hvepwg@mail.gmail.com>
Subject: Re: [PATCH 01/12] arm64: dts: renesas: r9a07g054: Fillup the
 SDHI{0,1} stub nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sun, Feb 27, 2022 at 9:38 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Fillup the SDHI{0,1} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
