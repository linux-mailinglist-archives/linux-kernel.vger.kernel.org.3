Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94E509235
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382609AbiDTVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382592AbiDTVnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:43:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1738DA7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A94C8B821AE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321CBC385A1;
        Wed, 20 Apr 2022 21:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650490861;
        bh=8X2QEt2lhi2nHtjk6Rs3WVQZYib5Iw0DT7J8jUnG10I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZeE1O5EpvOwXFbK6lO1RpwVY4KTk0d+yzNGNW47alh9PFEi6TKVJabMSeAlPawhkz
         PibaSiyJsufJmgusHMEPpvL38T2XcqXTj8Y/Ftt5hd4m4cGsAvUr0px5kBkCe8qtrc
         S/rB0k+UHp6zS3TyvLVIQO+R24U6Yn7lR4+IbIZ1Qjkpf3U92P+ZHehH+RthulPy4k
         TAHLP68rMA06V+SqNbHfMjBzayGJpdO+AqE/7n8IyTd8wBt7a3bkVgBlwiEv9GgzIz
         KUI66IxVvvsnzwJ8n6lqmXx4owvaqqfEBut1GfqVkibrdQPSCM4APPaClwuzTHsUI7
         InTyrTC7K2Jfg==
From:   Mark Brown <broonie@kernel.org>
To:     AjitKumar.Pandey@amd.com, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Takashi Iwai <tiwai@suse.com>,
        Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, vsujithkumar.reddy@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Alexander.Deucher@amd.com
In-Reply-To: <20220420094442.1352717-1-AjitKumar.Pandey@amd.com>
References: <20220420094442.1352717-1-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Add pm ops callback in machine driver
Message-Id: <165049085891.138067.2699474360256184999.b4-ty@kernel.org>
Date:   Wed, 20 Apr 2022 22:40:58 +0100
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

On Wed, 20 Apr 2022 15:14:36 +0530, Ajit Kumar Pandey wrote:
> Add alsa snd_soc_pm_ops callback in ACP machine driver to support
> suspend and resume operation of sound card components
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add pm ops callback in machine driver
      commit: fbae863de87bf50c7b13b40e3b4dc4b479335020

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
