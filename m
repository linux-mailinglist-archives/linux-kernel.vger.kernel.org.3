Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D7351D251
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389548AbiEFHfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiEFHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:35:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EB62ADC;
        Fri,  6 May 2022 00:31:21 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MlfCm-1oDifl3jvu-00ijHY; Fri, 06 May 2022 09:31:19 +0200
Received: by mail-wr1-f47.google.com with SMTP id j15so8866084wrb.2;
        Fri, 06 May 2022 00:31:19 -0700 (PDT)
X-Gm-Message-State: AOAM53027olsIfusuF9JqixzwazVMz+N19EknKk3MlZUEJ1Eejx6f5q8
        vdVn9LN0B2L25MeEIGV8riAadZAeb6uekQtVpYM=
X-Google-Smtp-Source: ABdhPJyl6B+Yi3fxE4xYEmk7s5ew/zzP2lC0ZNV1xGO5Lxor38jlzAsOmsx8UdBKNigE8R5SnwqPF7txxIHsenYD3Hk=
X-Received: by 2002:a5d:6da4:0:b0:20c:6d76:cc54 with SMTP id
 u4-20020a5d6da4000000b0020c6d76cc54mr1442466wrs.317.1651822279542; Fri, 06
 May 2022 00:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651805790.git.qinjian@cqplus1.com>
In-Reply-To: <cover.1651805790.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 May 2022 09:31:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0W4wpVwDmCXDkm_u9W=JozrnCnxW7zK3h2XD8f_ODy6w@mail.gmail.com>
Message-ID: <CAK8P3a0W4wpVwDmCXDkm_u9W=JozrnCnxW7zK3h2XD8f_ODy6w@mail.gmail.com>
Subject: Re: [PATCH v14 0/9] Add Sunplus SP7021 SoC Support
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
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
X-Provags-ID: V03:K1:NQJFiB5aaAr1QxCc6CwwI/7WQQAm7AUc/Evgzf6oHg0rxpc9Yv0
 mNJrl2eWgwUoiGDYH9Rw2wRKnmYPPp701bj4b0KpNN2n24OUAEFFJs/yoFYM+u0fiFQ3Ckx
 +bY3pPP0tVasSXlzV85KGbFiCdASWZbUGJ7Y//DtcARcrVWmX6cYGTvtzQhem7X0DAxRNi7
 yHhAWN4IIU6+geR4wLkmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8dN+VPP6q0=:12rMX5qXV6n0RGYINhZsK+
 6wBfnDRr9aNZsb+dzhRZygl56Zew1C5jBlS3rrZQ9LQRwwzYJ6AmMiAuxMILbcqCKT+6rRzoA
 xtFv3eVQmhgI2VwdsbFxTTP4ekvlnWpr4XDKVy6tu5NqPRSQp2J4pMkBZFKQFuudS6sN1tffF
 KjAPTi7vIRre/WenLAdOMnavbmVikI2GJBrUPnNAk7Tuw+nNds/UGVe2sl8iyHs24cSLCgzJ+
 CcLzTIi+4jKoMHGRPslimN8TjsZ2AOVWKmwqQf19RN6REpSwek1lf/Z79FLczQf7XJuobwz7c
 kcfX2sMoM1kw6mci1vhT/VuU2Hv6Wdye9c+0IWOskAreKWTKSyJCM5KJeHtqVPnId8mZ/4v4O
 JEB7R8sEjQopuEWW2aLQTSSZS+lj3/3NnAOx/sdBgFY4xzAzDEB03m5feKzv/+EYTT1KhAmU+
 D/koRw9+MKNSmpuZnYbmlwINl9UvhjoolK8QCyw1DlHjGVrPDLDcDmotPwVLi+HaWcaqspeAk
 nmEVnrF1WrPcFyQyp3i24f91E3zNYP3CzdfooJAm+377DUt+vMq5BBrdzJr3tlngmJXuFfGO2
 VAKICwMa5ruUNqO9LC5/556ACRfkQ2z9IJeoPGIW3CXZEqJvxa03m/7taiy2BX9HB480m0QIk
 XlXcEF1/JMgCrWRQPZZSIkYPL1r9LY7YY+zXnadmsnQwaxrBadOaD+Gt+pLR0HrtMfig1ELXL
 cTT3sMHhAmXPZWEBOjkX2xklSqgstnrztqvyu+3uKq3y8xbpOnlSHUZN3JJyL4/3zkkFvp36r
 PXw/0AgUlCVV4wjX0OECVNaSiXluujgw5yvLlgBQeTS8L6sH0o=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 5:23 AM Qin Jian <qinjian@cqplus1.com> wrote:
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

Just an update from my side about merging the platform code: the
submission looks mostly sensible to me, but as long as the clk and irqchip
drivers have not finished the review, I cannot take this through the soc
tree. We could consider merging the platform code without those two
drivers, but that seems pointless because it will not boot.

What is the reason you don't include a .dtsi file in this series? Usually
there should be at least one board and the description of the SoC itself.
Again, without those I'm not sure it's worth merging.

For the timing, we are getting close to the 5.19 merge window that
starts once v5.18 is out, and I don't expect that all the above will
be resolved in time, so it looks we will have to defer it by one more
release to 5.20.

          Arnd
