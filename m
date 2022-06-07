Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8453FBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiFGKrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbiFGKqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAABED8C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8156B81F02
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3142C341C0;
        Tue,  7 Jun 2022 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598768;
        bh=AXXJpNaKkdG+7UQKkjCCo3D49fnR3t/hk4qP9P50y44=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mL7XmWnZ4DH2YT5pHV0wtRdY1iYtU2Sg45NZFMb7kc5J77S4okvTh/kr3wDZDc2T/
         U84TfYl/fQNgPV02O7hzN5U6M3mjRSpryr7aVrC7XEIqtUoVFBGy1JX5M9GGyiE+JT
         6MMcGfiN5TaDNaRm9Pozr3IdI8XOeX64LVQ+mTcyJWYYNxt+sH/NnSIQ2sT9V0gP6z
         mhqbT35K9xd6+7Eq6W4OC7g2IYILBn6FrALqyOBH4guQ9n0v4+KvXhJ18Sqmoy8VqJ
         8/rWZ0ouCSX62snUe6dCLZ60jF0pMYVOJ1tc/j3ocN7LoE1RaI5kbxjLZ4B1qfiu4B
         tUP0UMXh0nCcw==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, lgirdwood@gmail.com
Cc:     chi.minghao@zte.com.cn, zealci@zte.com.cn,
        linux-mediatek@lists.infradead.org, perex@perex.cz,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220602071809.278134-1-chi.minghao@zte.com.cn>
References: <20220602071809.278134-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: mediatek: remove unnecessary check of clk_disable_unprepare
Message-Id: <165459876658.301808.3499982605939074236.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:06 +0100
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

On Thu, 2 Jun 2022 07:18:09 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Because clk_disable_unprepare already checked NULL clock
> parameter, so the additional checks are unnecessary, just remove them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: remove unnecessary check of clk_disable_unprepare
      commit: 12ba5ceb4a08d5ea776d3eaf83c0cee63fafe952

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
