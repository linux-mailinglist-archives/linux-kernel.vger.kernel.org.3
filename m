Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7974F4516
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387721AbiDEPTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbiDEJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A8DB499;
        Tue,  5 Apr 2022 02:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A37616C1;
        Tue,  5 Apr 2022 09:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C23C385A7;
        Tue,  5 Apr 2022 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151097;
        bh=PTjivoyGXs/CkRZCvvCX+908n0DKoSEzUrbI2LgEOkc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QLoRWQ7gd5z5sVQg4LVS16yj6W4zJt94Y1TN9AEsL3E9/j73G4vHGYcYX/FH1v/F7
         lFL3Oc/XpMBV1ulsVuHownh37cniGuzMtbPfXZqdeEiNh1EsCuxbew0E+lEpQCsRKO
         ywZ3zPExKGLFm2JDJshIRcjUNv9gtEv/2UCwFOf7gf/5XUajfZYKJaXg4vZfxWKS3r
         vbX7wf/taWf+UF9H/TVSuQarThNOpxLNVtM4zfYsYQEUfd3rfT/BytvnEu3fOx8gok
         V6AyV19s71iP64BMt01EzT4sOkMcv8g+yTWIBY4xcAnrSdTtPZ8KJg87RVEu5IQAgz
         Zffd90+4cW5Yw==
From:   Mark Brown <broonie@kernel.org>
To:     spujar@nvidia.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        tiwai@suse.com, thierry.reding@gmail.com, krzk+dt@kernel.org,
        perex@perex.cz
Cc:     linux-tegra@vger.kernel.org, jonathanh@nvidia.com, will@kernel.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
References: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH v2 0/6] ASRC support on Tegra186 and later
Message-Id: <164915109452.276574.5258971838741299202.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 19:33:26 +0530, Sameer Pujar wrote:
> This series adds support for Asynchronous Sample Rate Converter (ASRC)
> module on Tegra186 and later generations of SoCs. ASRC is a client of
> AHUB. The driver and DT support is added to make it work with Tegra
> audio graph card. The module can be plugged into audio path using ALSA
> mixer controls.
> 
> ASRC supports two modes of operation, where it gets the ratio info
> from SW and ratio detector module. Presently the support is added for
> SW mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: tegra: Add binding doc for ASRC module
      commit: c54ce1a17232215c4a518149292b41835992eee8
[2/6] ASoC: tegra: Add Tegra186 based ASRC driver
      commit: a2df8c2d5b36fc66b9a6e674f3e0c87c0b9d0a48
[3/6] ASoC: tegra: AHUB routes for ASRC module
      commit: 76821c139d7e0429845e7c0798747e7eec16ec83

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
