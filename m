Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7454317C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbiFHNfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiFHNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E0B5786;
        Wed,  8 Jun 2022 06:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B9A261AC2;
        Wed,  8 Jun 2022 13:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE5C3411D;
        Wed,  8 Jun 2022 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654695324;
        bh=5LB/laBhD+UgSSOr7WRcH6UEhfeHkVEIj7KyPjpj7bk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hEdu1RTA30wC/gVRvrUhamV4CIrMaI7UIJc2NGAqmGgsT6dbAjDo4FBPJFL+b+/D8
         ZJeBpPbyJkpirCUplI61/Gq1yjZHZG4T5C+bCPyeGkGggfU/0M5VKj8E8Z7vQxDLAj
         Ji90W1x9PiwNLAiSlagnIz/Z44sWRwPGDOs7wgOvqFrzAZ5kDqulANOtym3pL7fQwd
         EFgw/Zk0iwP9DDGNfAEwwBWMsP8Mx21B6nLRwN9wUvrBBirQZkQO45yLF+wNTvd78t
         QCXWFe0ImNoRz81zN2mnXF3xtLYcoTV46kHQs4fH+PW2JMJaUb/CSMPI4miSidZAbC
         4bn+/O3h0XkDw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jiaxin.yu@mediatek.com, angelogioacchino.delregno@collabora.com,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        Colin Ian King <colin.king@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220608082338.2083456-1-colin.i.king@gmail.com>
References: <20220608082338.2083456-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: mediatek: mt8186: Fix a handful of spelling mistakes
Message-Id: <165469532211.615471.3502999805996832817.b4-ty@kernel.org>
Date:   Wed, 08 Jun 2022 14:35:22 +0100
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

On Wed, 8 Jun 2022 09:23:38 +0100, Colin Ian King wrote:
> There are several spelling mistakes in dev_err messages. Fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Fix a handful of spelling mistakes
      commit: b09654e39c89a86680528345f3a95b832236ee82

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
