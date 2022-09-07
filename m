Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D005B0696
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiIGO34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiIGO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:29:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994FE1A3B5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87E93CE1BDC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D15C433C1;
        Wed,  7 Sep 2022 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662560971;
        bh=JiG4OMVdJz6MGyJ5Eyg3FGUXY+/mdIJYNhGg0aNUHFg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QJV2XHmIRt6pj3UdbrtHmM7FwcxMC+QbMjV1HVM3CYIVcMBKCJ3meDxMza79bGx71
         aha0tSB4pLRxVuS/UjBg7e/uR0+XV9ZRy2/jSl55u9Y8z7FyFaCsZQvCjx6N6ZdcE8
         Kcw0JLQ2JzouI7WR5l2iV61ilvqMd1KzF3l0p/CsnMRF0l6XLkZTJN3b4BMl/C1ERj
         m4QTmjwbFwc8C0RnyxDVw25YE/WfnoVcwITFaIw+77h2aBuusyLiest2ykOvuNFi4E
         SGXzkbW47BP2sHvaHW9hRyKXhPLq5VU5F9zvtnn7CrlhDws4aV+S+x8WzM+K/+omnJ
         8EOtoQ96LqS6w==
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     pierre-louis.bossart@linux.intel.com, yc.hung@mediatek.com,
        ranjani.sridharan@linux.intel.com, Allen-KH.Cheng@mediatek.com,
        trevor.wu@mediatek.com, perex@perex.cz, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, geert@linux-m68k.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com, chunxu.li@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kai.vehmanen@linux.intel.com,
        yung-chuan.liao@linux.intel.com,
        sound-open-firmware@alsa-project.org, kernel@collabora.com,
        peter.ujfalusi@linux.intel.com, wenst@chromium.org,
        tzungbi@google.com, tiwai@suse.com
In-Reply-To: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
References: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 0/5] ASoC: Fixes for MT8195 SOF support
Message-Id: <166256096652.159155.11970501436356826295.b4-ty@kernel.org>
Date:   Wed, 07 Sep 2022 15:29:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 11:27:22 +0200, AngeloGioacchino Del Regno wrote:
> This series fixes Sound Open Firmware support for MT8195 by making
> sure that the sound card driver is actually able to probe and IPC
> can finally happen.
> It is now possible to get DSP support for audio.
> 
> Tested on MT8195 Tomato - Acer Chromebook Spin 513 CP513-2H (Pipewire).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: mediatek: mt8195-mt6359: Properly register sound card for SOF
      commit: 64ec924c781ee846bd469be8d1d6bbed78c0f439
[2/5] ASoC: SOF: mediatek: mt8195: Import namespace SND_SOC_SOF_MTK_COMMON
      commit: 404bec4c8f6c38ae5fa208344f1086d38026e93d
[3/5] ASoC: SOF: mediatek: mt8195: Add mailbox generic callbacks for IPC
      commit: c2186a9b3a98f1ff814996aa52a019158bfad9c9
[4/5] ASoC: SOF: mediatek: mt8195: Add generic pcm_{open,close} callbacks
      commit: cf84edeeb95ee8e76f12bb02a7444876d031bea7
[5/5] ASoC: SOF: mediatek: mt8195: Add devicetree support to select topologies
      commit: 8a7d5d85ed2161869452ddb9ec45345dad665f52

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
