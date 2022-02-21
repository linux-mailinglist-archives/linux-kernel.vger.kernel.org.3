Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932BE4BDDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379076AbiBUPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:24:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379062AbiBUPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:24:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623751DA7C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:24:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BC18B80E9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13CEC340E9;
        Mon, 21 Feb 2022 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457063;
        bh=vfiV1Qm1/MHU0lksy3rapa4k1HrN7kyCz4nC8r4epk0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JF/QiYigsSz+pDmwfxF75oFVURELZH86roMYRIxPV2sXjLtCr8j7QaJ+DYY262j71
         N5G4zXCg6UYzFKY/S7tD/bO5roVrmGYUN17dYEaOORamn/93HQr9WCBjGcAQy25wm4
         74HVL4u9SWjnMCo0yaJ7EpBzoidHCyGnCpf6pYj5guyRmx9rveRWzeK/lmNYZhFyJZ
         J9mCNS3pHnDNpB8jx3bSEGOg/DssqZxVGNeayKqcObShy3ycFAfX+M3OO4ga1Q+yYS
         Xsx8vOW1g/kUMTkcAIXceXoHyTJ8iY/UunYYno0cFj+Gj4znXpnjsrTERBXCKcOHFJ
         G78z2xTWfEH8A==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, matthias.bgg@gmail.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     yc.hung@mediatek.com, linux-mediatek@lists.infradead.org,
        bicycle.tsai@mediatek.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220221055716.18580-1-trevor.wu@mediatek.com>
References: <20220221055716.18580-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: enable apll tuner
Message-Id: <164545706169.730905.15839904852131851975.b4-ty@kernel.org>
Date:   Mon, 21 Feb 2022 15:24:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 13:57:16 +0800, Trevor Wu wrote:
> Normally, the clock source of audio module is either 26M or APLL1/APLL2,
> but APLL1/APLL2 are not the multiple of 26M.
> 
> In the patch, APLL1 and APLL2 tuners are enabled to handle sample rate
> mismatch when the data path crosses two different clock domains.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: enable apll tuner
      commit: ff5a90173d981934e1134d28af3625acaab01d80

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
