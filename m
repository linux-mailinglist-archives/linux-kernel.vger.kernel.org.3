Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7D55D7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbiF1KbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiF1KbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A012F3B4;
        Tue, 28 Jun 2022 03:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7E5261913;
        Tue, 28 Jun 2022 10:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C1BC341CC;
        Tue, 28 Jun 2022 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412277;
        bh=ZsJrsMQjZ4r9bY/qw6CSC8P3WOviim42PDUT+zI3/RE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jHwLb/F2Gyn1FAYko4v2KVxR7of29E6qZReF/KZG0/5OudbeqiU9t4znFy3uRyv9E
         rPl9JKYQ9rS/kX4tXVACcMtN+pgt+e/MELhEt0vd2MgMSRORnsnn7/DFrlAOTbqt/I
         TDlhc570+LOVL3p5aiC8aZcfKj09Y3a6R3Xq/QkMMs4AFbU6R+m1MaIK64M8BcKYDt
         ThR2feqOesBnJoFRSFXcTFPfanB9TyPivDNH9MPhKQmXw8YStQX1A50NpFczxavPgL
         i0NNzIe827BIGbDtlUROyIBLmkK4prso+0J0nLUb4XvIFVoYcpPob8yyr5V4RbILhn
         WtW642EXV0k+A==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org, krzk+dt@kernel.org,
        shengjiu.wang@nxp.com, robh+dt@kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/7] Add PDM/DSD/dataline configuration support
Message-Id: <165641227438.254424.553872611116511612.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 11:31:14 +0100
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

On Fri, 17 Jun 2022 15:44:30 +0800, Shengjiu Wang wrote:
> Support PDM format and DSD format.
> Add new dts property to configure dataline. The SAI has multiple
> successive FIFO registers, but in some use
> case the required dataline/FIFOs are not successive.
> 
> Changes in v2:
> - refine the commit subject of patch 5/7
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
[5/7] ASoC: fsl_sai: Make res a member of struct fsl_sai
      commit: cd640ca20095ed3b9306981f0064313a54fd4568
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
