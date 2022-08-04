Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2D58A1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiHDUF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiHDUFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:05:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532889FE2;
        Thu,  4 Aug 2022 13:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF1B1B82726;
        Thu,  4 Aug 2022 20:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60512C433C1;
        Thu,  4 Aug 2022 20:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659643549;
        bh=DR5dO2HhWSe0IcUJOiD/fg0ANKhZCMxKZk0PtAJCVIE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ASDi46ygtgSS3Hd63mUk69Ip0+B6d8iPklvvrBFp7dK1MDB9txrTrDce8RR7Om83f
         VOtLQyfHm6vN+Jvl9dDxzsbJO7477LdDd1dhWchfqUt5pZ5w54r8qbrgm1uIln/zjO
         1efVbVUaCoKX9s32agmUMURLeCnPKuhjMQOeWjjanJJnVcG4t/JCt/32kr34hi9OK3
         GT0HZCbtDIn7WdhtQx2ETZiInLZKja3l9iXYW/X/va3cayacLrdkSKO7RBkVKfS4fc
         U9IgMn9zPNjxUM/P46K3k+ET9Q7mcqR632iBzdYXWfvK5w+7PEc/U2GPiWOPRY7+HM
         JWWCCDLkUTP2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1hOxG+2X-qTbvPkrVHQ5zf04GO21m1n328Jiqgzns2CMA@mail.gmail.com>
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com> <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com> <20220718191454.5B5D3C341C0@smtp.kernel.org> <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com> <20220723030226.8E43CC341C6@smtp.kernel.org> <CAP6Zq1gUvMFG9BNObVNLpVgbMRpV7e--HFxknP8kvL4nGk8Hsw@mail.gmail.com> <20220729225603.12528C433D6@smtp.kernel.org> <CAP6Zq1hOxG+2X-qTbvPkrVHQ5zf04GO21m1n328Jiqgzns2CMA@mail.gmail.com>
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
Date:   Thu, 04 Aug 2022 13:05:47 -0700
User-Agent: alot/0.10
Message-Id: <20220804200549.60512C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-08-04 07:01:30)
> On Sat, 30 Jul 2022 at 01:56, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Because it is jumbled in some range?
> Yes.
> >
> > >
> > > I do see a way to combine the clock and the reset driver, the NPCM
> > > reset driver is serving other NPCM BMC's.
> > > Should we use regmap to handle the clock registers instead of ioremap?
> >
> > Sure? Using regmap or not looks like a parallel discussion. How does it
> > help use platform APIs?
> I mean to use regmap API instead of platform API for handing the clock
> and reset registers.
> the regmap API gives only one user access to R/W (lock).
> I will be happy to get more suggestions, on how should we solve this situ=
ation.
>=20

Using platform APIs means using platform_*() functions, not of_*()
functions, which are open-firmware/DT related. Regmap can be used to
operate on registers mapped as __iomem, which is different from platform
APIs.

Is having a lock even necessary? Do the reset and clk controls live
within a shared register where we would need to prevent one driver from
accessing that register at the same time as the other?
