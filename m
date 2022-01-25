Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1146449B1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352303AbiAYKZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbiAYKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C2C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D365B81751
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A85C340E0;
        Tue, 25 Jan 2022 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106031;
        bh=9oanPmGbEa5RXVfsZnBLjEA4BeGdcq9Tr6zFHoUW3cI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=n1hLkgqOUOQ1uj4tQZHu6lnsHZJ1l41hlJWZGXAYw3xWCn3/fWOQ0+roowbnTmr24
         +dHu9sLzOzPVxPvHUVrZqZbPXBFlRYVt18vZy1ee2QH5zXnoqx9/fTJ1u5wy4i8Vw/
         Ml6Zf7lDmNI4loAFcsyoTy9wJk0ZqYUpyWqhpUlnT+pPpf8BMKGl4czzgp+bcPSKsP
         /m1DvZP2VaLb8rtpDWkzKA7UXSZocd8WvDh1Y74MCTD0WrSWHQtIhA5adMIkhb4El8
         eEbNOOXwWfJgITgfWh5xSC0CKaYPX3JvysTwOhiIRQhQwsD/YS6yu6VDV5Ffnt6Qfq
         Wjc6E3KtnLm2g==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        alsa-devel@alsa-project.org
In-Reply-To: <1642646642-15908-1-git-send-email-shengjiu.wang@nxp.com>
References: <1642646642-15908-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: soc-generic-dmaengine-pcm: separate max_buffer_size assignment
Message-Id: <164310603029.74844.18163154288522285277.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 10:44:02 +0800, Shengjiu Wang wrote:
> The config->pcm_hardware may be NULL when config->prealloc_buffer_size
> is not zero, so it is better to move max_buffer_size assignment under
> a separate condition.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-generic-dmaengine-pcm: separate max_buffer_size assignment
      commit: 88c62b16281e5fe748f22f44da3def8a91fb1c34

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
