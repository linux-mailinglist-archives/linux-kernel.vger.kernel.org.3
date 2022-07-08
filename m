Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5451B56C42A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiGHUri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbiGHUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:47:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B39FE3C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6176FB8297B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B444BC341C7;
        Fri,  8 Jul 2022 20:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657313252;
        bh=Bamh/X/oCw/wmbXnI+hOkWH86iXLJYCl0JfXsxQ4oP0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ogPyOete0HFn+dWK7TL5r7rIstCyDkz/6TMaJattCB7aLb8f/pw11h23O3QclGuaQ
         apMnYdDyx4OiPu71kS9Z6Ym/4eLhi4FqLvGUCWlPO9WUQsU/aVKakJW1xLI80E12pp
         r0k8vcD6VKWreZYZ2oJvqfZicuCN+2gspSCMcjr3JRAi5TjJDtjcTWsTm615HFfuiC
         JBGLyrDlSMEzRBa8ci1mDasoDSB+yPwc4MkBF46ylyOKl4NEDll4VpPcKATECfD/JL
         VYY/mfttpypCFb4gJKnWOiKPZ+DoWJzUYSN+h7+TcrjZS82E6vw7MbS1PyUP7AZjJu
         5V1eVzDk5H8aQ==
From:   Mark Brown <broonie@kernel.org>
To:     yang.lee@linux.alibaba.com, tiwai@suse.com
Cc:     perex@perex.cz, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220707232540.22589-1-yang.lee@linux.alibaba.com>
References: <20220707232540.22589-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: amd: Remove duplicated include in acp-es8336.c
Message-Id: <165731325045.2467307.11786300034305445651.b4-ty@kernel.org>
Date:   Fri, 08 Jul 2022 21:47:30 +0100
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

On Fri, 8 Jul 2022 07:25:40 +0800, Yang Li wrote:
> Fix following includecheck warning:
> ./sound/soc/amd/acp-es8336.c: linux/module.h is included more than once.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Remove duplicated include in acp-es8336.c
      commit: 657efd9c985255960cdd90bafc382a39dc303277

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
