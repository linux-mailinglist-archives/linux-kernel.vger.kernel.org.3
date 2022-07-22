Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2957E199
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiGVMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiGVMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7227C9E294
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11244B828E5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A290C341CA;
        Fri, 22 Jul 2022 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658494096;
        bh=lcEC2kCCCKbO1yjbDbyfX8qWq8HYcFr/tlhbvJ8XuHI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eraogMMyWRM05UkIcrgH2Jet2YLCblC54Gjgn/qqaLdS7jN8hg9jZcniK3hegC6C1
         7BZ5DTQkdoFXiFz6lJEyN0CU7h8u1Oa1CFB99AyF7P9MQxmTMB5NxZJjstbzSLf6IM
         2ZhzvN8uJEMVQvyLor6UuLx9Hex90dfZizAwCcIHjoziVUa1R++EHhfx3Zj3JHxk3X
         Pd5Gfx1KkKCWhhBXJCyhd7ItKCsFEl3TXaBpWrYFKyeR5UjCvuOJWHN5UsuleIJEPE
         xr60HY6gEax+/41XXSBlHHf6X0Bb0wgTVNHfSLAv4ABxWwaovdqR/qAI2qoN4ICzI6
         QRjgRs/oBuEGw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     Sunil-kumar.Dommati@amd.com, Vijendar.Mukunda@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ssabakar@amd.com,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        vsujithkumar.reddy@amd.com
In-Reply-To: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
References: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH 1/5] ASoC: amd: acp: Modify local variables name to generic
Message-Id: <165849409334.139149.4436089052962761200.b4-ty@kernel.org>
Date:   Fri, 22 Jul 2022 13:48:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d952f
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 11:50:33 +0530, Venkata Prasad Potturu wrote:
> Change local variables name to be generic in irq handler.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: amd: acp: Modify local variables name to generic
      commit: 93f53881473cbf6a364be36ccbb99568e04ffe59
[2/5] ASoC: amd: acp: Drop superfluous mmap callback
      commit: afde6727a9b66ff96e20d74ac392f3efdae1ceaf
[3/5] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
      (no commit info)
[4/5] ASoC: amd: acp: Modify const resource struct variable to generic
      commit: 96b008a1c2e9f455d982e9cfb7117a3a0fc8f550
[5/5] ASoC: amd: acp: Add error handling cases
      commit: c49f5e74a11e3909c424cada0f5d52345084933f

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
