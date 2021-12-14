Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED4474362
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhLNNZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhLNNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:25:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C9FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 05:25:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5434B817F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5368C34601;
        Tue, 14 Dec 2021 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488324;
        bh=Kfpg8F/M83/BGQDlYPcnf3fKEKL4vgzfFaEYnWCRd5M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WxUOtrNoJsZzUDkAZoEnCQpr8bYiQ7GZi5DCSyW5ApQv+Jk5QJGEkfyhaWJtC9/RC
         0fbXIU7EaEdQE0YHC0TXJk6+bcyP4xpvzuuL7PPMjqAgiTd97JhGUsoDIf2GziwL8V
         RADhkcRjbvjXYQmQ0+57gxkRRP19kibc2bDQGLeZ9ZzKPE0MYshi12g5WJvZQs2rGp
         o3V8+/Xi0B6/064bZ0FC2JjaOBbC0w0fRuENKuUuVKT44Dw3jvoLli8ESaMJgLbh92
         NXcIH97XXqqQbVZyjZO34RESiOfMfh5H+BGJUIM8SYxMt4Ne87OUH98VXvE9RDOopo
         VjvAEHH8ws6xg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     tzungbi@google.com, kernel test robot <lkp@intel.com>,
        yc.hung@mediatek.com, trevor.wu@mediatek.com
In-Reply-To: <20211209073224.21793-1-jiaxin.yu@mediatek.com>
References: <20211209073224.21793-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: assign correct type to argument
Message-Id: <163948832239.2865729.5262628793021796967.b4-ty@kernel.org>
Date:   Tue, 14 Dec 2021 13:25:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 15:32:24 +0800, Jiaxin Yu wrote:
> Fix the following sparse warning: (new ones prefixed by >>)
> >> sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33:
>      sparse: sparse: incorrect type in argument 3 (different base types)
>    sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
>      expected unsigned int to
>    sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
>      got restricted snd_pcm_format_t [usertype]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: assign correct type to argument
      commit: 03c2192ab636987db72e99f319a942cc4f3cb352

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
