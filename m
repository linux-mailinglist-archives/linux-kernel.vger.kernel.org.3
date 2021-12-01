Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259E1465587
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352557AbhLAShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:37:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56000 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352551AbhLASf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7863CB82103;
        Wed,  1 Dec 2021 18:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9BBC58324;
        Wed,  1 Dec 2021 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383553;
        bh=S547ErWqtNu3vwvGlmuxEEdxxKXbkWuC/GekSGIlTsg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HKyy+B6q6UABGRy9+hDJri5nNZbMJeHxPw3lIxgtUXwoqXH+fcbvj0B4x7Tcg9H+H
         gPnWA5aXD//LkzD1cdD/f8mwk42V84WqJbMspD66VED3/py/pPMEvn47S8e9bdmiml
         DnDNyTCYUs01RkisVrr0ch/PYtbrqFCcdGbRUczAk9iaOjjDLIxVq/IxFwIP0uvQcL
         1SVXkCX5JckjL2zScF+ztG/WEi6gtQdmbcU/Fvfnf/0Ot7qsBxgqF0LJ8id3ZnWcyq
         M6fcXO23DImWx5Rp8tV8WZPAaJ//HozNHxSj8APy7/JC18LvCNAy2W8tWe9QvjZuiV
         mWvPkbBpyeskg==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH V4 0/4] regulator: da9121: add DA914x support
Message-Id: <163838355167.2179928.18428295245396475167.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 22:10:09 +0000, Adam Ward wrote:
> This series extends the DA9121 driver to add support for related products:
> 
>   DA9141, 40A, Quad-Phase
>   DA9142, 20A, Dual-Phase
> 
> The changing of current limit when active is now prohibited, for the range,
> due to possibility of undefined behaviour during transition
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] dt-bindings: da9121: Remove erroneous compatible from binding
      commit: b9c044b7d63b2ffae9664349721c80c4ab3e56c9
[2/4] dt-bindings: da9121: Add DA914x binding info
      commit: d07fef2fcd4d79198a700f4b4d2ca4670649c9ff
[3/4] regulator: da9121: Prevent current limit change when enabled
      commit: 24f0853228f3b98f1ef08d5824376c69bb8124d2
[4/4] regulator: da9121: Add DA914x support
      commit: c5187a245e9bb0af2da8d37ede191569c824c66b

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
