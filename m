Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3539594E85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiHPCM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiHPCMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:12:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46542118C8D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E84BB811BF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1721FC433C1;
        Mon, 15 Aug 2022 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660601329;
        bh=DLDMIxJIJu0DBH9pCLM/6Am+PbmnnTYYn9x5d4S0a2E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RcabeOCb09dImPV6nUd8KymWvsNNtNdVrDZ3vUt163RG9C9Uw6L/l7vSOaR1rx2gr
         TLqdVI/fxiPVET9TTohx1dOFByRv0R6Bwn1nVmEOL8BNViJnbuG20Tl/miq+l4UkUO
         qI4GaxCgm7lCARysRZDV2mrw009iiDnUHbwsZq+VnuRh6qW9cunF1u5IL+Zs3+iFHM
         N4/tSQ+SlF3AqH/F4hAtIHEM1guC4ZNxjTzSqZhwbJsuAvxDdEK2amTy+teSzcklyN
         Q95ILn4U0LMTORF1P7lXwbBYO5uZjkcXefT65wN/kDPOjXVKLpeSEVUbMJyYZoeQ7x
         sggoJ0Z14oFIg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815113346.3805075-1-rf@opensource.cirrus.com>
References: <20220815113346.3805075-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-utils: Improve kerneldoc for snd_soc_tdm_params_to_bclk()
Message-Id: <166060132881.914979.11863568776659530881.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 23:08:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 12:33:46 +0100, Richard Fitzgerald wrote:
> The statement that snd_soc_tdm_params_to_bclk() is equivalent to
> snd_soc_params_to_bclk() if tdm_width==tdm_slots==0 is not accurate,
> it is only true is slot_multiple is also <2.
> 
> However, the description of special-case behaviour in terms of pairs of
> tdm_width and tdm_slot values is not particularly helpful so we might as
> well take the opportunity to rework the description to say the same thing
> in a simpler way. The behaviour of a pair of values is obvious from a
> description of each argument. At the same time make a few edits to clarify
> the rest of the description.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-utils: Improve kerneldoc for snd_soc_tdm_params_to_bclk()
      commit: efe30e2cb6ff87467389cece8ce604f6601059f9

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
