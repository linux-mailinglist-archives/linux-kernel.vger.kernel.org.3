Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F449FD52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiA1P7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349782AbiA1P6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410BC061714;
        Fri, 28 Jan 2022 07:58:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB42B8263F;
        Fri, 28 Jan 2022 15:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879EFC340E0;
        Fri, 28 Jan 2022 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385524;
        bh=TNhGzP3L4A62xIW3WqJXmAepqSZa9f/QpFgq2evI+GY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cLo52bKzZ8GfrFghA1xPWJnhoWIHtxlzjqxTcLxSjmrczYwy/J4qkSuMpHTCKCa28
         7RBkW6WwTtldAUfdfUM1PbzM+qMGbjCXRdFNDNsSaQmTsNnh9VvZp15iTBu7yHcQIB
         lkvX/Yo80fbskFQpSmkn8WCOCGR2HT6NmWVHEJsF/AdjbazXjTvfG9ISD6d91Gt6Uk
         8FASTGnHiVa+u45iJnBg0PZ0fHZFI5bVGHSX89k87WIkRx8LPM8ea0vRZf1BgAQbSE
         6UN1EZPa5S2Z2YcbTW+8lPryFcd1epj4tLzioc3056J+8wHNxJ2Ole0Qf4rpsw8QyK
         q83EIDhiCkQ8Q==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Derek Fang <derek.fang@realtek.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220126231358.1637174-1-robh@kernel.org>
References: <20220126231358.1637174-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: realtek,rt5682s: Drop Tegra specifics from example
Message-Id: <164338552327.1711274.18356400085950572134.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 17:13:58 -0600, Rob Herring wrote:
> There's no need to complicate examples with a platform specific macro.
> It also complicates example parsing to figure out the number of interrupt
> cells in examples (based on bracketing).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: realtek,rt5682s: Drop Tegra specifics from example
      commit: 0cfe76156cc1c7f8a707969c03ed2242db8f0292

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
