Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0919567FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiGFHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiGFHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:33:20 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1B22B12;
        Wed,  6 Jul 2022 00:33:19 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id i11so17117985qtr.4;
        Wed, 06 Jul 2022 00:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+b8wn8V7G4tAXt0NI6X/wOz7J1o+6frUT4H0oHfhEM=;
        b=jjiHX9PhsWiNs6debtBaPXWCSI+w04jPaPC35bT3BOU5i2CzXGu0EhbUYtVrVnRQ1P
         ov69vpKJS1Lb4nr7XtS8WJ3GoiZHFFJRRu3x5NpigoF7RXPiJCqUTlbTGtndpkE4O7+8
         F0o8xO2kT+NgIl3GznIo20ZtzymRn2H1pVVIDPDc1N4Y8SZJRZqU5NpDTTfiA+pky8/Z
         DkwLGxtHDKZUZ/dkT/nKKO5A0baEhi/uY5h0PtNtusL7WFDUBbNQq7lU7pu/whS+Yf3d
         SnTJDrDdZuIhpSGRk6oh421wrWKiE/NsL75Hnx+mRZXS6yuQ9qv6TCFfdAeR7A3jmfxW
         FiWQ==
X-Gm-Message-State: AJIora9yK6ys7cW3r6k04jdPuDIoqphaWFXuPOeeYc9buww5r4MweAHK
        Ic5LOdEabR2uOSYOIc81LWtMY11pJL4SwQ==
X-Google-Smtp-Source: AGRyM1vD/yKELU6fzItMdDmfa4FHS3qzsqMVpIhuUrMQRgdOGuficeXR3mOxBEEfvftIMpAS251z0Q==
X-Received: by 2002:a05:6214:519a:b0:470:99b0:bc4f with SMTP id kl26-20020a056214519a00b0047099b0bc4fmr35303399qvb.57.1657092798534;
        Wed, 06 Jul 2022 00:33:18 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id az8-20020a05620a170800b006b14b303b37sm16565430qkb.102.2022.07.06.00.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:33:18 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id e69so19354652ybh.2;
        Wed, 06 Jul 2022 00:33:17 -0700 (PDT)
X-Received: by 2002:a05:6902:1143:b0:66e:8ad6:34c with SMTP id
 p3-20020a056902114300b0066e8ad6034cmr4850012ybu.89.1657092797591; Wed, 06 Jul
 2022 00:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com> <20220705210143.315151-3-emil.renner.berthing@canonical.com>
In-Reply-To: <20220705210143.315151-3-emil.renner.berthing@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 09:33:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtK0-sDcFhPuaeRBnRn8=Bc7FDH+sfPFL55s7G7hdMvw@mail.gmail.com>
Message-ID: <CAMuHMdUtK0-sDcFhPuaeRBnRn8=Bc7FDH+sfPFL55s7G7hdMvw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: leds: pwm-multicolor: Add active-low property
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Tue, Jul 5, 2022 at 11:01 PM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
> Add the active-low property to LEDs that are part of a multicolor LED
> just like the regular PWM LEDs have.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
