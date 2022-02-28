Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0F4C788D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiB1TQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiB1TQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:16:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA7EE44A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:15:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A44616153C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6FAC340F1;
        Mon, 28 Feb 2022 19:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646075746;
        bh=/qQOB++KvvZ7sRy/B6gKIR06AjcperUnwullcN+5JlA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hUK/V96q2sCL7N238gDDmPKfGcA9oUaxW37RccU/y8c69v2P5Cal68n2DWTu18X69
         +SCh+y54u/f6lnN04cVFim7bItVQnVQGyW3t75zVw5v7HNaY6prgn/5K0X/z/CGjXM
         V5PuBWCpq26n4lPG9pCKP0tCq5vLyT6P3EYmdxzORmrPgtNscxUqJQP9tvLYEldfez
         gbnjdoia9Z4c4HAT3IdCRgQsMC4O5qO6KSIpe9wfPxcw2m24cvUy74pxYFpjWZC/1U
         VgyeK+poVSr3+TCAbnWULb9lI1PfgSM1/ED6cwEVKbbpuQFaoVVeMN8DJc1Vlv5OvL
         0mTYFl3Aqkkew==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, peter.ujfalusi@gmail.com,
        lgirdwood@gmail.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220228031540.3571959-1-jiasheng@iscas.ac.cn>
References: <20220228031540.3571959-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: ti: davinci-i2s: Add check for clk_enable()
Message-Id: <164607574441.3538791.1957643459988205698.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 19:15:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 11:15:40 +0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it and return error
> if fails.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: davinci-i2s: Add check for clk_enable()
      commit: ed7c9fef11931fc5d32a83d68017ff390bf5c280

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
