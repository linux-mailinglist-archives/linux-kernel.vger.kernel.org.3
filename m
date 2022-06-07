Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9ED53FBB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbiFGKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiFGKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F41E3E7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD40B81EF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1BCC34114;
        Tue,  7 Jun 2022 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598715;
        bh=zGH5b/STJj18mrG57UIzzjkiu2m/697Mzp28pW+tLkc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MZ3Z69WfLof8HyNjFb6ggN3qi90rV4dWtA0xnqnYR9cxdAqpIcsEGZ1D0upxLFZC+
         mEEiZLRBpZTAo6NTanz9ryEo+bVz4lOq3uP5S9sqX+UGqFd7hIh1yW/0zsGcc7gMkD
         rfAf6flBYGI+1va7+LipURXiddlgspFLkq/eT76ABPXhsra7mSETsBkNTppen93acd
         Ee4hWPMr41cZrSWMhNS38AY1k2rMwAbRRn0WcygCWmRdIh+Vioc7mgtZJQSFWTMntr
         4R36jstJG318S9EADa+JoVD1R5r9DSmLHRCwnwSscZB1wVnve9INlpLv/P0nal1ks8
         lhtovcmPzvdyA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com, lgirdwood@gmail.com,
        shengjiu.wang@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1653015960-15474-1-git-send-email-shengjiu.wang@nxp.com>
References: <1653015960-15474-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: enable dual fifo for ASRC P2P
Message-Id: <165459871277.301808.7959112198574702500.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 11:06:00 +0800, Shengjiu Wang wrote:
> The SSI and SPDIF has dual fifos, enhance P2P for these
> case with using the sdma_peripheral_config struct
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc_dma: enable dual fifo for ASRC P2P
      commit: 6398b004cfcce38626f3ba6fa5853177a3501aae

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
