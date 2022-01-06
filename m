Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26FA486B16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiAFU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiAFU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3997BC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:28:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB87C61CF3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074E9C36AED;
        Thu,  6 Jan 2022 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500890;
        bh=AAcqZiHkbGXIszcYuW9CrI5KI51itS0JI9XIaGI3/R0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QlSrKt2PXNHMmqFbLpaqXkS5xUHppUORFKOzb21q2zpPlZoUNEeiw5C0M1Cq5MfRj
         sDOmLa4WOfx9rdqQzURh5YpJmw5bURozKKiXH777FAnBg6nteGLoq8rdw1mX3YmZPU
         4tcPFI63u/ThxbzKpWn6qrI0NWTUWjJrYez0ZoOIQbivLvqV3KzORf3cZnGcsX2i4v
         Q5ZwA18cvK+jJ3UCquSKdwmfDpbhPpTUsJZ6OHtqWblVKhX+tRAxIgXTif/HfS3tTW
         Cxe4EUimM9UyEBn1idRTE9EykQQDpCbch8Z3mAbVu7wVxYVVYrTEOngcIspndwhxCU
         CAS64mIO7xoJQ==
From:   Mark Brown <broonie@kernel.org>
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220106092847.357035-1-qhjin.dev@gmail.com>
References: <20220106092847.357035-1-qhjin.dev@gmail.com>
Subject: Re: [PATCH] ASoC: topology: Fix typo
Message-Id: <164150088874.2243486.7338777476299923707.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 17:28:47 +0800, Qinghua Jin wrote:
> change 'postion' to 'position'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: Fix typo
      commit: 00ac838924f73b51e82994c7fc870f0a994e4d34

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
