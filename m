Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5457C932
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiGUKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiGUKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:39:36 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB782463;
        Thu, 21 Jul 2022 03:39:35 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id kh20so841457qvb.5;
        Thu, 21 Jul 2022 03:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3en6cyDPa1SruHHHVqAUOOdbcVIPyK0ecTvVZtCNsk=;
        b=qjO5sv1TPG4VUpDgWoB7iLcAxuX26P1sxBqZVmEIwKs+IJKoTMZNQM6uNe5nDkB3+3
         ABvpwn/MZSfJ4njEhF0ashbmz/pgte6x03k/474pJlExmfZOIMblJzrK+SRD+09WHsBS
         YisrtYrBGM8cEVtW60XavKrUtAXTGUu0wQX1YuXlf8cfqSaItBG3nxnsPRVze+dhCiOS
         BuSh2dFNnGlIougWquaK/fwrDfqvq5ZyXrI7jXK6gw5Vu5pML3oIiOE3A5+nLNSviRhK
         NkbKYDgJvXxc+qtxjsQ6ockt7cYsZMGAOuA1EvV3PFM2pKdxtqVwNvOpWT2GI03aBZlM
         Ya9g==
X-Gm-Message-State: AJIora+DY5NQEkEW8hFU9NyERWLirZPghI9tl/LE+njZWrMKNiU6FblQ
        z1l7yC39ZOc8YjHwtKFCtTtVuROjAKT1sQ==
X-Google-Smtp-Source: AGRyM1u6WrgpY6yHLlHY7goZw6l7+JWO5cQqFP99DTH0TE7UOIHM8cOQweyGhPs/Fh7ttxOCwk96mQ==
X-Received: by 2002:ad4:5ba3:0:b0:473:1b5:e8ba with SMTP id 3-20020ad45ba3000000b0047301b5e8bamr33276887qvq.49.1658399974772;
        Thu, 21 Jul 2022 03:39:34 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a244f00b006af3bc9c6bbsm1320550qkn.52.2022.07.21.03.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:39:34 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31e7055a61dso12361717b3.11;
        Thu, 21 Jul 2022 03:39:34 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr16277343ywf.384.1658399974351; Thu, 21
 Jul 2022 03:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220718195651.7711-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220718195651.7711-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 12:39:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjAQ9km_tVHc-BVAbs8XPZ5HiX2-_v5fmtE5-qd3bhog@mail.gmail.com>
Message-ID: <CAMuHMdVjAQ9km_tVHc-BVAbs8XPZ5HiX2-_v5fmtE5-qd3bhog@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r9a07g054: Add IRQC node to SoC DTSI
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add IRQC node to R9A07G054 (RZ/V2L) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.21.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
