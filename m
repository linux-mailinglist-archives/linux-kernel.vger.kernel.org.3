Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F649FD59
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbiA1P7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiA1P65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9BC06174A;
        Fri, 28 Jan 2022 07:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2847B803F5;
        Fri, 28 Jan 2022 15:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B206C340E0;
        Fri, 28 Jan 2022 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385533;
        bh=xxYQrH2a1nZXptgnuJ7VvYreXv9KZjIEe8yZ2pHXhhk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z4v227kfRRGYnf1Q5/FYJ6MKhXs3TzPxC2gd5G5XrWF/m8vdh1N/EMSDSK4maKqUY
         TyFJkcz4I+XSgb/fbldko33Gkl1WpdlAp7g/KYYtaRuHfOVBNaELkJgsQEuVei1RlW
         MDY2jsqLUBEBbb6rafaGJ7qcJbET/ZUi9g/OF/Aw/LaDVo+BVyNtcSkK3WZ+/JDJm6
         8xo+A1E/AfyZQ3swzcivgX1LR8PO3Hvf4Sh6gxczZe0J2eDdj0Bm6kKnOvikcsNl1T
         NNiOBKx6yACa82jCPtn2r+iJsYuN+QHyiRCZGL8h/oHr1S8lTm6T2b+zAZtI8/3Sbb
         OwNLs4CfLOZVQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, thierry.reding@gmail.com,
        perex@perex.cz, Sameer Pujar <spujar@nvidia.com>,
        robh+dt@kernel.org
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mkumard@nvidia.com, linux-tegra@vger.kernel.org
In-Reply-To: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
References: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH v3 0/5] Tegra234 APE support
Message-Id: <164338552935.1711274.7611891938400157156.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 18:07:51 +0530, Sameer Pujar wrote:
> This adds APE support on Tegra234 and enables sound card on
> Jetson AGX Orin platform.
> 
> 
> Changelog
> =========
>  v2->v3
>  ------
>    * Fixed DT build error related to power-domain and
>      iommu reference.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: tegra: Update AHUB driver for Tegra234
      commit: 4fcc8710fdd91b37760ccd99bbfbe10352df7600
[3/5] dt-bindings: Document Tegra234 APE support
      commit: fed44d6c3bcdb11ed77bc681f1cf80cbe8cfd9a5

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
