Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B74C6F37
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiB1OVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiB1OVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:21:30 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2E5D673;
        Mon, 28 Feb 2022 06:20:52 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id c36so6059867uae.13;
        Mon, 28 Feb 2022 06:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCsl/J5fP2/JmtRNo8BbmprLY7cOlxBvOyzidQ1R3I0=;
        b=iRUdhqViFFheDSA1FbxdDaf/Zd/N4d+0zrq9QrFseinoFxZATy/HkbiO5+aCU2bcx1
         1NtNyMorL8Htp9dZURYj5bkceU8Sw8TneAygvT0AuOdEjRTtCcu+GE9ntD8rkwAmEoxz
         SJQa8noL4OmK1WEQV8Rt1hR/ppYqwvp1Em4YQ+fWor7/qlg/h0bnFpuSCK4K8lWjAfDN
         IenGHa3q4N/MFbsyJ7nQTXp0atYgpmboPEkhvV6/aUEtAIY9cbalyJAwdeJON7ScHMkK
         c8S41J4d88kWp7ndIsuUJbP+AVW6ugzDt4XEQiUn23mTNOu9Rtm8/MFTG+Yh/UTSj2yv
         syjA==
X-Gm-Message-State: AOAM532u6Ym3L/1YdlY1iPdFxQYGXa5iAIJkE0H7SHdRDBFzkh9r2BZ5
        evVL7DqapDwq3+DcstNR3t9DSYFix4Wfzg==
X-Google-Smtp-Source: ABdhPJx4yUF6L6xwa+dTUEWgvOiSPRuJCeZ1MNsqQVGQ8Ri5iIbA+YU2ngIidcty9O3DT/s10/Rt9A==
X-Received: by 2002:ab0:72d1:0:b0:342:3751:d637 with SMTP id g17-20020ab072d1000000b003423751d637mr7349840uap.143.1646058051190;
        Mon, 28 Feb 2022 06:20:51 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id b5-20020a1f1b05000000b0032597a7ba97sm1901203vkb.9.2022.02.28.06.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:20:50 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id b37so6059699uad.12;
        Mon, 28 Feb 2022 06:20:50 -0800 (PST)
X-Received: by 2002:ab0:6253:0:b0:341:8be9:7a1 with SMTP id
 p19-20020ab06253000000b003418be907a1mr7893256uao.114.1646058050286; Mon, 28
 Feb 2022 06:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20220224125843.29733-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220224125843.29733-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220224125843.29733-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:20:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWn0UZYTN4AoK4pDyvgv2_5aeiCvLKSTpw=JmMUrzF-6g@mail.gmail.com>
Message-ID: <CAMuHMdWn0UZYTN4AoK4pDyvgv2_5aeiCvLKSTpw=JmMUrzF-6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org,
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

On Thu, Feb 24, 2022 at 1:59 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L ADC bindings. RZ/V2L ADC block is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-adc" will be used as a fallback.
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
