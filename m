Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4365346A396
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbhLFSET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52680 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbhLFSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D2A4B811E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02DCC341C1;
        Mon,  6 Dec 2021 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813645;
        bh=2RiRaDMe4pCK1VB/Bu/ITd8PZTYEbSQhnyGAdnBQUrk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XlI4NPX0kqvOLhI7fnk4Iwv3mg3BDGMu80RHDRDWvAyJAaklrga3eGZ7XKR9z58mQ
         ZGr4RHfoL3Td6RkVEzP1b0veYy6sWLOZTlQfa0apubFRwresEEl2AxsAbVDrHxgzBt
         SoW7YhLmvm+dKBgYHOcN5M6Und6tG7or3xfdH/DR9S/t2fZGcPDy8fgPQqGCnRc4Fz
         9JJ051TZUqWIfU3XqC8hOQrMe58l3RwT0Mi8gjEFrh+pAr8mpFpKJGMN7DuP9Tv31e
         lu6qPmgMoo4XJneKmZyrfQCyJo/BqahBJnnusEgZTNylYJFnzC09K69mR+tJLYEJFu
         xRtgUObS75QtQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Ameer Hamza <amhamza.mgc@gmail.com>,
        perex@perex.cz, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20211205204200.7852-1-amhamza.mgc@gmail.com>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
Subject: Re: [PATCH] ASoC: test-component: fix null pointer dereference.
Message-Id: <163881364233.2769299.1844028008704672549.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 01:42:00 +0500, Ameer Hamza wrote:
> Dereferncing of_id pointer will result in exception in current
> implementation since of_match_device() will assign it to NULL.
> Adding NULL check for protection.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: test-component: fix null pointer dereference.
      commit: c686316ec1210d43653c91e104c1e4cd0156dc89

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
