Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF95486B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbiAFU22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbiAFU2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE99C0611FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:28:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CC1A61E24
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60040C36AE3;
        Thu,  6 Jan 2022 20:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500902;
        bh=/HeOpyMdXJEm0oJ6Rb/pWakA0Uu7ogZ2rdPbVlKI3hg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pp7rwB+liL//1RFg9Fhzw5ISNYvnCdxiYgkFVq56vKyd9GFwvMuRK2Ru2pu8jRBHg
         pMf8s88ooC0x26yOTxwvpjRSnno4PyGLYgPAblEEUjOTgwXQb/eiuTwOpenXQrxhgV
         p5BiTTOAu8P7Tn+yJUEbe83TetluzlpDIwg9Y3I0lVYz3PoaMqR0WqLn10GkvjLwvu
         QpMDvKs7aq8Aw87Letr/v0B21CvWpCMKQlSWW90Q4W2WvC7PqssQfE8hi4UryR0InP
         Uv3JGWU3lhOP+zyiSe2HlmA8sy9Vqxc/xdNorYqocYD5xNz8K2u1akiNTxvRo/f08U
         vwPHIQjFxCpTQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220104033356.343685-1-y.oudjana@protonmail.com>
References: <20220104033356.343685-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] ASoC: wcd9335: Keep a RX port value for each SLIM RX mux
Message-Id: <164150090010.2243486.16272491720524163841.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 03:35:36 +0000, Yassine Oudjana wrote:
> Currently, rx_port_value is a single unsigned int that gets overwritten
> when slim_rx_mux_put() is called for any RX mux, then the same value is
> read when slim_rx_mux_get() is called for any of them. This results in
> slim_rx_mux_get() reporting the last value set by slim_rx_mux_put()
> regardless of which SLIM RX mux is in question.
> 
> Turn rx_port_value into an array and store a separate value for each
> SLIM RX mux.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Keep a RX port value for each SLIM RX mux
      commit: 3b247eeaecfefe35ecca1578b0ed48be65bc6ca3

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
