Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760315A10F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiHYMrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiHYMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C913F29
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C059661C43
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D60BC433D6;
        Thu, 25 Aug 2022 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661431512;
        bh=pOtQJt9kEx8p4pkA3MWq57CKBS+/4IwMA0AR5ke4v1I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lLxYM08fBDiqRFJl+zb/yqfIPSKEf49j9HQmj4Z9tJE3OGdfTXFYWLu7FXCPzxeDy
         oK5AqfeNt0cm9eak1kACO5Koe0/tw4RgysM9ymQU1Qi1GyW3xTCth170Hb3n9P/p1/
         dSJWO9Sshl0uaCsBvMdP2fJPjBsz28lCINbX1EZJ31pSYtUn8/Gjm/lKdebdHd9QsC
         Va1KwNKEBRBl9IutX0nwRB/oYxzZX0voLVYmW089GdfU39B+dndwyhSuCLBXZJ5v7G
         huP+/N2uTUj0g80haKehKDsRhENjpkmm7WPV7oempVCt2icrrKv76Afkx/GhyMOIot
         OZH+Y1hwQ6sSg==
From:   Mark Brown <broonie@kernel.org>
To:     peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com,
        Chunxu Li <chunxu.li@mediatek.com>, daniel.baluta@nxp.com,
        angelogioacchino.delregno@collabora.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        project_global_chrome_upstream_group@mediatek.com,
        yc.hung@mediatek.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220825065411.31279-1-chunxu.li@mediatek.com>
References: <20220825065411.31279-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH 0/3] ASoC: SOF: mediatek: update SOF driver for mt8186
Message-Id: <166143150803.98448.11310238712995264626.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 13:45:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 14:54:08 +0800, Chunxu Li wrote:
> In these patches, we update SOF driver for mt8186
> 
> Chunxu Li (3):
>   ASoC: SOF: mediatek: Add dai driver for mt8186
>   ASoC: SOF: mediatek: add snd_sof_dsp_ops callbacks for pcm and mail
>     box
>   ASoC: SOF: mediatek: Use generic implementation for .ipc_msg_data
>     field
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: mediatek: Add dai driver for mt8186
      commit: f3b75e9b56780e3bfaa910e560cb9ba4d8f38e53
[2/3] ASoC: SOF: mediatek: add snd_sof_dsp_ops callbacks for pcm and mail box
      commit: 82e93430e0ad13cc31e411cfa575e63118bb0ed4
[3/3] ASoC: SOF: mediatek: Use generic implementation for .ipc_msg_data field
      commit: 059846071f468da8389dcb8b8bbb38a781b02955

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
