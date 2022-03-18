Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5431C4DD647
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiCRIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiCRIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:38:25 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FEB2B3310;
        Fri, 18 Mar 2022 01:37:06 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id i4so6344697qti.7;
        Fri, 18 Mar 2022 01:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaaWAx7vW0Ep0uWBl4c9esdINjzMdVYjy0G5NfgIiGQ=;
        b=UvY09vcYf5uurAMxHf+en9hSW5W/SExEflAIihMMNrQgrPtq3SaMpBtfyAY8fcLC6v
         WvmzxVFULUVFmzwa43Y9plKsjeQPOvgpGdeHOtKKeZ0T0xhYkK858xXDXsG4uwy3jsQy
         HYbR3xy2KVMRQRYKMC9D8ofaREZriqGeFXtGl48SASF2xVl/Fd7NjKqUtKDVikU0M6Bg
         Cn7PKB6LKK28TYUPtERAFEUZ6S7OLq5Y1EEQ/EcfQI1OzlEQAOBfoCZwZTLA+YDYMkqk
         F4JY/s5TcJ5uaStSNskxRCOdK9aATStM9MvXKTu5i09Q9k9fXbXgOOCN5JwrHcgdcozU
         JmFw==
X-Gm-Message-State: AOAM530i4yC7fsy7ZZHipPsUEiwUyj7ggBqtc1J/qzb+NVxzJC0FXw+7
        FPNzlLdf5WVBUYA4SK14f/N336i8O9p6fwuv
X-Google-Smtp-Source: ABdhPJxb2enurGJdO1HL0t8pspJ3Qs9S29D9PoPpOm1IEWYu5olppjZet2cTw6gmbwbk/Z1ih/ergQ==
X-Received: by 2002:ac8:5bc4:0:b0:2e1:c841:361d with SMTP id b4-20020ac85bc4000000b002e1c841361dmr6671499qtb.208.1647592625867;
        Fri, 18 Mar 2022 01:37:05 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e645000000b0067b122fae88sm3625726qkl.2.2022.03.18.01.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:37:05 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id j2so14750332ybu.0;
        Fri, 18 Mar 2022 01:37:05 -0700 (PDT)
X-Received: by 2002:a25:4fc4:0:b0:633:25c8:7d9 with SMTP id
 d187-20020a254fc4000000b0063325c807d9mr9310864ybb.506.1647592615316; Fri, 18
 Mar 2022 01:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com> <20220317115705.450427-15-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220317115705.450427-15-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Mar 2022 09:36:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-oDgiUNhW1hX6n6z3hQhVY7v6WQa9PjnF3wnEC7NTHg@mail.gmail.com>
Message-ID: <CAMuHMdV-oDgiUNhW1hX6n6z3hQhVY7v6WQa9PjnF3wnEC7NTHg@mail.gmail.com>
Subject: Re: [PATCH 16/18] dt-bindings: irqchip: renesas: include generic schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-oxnas@groups.io
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

On Thu, Mar 17, 2022 at 12:58 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> Include generic interrupt-controller.yaml schema, which enforces node
> naming and other generic properties.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
