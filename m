Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166E346A395
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbhLFSER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbhLFSEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC5C061359
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:00:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61E6FB811E4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AF3C341C5;
        Mon,  6 Dec 2021 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813642;
        bh=gpgEzgtitb8ZbtTgNSGacdRk0bS0lGGyk4+yjPMNTXs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D5WtIidFy4blBoZa2JP7SnPul5vQI0db0zKSrraKthjPknYr9a40tzQ/Jn7OR3P63
         EEgKbfiHfeI7v60S4BBxhFp9I1YhF3eJtEA8BRBrLf1TCWEA86XgVakMamN58FSbBV
         po0WZfAPwhUBO8QdGjNJM5ii0pzhh4Dj6dHqQs8LmlkgeHajkAsoj7uV62psbXU44Q
         CNOURxpCBSXHSZj2H9cin/tzWvaKsFnJGGZ/quFCebmlvXuR8c8Ipb8K3Gx9hj36OF
         XInsTmBacISGo7fHHgTFNgqrQ72w8KgjAyp4l40+PS0buAeCUa1L4Llgh/EGOXjARE
         Pzizs53OBVtEA==
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20211204110848.21322-1-rikard.falkeborn@gmail.com>
References: <20211204110848.21322-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: amd: acp6x-pdm-dma: Constify static snd_soc_dai_ops
Message-Id: <163881363969.2769299.3291648369913552767.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 12:08:48 +0100, Rikard Falkeborn wrote:
> The only usage of acp6x_pdm_dai_ops is to assign its address to the ops
> field in the snd_soc_dai_driver struct, which is a pointer to const
> snd_soc_dai_ops. Make it const to allow the compiler to put it in
> read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp6x-pdm-dma: Constify static snd_soc_dai_ops
      commit: 7bef00106bc68beddcddcd06e3b02dde5525face

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
