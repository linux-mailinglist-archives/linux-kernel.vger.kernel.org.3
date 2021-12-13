Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059414737BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbhLMWma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243736AbhLMWm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:42:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD9C061574;
        Mon, 13 Dec 2021 14:42:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F03ABB816CC;
        Mon, 13 Dec 2021 22:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFBFC34600;
        Mon, 13 Dec 2021 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639435345;
        bh=dDQFAFUmTORVECs8IuRszmLZ6KqUu5Nfojvby5Bc3rM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QUX9zrPh31+XK+TMxIuA6+kPF4uIX6QRj1Q+26ETWZrZ6f0tcMg2/H94di7h0yysc
         zaiuMd3+xt5uNVevsiNk2yO7VUq6aL7Be/+Ho8zpUd4RMf09sqR7rSoHjJtJGZK/gc
         lwNs6cwupky48u1WEdk8toOE2bsgG74Yjnt6qZBKfxFwPk4GVcEfDCTgLR8HZe5hWL
         o+Rvh0hcd/oHuATZUnq1soZ/0+vH6ylr+PTcB8zIM0Si7RANNuKBkwMz25ZqTe+PqJ
         +izi4OUBUKxKNnPEflzaA5QjFIeFeA6CqGKWZdkxb4xb/k93Vg8OBNa473nURZldTN
         6JVzNqwWozF1w==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211211231146.6137-1-digetx@gmail.com>
References: <20211211231146.6137-1-digetx@gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: tegra: Add DAPM switches for headphones and mic jack
Message-Id: <163943534342.1012216.11678969524505932920.b4-ty@kernel.org>
Date:   Mon, 13 Dec 2021 22:42:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 02:11:45 +0300, Dmitry Osipenko wrote:
> UCM of Acer Chromebook (Nyan) uses DAPM switches of headphones and mic
> jack. These switches were lost by accident during unification of the
> machine drivers, restore them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/2] ASoC: tegra: Add DAPM switches for headphones and mic jack
      commit: d341b427c3c3fd6a58263ce01e01700d16861c28
[2/2] ASoC: tegra: Restore headphones jack name on Nyan Big
      commit: db635ba4fadf3ba676d07537f3b3f58166aa7b0e

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
