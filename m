Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4C47B882
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhLUCuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:50:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52842 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhLUCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:50:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53CC5B81113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F9BC36AE8;
        Tue, 21 Dec 2021 02:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640055036;
        bh=9FyG3W5ip2zv6ci01ldf1DOdvGhwMGzdqpxjmFLSxxw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=drh8QKpzxuAT25mPaCSbOhqZK7c8+1M02Rvw3TLmlMOzg1ARUcZ9T/J8XxiYRiW03
         IDmixepuqCaZX7Ufo5qYKU7qrr/XjLS27l3+y+h0fUe6IQcPXpdCDIls8Qx7Cr8qr6
         5apcwzda1wtxxvt9JthZU3PWxA70TgOGaanGHi0owlBOW3qVydPON77ZbGBO4XZ03Z
         3Q4vG3kIdqJEgFSrDIhakR9JDo4mJ/Kyr4TZnvfTGOqvhLt8cDVRZNvFl2KN+nm+Li
         rDxCLMwnaL/f6B0NUvtKw2W5NV30I8HuwI7FUKTVTqoSQ6LDz7ZeMVVQdRSdQz5bcD
         j4UtzYi6E/bbw==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, Trevor Wu <trevor.wu@mediatek.com>,
        tiwai@suse.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20211216022424.28470-1-trevor.wu@mediatek.com>
References: <20211216022424.28470-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: correct default value
Message-Id: <164005503431.2647762.14895672771692403341.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 02:50:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 10:24:24 +0800, Trevor Wu wrote:
> mt8195_cg_patch is used to reset the default value of audio cg, so the
> register value could be consistent with CCF reference count.
> Nevertheless, AUDIO_TOP_CON1[1:0] is used to control an internal mux,
> and it's expected to keep the default value 0.
> 
> This patch corrects the default value in case an unexpected behavior
> happens in the future.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: mediatek: mt8195: correct default value
      commit: 30e693ee82d20361f2caacca3b68c79e1a7cb16c

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
