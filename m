Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9A4C36C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiBXUVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBXUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:21:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EF75C34
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B056175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5CFC340F2;
        Thu, 24 Feb 2022 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645734040;
        bh=jHJhesHy+9/fGMrcaHrx6dRyS22nbc2nynNMtLMtBCY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k08/uO31fAuRW7vQFOqGyJslkunL8DVwQipPk0y+Uik8Z/1FtQ7IJnau+PPf8mB1k
         YA2ykCk+TocFcfWpUOvPww1Rh+HFQY9XyrTUsYqbmeoB1Y0u0rtlhEHZBw1i9H0euK
         CUXS2AZ8SDh/LffuLfhT1eqAn+3LaOOkrkL5053dmw2r9He56rKIpMFXwGt2NCMS74
         idvZdXx9OY8LGa+5kV4GGqVeG1pgPrTxY1Kn+yLQLUgmskGMXM5M9gv+1Bz7VKX14l
         /AOLtA3N701mPQYB1hNWA209cjUKnGdrUawBmJ7pjqrD16cX625cW8ugfk1XwrpseS
         m+nH0lBuYjb9g==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
        peter.ujfalusi@linux.intel.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com
In-Reply-To: <20220223153849.84471-1-daniel.baluta@oss.nxp.com>
References: <20220223153849.84471-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: pcm: Add compress_ops for SOF platform component driver
Message-Id: <164573403817.3139675.11623054539337651313.b4-ty@kernel.org>
Date:   Thu, 24 Feb 2022 20:20:38 +0000
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

On Wed, 23 Feb 2022 17:38:49 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Now that sof_compressed_ops initial implementation was merged
> we can enable it in SOF platform component driver.
> 
> This partially reverts commit
> 8a720724589e ("ASoC: SOF: pcm: Remove non existent CONFIG_SND_SOC_SOF_COMPRESS reference")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: pcm: Add compress_ops for SOF platform component driver
      commit: 76cdd90b27b4e7379ce4d9032dda1927ac69ad01

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
