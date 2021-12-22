Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54D747D447
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbhLVPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:33:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59116 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhLVPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:33:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D1361B01;
        Wed, 22 Dec 2021 15:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BABBC36AE8;
        Wed, 22 Dec 2021 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640187220;
        bh=byBGhTV5Xn9KAFDJW7bstvlAYTSSq6UwsroZt5WEVuM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CGaDy/hd8YWDB2zS8FGwC2cQ5x7PzkGnh53U+thvI4CtD+8TAcS2p5rWyFswWAd7c
         ujz8PcqG56G6/WW6oDfz/zI7I8Us3gG3A3922zYoQ4vsa2g2T1dcUCUL/gfl4yjuLI
         1GUygCb5kuZsYTFaWqRFwdJM+MQ6Ad4b54IYzB6TPeE93a5STz/isRUfH+M2qdd9ze
         YNPsDmtEyHovkgwFklAq81mg8ZuSaW1oyTRLwC/BXPpH5VywDGwIBD+ke9z2MSrapV
         35CzHmgGsWBpdb6HIUEt9vhOJo5Ettbg56aKy4iUJ7QteyNNUxKUvwgtnDmdhavYi6
         dvBn5mo4AmKkg==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     phone-devel@vger.kernel.org, alsa-devel@alsa-project.org,
        ~postmarketos/upstreaming@lists.sr.ht, stephan@gerhold.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211222135403.2991657-1-vincent.knecht@mailoo.org>
References: <20211222135403.2991657-1-vincent.knecht@mailoo.org>
Subject: Re: [PATCH] ASoC: codecs: ak4375: Change invert controls to a stereo switch
Message-Id: <164018721921.257503.2890165869395844521.b4-ty@kernel.org>
Date:   Wed, 22 Dec 2021 15:33:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 14:54:03 +0100, Vincent Knecht wrote:
> Don't use enums for DACL/DACR Signal Invert controls,
> and change them into a stereo "DAC Signal Invert Switch" control.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ak4375: Change invert controls to a stereo switch
      commit: 37daf8d9e0bd85a2859721aec28e1eb6e9973262

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
