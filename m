Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C984FE9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiDLVGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiDLVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 17:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6260C1546B2;
        Tue, 12 Apr 2022 13:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0488561C52;
        Tue, 12 Apr 2022 20:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6889C385A5;
        Tue, 12 Apr 2022 20:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649796216;
        bh=Cmw8wmLgMEm8YJZuVKcAlwoKMyj8hH9LZ8YJbZn6dfM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GvOYUPMSkR39kxQKaw0TQCI0PjxuXpOpFHVMIfeP7m5k5YZQLJIC1sGObDUBJ97JH
         8zp8urhr371YvawcSwzW2E7uspGz0uK2sVE2Of7JnSRoEY6KECPedYOQKxuXp6myS9
         Vu6tBniFKYdwZ1xywAB+GG9/DrBVXhMo9yo9BMQzLmMMzHY+yVH0fw9gJiPMpa1pMw
         MPc0y+sd8iIMQGXuGqpDRjZlX96bsHFa+6P3Lkvk2JjB5v5cB15n3OGbSKo85mR7kx
         /QDEgymq7Z3pqqPGyoFI/9fgb2TDpQRmNSG9LBpcRgSGK+yhm4isRim8Y6/6U+C4eE
         /JYwt6ZpNTJ8A==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, zealci@zte.com.cn,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220412070906.2532091-1-chi.minghao@zte.com.cn>
References: <20220412070906.2532091-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-stm32-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <164979621440.474093.2676903357878820514.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 21:43:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 07:09:06 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-stm32-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: c6cf1fafb65dda10f3babcec76991cbc304d02b9

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
