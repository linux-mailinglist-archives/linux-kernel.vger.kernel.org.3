Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5EF46A399
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbhLFSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbhLFSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAD8C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:00:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16F04CE16C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FC3C341C5;
        Mon,  6 Dec 2021 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813648;
        bh=TFrUdFOKOZTgMW/4vcU/Sx5rIGJgVMftP0iInpxV7XA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=DpIjXGwbx+gA/gtxKTrn8PFwHP5CQ7sAnktk0nzXGsrelPvhUfF58d09ZLqrganLw
         bV/ka+XSf+adSaypZ7xLBNg283+wIdfVBphsShlXOPMyRVrgUgE9XPCoyLz+rsRtcz
         4I53089gRYExRyMHIlpHSWQ2nyjAdvyY2UKekt0JDs/CYLJSy+VVkxsyMquUz2YBGT
         bNnIE38JweOlQnIpvvcw7bVvABLTS/WLXbNU2CHZUQXWXeQVhvkMfl5T7c21sXd0Lx
         zt1BrxCu4HE5LSoThOjbz+mIf34Viau4aocxkjH9KKuDdYN4XqB51DYzWimHY0o2S2
         D8blUU/YQVbXg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        patches@opensource.cirrus.com, Bernard Zhao <bernard@vivo.com>,
        James Schulman <james.schulman@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>
In-Reply-To: <20211206021100.321170-1-bernard@vivo.com>
References: <20211206021100.321170-1-bernard@vivo.com>
Subject: Re: [PATCH] sound/soc: remove useless bool conversion to bool variable
Message-Id: <163881364602.2769299.15385594323166864561.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2021 18:11:00 -0800, Bernard Zhao wrote:
> This patch remove useless bool conversion to bool variable
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound/soc: remove useless bool conversion to bool variable
      commit: e733ab7e3e5dc1bf7d34e050e839fc902ce7ff98

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
