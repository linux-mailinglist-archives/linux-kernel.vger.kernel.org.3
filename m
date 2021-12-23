Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3126847E6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349466AbhLWRRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbhLWRRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:17:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED817C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A5B61F15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 17:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBD5C36AE9;
        Thu, 23 Dec 2021 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640279860;
        bh=hHQknPuicKJvBqSHW3E8clobKgNap3tRvdRIIef0jsg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dSjdxNZx0Rgj0b/ehNm7s6TTXsWhXUq2JXrciJZx3Phr30r1IyUVdXgbMfyaoGvkE
         xotx/A3fqlzLXKEqLuo2zE0dqspY+L9OlXS3zVl0ANTOYwybpezwQNvR3PRAxeKN8q
         kbqM3xVcped70N3g3EzQUsWCsM+uPPlhn1UFVJ3TJjZZ9naI5hRYoWGcG1zqpjeVZz
         a/TN217vh8fVLnAzAVoFoCZmeD9ZPIinG91nFtLqBXv/xvrVzUiyKx0SPGKhzVCnkh
         VKaA9E2os6Y9WEE2wCdrcX4FArGoaPuXiG0zZBNIxnZo859Wr4kIOR3v3GFM5Z63t2
         j9qRfupHeys+A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     ricardw@axis.com
In-Reply-To: <20211223082212.3342184-1-yangyingliang@huawei.com>
References: <20211223082212.3342184-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: codec: tlv320adc3xxx: Fix missing clk_disable_unprepare() on error in adc3xxx_i2c_probe()
Message-Id: <164027985889.1292681.3234889694372986764.b4-ty@kernel.org>
Date:   Thu, 23 Dec 2021 17:17:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2021 16:22:12 +0800, Yang Yingliang wrote:
> Fix the missing clk_disable_unprepare() before return
> from adc3xxx_i2c_probe() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: tlv320adc3xxx: Fix missing clk_disable_unprepare() on error in adc3xxx_i2c_probe()
      commit: 8a2d8e4fed6d5829ec3681af313d63e02bc22dad

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
