Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA453FCBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbiFGLBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbiFGK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902DF68A1;
        Tue,  7 Jun 2022 03:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07886615E1;
        Tue,  7 Jun 2022 10:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44ECC385A5;
        Tue,  7 Jun 2022 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599312;
        bh=RMxBLzAW7Q9aqyjIr5rMgScv+pfwT+8lbeF5Fd1v700=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qFXaEbfPLM9891/pU83KYLFlThljzmRkg1Gnb/Zv2rjp4HWgtsmwgTWlk4nQZ7SEk
         KwG4y58qXF1jTacp0XL8O7ABwpRlHij3weDb94mx20VKfkJ+9rZ5z876ySns1iKB5e
         Kk3GLRoVxRHWvesYIKn676HPwdVHT4kmGpvPkKDPppyfVn+hy+WQwL0B/4Yk/fXoI0
         nQtD+C11pv+YRIHVFN+ZX8WX+jOGuYkF+3R+WSHCN7AQr08P/UPfX2/22Db+Upx8mK
         quulXl067G/NVEI1xkwBvic8I3BLUYBSSTiNlaG4xlFOEttmWkl6+HmzbWYp/GzUTf
         YuCn7Gl2B3FAA==
From:   Mark Brown <broonie@kernel.org>
To:     thierry.reding@gmail.com, tiwai@suse.com, spujar@nvidia.com,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
In-Reply-To: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH v3 0/6] OPE support on Tegra210 and later
Message-Id: <165459930944.399031.17402863866991236523.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:55:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 12:06:06 +0530, Sameer Pujar wrote:
> This series adds support for Output Prcoessing Module (OPE) module on
> Tegra210 and later generations of SoCs. OPE is a client of AHUB and
> it has sub blocks of PEQ (Parametric Equalizer) and MBDRC (Multi Band
> Dynamic Range Compressor) for data processing.
> 
> An ASoC component is registered for OPE, which includes PEQ and MBDRC
> functions as well. This can be plugged in audio path using ALSA mixer
> controls. The series adds necessary binding documentaion, driver and
> DT binding patches to enable OPE module on Jetson platforms.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: tegra: Add binding doc for OPE module
      commit: 45c6c5e052df2ee0d87e74743d8bb72e70fd0887
[2/6] ASoC: tegra: Add Tegra210 based OPE driver
      commit: 7358a803c778f28314721e78339f3fa5b787f55c
[3/6] ASoC: tegra: AHUB routes for OPE module
      commit: 7ee0910d03168535ffeea2f4ce924eebb3b24863

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
