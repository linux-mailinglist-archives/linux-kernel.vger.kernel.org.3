Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7959057C92D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiGUKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiGUKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:39:02 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3582453;
        Thu, 21 Jul 2022 03:39:01 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id u12so954590qtk.0;
        Thu, 21 Jul 2022 03:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUFSxEp/zU8vtHCTbm9y30wQpyHZOsNNXDWnLwp6e58=;
        b=RKHtVgOXxGTLJkXZC1chrpRRiZ6VeX7yIyqJxO/74CeJTI3U2HGNUglI6kICiG53R1
         JOTAS6EOLcgW32WuO4q+hXILE1FuMVwdv7+79tcLMvRezq2kePh1F+lZ7UKLNw2zb8Uc
         XJYuOqEolMSyc5+jsiD2SDbC6KIre+pjPtMO1PcxsyMQVGb5giiKFKG17z/AJg/em9tk
         A7HF8GGBhtfb8vUyATH+Oh6dgNBBinz++6ebg4VlRQExgMzU2ggybXYH2AWiXwEkBm//
         /OwmdZne8a4l9oc6zgMTQkdq2auY4OWddTvULQxeapWn7urJJqia00768FJH97i5d+lm
         chpw==
X-Gm-Message-State: AJIora+Ypc3eKbB3I63mv9V8AB0+Xneb2OzjSVBFNBND8dZWbNnnQnNm
        WeFNmIvz2Rdcx7wIAuDuBL4GEGnws87WZA==
X-Google-Smtp-Source: AGRyM1sxyP6EjNoXjuoTIWrWU1Z2Bb9M6Jm0pBk7Bxggwj77ML/sX3djUPc0UWGJDyL8bwFMaTIsmA==
X-Received: by 2002:ac8:59c8:0:b0:31a:576f:13f9 with SMTP id f8-20020ac859c8000000b0031a576f13f9mr33146270qtf.596.1658399940668;
        Thu, 21 Jul 2022 03:39:00 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id de39-20020a05620a372700b006b568bdd7d5sm1149211qkb.71.2022.07.21.03.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:39:00 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31e560aa854so12506157b3.6;
        Thu, 21 Jul 2022 03:38:59 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr44517762ywd.283.1658399939434; Thu, 21
 Jul 2022 03:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220718195651.7711-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220718195651.7711-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 12:38:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURjqyoJY=k4KhUAqfQ-n9JRYevAcZ2DVSnxS0Lt5-3rg@mail.gmail.com>
Message-ID: <CAMuHMdURjqyoJY=k4KhUAqfQ-n9JRYevAcZ2DVSnxS0Lt5-3rg@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: renesas: r9a07g044: Add IRQC node to SoC DTSI
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add IRQC node to R9A07G044 (RZ/G2L) SoC DTSI.
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
