Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8155DA74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbiF1KbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiF1KbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C7C2F3B4;
        Tue, 28 Jun 2022 03:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD1BF61917;
        Tue, 28 Jun 2022 10:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70334C3411D;
        Tue, 28 Jun 2022 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412274;
        bh=FqQbficcDw7vk8SHlBe1Sw1FJiQ7bntADu1nU2HONhA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aPJCGn4iSnzaPYC52niBVyz2Z5O4eiCmxAI2bupQSBWrMtPxRB7tuerZPab/kJss/
         owTupPs2hBaZdL8oFrvd9pcB+6WKUmXoKwJSR87JogfQunR1rUCH7uqZPjvJqzqulY
         Hn0lWgAhasLz2S/ttikVHr8xXLaC+iq5FEVLpK5O9VhTJRPQ7Co84tilhs4J8JKoj+
         Rhe6QnW81xLMNWmfVOl0llcR9aQxObDkL6XE1dY4Fohk3ZnSq+w7wOFjxuUjIerIOj
         xz4rRl/snTGJXqnszDHjhvOqsvQYF6AwnykavkNgDJlQGHfF+cDQo5ZLlMpLyP7Zxr
         pzpTxTRWh6Utg==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        perex@perex.cz, krzk+dt@kernel.org, shengjiu.wang@nxp.com,
        robh+dt@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/7] Add PDM/DSD/dataline configuration support
Message-Id: <165641227114.254424.14373197929735584783.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 11:31:11 +0100
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

On Tue, 14 Jun 2022 12:11:17 +0800, Shengjiu Wang wrote:
> Support PDM format and DSD format.
> Add new dts property to configure dataline. The SAI has multiple
> successive FIFO registers, but in some use
> case the required dataline/FIFOs are not successive.
> 
> Shengjiu Wang (7):
>   ASoC: fsl_sai: Add PDM daifmt support
>   ASoC: fsl_sai: Add DSD bit format support
>   ASoC: fsl_sai: Add support for more sample rates
>   ASoc: fsl_sai: Add pinctrl operation for PDM and DSD
>   ASoC: fsl_sai: Move res variable to be global
>   ASoC: dt-bindings: fsl-sai: Add new property to configure dataline
>   ASoC: fsl_sai: Configure dataline/FIFO information from dts property
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: fsl_sai: Add PDM daifmt support
      commit: c111c2ddb3fdfca06bb5c7a56db7f97d6d9ea640
[2/7] ASoC: fsl_sai: Add DSD bit format support
      commit: 4665770407de8af3b24250cec2209eaf58546f8a
[3/7] ASoC: fsl_sai: Add support for more sample rates
      commit: 0d11bab8ef3e5540dfba111947dbd8dcfb813150
[4/7] ASoc: fsl_sai: Add pinctrl operation for PDM and DSD
      commit: b4ee8a913e617a2d0f19226225bc025c8640bf34
[5/7] ASoC: fsl_sai: Move res variable to be global
      (no commit info)
[6/7] ASoC: dt-bindings: fsl-sai: Add new property to configure dataline
      commit: 6b878ac2711056dd07c712caf89f58449cf5a592
[7/7] ASoC: fsl_sai: Configure dataline/FIFO information from dts property
      commit: e3f4e5b1a3e654d518155b37c7b2084cbce9d1a7

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
