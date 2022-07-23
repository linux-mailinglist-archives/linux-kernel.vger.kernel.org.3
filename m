Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E257EB9E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 05:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiGWDCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 23:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWDCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:02:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFADDECC;
        Fri, 22 Jul 2022 20:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CE0EB82B1E;
        Sat, 23 Jul 2022 03:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E43CC341C6;
        Sat, 23 Jul 2022 03:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658545346;
        bh=RmHNidHcM6XnyksPN/PZ9Th3H+UhaPw4mbqV8BGr+lk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eu/SahGnm2hDYt+NNv6xEtT/DRemsy7UcVl/gxuxomUCXoPIbz5QwEzpuI3xmeDCz
         6CvunG/RROezKcPISJH/AZKEfl5SA9kYZ2cAm8q9MYDhCFWJhnpEhB1LjdF5nWszvo
         yxQ0h13kwPxBbjHoh9Qb4cPngEMrGcd8vfJT9cQ2BxmLzVqEXOjGCcaU3evhGVcTln
         ozPywvOhwtK+zhKYTPA2I/JIH1oVMEIwqP8BXwi82kEdk2hgJcTXMdVmSXvzcxerr7
         /5IotM9Y4VfFM3U5UH2+NHcLu0JYjN+Wqs3J2ch54DBiyzrtJ3KZpebnwAwHq6R/KY
         l9JO+hwonW7yw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com>
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com> <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com> <20220718191454.5B5D3C341C0@smtp.kernel.org> <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas G leixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        SERIAL DRIVERS <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 22 Jul 2022 20:02:24 -0700
User-Agent: alot/0.10
Message-Id: <20220723030226.8E43CC341C6@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-07-19 03:04:43)
> On Mon, 18 Jul 2022 at 22:14, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> >
> > So the clk and reset driver should be the same driver, or one driver
> > should register the other and use the auxiliary bus to express the
> > relationship. That way we know that the drivers are tightly coupled and
> > aren't going to stomp over each other.
> I think it is very problematic to use the same driver for the reset
> and the clocks also because The NPCM reset driver is an old driver
> that was used also to the older NPCM BMC SoC so it will be problematic
> to use the clock and reset driver in the same space.
> indeed the reset and clocks are using the same memory region but they
> are not using the same registers, is it not enough?
> Please be aware that the NPCM reset driver is checking that it is
> using the reset registers before calling I/O functions.

To put it simply, platform device drivers should use platform device
APIs. The platform device APIs hide the fact that the firmware is ACPI
or DT or nothing at all. The usage of of_address_to_resource() is
problematic.

After converting that to platform APIs you'll get janitor style cleanups
trying to convert to devm_platform_ioremap_resource(). We'll have to
discuss this again when that happens, even if there's a comment in the
code indicating we can't reserve the IO space because there's another
driver. These problems have happened in the past, fun times!

Furthermore, in DT, reg properties aren't supposed to overlap. When that
happens it usually indicates the DT is being written to describe driver
structure instead of the IP blocks that are delivered by the hardware
engineer. In this case it sounds like a combined clk and reset IP block
because they piled all the SoC glue stuff into a register range. Are
there more features in this IO range?
