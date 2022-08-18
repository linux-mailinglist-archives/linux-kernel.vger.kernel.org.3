Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124DA598735
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbiHRPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245219AbiHRPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:16:34 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCECC7B79A;
        Thu, 18 Aug 2022 08:16:33 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id w28so1331688qtc.7;
        Thu, 18 Aug 2022 08:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fNAryURHxGVgmjXYIDSK6dvngkhik8cAD5MGphiVLyw=;
        b=XU253U80V4kJNEIc9yNpxgbUC/z6aqclz0KqNZqpzPe+W8j0JumtqbzPomeRWqZm9Y
         eP6T3gBo75Fcxs+we2oo6yRCVs/6/IJAnNlUecgttXcd+hx7eeO5Sk3uwF8P+qQ7ZiAl
         zRDHa2rEOGIZ4WiOhMZEAXmpFLKDlSmYBoKJd02i7YhGYMsfykUa4fsDDKgGnzcpCFor
         L1nUky2l+q4CUuIf+WYFRyPpNZw7n+nyRQKOMWKFqKJlz1TcPUshB3Fyt+DMyj8pOMzV
         9s+zb7zhAD5Gr4wP/+4JluPI940O1KyHcx/s91lLtH1YVSD+NPD+I1oSGRvSWx4O9fBR
         NAZg==
X-Gm-Message-State: ACgBeo2/NuxcW6zqSQH6fpILiidWQrJcKUn64t2GLcf2Ce2WRzoL3Pi9
        ZlArYYOPBmcc3KRPe8XBpTYgL2qC2GDa2Q==
X-Google-Smtp-Source: AA6agR6b7uNb5yJfAVZ9E74dm/uGNc05W06ZLWjqONKxyVVLED2vrJEdtbAEov/g+tK0SqHOUMDunA==
X-Received: by 2002:ac8:7f4f:0:b0:344:6974:51fe with SMTP id g15-20020ac87f4f000000b00344697451femr3071043qtk.382.1660835792538;
        Thu, 18 Aug 2022 08:16:32 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id bs43-20020a05620a472b00b006b9b7879964sm1725316qkb.28.2022.08.18.08.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 08:16:32 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3375488624aso20473387b3.3;
        Thu, 18 Aug 2022 08:16:31 -0700 (PDT)
X-Received: by 2002:a81:658:0:b0:334:a23e:6caa with SMTP id
 85-20020a810658000000b00334a23e6caamr3123682ywg.283.1660835791476; Thu, 18
 Aug 2022 08:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 17:16:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW29Q40hypWZ05KRj5cc=DY8XjnDwOPVw3kJPNUrnL0fA@mail.gmail.com>
Message-ID: <CAMuHMdW29Q40hypWZ05KRj5cc=DY8XjnDwOPVw3kJPNUrnL0fA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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

Hi Prabhakar,

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
> (R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
> of the Renesas drivers depend on this config option.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

The technical part LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
>
>  endif # SOC_CANAAN
>
> +config ARCH_RENESAS

We definitely want ARCH_RENESAS, as it serves as a gatekeeper for
Kconfig options for IP cores found on Renesas ARM and RISC-V SoCs.

> +       bool
> +       select GPIOLIB
> +       select PINCTRL
> +       select SOC_BUS
> +
> +config SOC_RENESAS_RZFIVE

Do we need this symbol? You could as well make ARCH_RENESAS above
visible, and defer the actual SoC selection to ARCH_R9A07G043 in
drivers/soc/renesas/Kconfig[1].

I don't know what is the policy on RISC-V. ARM64 has a "single-symbol
in arch/arm64/Kconfig.platforms"-policy, so we handle SoC selection
in drivers/soc/renesas/Kconfig, and that is fine, as it avoids merge
conflicts.

> +       bool "Renesas RZ/Five SoC"
> +       select ARCH_R9A07G043
> +       select ARCH_RENESAS
> +       select RESET_CONTROLLER
> +       help
> +         This enables support for Renesas RZ/Five SoC.
> +
>  endmenu # "SoC selection"

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-drivers-for-v6.1&id=ebd0e06f3063cc2e3a689112904b29720579c6d2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
