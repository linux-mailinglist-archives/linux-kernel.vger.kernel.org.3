Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7697F461C18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbhK2QvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:51:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44654 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345923AbhK2QtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:49:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D66A4615B2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B927C53FCD;
        Mon, 29 Nov 2021 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638204344;
        bh=L1sUoNjRpQOBjNP1DUDEYD6IERNsu6y7djZ9pbkuNGA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Kb1iiedmiN4yjjhDuzhFykBkQI9W1rD9dMiiVOjT/v2rDURhm5oJKzknqsrsuak+g
         5LnT9dIfGteKuUcRTw9wgsD4uJOSI7Ojja6AjIsmgdjVk2PHAwIae3PjHwR/K0osUs
         JlPGBe+VMfKDYP7AxN+6bd/wpoCth9g796J+VAfgYhdmRXew2np6WqEtbKd/HlgN6s
         O8jq4s7ufiH5ZhgvzgL9QEkh6O3h4tGcD2xW24lgfNhfagGcgU+iL/nVbPz9ni1/T5
         0t58mTLXnPRWTdpkAfRBsBi0QRZnSpqylkPJYvc89hBnWnZ5DCnL3IM90N/VTurkLB
         3HzIcVVvMUHjg==
From:   Mark Brown <broonie@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        lgirdwood@gmail.com, perex@perex.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20211117194458.2249643-1-jernej.skrabec@gmail.com>
References: <20211117194458.2249643-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2] ASoC: sunxi: sun4i-spdif: Implement IEC958 control
Message-Id: <163820434202.1716750.14592457406948310338.b4-ty@kernel.org>
Date:   Mon, 29 Nov 2021 16:45:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 20:44:58 +0100, Jernej Skrabec wrote:
> SPDIF core is capable of sending custom status.
> 
> Implement IEC958 control handling.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sunxi: sun4i-spdif: Implement IEC958 control
      commit: 679de7b64f9622eff8f74357fc3ee071629d25b3

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
