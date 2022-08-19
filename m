Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D059A8C7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiHSWrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiHSWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:47:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC02A10DCD4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74A47B827C7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F755C43147;
        Fri, 19 Aug 2022 22:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660949267;
        bh=gr61zTXhKdKcoL+U9nYufVpT53h0XuUHqgUWQ/ZCDhk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H9LOGmLgCybT/7Njtw0vQgLu4tyWlpZKZpBtljeF1D2v0tJEm64oHQyJ9pKxsXbkm
         8DhQ276M9td/uMBrxJpVUNjfe/aDKnyKbAtPHcWUuTdcp3vse12eRjXX4mLVqDOpkI
         NLUyWC1F1APQlYNXp+HjeF+eGxpMofDvKHM904dkfV0wOqXQ0LG2nbMBJS1rHhvYNu
         0vJ7WrpdzsL+25kJoxuBqUomz+zq91FhP7Z0dQ7KVeNJwJASJotpgny/lP4PiH1Jwx
         EYvI74DbXB92Q7PNOzRFHzWlp/Q7+mjxCXZe0SuDEApcAuQWCXWBBpBFG8CSucvDqm
         P2y4aBOPMaa2g==
From:   Mark Brown <broonie@kernel.org>
To:     Chunxu Li <chunxu.li@mediatek.com>,
        angelogioacchino.delregno@collabora.com, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com,
        matthias.bgg@gmail.com, jiaxin.yu@mediatek.com, tzungbi@google.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818025113.17144-1-chunxu.li@mediatek.com>
References: <20220818025113.17144-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH RESEND 0/3] ASoC: mediatek: support SOF for mt8186
Message-Id: <166094926478.19151.18027354027835618602.b4-ty@kernel.org>
Date:   Fri, 19 Aug 2022 23:47:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 10:51:10 +0800, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> In these patches, we add SOF support for mt8186 which have HiFi5 DSP
> inside.
> 
> Chunxu Li (3):
>   ASoC: mediatek: mt8186: support DSP downlink
>   ASoC: mediatek: mt8186: add SOF support on
>     mt8186-mt6366-rt1019-rt5682s
>   ASoC: mediatek: mt8186: add SOF support on
>     mt8186-mt6366-da7219-max98357
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: mediatek: mt8186: support DSP downlink
      commit: 3c15abbed0ab99bac2e075ad38d43a7004778e91
[2/3] ASoC: mediatek: mt8186: add SOF support on mt8186-mt6366-rt1019-rt5682s
      commit: 4be34e1b70ac72415a55e02683cd847436424588
[3/3] ASoC: mediatek: mt8186: add SOF support on mt8186-mt6366-da7219-max98357
      commit: 9398381a3904d8849691fb3ec173b48f077c185e

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
