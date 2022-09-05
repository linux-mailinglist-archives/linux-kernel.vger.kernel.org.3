Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D145AD6BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiIEPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbiIEPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D542AEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBBF2B811DD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B75CC433D6;
        Mon,  5 Sep 2022 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662392333;
        bh=DI/JWN7filrxVXubuYQqOnCDfFoWn6A2a5o7fhUfYQ0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XALF/Egd82gPWi2ctRMtz61hOe5ALsWkA6wBZY08oSeTMr6nCXZlkO9bp0dr4vfco
         ztl1TxywHT5fWeqRZ475PjKW2HZl1zOQ9CmweAYV+oYBOMP2CA3j/kQkqD9R6nTWn9
         LFVxcYFWgsr79pjR3y9lO8efllXD3VM7q3O0IbPeZ2XlLZPv4rMFPCmw5b/Ih+KYhr
         6MBP/qLZthv+1+yV4lC2bPOtMl/lCERpO837OwkanAI42WZt7aKiZ0n+3Qs130EPVk
         pN/p30Gi5JYEGf9LLMRwhe9+n6kGXR3KWHnqnweX31oVqU3gAKJ5ULlDsj4uE/tXm8
         9supsjF/nNXKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <Vlad.Karpovich@cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
In-Reply-To: <20220825220530.1205141-1-cristian.ciocaltea@collabora.com>
References: <20220825220530.1205141-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Handle optional legacy support
Message-Id: <166239233135.736206.3778059125368264923.b4-ty@kernel.org>
Date:   Mon, 05 Sep 2022 16:38:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 01:05:30 +0300, Cristian Ciocaltea wrote:
> The tracing capabilities for the speaker protection fw enabled via
> commit c55b3e46cb99 ("ASoC: wm_adsp: Add trace caps to speaker
> protection FW") are not be available on all platforms, such as the
> Valve's Steam Deck which is based on the Halo Core DSP.
> 
> As a consequence, whenever the firmware is loaded, a rather misleading
> 'Failed to parse legacy: -19' error message is written to the kernel
> ring buffer:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Handle optional legacy support
      commit: 35c8ae25c4fdeabf490e005692795a3be17ca5f6

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
