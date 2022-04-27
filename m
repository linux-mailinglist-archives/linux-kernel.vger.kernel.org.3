Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F255124ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiD0WF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiD0WF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:05:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD247B560
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE675B82B05
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374A9C385A7;
        Wed, 27 Apr 2022 22:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651096962;
        bh=jGR3MtKiwYyR+lUnJSaAaDsNLiw4lH+yX1MtYnOs/i4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KYAsSER2fa68mS9DGuKJMxkz2YSD++pSrMvoxGWqBZ5FXe3TlAtwgsOqiA4aJk+7P
         FuC7iZnPgJiRFtfG+2TqFhKDB+aB4DF9nCvdnEZwf4nt1QKW3etyqCmmBh3DpTgIZm
         wFPwoKtcIqCFyYKxr8vgd+ej8mL9eM5Kz0ftgvB0h+bNI2N9rWu6XiD0pSWSBp8lS9
         Op3mySF/PDzwazx7lnmoYQibcQyvh6ZJbp9xQeZHubDMvGDQRgM7Q+s+BQWXFdt8b1
         gp5kEKwMNBA4bHkInGCJQiEozfrj5VYJpiGnY2D0C6L4paMmJuzSHS2r9Cdic0GlUW
         1mFKxLwcqiTVg==
From:   Mark Brown <broonie@kernel.org>
To:     yc.hung@mediatek.com, tiwai@suse.com, matthias.bgg@gmail.com,
        perex@perex.cz, allen-kh.cheng@mediatek.com,
        ranjani.sridharan@linux.intel.com, yangyingliang@huawei.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, tinghan.shen@mediatek.com,
        lgirdwood@gmail.com
Cc:     sound-open-firmware@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20220427071030.10172-1-tinghan.shen@mediatek.com>
References: <20220427071030.10172-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH v2] ASoC: SOF: mediatek: Fix allyesconfig build error
Message-Id: <165109695894.498174.15533470381534539256.b4-ty@kernel.org>
Date:   Wed, 27 Apr 2022 23:02:38 +0100
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

On Wed, 27 Apr 2022 15:10:30 +0800, Tinghan Shen wrote:
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o:(.opd+0x18): multiple
> definition of `adsp_clock_on';
> sound/soc/sof/mediatek/mt8195/mt8195-clk.o:(.opd+0x60): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o: in function
> `.adsp_clock_on':
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: Fix allyesconfig build error
      commit: 9ce170dc9c08895846c5828addb724e42bf98484

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
