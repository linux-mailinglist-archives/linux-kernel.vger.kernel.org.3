Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B414D1EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbiCHRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349458AbiCHRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641753B4F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DC761117
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDF9C36AE2;
        Tue,  8 Mar 2022 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760071;
        bh=KcfkXy/XtgCaDpCkwBnAMw9fV0DSG7bx2EbbSAQULKA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=pumk/87BQOBLkI5whDHBsNTP1uK8sEhC0NK+Q4uQuDGs3XYMnKgg8YpdXfsDUFWcu
         3H2U7jZWnMCL4NlCTPIYCFrnHYtjkVe+xtpaXEEmk3wv3EqXH6Ku9aFOsf1Vbg6Tlh
         sxEI2E4R7QhhnfWZNI72H7DweXBHhRjsC7TcAvz+LYu/2TIdVg5aH/sRdTDWhf2k7N
         Sc2BjqZst42r1Wkk++YNjLMSDU6QqMxd8sokYJ2N4POiNXmadsJshOURCPkG/6Kcnw
         +K69ATs7r94a4NC0rMUIUHv7iA2D7SJfVbMSzGlEyZMd0mhgYQ0U8mCk5knz2fnrnC
         xIW1IOqXxmZNg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        alsa-devel@alsa-project.org, Miaoqian Lin <linmq006@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Colin Ian King <colin.king@intel.com>
In-Reply-To: <20220307090146.4104-1-linmq006@gmail.com>
References: <20220307090146.4104-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: rk817: Fix missing clk_disable_unprepare() in rk817_platform_probe
Message-Id: <164676006795.54315.3795247515426909342.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:07 +0000
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

On Mon, 7 Mar 2022 09:01:30 +0000, Miaoqian Lin wrote:
> Fix the missing clk_disable_unprepare() before return
> from rk817_platform_probe() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk817: Fix missing clk_disable_unprepare() in rk817_platform_probe
      commit: a6b44a2518a08348bd0f0401e4d2b99233bbabc2

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
