Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81547C738
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbhLUTMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:12:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37574 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbhLUTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:12:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55E1FB817E6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 19:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C7C36AE9;
        Tue, 21 Dec 2021 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640113952;
        bh=28xw1paPaQH1pBeUDYRXDi5qVPT/FFxg4uLC0xY2BHA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RGip1+NwbqNfWugiUGnKC8FCIadMj6QzrowdC408+HVxMSsXihk2QH+lYs68A6qte
         5J1bfFzp7HrreV/MGtEKwL9OPLlDbIV/ADkRZGte0/nhGQxv14oE7zf7v4GC+KdTyK
         WqVCqNcRZlQc78sQzHjbYg3FTNx536TlMdGcFvavLoVhdp+5tZVQEbuwBeM3Cmx19M
         dS5xUsUd/c2IvWFT8sWDF2J5NTBuVPponKp5gpQEwkHMz3/zeHMqbfrwhGySJV9uVl
         98gc/Gug5TYR9ZQPm+LviuduZ6n1b5SLfzb5SfEiZyzO5LQJR49b+UVjmuPZgOcUqY
         Snk3KKEi44LZA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     Basavaraj.Hiregoudar@amd.com, Vijendar.Mukunda@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sunil-kumar.Dommati@amd.com, Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Alexander.Deucher@amd.com
In-Reply-To: <20211221171912.237792-1-AjitKumar.Pandey@amd.com>
References: <20211221171912.237792-1-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Remove duplicate dependency in Kconfig
Message-Id: <164011394960.93163.1701020272761890274.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 19:12:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 22:49:10 +0530, Ajit Kumar Pandey wrote:
> Remove duplicate depends on statement in Kconfig file.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Remove duplicate dependency in Kconfig
      commit: 15443f6cab25762272312373226d3fd2a742404f

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
