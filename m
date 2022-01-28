Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE749FD4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349803AbiA1P6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiA1P6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7152EC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:58:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EEF261EB9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E8EC340E0;
        Fri, 28 Jan 2022 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385519;
        bh=y+ep09zR78q8G5W3BKI9hlMB9ZdPXwl1deXwNREaBjg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Wu81xjVbgl73yv/V4mDC3V3PuR8qQYuzzjylEp38xlv2qrErClVSgwuMz10fVBlXA
         /q4MkSoutyj6IwUtimsTNh6ZKQpDIdnpZrtDuAi87mO3vNNBHML4+Q6/WjGDx+Qkv5
         eI86YDHoaeAwriNILRTvFIXqmbwWVpOR79WTjMv6BIcHIMZ2lhK3PAQeBEkuDkN6Ly
         GdxeRsIIS1EHjwiSdAjxMjA6/hK82bfELnZmHuJLzsK/4RmeNZsWS+abbASI7L7haE
         O7g3lcwr0pNuznJRIDLOX2kzrxWvYbOpPSiVqvoCRTsfDYH1MzUXqnWq0huyHebe+3
         TViyzTt5biheQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Eric Millbrandt <emillbrandt@dekaresearch.com>,
        Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220127131336.30214-1-linmq006@gmail.com>
References: <YfFFWSVgnbL6ETxo@sirena.org.uk> <20220127131336.30214-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl: Add missing error handling in pcm030_fabric_probe
Message-Id: <164338551779.1711238.6752613705973183003.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 13:13:34 +0000, Miaoqian Lin wrote:
> Add the missing platform_device_put() and platform_device_del()
> before return from pcm030_fabric_probe in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: fsl: Add missing error handling in pcm030_fabric_probe
      commit: fb25621da5702c104ce0a48de5b174ced09e5b4e

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
