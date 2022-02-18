Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446234BBA99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiBRO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:28:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbiBRO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:28:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360031511
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:28:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D07C61B18
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AE3C340E9;
        Fri, 18 Feb 2022 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645194509;
        bh=QIhhSf+LNnFkR0oPqDauJgbg11+0+JGmV4ABpoWiHVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=asICOcEcJc0EYX8Pm0VJqHru/j2mEDfmmf7UF5lkNEREMyQ/KTtmNyg+E2jhCPTov
         B8WZF4sfK9nrMFzv2niVzfyDHN8GG5nkvz0WqK1hfB+Km0SvYFwl3LPJfYb231Hpj/
         NOfomnM6LHPJFB/BBOVc2uz69WIES5yKKfkkKXBz36nTPRmdWVGy4HW1bAG2kWMPUz
         iI26wPcVWWW7qHggyxVmH3Vr/tiPG75Q1ETPq0rxU4Lq87FGtBzxOgbJDdzpN+9Y5u
         EQvceqCUm3dhyKFk8oxCy0gdd52c/XxJHrq8cvKX1+qMY/TqHb5X5hjdrsgsj4NSJO
         S9WGi/0uoyQRw==
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Huajun Li <huajun.li@intel.com>, tiwai@suse.de,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <cover.1640351150.git.mchehab@kernel.org>
References: <cover.1640351150.git.mchehab@kernel.org>
Subject: Re: [PATCH 0/1] sound: add quirk for Huawei D15
Message-Id: <164519450743.1836505.3912962145996830275.b4-ty@kernel.org>
Date:   Fri, 18 Feb 2022 14:28:27 +0000
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

On Fri, 24 Dec 2021 14:09:48 +0100, Mauro Carvalho Chehab wrote:
> Based on my tests, Huawei D15 (Intel) uses SSP0 on es8336.
> 
> Add a quirk for it.
> 
> Please notice that, currently, only the internal speaker is working.
> The topology for the internal microphone and for the headphones
> is wrong. Enabling/disabling the other two quirks (GPIO and/or DMIC)
> doesn't cause any audible results, nor change the devices listed
> on pavucontrol (tested with pipewire-pulse).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_es8336: add quirk for Huawei D15 2021
      commit: ce6a70bfce21bb4edb7c0f29ecfb0522fa34ab71

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
