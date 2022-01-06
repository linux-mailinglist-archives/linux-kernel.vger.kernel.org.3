Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA66F486B18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbiAFU2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243740AbiAFU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46921C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:28:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DADEA61E15
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B656C36AE3;
        Thu,  6 Jan 2022 20:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500897;
        bh=21uqmI0sF0iqFXzWvfwSr8yWzQwcFoXEvQOSpJlA73Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F+qwbyGHuzSd59HvZAdcWL05m/1dwoHw0g/OWlN9NjtsNLYA9CjiZ2ElVAOi8ifoU
         nwjK6pBaLzl9SFkc64aiFm9xXA/60dEPD5gfqwFNH9Ja1YK+GMSCdk5QV54Gm3K5Lq
         x9wN2hC7VsVxD8mKZpexdSqzLaCZoixn7AOiYc1YrO1/PSpONTvYJtNOCNe76RdbWL
         00LAaDGFeYt1WoPPpAmE0J8p5+xuLVnLB7jyIwYoJydwywAweOIBdZ5DmzezjNWGTV
         6/WHdrxYrWqndNnjrbAlWzgPj4yMz7CWcbQyHCiYvRGKunDcR+7p3bQmPPBO9u/ZM2
         SBTXbdFyaBxBg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com,
        alsa-devel@alsa-project.org, festevam@gmail.com,
        nicoleotsuka@gmail.com, timur@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
References: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/3] ASoC: imx-card: several improvement and fixes
Message-Id: <164150089509.2243486.810361187856950551.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 18:40:32 +0800, Shengjiu Wang wrote:
> Several improvement and fixes for AK codecs supported on i.MX platfroms
> 
> Shengjiu Wang (3):
>   ASoC: imx-card: Need special setting for ak4497 on i.MX8MQ
>   ASoC: imx-card: Fix mclk calculation issue for akcodec
>   ASoC: imx-card: improve the sound quality for low rate
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: imx-card: Need special setting for ak4497 on i.MX8MQ
      commit: 3349b3d0c63b8b6fcca58156d72407f0b2e101ac
[2/3] ASoC: imx-card: Fix mclk calculation issue for akcodec
      commit: f331ae5fa59fbfb748317b290648fc3f1a50d932
[3/3] ASoC: imx-card: improve the sound quality for low rate
      commit: 3969341813eb56d2dfc39bb64229359a6ae3c195

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
