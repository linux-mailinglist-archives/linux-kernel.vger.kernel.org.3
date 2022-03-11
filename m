Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236D64D6964
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbiCKUYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351206AbiCKUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:23:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008409D07F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:22:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE65B82CEC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 20:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1537C340E9;
        Fri, 11 Mar 2022 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647030166;
        bh=xJwfXtrmDnk/l4WW8UCx8MYFFktOlAtYVoFB/u0RMZs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ANMxTiBF3g3kWtnXUdy08hvSgxuan/qpXmTxAxQYj+/ejXnZo8O38QbMHgXEc5kic
         Ipvks6kpv8hpvySjey0x8yDNlUxFPi2WE7DQmBjJ89kaeXeTez/uOPgcEE/+NQ6UeB
         YGQ3pKwmDW8JaOT8BpsJiyaLXZrF4u06fc29BPkwIc1eu9mUwed8zyC1hj7Ru1nfZ/
         Yo1tDBU4aLW8iQKa9eMH2h9k9Sb4+MNynefc67hEIlhgLiUaCNsnvbJS+IlFvYcXJQ
         ZrlP8uFIjkFrPQqRYdLDV+lCfa4b04xmdDrRszLcFmfp1TCcqaMM+kHt3S9K3Pnf/U
         DO7MFSkICYKBg==
From:   Mark Brown <broonie@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220307084523.28687-1-linmq006@gmail.com>
References: <20220307084523.28687-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Fix missing clk_disable_unprepare() in msm8916_wcd_digital_probe
Message-Id: <164703016458.264137.8737239067223778566.b4-ty@kernel.org>
Date:   Fri, 11 Mar 2022 20:22:44 +0000
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

On Mon, 7 Mar 2022 08:45:22 +0000, Miaoqian Lin wrote:
> Fix the missing clk_disable_unprepare() before return
> from msm8916_wcd_digital_probe in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: msm8916-wcd-digital: Fix missing clk_disable_unprepare() in msm8916_wcd_digital_probe
      commit: 375a347da4889f64d86e1ab7f4e6702b6e9bf299

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
