Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71934B6D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiBONSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:18:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiBONSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:18:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A71D10A0;
        Tue, 15 Feb 2022 05:18:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88C24B819C2;
        Tue, 15 Feb 2022 13:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3062CC340ED;
        Tue, 15 Feb 2022 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644931113;
        bh=6sDK0ccoSzhYNr2YTp0NKTVctS799bzZHwni9VvC+GI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CeIMzQji6pQPppttKX9ZxoE2OPFrWW9a+9Fu8Coii2iyM02IjSEw+UxvuZ4ouWUt2
         SsJlW8lFWyj2o7mR+xGUnSVGvyeEBjQrMauJS5pY3nxkqFk2U3tuabW1GPt7HKCbMd
         zGUKpP2Uylv5OPTAqCGLkBNVgv920ngnO8CGHQN21B0nqMuamtknG5ra4t/pUjek98
         mwTHb66jaPsTTV1QREPLPJqoB4zVqOQERavSVroCXrbWqNARdgA7gmyMi/6u3OgrlL
         Gxut4aQT4COPorjx2VNFAEL2BAmeh8MIXHLzaxyftpXG7E2FrWkjzwBdMGAMECbUut
         9OBjgEoT7yzqA==
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220214213223.65780-1-colin.i.king@gmail.com>
References: <20220214213223.65780-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: tegra20: spdif: make const array rates static
Message-Id: <164493111091.974741.18170472602420654568.b4-ty@kernel.org>
Date:   Tue, 15 Feb 2022 13:18:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 21:32:23 +0000, Colin Ian King wrote:
> Don't populate the read-only const array rates on the stack but
> instead it static. Also makes the object code a little smaller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra20: spdif: make const array rates static
      commit: 83a1bed1f49869ea0fc7de321d5dcc598d0dfb15

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
