Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342B4C87F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiCAJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiCAJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:25 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD48F1090;
        Tue,  1 Mar 2022 01:32:33 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id k9so6542993vki.4;
        Tue, 01 Mar 2022 01:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JewjBvTz72R+8K96y3pWlhGhOTqqPKm2D0L3LCWGapc=;
        b=cXj2I73JyzcboCghrBrdaePwE/SwuQoWc+ryOofBe/N0BcDDQ2HROZ0/qLw8tlVjX3
         jGo0OGgLVBUFe6t2c0R/dokXD7HaFhnc5/TJ9iJpFrDYFYkZE1+0u5A0vvDpL2xp4ilM
         TqazDjwiVfYaVHltVI1KGWXuJemjC4wCPr0TuBIrgTQQOn8VgAUZ7cwxZl+UhFt/Tv7E
         JpM6LBgsMRwvGkyOOvpsbXZyX3eP9BpzF257yjK0brM7Vwvhs1KK3rtewGwTMQ5SUe9R
         ielv8YDHi9s3vBBGoiU7ONOB3pkg2ScWekB/jWsdsfXEYwGEz39Nf95ZU2UiBKdSTSEO
         Co+g==
X-Gm-Message-State: AOAM530FwLEq+ERynRvGkX53uogGBfoiUJ4pZj+iByHyK7xQLPLAAdEH
        g3picnXJS+ks1ZSUJgkBYlqMNJRQWGRwOA==
X-Google-Smtp-Source: ABdhPJzEEteiw+8b2xBdTr45TSwjVYghMnR6qU2K2ZMJ+SknnFp3IY0ZKrQqoJ4nW0BvowRoeAftlg==
X-Received: by 2002:a1f:348a:0:b0:32d:34f:7941 with SMTP id b132-20020a1f348a000000b0032d034f7941mr9607573vka.13.1646127152627;
        Tue, 01 Mar 2022 01:32:32 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 4-20020a1f1604000000b00330d7b11691sm2083692vkw.51.2022.03.01.01.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:32 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id i27so15842686vsr.10;
        Tue, 01 Mar 2022 01:32:32 -0800 (PST)
X-Received: by 2002:a67:b00e:0:b0:30d:dc98:6024 with SMTP id
 z14-20020a67b00e000000b0030ddc986024mr10340330vse.57.1646127152232; Tue, 01
 Mar 2022 01:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW2ckTAttC4Wx8Uo=Q6FAAktK-40usfGMgNS9x5jtEeyg@mail.gmail.com>
Message-ID: <CAMuHMdW2ckTAttC4Wx8Uo=Q6FAAktK-40usfGMgNS9x5jtEeyg@mail.gmail.com>
Subject: Re: [PATCH 02/12] arm64: dts: renesas: r9a07g054l2-smarc: Drop
 deleting gpio-hog pins related to SDHI
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
> Drop deleting gpio-hog pins related to SDHI0/1 so that SDHI functionality
> gets enabled on Renesas RZ/V2L SMARC EVK.
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
