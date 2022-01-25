Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B449B1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352773AbiAYKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:25:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60600 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbiAYKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC9561639
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4CBC340E0;
        Tue, 25 Jan 2022 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106036;
        bh=teZpSSDIJO8MxzMjV0LQdvAm1PtEQNLwt0AmngnKKyI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dYPxNsfgvNGvhmD+fMaXfnYHhV3TJYQ57AavGj92hdZnTsmn51oewzSYGtjgpZFA8
         kCXMb5eZHPQGcQHt1UWvCcN0fpq2EdWg9bAhIAz1DbaV48P3rRNf1+6Tn6rqRrJ8Tp
         rHUWTtlocmLtQl8jblnWlzeUbHPCrN6qyMWwbS5TzGIkCfhgjQ7LLWmoWzu3RYppn1
         qotbJ6YjF8Kg/ORPJ+oTKgfKZ7hcqwuiFUeCSRQKaiT08/maQlZTXgySNiaYTx4B1e
         jlcueyAC0HIKNsDFz9jGaj2Dwr5n2zZvYgUF4OFQTul62rgURXMpidnMz1GuVQReQ6
         RTM1UdDu4ZWLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220121120412.672284-1-rf@opensource.cirrus.com>
References: <20220121120412.672284-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/3] ASOC: cs42l42: Add support for system suspend
Message-Id: <164310603562.74844.1855667686976141960.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 12:04:09 +0000, Richard Fitzgerald wrote:
> Add system suspend and resume handlers so that the cs42l42 is cleanly
> put into power-off state during system suspend and the registers are
> restored in resume.
> 
> The first two patches separate out two small changes that can stand
> alone and are needed to enable the system suspend implementation:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs42l42: Report full jack status when plug is detected
      commit: 8d06f797f844d04a961f201f886f7f9985edc9bf
[2/3] ASoC: cs42l42: Change jack_detect_mutex to a lock of all IRQ handling
      commit: 5982b5a8ec7ddb076e774bdd0b17d74681ab0943
[3/3] ASoC: cs42l42: Handle system suspend
      commit: f8593e88540052b3feaf1fb36f2c1c0484c9dc14

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
