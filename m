Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D400446557A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352437AbhLASfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:35:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55600 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbhLASfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7477BB820E0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69631C53FCC;
        Wed,  1 Dec 2021 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383519;
        bh=0ErMPp+nSpqns+RPcMscWpoz3VnyGlsjo34kCcsaDN8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hObqE1g/hGibCRCZBqE4Cpq2ldXrizQ0oBDzuCHBLSZ2X1aSSd7c1b11ci7GZCQB4
         3EuwjuDDcl7Zs4ut4jKP03BE2e3ODlv09Mrx4IVVPzI76NrGnuiQx7zzdhlz8/huJi
         ICQut3T7vrGA0hfS4GqgOkW397ohuG7OC1WG3GxCR+pvHzECjhN3Dgib4hQ9y76eit
         WJSc4PFZSXlLOSJIfCuDDt/dHxn6NFlMwxLgfZn5MtqEUTYvdUGK7R+PVM6sQSTG+Q
         1KzhjlhCVK4E2q6NSFwJ9SjSmaz0ttawVNU/UX45p5jruSLoyieEu9d/l9+dDhHV+T
         ReNhwJ9UsE+xQ==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211125084900.417102-1-frattaroli.nicolas@gmail.com>
References: <20211125084900.417102-1-frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH v3] ASoC: rockchip: i2s_tdm: Dup static DAI template
Message-Id: <163838351714.2179725.14811298107185892550.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:31:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 09:48:59 +0100, Nicolas Frattaroli wrote:
> Previously, the DAI template was used directly, which lead to
> fun bugs such as "why is my channels_max changing?" when one
> instantiated more than one i2s_tdm IP block in a device tree.
> 
> This change makes it so that we instead duplicate the template
> struct, and then use that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: rockchip: i2s_tdm: Dup static DAI template
      commit: 53689f7f91a2ab0079422e1d1b6e096cf68d58f4

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
