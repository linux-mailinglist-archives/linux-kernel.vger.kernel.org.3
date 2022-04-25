Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D777550E721
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243956AbiDYR2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244037AbiDYR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DF340E71;
        Mon, 25 Apr 2022 10:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C718B61585;
        Mon, 25 Apr 2022 17:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E29C385A9;
        Mon, 25 Apr 2022 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907482;
        bh=6gmtLm26FKCqWWG3JfvENu2V0fQ81REkQJwYzVoLt0w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Cf9bZmvm0JAXgYFKXN9AAJ0idCc220H9FGJhA5kZ5FjpVCzgXftyJSRhZY5TOFwW7
         KMaTgCQuAEF/5YDg2kGyC9C6nw/NRqcKk539HXDDgB9G1aPSFqFRuIMNU3CJ0jGJJ5
         A/ntB4WhpUAxI9Uk0xlem31LJ5CFi7YUqtJXLHc+OL5kSEdv9ZWLSyb4KNzSOaUdKv
         huLTybryQ8FPVKZh++L26rZSp3l9GePdJF4VOcPzqOihvmdBlc0qcbEH4yB1Zv+6y1
         s7TARXTzMNAUjR4wQhe41POLrP//S+mB7uR/E8tfkaYQbO+9DlENeXFqvh3gvjmY6Z
         OaGEU2t+fkjZQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, ldewangan@nvidia.com
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn,
        zealci@zte.com.cn
In-Reply-To: <20220418110141.2559019-1-chi.minghao@zte.com.cn>
References: <20220418110141.2559019-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-tegra20-slink: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090748053.584172.14297698011907857671.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:40 +0100
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

On Mon, 18 Apr 2022 11:01:41 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-tegra20-slink: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 1e6f8bd15cf8447a42375b005476e02fc13deb2a

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
