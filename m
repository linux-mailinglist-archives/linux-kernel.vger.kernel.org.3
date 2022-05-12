Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37042524F94
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355099AbiELOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355098AbiELOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D763380
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 324F261A01
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC6FC34114;
        Thu, 12 May 2022 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652364763;
        bh=UIXcV2KLWijXWL19jQLq1vEhgqxz6qEWy8qt2aKyHXE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a+r+E+ToFiNe9Q7bFQULMTHx1L1w/qPqi22IiPMWuBdhHM2PMyik/wtrfUatP3Qwu
         f/ymLloRnIPL9gHtXw8KX1zJpXeCsNNNDvaH1XbsPUkrKJSYy6yaa46/QrqqvBA45K
         dLouZyUfxUxr1YRmmWGcRSDN1+AQL5tYeAqEbhxqk236jNDgSiejU3wcugptP9q0Uo
         otnhI8wtvttwXf8huK8VHoDKu4xsvCq4/vcQ+z6ByhxcY41Nr5NtxJ76o0VPgGe/qd
         l9+7DqfbVcaauw+IjIpsjDbd0OKcVgYPDNs0t7Nilmfyyl3i8GXeZac0ijp0e7YC8S
         rMHxvAAY8lZiQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        Xiubo.Lee@gmail.com, tiwai@suse.com, shengjiu.wang@nxp.com,
        nicoleotsuka@gmail.com, shengjiu.wang@gmail.com,
        festevam@gmail.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1652183808-3745-1-git-send-email-shengjiu.wang@nxp.com>
References: <1652183808-3745-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Add support multi fifo script
Message-Id: <165236476117.1016627.2134369167163504091.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 15:12:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 19:56:48 +0800, Shengjiu Wang wrote:
> With dual fifo enabled, the case that recording mono sound
> in the background, playback mono sound twice in parallal,
> at second time playback sound may distort, the possible
> reason is using dual fifo to playback mono sound is not
> recommended.
> 
> This patch is to provide a option to use multi fifo script,
> which can be dynamically configured as one fifo or two fifo
> mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_ssi: Add support multi fifo script
      commit: 7aded7003a4e949b3bf73f060771f9db018a6d96

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
