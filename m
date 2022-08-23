Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8F59ECB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiHWTrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiHWTqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4315D4F6C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 451D7B82061
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D17C43470;
        Tue, 23 Aug 2022 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280608;
        bh=cs17o2i+l63HI0ig2H81rSYNYdqBTrrXaJ5UfzE3tPc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gegl/xff6oBa1d0RalUiCoq2qAl+HPe9CyA9nd/UG7QePRTIknGOT3k4AjlyiZ32y
         2R3nsWxlw8i+Iqlnn2fVIAiPTAHl3dUnW2HWx/i7n/KBFWyT4RaIE40VUdftjNlnOJ
         yEqfzL/mjGr3IbqSG3gJ0S+unCR1frZsQVtZqYpaEImQpJPbnNPaA+pDQ6GbkzJeL7
         BPKTkD6TiH7CIXMz7mjYOaQeQTYkvikFmFV2O4d/XkxlxAAT6z0SaS9XIHecFgqDQK
         XVHahS97Iw1Mt8VPBaf7ElESu2yPUJ7U1Lvgmm5Ytpoy1oRWQMv3paz7CH+eD+VnId
         D7K5e8AdNPuxg==
From:   Mark Brown <broonie@kernel.org>
To:     angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        Chunxu Li <chunxu.li@mediatek.com>, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, jiaxin.yu@mediatek.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220823090735.12176-1-chunxu.li@mediatek.com>
References: <20220823090735.12176-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: rename sound card name
Message-Id: <166128060567.1031684.10706581523547029443.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:50:05 +0100
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

On Tue, 23 Aug 2022 17:07:35 +0800, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> The field 'topology_shortname' in 'snd_soc_card' is defined as char[32],
> Current card name will be truncated when SOF is enabled, so rename the
> sound card name.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: rename sound card name
      commit: e8ee449bd7a45e871fc84fe51c773f7a6e68a02f

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
