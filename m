Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8542D4C8802
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiCAJdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiCAJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:28 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9EC3F;
        Tue,  1 Mar 2022 01:32:45 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id j201so6536714vke.11;
        Tue, 01 Mar 2022 01:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEoOzEvV8DtjK0g+F3/KiXOH1X2vfBFwKkiu6nhcUsA=;
        b=0h+rg65C/RHttOlqdCCJhH3/Ert1UY2giKhDG8Gi3l0GDg50P6kgv9HKLsMk8Pa+i0
         yh/1wsZr1NQ+GoccyqJuUHzcynS3GfrZjitQTzEEsdbXLVZGiG0PVgcKm2sAf4phL4Mo
         gL6Xu82U6IIwxxzUXg8XaXZJIXvewI0HIkICQrYE20OUtGuZbHloCBRd1X7TwRTndv5y
         bPgM3hgYURxW9kizM+sEk3FTRcaftl30o19xbZt/J8Ghqrv3avmIhF+upsyU2sme2Jrw
         azUUXsVUZ0zybI7MWtMU0dAFxLhHWTCYv/Z7tUKHmSbqs5giFXsRI38rVHOwJ2LlRGZN
         ROoA==
X-Gm-Message-State: AOAM5332FQOa4Wg7MkC1IR3ss69Jc9JNP2nryiG01CiNrX0r+pYV7sIh
        6wQ6x59V+4GRtTC6vK6qS0qVFLW+CIbHYg==
X-Google-Smtp-Source: ABdhPJzek3fjqzPeEw8Ia3n52aFDNkUivsaGJ35boNQA+ws42nQ7acmGELSWMRFfqUaVrcNoNfLN5g==
X-Received: by 2002:a05:6122:2151:b0:32d:a624:f5d0 with SMTP id m17-20020a056122215100b0032da624f5d0mr9949158vkd.18.1646127164166;
        Tue, 01 Mar 2022 01:32:44 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id h79-20020a1f2152000000b0033176aaacb1sm2084840vkh.35.2022.03.01.01.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:43 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id e26so15904931vso.3;
        Tue, 01 Mar 2022 01:32:43 -0800 (PST)
X-Received: by 2002:a67:e10e:0:b0:31b:956b:70cf with SMTP id
 d14-20020a67e10e000000b0031b956b70cfmr9564355vsl.77.1646127163225; Tue, 01
 Mar 2022 01:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULRKzr46cJEsPrqjO2xH0zBA0Y6K=kJu6DcsCeJpo1aA@mail.gmail.com>
Message-ID: <CAMuHMdULRKzr46cJEsPrqjO2xH0zBA0Y6K=kJu6DcsCeJpo1aA@mail.gmail.com>
Subject: Re: [PATCH 06/12] arm64: dts: renesas: r9a07g054: Fillup the sbc stub node
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
> Fillup the sbc stub node in RZ/V2L (R9A07G054) SoC DTSI.
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
