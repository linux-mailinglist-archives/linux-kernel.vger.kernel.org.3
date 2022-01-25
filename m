Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9E49B691
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578419AbiAYOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389409AbiAYOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD79C06177B;
        Tue, 25 Jan 2022 06:35:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1C73B81810;
        Tue, 25 Jan 2022 14:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65418C340E0;
        Tue, 25 Jan 2022 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643121300;
        bh=Z0/BxPj1f0zGFFhou0DpMjIeUZvUYaF7CHh5vwihvLo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rrrYkTHg+aQl2BGBDEQeU60APeqwLT9THsb7j3lv0VgcGhYpN2yYRUEmI48RNhSrE
         XBHm6apMgn46VFHbiUfv9NA0582AvvsmTQrxTEbbELdHThgsR1bQ/bQWX5j0WNbitK
         i2WulknE9grM1dJfSwT+ia5VeLZ0OmHOR2STNP37cm8FCLLuVug7tsyc6RgmWdccgQ
         R2mzUX0HNlUHvVUX4KHvqlO+Cb3M6xVpL2SBjLz+nU2Iy2DUk8tQZtR8zaDlzUyOPs
         uGsRzINx5Qn75Gm6wmxjFOZ4Wt/NjJvO6BYbTWNgvwadIWKx+ZMtTjRyz6MrTKo1P/
         vrs/V2U5zAYYg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Pavel Machek <pavel@denx.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 0/3] ASoC: sh: rz-ssi: Trivial changes
Message-Id: <164312129811.3598034.12132731428429313313.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 14:34:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 13:24:54 +0000, Lad Prabhakar wrote:
> This patch series has trivial changes for rz-ssi driver. Patches 1
> (partial) & 2 are from series [3].
> 
> patch 1/3 is just a cosmetic change which was part of patch [0] where it
> uses a do-while instead of while-do. Patch 2/3 is from series [1] where a
> helper function is added and patch 3/3 is a new patch which removes
> duplicate macros.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: sh: rz-ssi: Use a do-while loop in rz_ssi_pio_recv()
      commit: 7276d3f329c633340f3c539ce35ed254d2fe467b
[2/3] ASoC: sh: rz-ssi: Add rz_ssi_set_substream() helper function
      commit: 962ff7ecb60b684fe15b135ccbe07628b8bb522a
[3/3] ASoC: sh: rz-ssi: Remove duplicate macros
      commit: acfa1e2c2ff5cd7fb7948b0c5c2057acd9dceb14

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
