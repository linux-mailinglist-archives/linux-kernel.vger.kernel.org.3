Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42414D0888
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiCGUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245322AbiCGUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C387522E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF2861520
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015F6C36AEB;
        Mon,  7 Mar 2022 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685556;
        bh=0Cv5vxXicRFXtF41SUF86JorRsvlrBPG16Z1OipQCFY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GXICFvko+7lCN6j/JEWFGf/TCOSFpNoXmvZFEL4W8HNoeng2ozIrEjxEOzpgBKAmZ
         SYnEaNSHfOtfw8nitbgpigzL6rQWb/CMHG8RHxX2K6XLKNtCMNEmubD5by/K6RFlJQ
         lPKTDiXx0spXrhKYUvjP2UrOheNacI7Po4C9p9cxZGCB0HEFV1kRyj9xYpyFM+Zp1i
         63ySRHC3bMDqwSviMmNe85L5QdMkmJl9+2vakW1441KUh7q1IBHksx6ucgUnnQPBr3
         S0L2ii6LG83hQNlBUshk785Y7A6Lsam20y3Gv6DcuNZzDcS59VtzxRJzAP/HVAxgne
         fbDXz0mfflt5g==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220304144015.398656-1-rf@opensource.cirrus.com>
References: <20220304144015.398656-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Add warnings about DETECT_MODE and PLL_START
Message-Id: <164668555573.3137316.14425492431771518376.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:15 +0000
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

On Fri, 4 Mar 2022 14:40:15 +0000, Richard Fitzgerald wrote:
> DETECT_MODE and PLL_START must be zero while HP_PDN and ADC_PDN are
> both 1. If this condition is broken it can discharge FILT+ and it
> can then take up to 1 second for FILT+ to recharge.
> 
> There is no workaround required for this, simply avoiding settings
> and sequences that would break the requirement. The driver already
> meets the requirement.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Add warnings about DETECT_MODE and PLL_START
      commit: 71a6254c8b8aa3dcac3a5cb1d1cc2a2d3a840bfb

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
