Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451094D2A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiCIIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiCIIQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:16:28 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909DAE02CD;
        Wed,  9 Mar 2022 00:15:30 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id e22so1397064qvf.9;
        Wed, 09 Mar 2022 00:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxAUDyS9GJLYSOSCc/5rpqFIxvMO8bZDSJoz+/4nqZE=;
        b=6xjZVgDMfz1TxOIGdMxLLkKGmEKdLtgqrbessUQn/+m9ULl9XXELzjK9fJyFlAZ22B
         2rg3ZR3Kjxu5Kd3YE7xI2Ndsd+k4jETqKotq9Vq5855edjGaLMbiUPmD+YjdIEUBVghD
         IyrgfN3Rnu4r3ahhvRbU7w2yc58H3yND7+lD/fUHxU/LDJprtzuzioXdLmS2/ppM88t3
         Q3y2aPp/+CCB9cTtjuvtJDu5O3rOQYz1IWwwWm/TnO/aRxw85jidHgKo5WY/UFYhVatT
         8Yfqqx6yuY9WnMfvHSiGy3OADXnDtASNmLK4ramMuzc1o5olJCwT9Tv9J2k8vLJSFHKw
         nmHw==
X-Gm-Message-State: AOAM533zdhuM9XK8KS5tl/+5PX32dYsVqk/u7Y/KzzWL7YSvs0oUD6Ia
        LvJBNqAX9pwVBe3vWcukTnuvA4vtWllEGg==
X-Google-Smtp-Source: ABdhPJx+oYvs9QIq6WWeTPOaPh/sQlMSM5QMEm7pRhAdnwC/+0PEjcSdVFaiOWoSShpgDOiBPHtsCg==
X-Received: by 2002:ad4:594a:0:b0:435:23f0:d6ba with SMTP id eo10-20020ad4594a000000b0043523f0d6bamr15694088qvb.90.1646813729054;
        Wed, 09 Mar 2022 00:15:29 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a13c700b002de9f3894c2sm931275qtk.50.2022.03.09.00.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:15:28 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2dbfe58670cso14262697b3.3;
        Wed, 09 Mar 2022 00:15:27 -0800 (PST)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr15779778ywi.449.1646813727425; Wed, 09
 Mar 2022 00:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20220308211543.3081-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220308211543.3081-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Mar 2022 09:15:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuu8-wEfVRZo-yLCBaTYhOa1No1mE+SgekW3jQW9+9ig@mail.gmail.com>
Message-ID: <CAMuHMdUuu8-wEfVRZo-yLCBaTYhOa1No1mE+SgekW3jQW9+9ig@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Tue, Mar 8, 2022 at 10:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The Renesas RZ/V2L SoC (a.k.a R9A07G054) has a Bifrost Mali-G31 GPU,
> add a compatible string for it.
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
