Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9112946649B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358318AbhLBNoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:44:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36946 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358292AbhLBNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:44:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B31DB823A9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE84C53FCC;
        Thu,  2 Dec 2021 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638452441;
        bh=vx6hdCe/4wgrzwpQ2Hj0Hewq51BjCl83piJc+BwakoQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b5+cz0573r0c4WYX1NbIPuE1ylkNQjKQ/EktPk6gNaTKhD2EWhmmgukeLOGcnLZ4J
         U7GLekVVQokWU+uHNd+9PgnMHcZDuWk/2XDdNr44RxuZuizNaJkkWFaJTNid57OIro
         g7o75m4gUMyMcEqhOU6QMwKh3uHZ8RxvcJtLbf6JTxvrwQz8wYLON8lxK0QEs75nSz
         lBM5eOKMVyWbpW2cZdSO2hkZ5gzKf5dxo1bZR+ixOvIXlrQQbjC3ckyG8BLvDs/Q0L
         fszl/guAvzVzu4p2XSASfl0JpmMk/L5NfDpimFnmHCAf7PS+4FnaGm4Zbw1PdsBOZv
         1F+05/LryH7mQ==
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, Len Brown <lenb@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20211201180004.1402156-1-tanureal@opensource.cirrus.com>
References: <20211201180004.1402156-1-tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: amd: Fix dependency for SPI master
Message-Id: <163845243916.1057742.7617064791622054401.b4-ty@kernel.org>
Date:   Thu, 02 Dec 2021 13:40:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 18:00:03 +0000, Lucas Tanure wrote:
> Set SPI_MASTER as dependency as is using CS35L41 SPI driver
> 
> Fixes: 96792fdd77cd1 ("ASoC: amd: enable vangogh platform machine driver build")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: Fix dependency for SPI master
      commit: 19a628d8f1a6c16263d8037a918427207c8a95a0
[2/2] ASoC: cs35l41: Fix undefined reference to core functions
      commit: 0695ad92fe1a0bb7697eb92c6a145a73c5ab0e24

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
