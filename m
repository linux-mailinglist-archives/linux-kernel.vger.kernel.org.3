Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65D2509234
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382603AbiDTVnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382595AbiDTVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:43:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7228138DA7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0402BB821AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D897C385A0;
        Wed, 20 Apr 2022 21:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650490858;
        bh=6jaiM5EEkZokoyNt2f05Dgwu++Zj3+Z8+mfjrNupSEI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OeUkZbODgwjPKvS1nHtnuZlnoQvT041gNVtxebkD7ofNZOZnQbM4vvhfET+1DfEHN
         babP+yod5/7sLDCUDQTG9mgtqtoQKpC+/HlA+ytRbPnyUxKkbBdcThRzufTdk8tVfD
         wvZFsJyZg9M8KM+yetLt6cZmYCpmNcoiu2k2vZhV+tTV9hfs3OOrSiNvgb3NNMsXCb
         Gnf0k3QUIY0fOuHSEId6pO/pF55QR9R8B6bO+1pGr91U1lK18XrCBc2oZopUiOK8vS
         Gd1Jt9WRIQ+COAmIrPZjzb5PzWuGmoui0SLUGgVa56wQLkOwZo+ZhH1m4alZI9NOsp
         jvD7uOtrKWkxQ==
From:   Mark Brown <broonie@kernel.org>
To:     samuel@sholland.org, rf@opensource.cirrus.com,
        Takashi Iwai <tiwai@suse.com>, robert.hancock@calian.com,
        spujar@nvidia.com, olivier.moysan@foss.st.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, stephan@gerhold.net,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220412111658.11015-1-olivier.moysan@foss.st.com>
References: <20220412111658.11015-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: fix sysclk shutdown
Message-Id: <165049085609.138067.16736006063801162834.b4-ty@kernel.org>
Date:   Wed, 20 Apr 2022 22:40:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 13:16:58 +0200, Olivier Moysan wrote:
> In asoc_simple_shutdown() the snd_soc_dai_set_sysclk() function
> is called twice with input direction SND_SOC_CLOCK_IN.
> Restore one call with output direction SND_SOC_CLOCK_OUT.
> 
> Fixes: 5ca2ab459817 ("ASoC: simple-card-utils: Add new system-clock-fixed flag")
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card-utils: fix sysclk shutdown
      commit: 3756aa16fadaef2873cfbd2659dfa1978a7e1859

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
