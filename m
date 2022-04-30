Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2B515E12
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379212AbiD3OQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiD3OQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:16:21 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9616174DC1;
        Sat, 30 Apr 2022 07:12:58 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknq3-0001c8-6F; Sat, 30 Apr 2022 16:12:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCHv1 13/19] pinctrl/rockchip: add rk3588 support
Date:   Sat, 30 Apr 2022 16:12:46 +0200
Message-ID: <8226003.NyiUUSuA9g@phil>
In-Reply-To: <CACRpkdZXuLPpgKcM_OU+Xewuuq6zGJek0QXAT1Xxn5fcZofJvA@mail.gmail.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-14-sebastian.reichel@collabora.com> <CACRpkdZXuLPpgKcM_OU+Xewuuq6zGJek0QXAT1Xxn5fcZofJvA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 29. April 2022, 00:55:52 CEST schrieb Linus Walleij:
> On Fri, Apr 22, 2022 at 7:09 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> 
> > From: Jianqun Xu <jay.xu@rock-chips.com>
> >
> > Add pinctrl support for RK3588.
> >
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> > [merged in downstream fixes, simplified register lookup logic for better
> > maintanence at the cost of a bit more static const memory and fixed some
> > incorrect registers]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Patch applied, unless Heiko does some loud protesting it stays
> in the tree.

I'm never loud ;-)

Patch looked ok overall as well. I guess at some future point someone
will need to refactor the small "if rk3588" but that can be done when
another slightly different user appears and we have a feeling what the
common approach could look like.


Heiko


