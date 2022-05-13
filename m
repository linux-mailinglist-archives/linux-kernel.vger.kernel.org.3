Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31637526101
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379922AbiEMLaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358821AbiEMLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:30:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A102B4CB2;
        Fri, 13 May 2022 04:30:11 -0700 (PDT)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMH2M-1nWAC72E4c-00JGAI; Fri, 13 May 2022 13:30:09 +0200
Received: by mail-yb1-f169.google.com with SMTP id s30so14760376ybi.8;
        Fri, 13 May 2022 04:30:09 -0700 (PDT)
X-Gm-Message-State: AOAM530/X3yxdCgm/B6dzrHlAompw7PJ0SdS4HvM7hknTzFtfdBOpsq9
        GlJG9aB6+sJEL72h9Pa3/1Uj3L+Tlc5QFrUzNM4=
X-Google-Smtp-Source: ABdhPJysbP9caH0brZ2V+y5dn6JadZrsxosGfVAkjTJrk0Zyj9/I1i6bXuEYM+5TKCjnUR/tmE+Fnueu4QwqsbYjlmg=
X-Received: by 2002:a25:75c5:0:b0:648:dccd:e1c with SMTP id
 q188-20020a2575c5000000b00648dccd0e1cmr4249474ybc.452.1652441408145; Fri, 13
 May 2022 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652329411.git.qinjian@cqplus1.com>
In-Reply-To: <cover.1652329411.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 13:29:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a37G0++hwsxXbMun-r9XKCBvkH3BF4c1f21eFxGPdCdMw@mail.gmail.com>
Message-ID: <CAK8P3a37G0++hwsxXbMun-r9XKCBvkH3BF4c1f21eFxGPdCdMw@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] Add Sunplus SP7021 SoC Support
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oAfpTfZjFuTprj0WwrUlyPRugNb2/x6jStD8W+dLEuVch4K2NZ1
 7QG97pO2JPrABb9NeVrdlTNgtceI47FOf+2Cz+1NimqFOy+drgpYd3ghc/BA6h9cAkW7KBN
 ww9LACzLh1j6JAsRzXCACuPUmTXnzVObCrxpcxAbVwP65L/i5FYOo7XoPAlGNp4atYEMHCT
 WZKcCpzUMAb7QEgOJUgjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5kPDjH97w0s=:0eWgAwZvvTsw614xcyI5Fe
 u7911TD4ivrDzEeM5yEmUbKja4Gh5HzuIpUx3rv3D2uHHysDU5dl1N6gUs0xETdplDGB92kNZ
 0lmPKtuJc1rxHpxcNZ2LLQ5vauR1j0PnBxa1q1fexEV8HcWxC+3TKfPIoQ4mIyXaHlbBZOeR9
 dRsLxHQkvLIIV2j/zq2kVE5m6G1gRKL19bttYqYXOpVCAPGv5bpbtWDGsS3bU674GC2QYhhsc
 arP/s9SMh3612DwFAL4Oe8o/lJM1ykwAzXzCwiLPsOgU1WKQdyhrbHGI/0LFwjJbvAh7cu+UA
 WdVkPBcnCTGNOlL3W6VjdrU4ISHX8uLF6dTRqAE8swcC+vFVXV5Vm7cZkNPGuE8NuR9md6EK7
 hwnKPW+fPcIa5mm4dTv2kK1P7Yk5oVnvaw/LPNIxxrcHlD5NhFfTl1fpFbU0eqN1NBN1+I0O6
 8n6zY5VBm91+vRAUxBPYkutOzbumneygiJSFnP1HoVAzIDsGvnnin6TtcKqvzZdcVlWhxGRwA
 ZCrz+Kw5PqpM72MOvs6MBClkhaNuSwS4gWNrlcv/nOjykXHxwAPuAHxSs62Xbk5opnHWsgPKC
 uAebZpx/02IKnAryZxeEeAPgEQrjMmqVIJailWZw7VfPAwp+x2FigRNaxtxjyGiYYiMaxEItv
 eIK23kPKaWrEkElQzVQR6oPLkmZEzWIDZ8rwz+PlPQTH8iIYIKEsYNjXSrJYeY//ZWd0QrS9c
 NOQh7PyL1mihwJFUc9OK01tl8tW/Qnw6ZGns/FHM854PHMol9J6XMUg2xA0OyTqiCn8ORToTn
 xr5pWmEee5UKAXxOYMpKke5sqUScBTWbgxIjWiBhqNCloLfzQ0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 8:30 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> This patch series add Sunplus SP7021 SoC support.
>
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates many
> peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and etc.) into a
> single chip. It is designed for industrial control.
>
> SP7021 consists of two chips (dies) in a package. One is called C-chip
> (computing chip). It is a 4-core ARM Cortex A7 CPU. It adopts high-level
> process (22 nm) for high performance computing. The other is called P-
> chip (peripheral chip). It has many peripherals and an ARM A926 added
> especially for real-time control. P-chip is made for customers. It adopts
> low-level process (ex: 0.11 um) to reduce cost.

It looks like there are still some remaining review comments, and the clk
driver is missing a review. Since we are close to 5.18-rc7, I think it's
too late for the coming merge window, and you should target 5.20,
with a rebase on top of v5.19-rc1 once that is out.

If you get no replies on the clk driver, maybe try splitting that out and
post it separately to the clk maintainers. I know they are rather
backlogged on review time.

       Arnd
