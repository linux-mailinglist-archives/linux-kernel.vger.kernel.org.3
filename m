Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF400565A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiGDP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiGDP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:57:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4BBC97
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E645BB810E7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 15:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCA1C3411E;
        Mon,  4 Jul 2022 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656950258;
        bh=BpTmJubMs2qUx6naTQaapSEcEv4ZyxAHDy8bQevFv3U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ORTk4Kp3CH9Tjltwn0WeW+St5tAC10Eay5u0OHmU4rAGGQgO6Cd/9CwUcdMzyEbla
         FiRpAC8izJ4RcQb8DPGKn05abiCPZ6zwWPyLMex/1vIJQ9DUcT/IHYMks733p5vM1G
         XDZOiTM8k4KZwg/iOfZz4R/tpXPvZmQMWYHFJMjR4Aa2vslwJ024/hJ1xqNarNaGj9
         gKFTXGhV76remIq7v/N7KpN4cPWkTWXm+PnYoLD7pFBqlz/KoNNmPtW6m6LSB7muEt
         t4ZjqxjcDurlFdJzVqbvxJTgpCNyi5pveRQmkiOJ6vu3fEQTS9tfx0pPsJhRmV9RKV
         +K3bwrA+J1z/g==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, jiapeng.chong@linux.alibaba.com
Cc:     tiwai@suse.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org
In-Reply-To: <20220701073039.64556-1-jiapeng.chong@linux.alibaba.com>
References: <20220701073039.64556-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: codecs: max98088: Clean up some inconsistent indenting
Message-Id: <165695025694.481068.15705857947367046275.b4-ty@kernel.org>
Date:   Mon, 04 Jul 2022 16:57:36 +0100
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

On Fri, 1 Jul 2022 15:30:39 +0800, Jiapeng Chong wrote:
> This was found by coccicheck:
> 
> sound/soc/codecs/max98088.c:1761 max98088_i2c_probe() warn: inconsistent indenting.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: max98088: Clean up some inconsistent indenting
      commit: 1d5c7a91dfc2b7a5672a2706553e5782482d6e6f

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
