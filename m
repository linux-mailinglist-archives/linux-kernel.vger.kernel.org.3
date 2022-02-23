Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424ED4C0AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiBWEIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiBWEIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:08:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7666AF9;
        Tue, 22 Feb 2022 20:08:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE12D609E9;
        Wed, 23 Feb 2022 04:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91180C340E7;
        Wed, 23 Feb 2022 04:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645589302;
        bh=6pShpH0O4xL8+uHkUI6RgxdAEV33MdsmM+hYAqFM09A=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=in7Uvzv4Z7qAJaFWfU6KIldrrXBelBJYiXC2EEny3+s+aoJksA6Mzhzae/DceCwHY
         pDMjAuOQ0Mp2fOoa138yUKGEmMq5djuidLZf72hv1FE/BJfGuX60ayyHJAsrf9syIL
         0ynwfs4TgfDUvnsU4KoqfLwzC749oArrPTtWbVQPHsSOlWIaZOMGAL7bkOz80hu8N9
         onhZfnzxxvtLnyBz+SBAtmuaPCwZBfXbfe88QOUPput/pHu6WtusQqKc09ESExIvJh
         9R2nM80b4cqzs9zhzNaWpaonME1U4AjpRJIPGxXrc3CbgpXRbwuAovhxkVpDHw8fkQ
         wgCroWW8ZSEtQ==
From:   Mark Brown <broonie@kernel.org>
To:     Qing Wang <wangqing@vivo.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1644890407-65167-1-git-send-email-wangqing@vivo.com>
References: <1644890407-65167-1-git-send-email-wangqing@vivo.com>
Subject: Re: [PATCH] spi: add missing pci_dev_put() before return
Message-Id: <164558930131.1665159.11296485721987449047.b4-ty@kernel.org>
Date:   Wed, 23 Feb 2022 04:08:21 +0000
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

On Mon, 14 Feb 2022 18:00:07 -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> pci_get_slot() increases its reference count, the caller must
> decrement the reference count by calling pci_dev_put()
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: add missing pci_dev_put() before return
      commit: 4d986ffa036a773456476f70bd0fde2fb1330b7d

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
