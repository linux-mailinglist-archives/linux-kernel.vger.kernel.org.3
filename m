Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AA4F6449
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiDFQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiDFP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D3945B165;
        Wed,  6 Apr 2022 06:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7154AB823C3;
        Wed,  6 Apr 2022 13:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBA7C385A1;
        Wed,  6 Apr 2022 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251717;
        bh=3TaUT9+vHV4ELLBDNt7fqMxEWQnqlwB843HZYhfTDRA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=haGlb+m6YgipxJXICWTCIYl1FoJLlr8OZtDtWQHpLqBNGZnhi0ngescr0UOO145uV
         pHFtXDt6/fUB+LZm83p2CKAk2PpepQtoV58737tBb528RF80NjB3xJU6oykPG1WzEY
         wLwr8SM7O7XG1aYtOPbvD/nzpvc3PsTIo8WEs5mCT4oTlX8P3a2NjHJADCwKNNlzKS
         Nmf4P4VaOpj5ZZUpxchTS85Ydv1daX7rvGLutAETEals5/83NqNvXqXQcCFeaN80Mj
         afGodjZJp+w24QgAvaly1854bJy08sc+g0sL3fg9Bl8azzP/XJc7dhUgms/0mTdlq2
         H+opc/K5wc18A==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, rf@opensource.cirrus.com
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220318162943.1578102-1-rf@opensource.cirrus.com>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ASoC: Add a driver for the Cirrus Logic CS35L45 Smart Amplifier
Message-Id: <164925171568.83821.4847181026901086960.b4-ty@kernel.org>
Date:   Wed, 06 Apr 2022 14:28:35 +0100
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

On Fri, 18 Mar 2022 16:29:38 +0000, Richard Fitzgerald wrote:
> This adds basic audio support for the Cirrus Logic CS35L45 amplifier.
> 
> The first two patches add two generic helpers to ASoC, and patch 3 is
> a kunit test for patch 2.
> 
> James Schulman (1):
>   ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: soc.h: Add SOC_SINGLE_S_TLV() macro
      commit: bc8cb02976cd602b8d7631a6f4a54a9cf305d38c
[2/5] ASoC: soc-utils: Add helper to calculate BCLK from TDM info
      commit: 1ef34dd2b90d78a9830398441801658ef86eee9d
[3/5] ASoC: soc-utils: Add kunit test for snd_soc_tdm_params_to_bclk()
      commit: 89342fa38bbaade51584f255eee5cd43621f4e10
[4/5] ASoC: dt-bindings: cs35l45: Cirrus Logic CS35L45 Smart Amp
      commit: 72661ff7662acc00d51976d4b2d2d13eb5628385
[5/5] ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp
      commit: 0d463d016000d68d7e982720b5e4380b2d83409a

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
