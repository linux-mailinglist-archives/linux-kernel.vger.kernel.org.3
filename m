Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3A4C867A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiCAI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiCAI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:27:46 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6219888C3;
        Tue,  1 Mar 2022 00:27:05 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id j3so15729129vsi.7;
        Tue, 01 Mar 2022 00:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwB4M0FfzvPist4ny08Y1gyEoTHezds+UwIqZ00x3vo=;
        b=X+8hIQQ7mtKrv/kxqlOJc+vY7tgGiyy8vuu7ar8Lw4BBVMhYcrUFNBYzEBrpWNwmer
         B0ohx703bZADeyxhR26hfzTQ5Myz/s0yVp6Ww9WngQLOsv3dZiHAzhOqkI43sPeL0oJj
         Ut5fcBL6RzWsxoYrBKxiRzTixLjZnr0aTT/cEw3vUGYFkPk8fJYpfLwRO7lNyrpEXorh
         OG4ILatr6UC711g86LwiduyDDb+cZSqPW/ao15I9riTDV934CJpusPCG75lw5/V2N4kX
         IsK2x/CLXQPxmoYMWb9OZ2SbjL26d2G+1rUcF9OwMDoAk20dUR2Ai+RkCza/NHDvhBh9
         g0ZQ==
X-Gm-Message-State: AOAM530cSGZdDq8xsa0RAclYPAstOduhiQX5tU/cHATlnK5N0kKcAywa
        X7uvJCOE9HzKI1v4MIfFF/ase8S7yX+XmA==
X-Google-Smtp-Source: ABdhPJz7NDPZ1jf/AZqOdefwJ+fMpJuZTLPpDDplHmDLCPx9MN943y9LSA1/okLg59nKNzvxYIRDtQ==
X-Received: by 2002:a67:f645:0:b0:31b:916e:8d92 with SMTP id u5-20020a67f645000000b0031b916e8d92mr10314447vso.72.1646123224732;
        Tue, 01 Mar 2022 00:27:04 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 127-20020a1f0085000000b0032d19f4946esm2026317vka.28.2022.03.01.00.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:27:04 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id y26so15712887vsq.8;
        Tue, 01 Mar 2022 00:27:03 -0800 (PST)
X-Received: by 2002:a67:e113:0:b0:30e:303d:d1d6 with SMTP id
 d19-20020a67e113000000b0030e303dd1d6mr8950618vsl.38.1646123223733; Tue, 01
 Mar 2022 00:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20220227230302.30388-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227230302.30388-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 09:26:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSbPrrp6WLzAgW=jt8sDrhYxHorhxzMtEq3rdnMYg-WA@mail.gmail.com>
Message-ID: <CAMuHMdWSbPrrp6WLzAgW=jt8sDrhYxHorhxzMtEq3rdnMYg-WA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document
 RZ/V2L USBPHY Control bindings
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
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

On Mon, Feb 28, 2022 at 12:03 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add device tree binding document for RZ/V2L USBPHY Control Device.
> RZ/V2L USBPHY Control Device is identical to one found on the RZ/G2L SoC.
> No driver changes are required as generic compatible string
> "renesas,rzg2l-usbphy-ctrl" will be used as a fallback.
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
