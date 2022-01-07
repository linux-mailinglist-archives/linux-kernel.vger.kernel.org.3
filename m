Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56EB487C21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiAGSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:25:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38916 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiAGSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:25:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1794461FC5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 18:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0397C36AE0;
        Fri,  7 Jan 2022 18:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641579914;
        bh=boy129E9PdA7n6s3xoz7akFRvP4uixNAw6b4IO95Srg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=muTAdRWu/3QtlS0GIUJl5RULWo4aakF7LypM2Rtmc5Zr3Lv250zv0IPwOiQGcc/j7
         e3wCoIDox/kEpu2CKB04XSQh6VHi6yO3Y7DmT5n4Q8HBfAp3TQvk8CAeGol44oosVZ
         mkIFAISH9eBe+Zh0Q767Ooc3YcWTzH0IZsk7G8uOszCOpLykAzAltWH9DbsMFFP/Dh
         +kXZ812SOOlNqgv68z6kCpulp9Wr9pDP/KbwQi5Lbs0AJgv9q0uP30ZnQrmP8fRxcD
         7YFCQ0wwc+e6q6fV+bKZx1XtvubjQHVTPQzvWZav3xoYYTyzOW73BAi1MGBkNPM2rd
         1+EXQe4/06J1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, matthias.schiffer@ew.tq-group.com,
        Fabio Estevam <festevam@denx.de>
In-Reply-To: <20220107163307.335404-1-festevam@gmail.com>
References: <20220107163307.335404-1-festevam@gmail.com>
Subject: Re: [PATCH v3] regmap: Call regmap_debugfs_exit() prior to _init()
Message-Id: <164157991337.718321.10584300077901907830.b4-ty@kernel.org>
Date:   Fri, 07 Jan 2022 18:25:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 13:33:07 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit cffa4b2122f5 ("regmap: debugfs: Fix a memory leak when
> calling regmap_attach_dev"), the following debugfs error is seen
> on i.MX boards:
> 
> debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' already present!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Call regmap_debugfs_exit() prior to _init()
      commit: 530792efa6cb86f5612ff093333fec735793b582

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
