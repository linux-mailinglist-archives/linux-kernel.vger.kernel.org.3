Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB26509238
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382604AbiDTVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382599AbiDTVnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA1742EE4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FED661856
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77EEC385A0;
        Wed, 20 Apr 2022 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650490864;
        bh=F8AeT1gPh9EBU1TCJSOcCs0CcyJJkegE+/aoO8QW668=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X7pEUC2WxvodOpeK94bF0YdDjxehU8afHnEejPFz2CKDsmdIPM4c/cLT+Ot4czbQE
         B+iO17j3/0Mz5KxTeonal+AzYI3xwI5DOJYb3qdJTQBjHEykYeHLVp/1IeBp3FDSuG
         tEMgOoXsydeBS/spPk8xFLXZnMHDL/FMQ6Oe9oqTNZMq0vL6WZBzNoTEqJPa3AKJXw
         D8l1VSUEwMQkLenMSVl9ALZtKhgrA8noBy0qgSKDVYfFc0Tw5GKrzFmvX7S7qPSBLg
         QMRMYSOYTsFrcDC1+reR5M3mtcOW5B/HUnxA7J8/KM2BabcmLdzRV92Sar+QdYrW6F
         xJJfkRnFqHgjA==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com, cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, ranjani.sridharan@linux.intel.com,
        chi.minghao@zte.com.cn, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
References: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: SOF: using pm_runtime_resume_and_get to simplify the code
Message-Id: <165049086153.138067.9717341459328892843.b4-ty@kernel.org>
Date:   Wed, 20 Apr 2022 22:41:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 03:03:15 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: using pm_runtime_resume_and_get to simplify the code
      commit: b3598fe6d009b2f2144115dfc381615c8b534aec

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
