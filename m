Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16048570488
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiGKNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiGKNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:42:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574634D811
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B29CB80F1A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1876C3411C;
        Mon, 11 Jul 2022 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657546938;
        bh=KqT9jXk7gPcHs0OREpA0JbWzkxkbkXw/FOHUWxufhRo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Yh4+12vnfz/2k7t73GAfVvazukytAqGwPao+x+u63zCaZL4Ed1Et6Pd6qTMkTuVhH
         G62ZGbXc5ca1lpNJmS4AHKmiSO1cGZFv7A5Ez/skc2P/E4ib4x6Nm8F1GGYFGmlKUe
         jdqg9f8RZ0m5m1jQQn4TwF4Dy/68gsc4RcbQg4J4Ic+yxz5Hx5J14pZeGgSnGZjxwe
         YWwtmifKVmuztiw6SJzq4vmtONW1aXJE1mA2qZqstUuVhFqdX//Wv9UNXgKpHB0iNT
         Q4se9Xx61BaiigNoUqPFsE09l9Lsp1fQQg3kM5pkv2xy829N7Qnf7uHPzWwq5j0K5t
         wDC8Sbj6efthQ==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@nxp.com, perex@perex.cz, festevam@gmail.com,
        lgirdwood@gmail.com, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1657507190-14546-1-git-send-email-shengjiu.wang@nxp.com>
References: <1657507190-14546-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_utils: Drop usage of __clk_get_name()
Message-Id: <165754693638.334539.15476852072708408930.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 14:42:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 10:39:50 +0800, Shengjiu Wang wrote:
> Avoid build errors when CONFIG_COMMON_CLK is not set/enabled.
> 
> ERROR: modpost: "__clk_get_name" [sound/soc/fsl/snd-soc-fsl-utils.ko] undefined!
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_utils: Drop usage of __clk_get_name()
      commit: eaa27e7fe43f16fe587c3e93fd5c25ce86be3c43

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
