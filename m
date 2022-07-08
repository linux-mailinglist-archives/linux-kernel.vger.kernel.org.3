Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68656C3A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbiGHUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbiGHUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902709FE34
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3269628CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37162C341C6;
        Fri,  8 Jul 2022 20:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657313247;
        bh=Ki7BSssMR/sY2i/NbhPKrIyoLypU98vQTGisVtw13nM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qoxmw3qKHBYsBS8jIKSSUFDl+zyPigyqE4ONlm2s4KLL8TcAbH/LzEBD8/xjbDKzn
         FGMjqbDP8E23+4pRw6QdGV82s7MKWvkbRSaNbH0xuQUHgypaUWFFJjx98aoWSVWVXc
         5P2RL9Z4C16wS7wsmeRwSTPYoxiWoTXQvrIYb5u+/JenMx+7sa+HKOPA2+/IaM+Hsv
         3EqIrfZeiNWHiksqeDt/8cdBkLTqyoUAsi5xIGIBz08jjB1oVEG15z0NV7Q92Ah7U4
         u8reFV7vJtWvmkxr++cJujcNNfFZV1L81WOrpnXEW46WHppM9XgtORTq1xW5rU3bDs
         bGWuiPZI3dcsg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com
Cc:     zhuning@everest-semi.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com
In-Reply-To: <20220707132613.3150931-1-Vijendar.Mukunda@amd.com>
References: <20220707132613.3150931-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/3] ASoC: amd: remove unused header file inclusion
Message-Id: <165731324493.2467307.9897367470295247193.b4-ty@kernel.org>
Date:   Fri, 08 Jul 2022 21:47:24 +0100
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

On Thu, 7 Jul 2022 18:56:08 +0530, Vijendar Mukunda wrote:
> Removed unused header file inclusion from Jadeite platform machine
> driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: remove unused header file inclusion
      commit: d7e5d8d24c1179b36a3cb40b3f785e23a8992acd
[2/3] ASoC: amd: drop machine driver remove function
      commit: 8d9cd3ead42a6d3bac131c4331acfa5244674fbb
[3/3] ASoC: amd: fix for variable set but not used warning
      commit: 0de876c125188e502d2899de4bcba8d4a6b1f98c

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
