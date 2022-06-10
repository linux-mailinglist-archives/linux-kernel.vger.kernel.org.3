Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5A5469F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349347AbiFJP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiFJP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:58:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BC1EB423
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94B14B83630
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B3EC3411B;
        Fri, 10 Jun 2022 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654876735;
        bh=rzSH/RSyuG4CWrd4Hatex8pHH2v31xWjR6/WgpyRVyo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mmYi3XaT24Whre/dR0dLpUupQD6pU/v/PsljYUiX3kxJm4RuLBVGO9425ULgs/lvi
         sF9xoVJgx0Du1f/KtQcmudgSvlKTSMIDe/WvTRSqd5dgbU/5OBaQBpiS3C73/OKmbJ
         FNMyVXsOf+8Ynfdp+hWvzIROrxLd1oMqdl3fU4yj1pcMouTpnvTJ7iXPfWd2xp7zF0
         x6fvi+aAXiq1HuNxQiq2BL3EDMGJKfB8iGEzfAGtVdoVARKLUah0VGqV67c1UIbMOT
         saKLuEor0td4Wm7g8xISabqCIZWWg8ojncPVsD1qO56eUaEZ0OiwglrCQk3k+ctM0D
         W2hYHVLN3NYZg==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220609111901.318047-1-srinivas.kandagatla@linaro.org>
References: <20220609111901.318047-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: codecs: qualcomm move gain to S8_TLV
Message-Id: <165487673382.1755957.2629868931367227265.b4-ty@kernel.org>
Date:   Fri, 10 Jun 2022 16:58:53 +0100
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

On Thu, 9 Jun 2022 12:18:59 +0100, Srinivas Kandagatla wrote:
> Move all the digital and IIR gains form using SX_TLV to S8_TLV,
> these gains are actually 8 bit gains with 7th signed bit and
> ranges from -84dB to +40dB
> 
> Tested on DB410c with Headset playback
> 
> Thanks,
> Srini
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: msm8916-wcd-digital: move gains from SX_TLV to S8_TLV
      commit: 5babb012c847beb6c8c7108fd78f650b7a2c6054
[2/2] ASoC: codecs: wcd9335: move gains from SX_TLV to S8_TLV
      commit: 2fbe0953732e06b471cdedbf6f615b84235580d8

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
