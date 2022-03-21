Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED04E25E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347064AbiCUMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347048AbiCUMCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:02:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62B532F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C800DCE13B1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E71C340E8;
        Mon, 21 Mar 2022 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647864037;
        bh=x7RIt4mLNf8mNberwc71l5fBa0XC8ugDp4MrJBP6Nek=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xa6xRMwoEmgjWxCWOEJdmmp7L8ZGpxrrK/IlLjLMCpZPbOecdMtKsY4ttW5bkyiQn
         RQdQv+QdS/hH+Aa4AWx213Q864twi8Ro6gvE6BX1ttwwdPhY3CO+n685a17NeHdXJb
         r4n7YMUlYiqSq4O6IGLvRKMpHHAgTmgI5N4PzK+fNfeh4BtsVZWG+/n9ODaVQ5RkdU
         ftCJHj+SPsQQWa/J28XMkReAUUpgUaXPsRdx74w0qkQSPZTcOO7SicAeBXGbGliEZj
         A1elc8hIO0p5rT5DdSpiLF6IBT+FCWBMHYDjMzNVotBhhHO7pcD2qt3VnOEYimFV/p
         DKAYtWS5X3zPw==
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        trevor.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org,
        angelogioacchino.delregno@collabora.com, tzungbi@google.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220319120325.11882-1-jiaxin.yu@mediatek.com>
References: <20220319120325.11882-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt6358: add missing EXPORT_SYMBOLs
Message-Id: <164786403520.879132.12234155577870165792.b4-ty@kernel.org>
Date:   Mon, 21 Mar 2022 12:00:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 20:03:25 +0800, Jiaxin Yu wrote:
> Fixes the following build errors when mt6358 is configured as module:
> 
> >> ERROR: modpost: "mt6358_set_mtkaif_protocol"
> >> [sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.ko] undefined!
> >> ERROR: modpost: "mt6358_set_mtkaif_protocol"
> >> [sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.ko] undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: mediatek: mt6358: add missing EXPORT_SYMBOLs
      commit: a7663c89f4193dbf717572e46e5a3251940dbdc8

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
