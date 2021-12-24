Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1858247F00C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353198AbhLXQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353194AbhLXQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:17:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94027C061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 08:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F10C620CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 16:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C00C36AEA;
        Fri, 24 Dec 2021 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640362652;
        bh=Ug7MgkARQjzTdBT5xt2EBO4kufmFltAfOCADeAkS8DQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tivlVGhlNtPLzZMoW5SpMeW1y4mTPFkq/im04/MvwXR7VqSQnCF0LBZs7qDFg1iiq
         zMxV39Eg0tQeDedRr98u3bUtxc4rHQRAOeYNSJKEPlXZotZV71OflQJbQmXtIj/k7e
         O8dvZIhw3wSNx+IC804bWaRpvFfLr2LVDejfgVnR7psHN8B7HTjjeRoGJ2f0qOxreV
         vQ2QxRD1p+7Ly+IekZw2f19W6AcsI2qKrgWLJB2el7dnqXtoN875vAejFui1kfwGfZ
         k9J6JBzkkykqLKJpZxFHHYHZOPtJ68KCiTRo2MIwn5+uQtQ4NDQAfGQV1ImfSQisLm
         pzDjVrQIUXVHw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Vijendar.Mukunda@amd.com, ajitkumar.pandey@amd.com,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <20211224150058.2444776-1-vsujithkumar.reddy@amd.com>
References: <20211224150058.2444776-1-vsujithkumar.reddy@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Power on/off the speaker enable gpio pin based on DAPM callback.
Message-Id: <164036264944.3720027.17021218639884939671.b4-ty@kernel.org>
Date:   Fri, 24 Dec 2021 16:17:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 20:30:43 +0530, V sujith kumar Reddy wrote:
> Configure the speaker gpio pin based on power sequence of the DAPM
> speaker events.
> Enable speaker after widget power up and Disable before widget  powerdown.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Power on/off the speaker enable gpio pin based on DAPM callback.
      commit: 5c5f08f7fc0bee9a1bc3fbdcb7a21cfd0648ab14

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
