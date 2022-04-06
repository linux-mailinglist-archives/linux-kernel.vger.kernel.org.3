Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3C4F642C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiDFQA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiDFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94730CBA9;
        Wed,  6 Apr 2022 06:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90FF4CE23B0;
        Wed,  6 Apr 2022 13:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA46DC385A7;
        Wed,  6 Apr 2022 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251730;
        bh=ZZeh6zTDcFwtbxD5va/nJQyyLywroM+cwhGSFxHPOY8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e68Neh16zqsi6ozs7M9q9u+X150Cf/5gO/40+b73FPQow30cPj+GLR2vaPMhC+HTx
         iR6Phw04NsvKelnF7Qy8GKAJFjM8rpn2YuCxKd/CowT7TlB1fMpHOAqkJNSHmZVbFd
         bope+12XR2c6psl5Snqe0Ya1gzfeYw7UcKFo2yGyFVkdjkkmY1vwtNsFpil6teSluu
         B4WCqTprKj9u1ASVzAiAWCL0yUcQpN1JMZe73LSd0A5wj1Zxv/XlETz7e53rUhLzzZ
         Q0EWM94S1iEiM8IclW/la9cg4u/JySJngzoZctx1zEFMrmnCdt6/0DrEdZQC6whVlO
         NrG6vRGqbJ3BQ==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220405135419.1230088-1-rf@opensource.cirrus.com>
References: <20220405135419.1230088-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/5] ASoC: Add a driver for the Cirrus Logic CS35L45 Smart Amplifier
Message-Id: <164925172848.83821.10687099289112753993.b4-ty@kernel.org>
Date:   Wed, 06 Apr 2022 14:28:48 +0100
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

On Tue, 5 Apr 2022 14:54:14 +0100, Richard Fitzgerald wrote:
> This adds basic audio support for the Cirrus Logic CS35L45 amplifier.
> 
> The first two patches add two generic helpers to ASoC, and patch 3 is
> a kunit test for patch 2.
> 
> CHANGES SINCE V1:
> Patch #5:
>  - spi .remove callback now has void return
>  - use new I2C .probe_new callback
>  - force boost-bypass mode as default
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
