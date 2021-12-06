Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2846A3A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbhLFSEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52970 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbhLFSEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A339CE177C;
        Mon,  6 Dec 2021 18:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90F3C341C2;
        Mon,  6 Dec 2021 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813652;
        bh=qOyUKJ/q4tpHts63eyHa7j3yANk+RknprGHSSCDq6dQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AJUiWkk4/dvF/Mxl/SYYahxRDSzTN/YisNZjONLfZcJmOuPoUZQXKDhkqL1aJPIS0
         AsT+MJRn9wCUp5sbiXYGPoZNgPYIYNPL+IyRETeM867t4H5PL9X/CDk5n7z4Uk+gVr
         t2Ai+kfM7zjporxfkGjlldR1X2q+DI1kFEvdeXM9sH9JLI3eKfhCpGFAkf/TF8hT96
         ubl+ajkWmBhf5x3Y8NultoU/HuqqqsRKOT4Fyd5f85PMIP8+ad2kY18g71DkaXFN3I
         96xERwQpPWTwRoASaQWUraPK9y5y7EKHMl43Z3caoSEz7hxAUSM2fdwAxXDtdWO+tR
         yr3pybWl7j5Cg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        devicetree@vger.kernel.org
Cc:     michael@amarulasolutions.com, shengjiu.wang@gmail.com,
        bcousson@baylibre.com, robh+dt@kernel.org, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, festevam@gmail.com, perex@perex.cz,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        tiwai@suse.com, tony@atomide.com
In-Reply-To: <20211203175018.252641-1-ariel.dalessandro@collabora.com>
References: <20211203175018.252641-1-ariel.dalessandro@collabora.com>
Subject: Re: [PATCH 1/1] ASoC: fsl-asoc-card: Add missing Kconfig option for tlv320aic31xx
Message-Id: <163881364846.2769299.4416026362989007354.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 14:50:17 -0300, Ariel D'Alessandro wrote:
> This is a follow up of patchsets:
> 
>   [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
>   [PATCH 0/4] fsl-asoc-card: Add optional dt property for setting mclk-id
> 
> Patch "ASoC: fsl-asoc-card: Support fsl,imx-audio-tlv320aic31xx codec"
> in "[RFC patch 0/5] Support BCLK input clock in tlv320aic31xx" missed a
> Kconfig option. Sending incremental patch fix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Add missing Kconfig option for tlv320aic31xx
      commit: b6ce5d85b1425d3a1211f85835ab152c9bf3803a

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
