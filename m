Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11A54BA853
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbiBQSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:33:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbiBQSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:33:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE86363
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:32:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B28DB823C5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5447CC340E8;
        Thu, 17 Feb 2022 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645122741;
        bh=xwSCKgJCSi//NdMMY/uqE9yzCLpiaQujmlrCLYqJ29M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ew0EMEJtVqPTC1tjTEMpaKO7aSCibLsRxhlFO4GWnj6NtQBwSyUj/cqtZ7o/9wami
         IJ4oJrpgwwKsN9cBs5irSLjVFEhgaoQKhaBCrbp+mAR+g8Ti67368C2hMG/+nkI2c1
         HKwOdcZ2qdisPdToFP/OTLujo6tHv6Ac3B2K7V3G5sgWBtzPxhvdYevoGRmCyu6gTi
         /Xtnt87CydStz6RXQSCnyfZobLbG1cy8Nla+fEsjq65M4v+Mk9GZhbT8NA+5/xjTKU
         LggzxN5JGHvD7nxgiNzuC/mMRjCfari4eOKmhlqL2U1FMeGyqJBX+FFf/ai0kJPwTT
         5kuCS929r4dwQ==
From:   Mark Brown <broonie@kernel.org>
To:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Stephen Kitt <steve@sk2.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
In-Reply-To: <20220217132755.1786130-1-steve@sk2.org>
References: <20220217132755.1786130-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: SOF: Replace zero-length array with flexible-array member
Message-Id: <164512273904.3993052.15786188783009967860.b4-ty@kernel.org>
Date:   Thu, 17 Feb 2022 18:32:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 14:27:55 +0100, Stephen Kitt wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members"[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Replace zero-length array with flexible-array member
      commit: 4fe6a63077a6d3c143d68f6b96e4051f1d0740ac

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
