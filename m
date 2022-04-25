Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF050E71C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiDYR2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbiDYR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764B940E74
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1200661583
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B27C385A4;
        Mon, 25 Apr 2022 17:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907474;
        bh=/eg1aAQGAhXyy+euVBTjuXj3vXPgIAwKG34G46xjphM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jt7M9osM6PGY8RKw21ZKDnjUT5uRB/zCjP8t4Akgeytohy+jyODJheE/nvOwDa1t8
         cfg2a75JtASaoc0k5JzcLAHQ7dnEHFnzSAZsk8fCbpCAtJla6HgGEbH4W7m+fDZaj4
         gtV4zjyAXIMBrqiRmejQ6/tqWJ16XFjdZWAvnTmSQNXsp7flV75570lHlPVEAGtqbT
         f70bpC2CuqDEYpe0OeF8MEtHuXKVj0DdLRSTsjuKc7ieqeDyvpUbGXBh7AgvT/Csqw
         YLr4R4O++XWkpftl9ivE0DbOXNPVji8jlZtaladHg+m0tPE/wTtRMJUz5YmHqSdAKI
         EUdUOUTPjPu+Q==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, daniel.baluta@nxp.com, lgirdwood@gmail.com,
        geert@linux-m68k.org, perex@perex.cz, yc.hung@mediatek.com,
        pierre-louis.bossart@linux.intel.com, allen-kh.cheng@mediatek.com,
        tinghan.shen@mediatek.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com, peter.ujfalusi@linux.intel.com,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220422055659.8738-1-tinghan.shen@mediatek.com>
References: <20220422055659.8738-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1 0/4] Add support of MediaTek mt8186 to SOF
Message-Id: <165090747057.583823.11213583506158187957.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:30 +0100
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

On Fri, 22 Apr 2022 13:56:55 +0800, Tinghan Shen wrote:
> Add support of MediaTek mt8186 SoC DSP to SOF.
> This series is taken from thesofproject/linux/tree/topic/sof-dev-rebase.
> 
> Tinghan Shen (4):
>   ASoC: SOF: mediatek: Add mt8186 hardware support
>   ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops
>   ASoC: SOF: mediatek: Add mt8186 dsp clock support
>   ASoC: SOF: mediatek: Add DSP system PM callback for mt8186
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: mediatek: Add mt8186 hardware support
      commit: 1f0214a86de87011ecb96f22545dd6e5c7324cd7
[2/4] ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops
      commit: 570c14dc92d5dc6f732cb74fa691ef909d182710
[3/4] ASoC: SOF: mediatek: Add mt8186 dsp clock support
      commit: 210b3ab932f7a08d8b912c497ca0ca86f712814f
[4/4] ASoC: SOF: mediatek: Add DSP system PM callback for mt8186
      commit: 0e0b83cc7ec7fc5e6695aa6ebbb0961e26096105

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
