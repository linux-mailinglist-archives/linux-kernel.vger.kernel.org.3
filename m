Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746B559ECC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiHWTrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiHWTqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D629D87CA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0843E61716
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87473C433D6;
        Tue, 23 Aug 2022 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280614;
        bh=koJ6rzVdomfaX6woLpwAmnTIiggmEx7bd6R+PBkBeJE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=khbOK72XLBDeOqniHglLFaV9Rzz0QuCWnvInfb0uyGxyUXuf/RCp8P5YfsklJMw4C
         z756LyMUOdLbx0TKYbJbq+EAtASfSMDA5q3TV3qESe+0D8+SedqoZOrg+dpmmJbfbb
         tT6IS3vKh5Tw1malONmOwDlqkpbw68RrlG+tAtRjUOhbgsLYq1zKg/7ygMsxIoO2d0
         hlzoraEm+x/x1KkGuYan1Apc0mu+ZnRGhBC56pBlpikNMEfGgkGEKeL+nT9V2p61TX
         GaPi55rpu705WVW/mkjtvXBA6ItQ7SZhtJZCbk7ipamdTPjUB6dllq6WfPyBleDzjh
         yFh8wx/mM8+iw==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, daniel.baluta@nxp.com,
        angelogioacchino.delregno@collabora.com, lgirdwood@gmail.com,
        Chunxu Li <chunxu.li@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        sound-open-firmware@alsa-project.org, tinghan.shen@mediatek.com,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        yc.hung@mediatek.com
In-Reply-To: <20220805070449.6611-1-chunxu.li@mediatek.com>
References: <20220805070449.6611-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH v2 0/2] Introduce sof_of_machine_select
Message-Id: <166128061023.1031684.5884182401063110421.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:50:10 +0100
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

On Fri, 5 Aug 2022 15:04:47 +0800, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> Change since v1:
>   - remove the callback of_machine_select defined in sof-priv.h
>   - move sof_of_machine_select to common code, and called in
>     sof_machine_check
>   - rename .board field to .compatible in structure snd_sof_of_mach
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Introduce function sof_of_machine_select
      commit: 6ace85b9838dc0162b474dbbbb6b388e7561f6a7
[2/2] ASoC: SOF: mediatek: Add sof_mt8186_machs for mt8186
      commit: 2dec9e09e955dfc4b7843fa4f9c09e7ee8931b1d

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
