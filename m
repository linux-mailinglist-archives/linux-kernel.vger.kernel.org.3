Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6E52EA9B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348456AbiETLSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348443AbiETLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC1153536
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12DB961DB3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99908C385A9;
        Fri, 20 May 2022 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653045525;
        bh=QI/Wp5OFrg8DZFaDAnxSX717/fIkU2TW5bPmuaN/enI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jYol+oKj0wYTzAeeKSLIkHdNvkNLvTGs/dmcsrT3DNkBcuFpI1S6i28rjXPkhn+nn
         WFsUZRTU/lFzOZIHV7Pbc/Ik2cRvauW0ihACXOX56JR7DlV6VMYHX9fiYDpAuxun3q
         Zv1onFxKi83gn+NdTP/+Djltn3O78M6jh/27rSB8vYrCT+sezTh7HPb6ciamW09rTW
         /IAPUdNgGObNbI1aY//Cr758RF5GpDDONKYAWzWONM80ngpydHk5KvsNJQ4iW6Nur0
         d8M0RFzDX+Sh86lF0RpSeqyaLRXHwEIfBP3JEMGiKRweoV34z302Z021poDR8pa4Ny
         kIV3EXrKpnkbg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com
In-Reply-To: <20220514091053.686416-1-yangyingliang@huawei.com>
References: <20220514091053.686416-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: wm2000: fix missing clk_disable_unprepare() on error in wm2000_anc_transition()
Message-Id: <165304552434.45439.17487958177424111002.b4-ty@kernel.org>
Date:   Fri, 20 May 2022 12:18:44 +0100
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

On Sat, 14 May 2022 17:10:53 +0800, Yang Yingliang wrote:
> Fix the missing clk_disable_unprepare() before return
> from wm2000_anc_transition() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm2000: fix missing clk_disable_unprepare() on error in wm2000_anc_transition()
      commit: be2af740e2a9c7134f2d8ab4f104006e110b13de

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
