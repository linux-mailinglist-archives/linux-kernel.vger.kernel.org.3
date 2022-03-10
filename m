Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292D04D45C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiCJLgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiCJLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:36:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EE714237A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:35:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2BC5B81EF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20060C340F3;
        Thu, 10 Mar 2022 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646912125;
        bh=AnDM7FNCQi75VSOYT6xKBeT+BDE6bxlYZVn7KRHx63U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k+VS0Ue73un/AjXuiuoFw90Gps1nTbaWecCkV9N9DLS3Gn6zq33rkwvipTqMtKZyL
         RyXXOGbRwCQDV/q7nzerB6Paj/sk92/CLNvtzQHAgL6no6Xs+O8cBXlTRrk3trESRO
         xmk/T/+OXD4DAA4tRxMA8ih+W/uh9JvGeVHK5n1fou2vvOMSqMBMHLUkPuLTRWnnHY
         Lth2108o4NjYQWaynuX6mMPMBZTLh0iQXDHueziwgPOdyM30W/YJkMy2UzCZdMMdXX
         e01vJo2tz+5tuxZdBz1KZYzrPfO+UbFpCf+doblZoISICBRcy956OvvzVK/cNlhxRB
         XIY03BjYQ1VBQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        pierre-louis.bossart@linux.intel.com
Cc:     kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org,
        ranjani.sridharan@linux.intel.com,
        Abaci Robot <abaci@linux.alibaba.com>, daniel.baluta@nxp.com,
        lgirdwood@gmail.com
In-Reply-To: <20220309004929.125558-2-jiapeng.chong@linux.alibaba.com>
References: <20220309004929.125558-1-jiapeng.chong@linux.alibaba.com> <20220309004929.125558-2-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: Remove unneeded semicolon
Message-Id: <164691212284.13798.8164925619305971959.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 11:35:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 08:49:29 +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./sound/soc/sof/amd/acp.c:280:3-4: Unneeded semicolon.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: Remove unneeded semicolon
      commit: 5af07dad696422d48368409461a754990faa713c
[2/2] ASoC: SOF: amd: Remove unneeded semicolon
      commit: 5af07dad696422d48368409461a754990faa713c

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
