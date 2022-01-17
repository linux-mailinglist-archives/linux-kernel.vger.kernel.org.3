Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56568490410
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiAQIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:41:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:58366 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238267AbiAQIlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:41:12 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1n9NZP-0006T4-TT; Mon, 17 Jan 2022 09:40:55 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: rockchip: Switch RK3399-Gru DP to SPDIF output
Date:   Mon, 17 Jan 2022 09:40:54 +0100
Message-ID: <3970568.xje1Q9F24u@diego>
In-Reply-To: <CAGXv+5H0-dM28YQj_orS1_14NLcJve8VtO6oLcBiRpJFjaf5KA@mail.gmail.com>
References: <20220114230209.4091727-1-briannorris@chromium.org> <20220114150129.v2.1.I46f64b00508d9dff34abe1c3e8d2defdab4ea1e5@changeid> <CAGXv+5H0-dM28YQj_orS1_14NLcJve8VtO6oLcBiRpJFjaf5KA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 17. Januar 2022, 08:44:37 CET schrieb Chen-Yu Tsai:
> On Sat, Jan 15, 2022 at 7:03 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Commit b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> > switched the platform to SPDIF, but we didn't fix up the device tree.
> >
> > Drop the pinctrl settings, because the 'spdif_bus' pins are either:
> >  * unused (on kevin, bob), so the settings is ~harmless
> >  * used by a different function (on scarlet), which causes probe
> >    failures (!!)
> 
> I suppose that means the default pinctrl should be dropped? Or maybe this
> use case is the outlier. Up to Heiko?

Interesting question. Right now it looks like Gru is the only one using spdif
in that way, so I'd think dropping the pinctrl here is the "saner" option
at this time ;-)

I guess we can reevaluate if this becomes more widespread

> > Fixes: b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 




