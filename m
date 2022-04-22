Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6693D50B7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiDVM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiDVM4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:56:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9CD527F5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C001E61FE5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C01C385A4;
        Fri, 22 Apr 2022 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650632003;
        bh=jMqFxIuoT1cqZV1l+rV7YI1X5VmlIyBbAJyV8buDTA0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mR1i20toR3c2UQojmDZbvNBd1EwwCYW7BwW9VImL8FL7TPfZBy7BHbwbdsX1WT6Nc
         ZfQYSljjNaQx6vuHBFmA+m+/LZAPY8LnJ6S8WZ+gfGLfVd1+gkLx7ZQ+K0GJkvr5FY
         PoKpqLmD1MNRomsnXKff+3pBlIX08WsfW0YNjjvZYGar+Zf34iwUswOOk24v6NmQ+s
         MqTUhFnYW0jxT7ZPZJ9uJUjdqBQJievC2qpRdsEaqgoFI/7iGP1pq3nUVCaKT+AX6+
         M/923tscIaMDTp+U2RttxeWGyAT44PQDANDJSuoLGb6/GKBdpdLvXCtGX3S3v3HgXU
         yW044RGV9LcsA==
From:   Mark Brown <broonie@kernel.org>
To:     u0084500@gmail.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        lgirdwood@gmail.com, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org
In-Reply-To: <1650608810-3829-1-git-send-email-u0084500@gmail.com>
References: <1650608810-3829-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH] ASoC: rt9120: Correct the reg 0x09 size to one byte
Message-Id: <165063200120.312964.8713966369243201308.b4-ty@kernel.org>
Date:   Fri, 22 Apr 2022 13:53:21 +0100
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

On Fri, 22 Apr 2022 14:26:50 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Correct the reg 0x09 size to one byte.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt9120: Correct the reg 0x09 size to one byte
      commit: 87c18514bb8477563a61f50b4285da156296edc4

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
