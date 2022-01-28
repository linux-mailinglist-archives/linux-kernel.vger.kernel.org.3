Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1E4A0477
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbiA1XrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:47:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46890 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344508AbiA1XrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:47:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93CB2CE27E0;
        Fri, 28 Jan 2022 23:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1611DC340E8;
        Fri, 28 Jan 2022 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413620;
        bh=YbZLwG+eJY1ZimQ3PDJ414ftXS0oYjH5t+IwvoH0++s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H6N+qa02zvveNZcva5WhrGiGfFlJ66Cb6+yfRLYilkduh+hulF7T0OeTu/hburMzI
         yri78rLL6daKW9gr8X08EibZESI18/IBpN1Pbc1hUchVwsl9f1LfyCo1WFwktqwb8/
         WhMvDqfjoXFeMWDKTJAFvPq07d9H9J95VdV4XpgahRGHn8cMJcF4WTXB1tus4t4Uh1
         5GnvTRmAL9qKEWspIPzel0cYJTWOmOhQW3fmKwYGPfuBHC5T3VxISuz3I97zsJVC+N
         KJ0PrtCoVJ9qsR9tTbUB13DANVzaUtP5ujdmoAOK3ZTdma0dMi9TkcPU5eWB2rSYik
         XmBrYqh7uuWpQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org
In-Reply-To: <20220114230209.4091727-1-briannorris@chromium.org>
References: <20220114230209.4091727-1-briannorris@chromium.org>
Subject: Re: (subset) [PATCH v2 0/3] (Re)enable DP/HDMI audio for RK3399 Gru
Message-Id: <164341361780.694709.13259283241590347085.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 23:46:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 15:02:06 -0800, Brian Norris wrote:
> This series fixes DP/HDMI audio for RK3399 Gru systems.
> 
> First, there was a regression with the switch to SPDIF. Patch 1 can be
> taken separately as a regression fix if desired. But it's not quite so
> useful (at least on Chrome OS systems) without the second part.
> 
> Second, jack detection was never upstreamed, because the hdmi-codec
> dependencies were still being worked out when this platform was first
> supported.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/3] drm/rockchip: cdn-dp: Support HDMI codec plug-change callback
      commit: 9da1467b49ad6c02840e8f331c5da69f6a5bdb2e
[3/3] ASoC: rk3399_gru_sound: Wire up DP jack detection
      commit: 6a8bc4b68ca0c6ef73518b692c00b7e1e010d056

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
