Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89904DDA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiCRN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCRN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:29:16 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0957C6A;
        Fri, 18 Mar 2022 06:27:57 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id v14so6831013qta.2;
        Fri, 18 Mar 2022 06:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwYsNjZl1OEA0rSc4LCpGf6eFyLL2xqbEphrx6Yl5Dg=;
        b=YQ57QqWaUddnjqbkS0/3lrZqF4s2esB+vJxSP1gTzhgMCK7GbbOJlWAnv+YF8NK/mr
         KSnfiVkana9xMwEaMXrhXTZSaPLxAde/woGGlvki1MiMt0teP4e16IkyhVvFPQ4IAtRS
         wMeiYZhab3tZtBwokZRBVqdJ/flG8BONolTf4w2kGk4kJdN59FIG9IPqwY5qIG74Gr8A
         dANJvAKaIsCYSIP7DgoIxSfOKze25Fx6oObfk4uMzz9aM/2QbAO7Zmpxl6zuFEmxE4/Z
         HS48bQRNGStaRduQLSPfwuFjY0Pvm+eWG9rkr9RCgSRnRiTGsFtW/7CA7CrI4HrCq7oU
         zQBg==
X-Gm-Message-State: AOAM531WJgDmEsxBnvi4l5g8SqqrdTysjJFeBwl8gBMsfcE3bSSTp00u
        Tc9eF3lsKJ/cHgfb5DB3FgBAsIJuVNdqiQXY
X-Google-Smtp-Source: ABdhPJzr/8XxLHe9czn8uTip2PGqsesgcgLjFDAt9QSdxOlPvQEg7ROIY+kMpM17rPg/F+4KRhyukQ==
X-Received: by 2002:a05:622a:195:b0:2e1:bce1:712b with SMTP id s21-20020a05622a019500b002e1bce1712bmr7439682qtw.114.1647610076307;
        Fri, 18 Mar 2022 06:27:56 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id j11-20020a05622a038b00b002e1f0bc2e8csm3567523qtx.81.2022.03.18.06.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:27:56 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e5a8a8c1cdso82301357b3.3;
        Fri, 18 Mar 2022 06:27:55 -0700 (PDT)
X-Received: by 2002:a81:24d6:0:b0:2e5:b253:f9fc with SMTP id
 k205-20020a8124d6000000b002e5b253f9fcmr11309387ywk.438.1647610075527; Fri, 18
 Mar 2022 06:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220308223324.7456-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220308223324.7456-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220308223324.7456-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Mar 2022 14:27:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUs4X+A+kdmoaUxf2eqoYFQ6GhR2fqnAfdmn=yOHLWdCQ@mail.gmail.com>
Message-ID: <CAMuHMdUs4X+A+kdmoaUxf2eqoYFQ6GhR2fqnAfdmn=yOHLWdCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r9a07g054: Add TSU node
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 11:33 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add TSU and thermal-zones nodes to RZ/V2L (R9A07G054) SoC DTSI.
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
