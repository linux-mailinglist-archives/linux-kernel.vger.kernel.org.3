Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D64C4C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiBYRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbiBYRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E641CDDCF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12FF861DC7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C96FC340E7;
        Fri, 25 Feb 2022 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810545;
        bh=yVQLKQLnoKnhVc4ezrGEfHpRFSFDPimf5rhD3F4nZw8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iA1a7oFHNe1g/rggWA/IKrr/hJBYi+it46e25chVfX6ikO1VSGULZcBHUU1HI2TPO
         4Dup8FiEO6u/SX9Yy+U1ptGyX8l4QangLxDU41IIv1g8xvdOqcW0Sff8nG+1LZ+qTD
         7wjA5sG9Ytfj/2mqZSUkTRuRfosLou6sG0vYrdLK0TQMNT5NUgduUiB2ZOUMg90FnA
         DYkdI+VmkVqDUEugCttyglZM9/VnODVkxMed3wHJURXZgamIQfLaePAzSslwvFN2ft
         OjIh5EGqMeJMntsFFfuQxKFLP+Gke9u9dKpXVvd7VnktWo6K6IdXJMvnoIuHqVf6Cf
         ECJbvABM8RV9A==
From:   Mark Brown <broonie@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220225112358.19403-1-tangmeng@uniontech.com>
References: <20220225112358.19403-1-tangmeng@uniontech.com>
Subject: Re: [PATCH] sound/soc/amd: Use platform_get_irq_byname() to get the interrupt
Message-Id: <164581054397.2548431.5315227430767175484.b4-ty@kernel.org>
Date:   Fri, 25 Feb 2022 17:35:43 +0000
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

On Fri, 25 Feb 2022 19:23:58 +0800, Meng Tang wrote:
> platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_byname().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound/soc/amd: Use platform_get_irq_byname() to get the interrupt
      commit: 3304a242f45a501a5de69492e421a45c468c89ea

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
