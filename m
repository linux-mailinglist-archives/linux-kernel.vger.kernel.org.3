Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE82752A780
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350735AbiEQP7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350731AbiEQP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:59:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A164CD57
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28BF4B81AB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CB5C34116;
        Tue, 17 May 2022 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803175;
        bh=b+oHipmTddyUCEfLTe547iUSxup2tDJx6tkGs3EkcXY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Kb6FevduQQnc1BDygTI2jCYW67vnYL3xn6yXj2HsklomkzAxOo3vLaCowVAMKt/wG
         coVoWx/1r5nCedFjxgHUgmQ+w27+RQx8ed4EOPQZaxUedoEe9kYDBqBpmP/PnYz2SP
         6vH+vb/hzz3Rd/i23twIenU/wFnKwrXnn7tC+jQo2YswCSZ35mlf5WWsg98k40yGiE
         RHjrbg1PZ25E6GxWOnFT+G5r4nIdBalCCQ51E/GO7CA6ZTe6TuZmRb/EPrgGKIYwTt
         GsyS0shiFBoU4BR2XZKokD2gNfIK+9qc07I7osDz5XnEa3IY1auUCWFj8e/4XNqV3Y
         xR9v48lqFyRyw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Vijendar.Mukunda@amd.com, lgirdwood@gmail.com,
        perex@perex.cz, yuehaibing@huawei.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220514023806.34768-1-yuehaibing@huawei.com>
References: <20220514023806.34768-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: amd: vangogh: Remove duplicate include files
Message-Id: <165280317326.1635268.6024055141505339683.b4-ty@kernel.org>
Date:   Tue, 17 May 2022 16:59:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 10:38:06 +0800, YueHaibing wrote:
> Remove duplicated includes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: vangogh: Remove duplicate include files
      commit: d91835655cc9047f8b5c40530791bd3bc020f1bd

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
