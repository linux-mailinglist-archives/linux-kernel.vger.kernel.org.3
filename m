Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C249B1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352903AbiAYKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243556AbiAYKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF9C06175D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A91D61614
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5890EC340E9;
        Tue, 25 Jan 2022 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106044;
        bh=V+CXNMlBJLDkVnoMPBK0epjEdchEM7zxpeDI595A+Bw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=te+l92wRX7p451mWxm/bQ9/Y7QwQ07TyYhXRvd9JGv6T/QJXaQwZJbzN9g/qFFxUk
         7yF5WuiSVn5Hct9ABnMSV/YjmNtZcaWqi/fcXTmlLHaa4Jh/w4s4TJcDf/7gDaFTEv
         +QUBe5zdsQkVHx5UdhqqFlDxEEtuuDUN6va0lsim7mSQ9CB3rDl4LO1NZwtB/XgzzB
         k5F1g1ZZjJbeSEBbwuZd9MCvhVnVBNFeJIZBDx6EB5LQVesvo8Y7lacUCouRoHmKzb
         +pvRQnvYXCGk9sWrb5dWfA2UeZk0Uu/WG0GEeBgxg3GNGlnDH190K3hb+BHf7bChgv
         M1qT64xqFZYPA==
From:   Mark Brown <broonie@kernel.org>
To:     V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Vijendar.Mukunda@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ajitkumar.pandey@amd.com, Basavaraj.Hiregoudar@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sunil-kumar.Dommati@amd.com
In-Reply-To: <20220122194707.2661026-1-vsujithkumar.reddy@amd.com>
References: <20220122194707.2661026-1-vsujithkumar.reddy@amd.com>
Subject: Re: [PATCH] ASoC: amd: sof-mach: Add support for RT5682S and RT1019 card
Message-Id: <164310604108.74844.4371897613558454989.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 01:16:59 +0530, V sujith kumar Reddy wrote:
> We have new platform with rt5682s as a primary codec and rt1019 as an
> amp codec. Add machine struct to register sof audio based sound card
> on such Chrome machine.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: sof-mach: Add support for RT5682S and RT1019 card
      commit: 330dc18356e697eaf9796732b6acbdf948022136

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
