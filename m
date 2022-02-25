Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA384C4C78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbiBYRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiBYRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7B1DBAB9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:35:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF2E61DCF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B854C340F0;
        Fri, 25 Feb 2022 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810555;
        bh=60Aj97bhCy6GhcHiP/GEc6hAyHSIKtkMbp6raHwJd4A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F16A1nFNWxF85bJAu6f10xr4xjBGEIUr2LqmsDSNLo7x8My+7YawxNYJoUVrD09ae
         s3tx5oHe5/yedR5uxCzfu8PZmXo/Nf3nQ4zGk9Qopbd5qoJRQAbuXgyPpImFSESquO
         +AJYdWXF2s63xgGSZhkG5AMQEsGHPdKcAU1cD7Ldnmy6ujONILs1eAFRRRAYzcqW4z
         YrSmivQcSadKn8WCgtldTsAwCdBMp3h344N/kfzOE+rrA+3aBdP0baGS8aWpycBfxv
         cOCrpFXC+2kKdVYPeoFcxaH4RcxnGnsduna3Sf1GAFglRVR3gN2zcdC46WmJNLItYW
         PUGdckQP2MKIQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        AjitKumar.Pandey@amd.com, vsujithkumar.reddy@amd.com,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220225131645.27556-1-baijiaju1990@gmail.com>
References: <20220225131645.27556-1-baijiaju1990@gmail.com>
Subject: Re: [PATCH] ALSA: acp: check the return value of devm_kzalloc() in acp_legacy_dai_links_create()
Message-Id: <164581055316.2548431.3373385373741114980.b4-ty@kernel.org>
Date:   Fri, 25 Feb 2022 17:35:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 05:16:45 -0800, Jia-Ju Bai wrote:
> The function devm_kzalloc() in acp_legacy_dai_links_create() can fail,
> so its return value should be checked.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ALSA: acp: check the return value of devm_kzalloc() in acp_legacy_dai_links_create()
      commit: 431f9a77a4a62694ce90742d1f4c5abe1b8b6612

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
