Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68674D1EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349150AbiCHRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbiCHRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058554692
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9596D61117
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1471FC340EF;
        Tue,  8 Mar 2022 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760050;
        bh=OTBvjPDi+isTMADoBJKHUAl7J8WbruRWlXA5d3Qair0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=h+9lSc42lHWYcPr8dH9nm8eA1GZza7+G7Amy5YzWHbBP5WFKhjLghncJ+7zerIBSa
         CeFMl2t0J3fmb982ZU1FSL0knrWyJB1GKmgs0zd6x/+pkqDI9kicM9Adtzd0GJ/8KC
         GdE5NeOr/Nr/APVNkh5RUFSUTcFWIjLkuCRoDyii5cM7C7hicAlT812Q6aVlCour+j
         V1mfVnnXjpGBLujey+3UDyvbe9AEd9/ADUG4p076i/rfkFNZ6d9CSfPfpKZiAtIJ3Z
         Td+60L2vllqUOqMBYTYv/Hp//xHUMbAvQvC6LVOvxoVYm79T7sV0fTdMujx87FlQ+0
         Y7BTMEY7+RBxw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jianqun <jay.xu@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220307083553.26009-1-linmq006@gmail.com>
References: <20220307083553.26009-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix missing clk_disable_unprepare() in rockchip_i2s_probe
Message-Id: <164676004779.54315.18423520292577645597.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:20:47 +0000
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

On Mon, 7 Mar 2022 08:35:52 +0000, Miaoqian Lin wrote:
> Fix the missing clk_disable_unprepare() before return
> from rockchip_i2s_probe() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: Fix missing clk_disable_unprepare() in rockchip_i2s_probe
      commit: f725d20579807a68afbe5dba69e78b8fa05f5ef0

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
