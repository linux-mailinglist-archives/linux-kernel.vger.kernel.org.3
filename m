Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDA4621E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhK2UOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhK2UMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:12:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7961C08ECB4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E70615AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399A1C53FC7;
        Mon, 29 Nov 2021 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638204341;
        bh=gGQZ1XxL/JzQ52kfNY/nOzOWpgFUv70PvloYw+e/SUw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hiE2Yk2U385ARDIrpA2Xp8RIz9vooK0BTnopEitzgQEBTTn7DszILuWGh0HmFlbDZ
         8CoS635XzAUBXepyJ91t6lSdg441BlJK1REAYNGB+UdxZRpqdxbhhMxJ4McNa+4XDr
         j/avWi96rnFgt8TH/f8E8LXRz3LTsw8Eo2ug1n0KJKb2Ntz9IdZJWkhMECsqjwdEks
         B9le8Tf75F/l6eQ54uhiMij4ZRjI90kNGk4PuRQnd9wqZtV3di18biCQ2UAHYIpeLi
         TnZg/i40ZEIGv5QQ15jrNqRH37sBzzEwVpvIQd2VKTN4WSG/cVrRRoarNj+5JD7J6S
         6i67b5EbGDzgg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     alsa-devel@alsa-project.org, Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211118033645.43524-1-samuel@sholland.org>
References: <20211118033645.43524-1-samuel@sholland.org>
Subject: Re: [PATCH] ASoC: sun8i-codec: Add AIF, ADC, and DAC volume controls
Message-Id: <163820433995.1716750.12532237321592669986.b4-ty@kernel.org>
Date:   Mon, 29 Nov 2021 16:45:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 21:36:45 -0600, Samuel Holland wrote:
> This allows changing the volume of each digital input/output
> independently, and provides the only "master volume" for the DAC.
> (The ADC also has a gain control on the analog side.)
> 
> While the hardware supports digital gain up to +72dB, the controls here
> are limited to +24dB maximum, as any gain above that level makes volume
> sliders difficult to use, and is extremely likely to cause clipping.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sun8i-codec: Add AIF, ADC, and DAC volume controls
      commit: fd03cf7f5b4726028cfc2ef76e42d0d5c66377aa

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
