Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E5474364
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhLNNZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhLNNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:25:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD99C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:25:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AF9614ED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10650C34605;
        Tue, 14 Dec 2021 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488327;
        bh=C1uJktXTIMr7sT2GFRLDAAL2YnFQrtakUNIPjjHazus=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pBayhBOI91scR4orTqi8lR9XS5GYX9pBvTo9urfTJAaIPYF3hkmUt2d5VVrmSz9X0
         V4lJohLQjkfw7Zj0jlYRtotFOahoesgLNJhiozUm6YZJMJdv41mUV7gWqSs0Jy9oTK
         jTDv3J2C4csu8xxImqbkCadkQAql+EXOBV+rvvUV+P+LN4NYz4xEpJ0SVCLjWzJ0si
         Y7oh4ILao5VkdyVj+XYV1ISd6c3qjjb02nyWYi2T/jnvKSZ3BVguGAW7Hp+/l6slwu
         qipepkPv3OTBCL/+aQZRFH50jukBBotgzjsAQJJBO0uJ67zsTIu3+KSdHYXENYJG3i
         kKLbZqFUS4gog==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     ranjani.sridharan@linux.intel.com,
        linux-mediatek@lists.infradead.org,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20211209200830.145005-1-daniel.baluta@oss.nxp.com>
References: <20211209200830.145005-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH v2] ASoC: SOF: Remove pm_runtime_put_autosuspend() for SOF OF device
Message-Id: <163948832478.2865729.8112402279770630792.b4-ty@kernel.org>
Date:   Tue, 14 Dec 2021 13:25:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 22:08:30 +0200, Daniel Baluta wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> In SOF OF device, pm_runtime_put_autosuspend() is not
> matching any pm_runtime_get_sync().
> 
> This is imbalanced for PM runtime.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Remove pm_runtime_put_autosuspend() for SOF OF device
      commit: 475b17b4a875ef31246c6a038ee60d5ca4982ea5

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
