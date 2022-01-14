Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0766848F2B2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiANXAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiANXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:00:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108B0C061574;
        Fri, 14 Jan 2022 15:00:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68F1DB82A0C;
        Fri, 14 Jan 2022 22:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285ADC36AE7;
        Fri, 14 Jan 2022 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642201197;
        bh=pinsoFsBLJXMxhqrkwnb4NPQ5Tui8gvxNk7tIaJK/Tk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=en8/v75YdOTH0qUlFjNBsBJ320M/eAFBm5gcn+8I4NI4i7sQ40mmWfu/us8knqbCq
         f3c7sTQxhqnbRJBbJX2VN8RySqfW+4Q4sdKMfeEbgdM40L5U9fXn+xvYV2WyUGiNaA
         qJom3wy5rnh91yxHR096Kbav8YaAo/sVJ522qCqkP7YRTAGmADNQ7rXOquZRl4xQGk
         mRxP1/0B8ZNALrVe9cLnkQEWRGHCWkzeC1Jbi8Gkgg9/1lC0kcw1VuOkz/RDiqLERR
         gT2lY1LLBEHplGVPC2flRPnXnAuSBlfGie52mXlGRxeaaJblWt72BMZl9pT0vU91Uj
         G58lcF6f6R/Yw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d99ac02-a246-5bcc-2ecb-371b0d193537@amlogic.com>
References: <20220113115745.45826-1-liang.yang@amlogic.com> <20220113115745.45826-4-liang.yang@amlogic.com> <20220113212957.768FFC36AE3@smtp.kernel.org> <5d99ac02-a246-5bcc-2ecb-371b0d193537@amlogic.com>
Subject: Re: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org
Date:   Fri, 14 Jan 2022 14:59:55 -0800
User-Agent: alot/0.10
Message-Id: <20220114225957.285ADC36AE7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang Yang (2022-01-13 19:06:07)
> Hi Stephen,
>=20
> Thanks for your quick response.
>=20
> On 2022/1/14 5:29, Stephen Boyd wrote:
> > [ EXTERNAL EMAIL ]
> >=20
> > Quoting Liang Yang (2022-01-13 03:57:44)
> >> Document the MMC sub clock controller driver, the potential consumer
> >> of this driver is MMC or NAND. Also add four clock bindings IDs which
> >> provided by this driver.
> >>
> >> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> >> ---
> >>   .../bindings/clock/amlogic,mmc-clkc.yaml      | 64 +++++++++++++++++=
++
> >>   include/dt-bindings/clock/amlogic,mmc-clkc.h  | 14 ++++
> >>   2 files changed, 78 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,m=
mc-clkc.yaml
> >>   create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.=
yaml b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
> >> new file mode 100644
> >> index 000000000000..a274c3d5fc2e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
> >> @@ -0,0 +1,64 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/clock/amlogic,mmc-clkc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Amlogic MMC Sub Clock Controller Driver Device Tree Bindings
> >> +
> >> +maintainers:
> >> +  - jianxin.pan@amlogic.com
> >> +  - liang.yang@amlogic.com
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - "amlogic,axg-mmc-clkc", "syscon"
> >=20
> > Why is it a syscon?
>=20
> The register documented by reg is shared with SD/eMMC controller port C, =

> and it need to be ops on NFC driver.
>=20

Is this the case where the clk is inside the SD/eMMC controller? Can the
mmc driver register the clk controller from there and pass it an iomem
pointer to poke clks?
