Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8555DE21
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbiF1Kbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiF1Kb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:31:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3B2F644
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26E86B81DCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689D8C3411D;
        Tue, 28 Jun 2022 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412282;
        bh=r76Re/xOvLzrRf/PxMnn/Z5S0c5ucm9VBXxqbgjKa18=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=B9eJcXaj/ZLWGZzuPRwnpDAMZDbCDBYL0iL0qxO6gUiDKzHslZesvupktrwqxMXTb
         JPgW8KYbOxZb+8Y6Mzsm1sgpB/uLJdChhZgUhyOQe5oOesUgrdePSMmaZAYyPLCaHC
         65GXd27NDWIzc29nmaR7QKdRr4juX/ESmKMwBupsKxzCmoEKKdcCFix3HfkiTI326P
         4shdcFP1jjdZwf7BHJXtCNAq8a0xb/GPJb0w3dD76tWO8ObZFTGSbJTtatOkCLfDN2
         obTDbPW/57RFnLo3IPTpEzvXOgPUXYZmpdg94/y+knRcSdEIae3c4uJ5wbNi3/C3s8
         TXtTyBkQJ4ilA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, krzysztof.kozlowski@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, s.nawrocki@samsung.com,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
References: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: samsung: s3c-i2s-v2: Allow build for unsupported hardware
Message-Id: <165641228114.254424.9239114588786840760.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 11:31:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 16:34:10 +0200, Krzysztof Kozlowski wrote:
> There is no particular need to restrict building of S3C I2S driver to
> supported platforms within the C unit, because Kconfig does it.
> Removing such restricting #ifdef from s3c-i2s-v2 allows compile testing
> it on other platforms.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: samsung: s3c-i2s-v2: Allow build for unsupported hardware
      commit: 17a1ffc7bc4d5b4657d0f3fe5c01778d8fcab9a3
[2/3] ASoC: samsung: s3c24xx-i2s: Drop unneeded gpio.h include
      commit: 3e4bac7cf06e46225322f264e7387efe6ddd457e
[3/3] ASoC: samsung: Enable compile test
      commit: f43ff8038e8289ca811b5b89e8cc15083dafe5c4

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
