Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E077247F00B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbhLXQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353187AbhLXQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:17:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FEC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 08:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 989A7B82331
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 16:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F5FC36AE8;
        Fri, 24 Dec 2021 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640362649;
        bh=c770Vl0s4K8ne0JvN1d9u+B9NXqvmS0SNJ/Vr5lpXpE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZEHguiC6Sx7jrCAhJzIdc2b9ali2tP+4TU7f9jBubYM0wRTV+5z2WM1d+UdVO+SSM
         4pW7maR7w6UnpSEr5pGdlEcI7kV19acXkdaZ6ur5GPnzaCnsBwQegp5vLvQHOtsezx
         50d8BGJHorLbpnq3Y7QfTbaJBh6een0e4Lf7RQSTZpsb1uBYsf9bJTCGeQ9dqLsVra
         1w+6qTu+nP1SNiNTASOCEP4dyg6JnKwZngEGpDLtacCxpviuFrOk2Ko0k3GpuC8Vxk
         0RkZrccFISvkZh6J+83wizRMFkcpGi0UV4X+FbWDVzSBpeuGIXmQn3BjLB8alJbv6q
         6wjAsYfRYVHhg==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        perex@perex.cz, pulehui@huawei.com,
        kuninori.morimoto.gx@renesas.com, lkp@intel.com,
        linux-mediatek@lists.infradead.org, Zeal Robot <zealci@zte.com.cm>,
        alsa-devel@alsa-project.org, chi.minghao@zte.com.cn,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, srivasam@codeaurora.org,
        matthias.bgg@gmail.com
In-Reply-To: <20211209015707.409870-1-chi.minghao@zte.com.cn>
References: <20211209015707.409870-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] sound:soc:remove unneeded variable
Message-Id: <164036264573.3720027.488082222157598597.b4-ty@kernel.org>
Date:   Fri, 24 Dec 2021 16:17:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 01:57:07 +0000, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
> 
> return value form directly instead of
> taking this in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound:soc:remove unneeded variable
      commit: b2fde4deff854ca7d49ec735a8252d944418b64d

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
