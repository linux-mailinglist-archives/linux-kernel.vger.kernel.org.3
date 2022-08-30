Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201255A6CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiH3TEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiH3TEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:04:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B360531
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 493D3B81D0C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7ACC433D7;
        Tue, 30 Aug 2022 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661886281;
        bh=eFPF/n6jVsSaGykmhj+28XDu8sEBKuaI1h0KdA5loS4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b18RNr1xIJMS30q6OSmh3Ztnx1M0lzSkW/gpBHTFX+Bcdwc4Hi87MqM7TFSrQaWaZ
         cCiMg0SF2H0WEFWnvk/b9zhjo/Ui5kTWNVL4t+nLc68qszjPH/W+QY+EaiKGnIIy3D
         T6VS75xwavRnhaoiAs8NMwrZRAZYapiIXrUsviGf8SNPTB3MNNCWtsJ1ftv2tcG0iI
         FDNcl4vy0bcZgJN0slgKWDAtmmMZVlrBufEf/NkH/4xC2Irr/zLr9gGREonyZFQN+P
         R9ZDpxa8oXFRl9WCNJ+OfHSrgaEfYPMH/hS2IjVJtqc0AZAWCIK6SkS/lNMTRhRQvE
         zf1mfLJxt5lQA==
From:   Mark Brown <broonie@kernel.org>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Vijendar.Mukunda@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Takashi Iwai <tiwai@suse.com>, Sunil-kumar.Dommati@amd.com,
        Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20220830132259.7759-1-Syed.SabaKareem@amd.com>
References: <20220830132259.7759-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix spelling mistake: "i.e" -> "i.e."
Message-Id: <166188627628.1152207.14297370595024106059.b4-ty@kernel.org>
Date:   Tue, 30 Aug 2022 20:04:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 18:52:55 +0530, Syed Saba Kareem wrote:
> From: Syed Saba kareem <Syed.SabaKareem@amd.com>
> 
> trivial fix to spelling mistake in Kconfig File.
> 
> Reported by : Randy Dunlap <rdunlap@infradead.org>
> 
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix spelling mistake: "i.e" -> "i.e."
      commit: ced579dcaaa45fe16ac6c12fe847d650734af7bb

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
