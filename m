Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1A4A0475
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbiA1Xqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:46:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51664 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344508AbiA1Xqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:46:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2857561F3E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 23:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA14C340E7;
        Fri, 28 Jan 2022 23:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413610;
        bh=5apkettzIiX+OPI0gdZmyvbdiXBJsgjX2ch0UKkff2I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UjxaIaY7dJeMsOQ8Bf/NB5fqHYz7r7aDzcuraEaF6ZfAak/6EqJanXB2w4/hifrQT
         4tkvQXWsfI2GYqp+ZD1DlOlUDMC1txcquWme3Dvw0rFYaEFVYlFSxKw/WSPzierN3i
         R6Vao+LZ7fF3nLF6fhGNUveWXC4NlvFP+SEJgl1CWMV2/fEGXoYUkfr+UByREm7tiG
         LYJ6vkc8UcFlHmuqVUQRjCXRFv/fMCHwpd84Wb5ox/owjekANyIejoPkOdJ96Vywn/
         p0XFJlSgqKn+24iqirup8TaqrWbS2pUYBQV8Yc4U3olEqk2zLBCZPi+MqPtYz63h5p
         yLJV6y6vrwFXw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220112195039.1329-1-digetx@gmail.com>
References: <20220112195039.1329-1-digetx@gmail.com>
Subject: Re: [PATCH v1] ASoC: hdmi-codec: Fix OOB memory accesses
Message-Id: <164341360910.694662.2417882289675781544.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 23:46:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 22:50:39 +0300, Dmitry Osipenko wrote:
> Correct size of iec_status array by changing it to the size of status
> array of the struct snd_aes_iec958. This fixes out-of-bounds slab
> read accesses made by memcpy() of the hdmi-codec driver. This problem
> is reported by KASAN.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: hdmi-codec: Fix OOB memory accesses
      commit: 06feec6005c9d9500cd286ec440aabf8b2ddd94d

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
