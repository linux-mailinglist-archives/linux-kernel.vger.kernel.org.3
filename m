Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E048659F86B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiHXLMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHXLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD46716D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157436192C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6E5C433D6;
        Wed, 24 Aug 2022 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661339548;
        bh=OGlg8pv6kHT4dTZmIiN7JaN/Td1DIt3ykmROSVhjXKk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R89AQjm5QIFEy1m4KLw/y3y2fnUtsahYYAiDRrKZ7ZVutepzYsjI3j649BIhmpVt6
         BIWFJ24zWf8uKJTwO1LANI064i3Q62jQ+yYvw/u/dnBJKdhi5e9QydoifyCwe/MjHM
         0ZVAG30iOKEHOZovM7etDo7b/5+D6FUkhYJ6YFS+7ltBW9GEgC7dxVTEOxHr6NBk5l
         EVmUTe5SOqjkkKpguYiDGPkIu3jt7uEhMNl09oAVmExm700bo6jZGgahl7SyVHDnNW
         +J3qiIHFrMv7UBLBAOjdyFF6h+h2kufzi4Qm5U2kc1FrbqERx9edy/uS/1BORps4Ju
         WAy5d2T1nRQfw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, perex@perex.cz, Xiubo.Lee@gmail.com,
        lgirdwood@gmail.com, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        festevam@gmail.com, tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1659681926-13493-1-git-send-email-shengjiu.wang@nxp.com>
References: <1659681926-13493-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Update slots number according to bclk_ratio
Message-Id: <166133954610.17904.8655688757494279362.b4-ty@kernel.org>
Date:   Wed, 24 Aug 2022 12:12:26 +0100
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

On Fri, 5 Aug 2022 14:45:26 +0800, Shengjiu Wang wrote:
> The bclk_ratio is set by .set_bclk_ratio API.
> bclk_ratio = slots * slot_width
> So if slots is not set by .set_tdm_slot, then it can be calculated
> by bclk_ratio.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Update slots number according to bclk_ratio
      commit: 837b40293de66a5b96f883f540512ec5c3867610

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
