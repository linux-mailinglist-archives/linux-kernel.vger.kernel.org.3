Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450DA565A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiGDP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiGDP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F77E0C2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9BBCB81160
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 15:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CDFC3411E;
        Mon,  4 Jul 2022 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656950270;
        bh=sJPtODs8e7CE/TqDOZ/dlaycf1N0uI8bA5H6NOBLPgI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H6wQDXAmT/dhA4lSI0BSUuKRFfhRch+HRrK/Dx1890QxbpNkEUHnsy9KBRDoqzuFW
         6yhk5QYcDcvx7f3I+2o66CFZmwLUROy6+X3t/Go6lEOt6uXortfNjm/mphQiFLI2M6
         sFlM7osS2yPqynx8lyvdcyXkwHxaGvgihcAZC1HAapUjEPvl3MBRQYEjomHI0eMQu0
         UhmpQvQN2El2iu451knYLxICLUHWApF9NixKEdchj/RDfDa6leDl0Kv4o53jsUs30R
         BgpVHgMyUqSEIv7smYO5hr0IUkxwLp7c5vHmds/CvXg4Phm8Vhbm1b4CgdlAMGlA+y
         HwBDJCIDAZYmA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com
In-Reply-To: <20220704075134.26230-1-yangyingliang@huawei.com>
References: <20220704075134.26230-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: fsl: pcm030-audio-fabric: use platform_device_unregsiter()
Message-Id: <165695026945.481068.10391765558423256612.b4-ty@kernel.org>
Date:   Mon, 04 Jul 2022 16:57:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 15:51:34 +0800, Yang Yingliang wrote:
> Replace platform_device_del/put() with platform_device_unregsiter()
> to simplify code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: pcm030-audio-fabric: use platform_device_unregsiter()
      commit: 679139ea62e3e78542cd409c2437ac1da9f31026

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
