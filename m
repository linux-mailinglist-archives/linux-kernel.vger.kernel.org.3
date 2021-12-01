Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60D465579
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352374AbhLASfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242940AbhLASfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:31:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43A7DB820E0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312DFC53FAD;
        Wed,  1 Dec 2021 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383517;
        bh=7qhygDHX4J1BeJlKqGRQ1ZZF1wSu4J7V9n4jarp8HOI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fA3Rscm+Zo8Tu5O8KbUZDiMyF/Na5hEy0DoyxyYkFXD50PkuN86AfvwqMj3wJetCk
         bO141OVMndGgrGBAur5hfdUOYhr7T9CZKzp2UzrRP+v2JiQe4Qsw9L2ooekc922YiC
         RcgM4FnUqQaZnELYB0/3DhpS/qOdTzFyQoSlzVQpZ1SaYSPwLBp0RE4OdDcX1wGTdl
         7luZNt1Ts3YL6Q3MBxMhPzdwHvofLGmOc9qlyYvHMRG5MJKOs9j2lDL4OqttjdfEvu
         AU2NIlv5XlriBbBC5swsofXtQk1QkQCxvN8LK+iHJhaKFvBzK9hwNsV0m6KgG+1A7I
         qQ6IiU0QIoB4A==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211124210655.288108-1-frattaroli.nicolas@gmail.com>
References: <20211124210655.288108-1-frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s_tdm: Dup static DAI template
Message-Id: <163838351490.2179725.16335234667243038624.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:31:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 22:06:55 +0100, Nicolas Frattaroli wrote:
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
