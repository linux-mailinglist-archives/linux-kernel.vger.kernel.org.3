Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D150E710
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiDYR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbiDYR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5941308
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47BFFB81929
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3953C385A9;
        Mon, 25 Apr 2022 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907455;
        bh=UYeLk4eFqLkaYMknBOIlAl5C6wWequqNThJQkWUVbRs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K3/sW0BYOT+EPsoPyW71Vl4OtX8MamBhCgTSRWFIpE9TC2uYVxWjeWDWlfZ6P2n3v
         oNBmoNIZVmX+Lnl3diZcYpwuftv5a4au4uhUcd1cfayoJswzvyuS+n9drdgyOB0rEp
         8CZU/HV5H/8Q+I2hjFEClSCpVKTpLzdqbdlgdoQdBOJ7mIdj6Gl6Pbty88pPuDNOSq
         i5fLHAoJcIaRGQRDzAHVYnCOvLCDJEscnjP3PyZ/3AJc1usBYFmVRMMUcC/ElUvnqQ
         pOpaDssmAZBcUxYm9IQooCBnRiUTfhw7SF2BHdVcFqpqiGFOjHsN0G8MBeX/Nz/QPy
         2UosfSoz7no5w==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, lgirdwood@gmail.com, Xiubo.Lee@gmail.com,
        alsa-devel@alsa-project.org, nicoleotsuka@gmail.com,
        zealci@zte.com.cn, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, festevam@gmail.com
In-Reply-To: <20220420030402.2575755-1-chi.minghao@zte.com.cn>
References: <20220420030402.2575755-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: fsl_asrc: using pm_runtime_resume_and_get to simplify the code
Message-Id: <165090745244.583823.17649634383855678993.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:12 +0100
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

On Wed, 20 Apr 2022 03:04:02 +0000, cgel.zte@gmail.com wrote:
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

[1/1] ASoC: fsl_asrc: using pm_runtime_resume_and_get to simplify the code
      commit: d05040741afef6eb5d4366de7d5b62f700958787

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
