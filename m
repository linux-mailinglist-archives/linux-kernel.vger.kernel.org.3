Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A21563C49
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiGAWWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiGAWV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B5B70E47
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A20623DC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 22:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C25C3411E;
        Fri,  1 Jul 2022 22:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656714115;
        bh=QtVAvCpWJRtTqq2wfJizMcxgUjJUwOOMwgQo9QJsnoI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s6b9AlkmAh6MZJFmlunyM/WQ7AlhRNT0hmtUM7y4beWDoO9uLJKxxWuozrL7ogIKh
         fXiqnWm3GSxfDdU3SGjJFV6VxUbNuS9bTxuAN98+K9ZPI8/RTJSOqVU0YEKmc4s/5H
         UwLZ9dBki7ER5zIif0+7zKfVTQ8I34XlcPKYdZ9kLgqS1SJbsDBQ+x3erDOttOZ7x+
         +yRITE01aAHZYLQu4DsgyERaZ3ZQG/KdnYFLTv/FGuW9Le6mgIaf+j/VsTTQtYxsEh
         4lq1uuHqYiGhRXEDrC4iuSGnEoDlaCgKtwCQriW6VH+E68DXmvslN0ZjeUaNIJtrtO
         FJ3Xw4DyhTH/Q==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, brent.lu@intel.com
Cc:     linux-kernel@vger.kernel.org, peter.ujfalusi@linux.intel.com,
        yong.zhi@intel.com, liam.r.girdwood@linux.intel.com,
        cezary.rojewski@intel.com, perex@perex.cz, ajye.huang@gmail.com,
        tiwai@suse.com, ranjani.sridharan@linux.intel.com,
        mac.chiang@intel.com, kai.vehmanen@linux.intel.com,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220701141517.264070-1-brent.lu@intel.com>
References: <20220701141517.264070-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_rt5682: fix out-of-bounds array access
Message-Id: <165671411147.591936.521859286196210706.b4-ty@kernel.org>
Date:   Fri, 01 Jul 2022 23:21:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 22:15:17 +0800, Brent Lu wrote:
> Starting from ADL platform we have four HDMI PCM devices which exceeds
> the size of sof_hdmi array. Since each sof_hdmi_pcm structure
> represents one HDMI PCM device, we remove the sof_hdmi array and add a
> new member hdmi_jack to the sof_hdmi_pcm structure to fix the
> out-of-bounds problem.
> 
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/1] ASoC: Intel: sof_rt5682: fix out-of-bounds array access
      commit: fba5a02a4c028dad32299aa723716349f93845eb

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
