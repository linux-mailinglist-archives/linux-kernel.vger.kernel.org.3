Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F5C538C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbiEaIST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbiEaISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BA939AE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E94A6122C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8D3C341CA;
        Tue, 31 May 2022 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653985088;
        bh=fSVEgHaQGJCievYHd/siPU9MrxqftRRsLr4LLyS7pIE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e8AAYJgWyOqcPINHbX51cvc9F2YNxkdwn2HcDd7WPgbW0dK5XJlLPPb18vVmBIH5/
         xEKw9Uh8hZ0K4/K8i3d6juxZNufcKIErfb9Y0RAv1v6RpZAyYsiLy66/+IFHFvIowy
         lmh1O2CTB7sAf1RXjYmQO8Fhx82xGX4np+blffUij1w8D6lhp4gUh1b2D/F0RcQTDX
         /XU88mpNGZzcVowqyQom2hBeybvzYJrcQGkZ5/f4pqtr2u7EHrX1tkdsmKKJVzt2SB
         dO1naBmegRow+N9JPAukBqOHJZvzN8rJjZYcb8oFCUR5qGLcj2tpJr0PhQkzcd7Bu1
         dHjjuiLE0ueSw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com,
        DLG-Adam.Thomson.Opensource@dm.renesas.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        DLG-Support.Opensource@lm.renesas.com, alsa-devel@alsa-project.org
In-Reply-To: <cover.1653916368.git.DLG-Adam.Thomson.Opensource@dm.renesas.com>
References: <cover.1653916368.git.DLG-Adam.Thomson.Opensource@dm.renesas.com>
Subject: Re: [PATCH 0/2] ASoC: da7219: Small fixes for jack detection and removal
Message-Id: <165398508710.2913674.18295857798607070807.b4-ty@kernel.org>
Date:   Tue, 31 May 2022 10:18:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 13:22:21 +0000, Adam Thomson wrote:
> This series contains 2 small fixes around the AAD part of DA7219, particularly
> in relation to jack pole detection on certain active headsets, and tidy up
> when a jack is removed.
> 
> Adam Thomson (2):
>   ASoC: da7219: Fix pole orientation detection on certain headsets
>   ASoC: da7219: cancel AAD related work earlier for jack removal
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/2] ASoC: da7219: Fix pole orientation detection on certain headsets
      commit: 06f5882122e3faa183d76c4ec2c92f4c38e2c7bb
[2/2] ASoC: da7219: cancel AAD related work earlier for jack removal
      commit: 2d969e8f35b1849a43156029a7a6e2943b89d0c0

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
