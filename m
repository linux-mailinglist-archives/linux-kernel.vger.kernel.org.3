Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107F5676DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiGESwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGESwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CED18370
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E72D61A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 18:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F09C341CB;
        Tue,  5 Jul 2022 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657047138;
        bh=EWfRq+tWKV+8Qks2XSArxpnIXRNsB+UBf4g4MzjPFHI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JF9LQ2HrBz6obOxva65E3jEGayO18adkIej71mpp+DqqY3953oXUlnj1tUJF7xM2T
         OXFbbVcLYnbt6CbG+b2cBQdzDhZ/gB7/XXuZkBx/pzsorYEs5LrCy8/jNcMfODVTO5
         EmHokIpljGhzPbjG17hel3BXndN5eUncXPSRNykes5sFixf6skQ9CZZqvC6/tzjvHT
         +JBPzYhGhwEJ/G8/n0CSiWgGo5ZZ/7/tR8bHwqfYQioFWw5CvZgc+sSkQc7ZPqPIK+
         vSEYHG1H8zvAtQJ704WIjyGdskePtrVvh4FOZ9dsSuf3TL9djymbBnLY8wi95Z7UaS
         qEK6wlimJVmiQ==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        cuigaosheng1@huawei.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220705005315.663920-1-cuigaosheng1@huawei.com>
References: <20220705005315.663920-1-cuigaosheng1@huawei.com>
Subject: Re: [PATCH] ASoC: codecs: wsa883x: fix warning using-module-alias-sdw.cocci
Message-Id: <165704713682.1050281.11385702156184888420.b4-ty@kernel.org>
Date:   Tue, 05 Jul 2022 19:52:16 +0100
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

On Tue, 5 Jul 2022 08:53:15 +0800, Gaosheng Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: fix warning using-module-alias-sdw.cocci
      commit: eec8a5f44e4f68c64ce21d90e438e31e85b92178

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
