Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC74C6FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiB1Orh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiB1Orh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:47:37 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82927F6D9;
        Mon, 28 Feb 2022 06:46:56 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id j7so1515627uap.5;
        Mon, 28 Feb 2022 06:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkv1u/oC76T/ywctXkUzgjlhF9lYc1skXbf9g5YwS34=;
        b=ElMMzwsq7ked7M/P6tEDkLBQgTgVfGhI9f21GfPbIDDYX8NHcQzyPQIR/lvDpIBHyA
         ACAizw9+Qpy1coW6Tr9TtSk79mRlOZmPENSkTK45/Jihbyaxc+cFjFncy+LxbdXbrBDf
         VF7bvoSGSJbG7w8wMX8w+HN+ejYWM0D/Z0mhyEyHG9anGBvssYskmbRsk1iinK0z+J4l
         daVqQcFJstVe8q8G9sEDUI2hqIZRAnrvbVco+QkUmvVQcOdutowqQ8kWDSmRnirvacpk
         yHwPY/0tUX5LMtj5dRb44WQew6ndWhBFWgX7LotwGIVeoX0DP1L0dxz45TdJaFaz6y2f
         eKVg==
X-Gm-Message-State: AOAM533VL3g+ynC6Gzz/XfyfTFRO09tc5oKa0SkKPSpswY/hU54LAzbO
        KQd4A2Fp6Hf0H/2n/dZcpjYqaiq2yVeTmg==
X-Google-Smtp-Source: ABdhPJwyccWMwvsmSnvTIQGHHXslnVzc56z/FNNteTpLXMxgDMutY5LYTGNIRb/5jsfRz+Q3TK84kw==
X-Received: by 2002:a9f:2482:0:b0:341:c96f:e71d with SMTP id 2-20020a9f2482000000b00341c96fe71dmr7305025uar.9.1646059615937;
        Mon, 28 Feb 2022 06:46:55 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id o16-20020a05610232d000b0031b075821b4sm1240982vss.27.2022.02.28.06.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:46:55 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id l10so5271849vki.9;
        Mon, 28 Feb 2022 06:46:55 -0800 (PST)
X-Received: by 2002:a1f:6087:0:b0:328:e94a:54b3 with SMTP id
 u129-20020a1f6087000000b00328e94a54b3mr7895015vkb.20.1646059615405; Mon, 28
 Feb 2022 06:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:46:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_HUHnqj0XmXxH9LEFNqt=wVf=nX9XHd3x0-3iDLsv0A@mail.gmail.com>
Message-ID: <CAMuHMdU_HUHnqj0XmXxH9LEFNqt=wVf=nX9XHd3x0-3iDLsv0A@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>
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

On Mon, Feb 28, 2022 at 12:00 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add RSPI binding documentation for Renesas RZ/V2L SoC.
>
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required. The fallback compatible string "renesas,rspi-rz" will be used
> on RZ/V2L.
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
