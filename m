Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59464CAAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiCBRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiCBRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:01:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8192D02
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60BDC618FF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570ECC004E1;
        Wed,  2 Mar 2022 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240454;
        bh=03m/Ug+M2jkhIYNLtlMDdUeKAjuUOGD+JbkbKcwu9f4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N0oOgQcStSStcr0Wfky2G20L6W1S9Ne+gXlMYJ08y3gfhKDsW+MXgL7AVugz7foJs
         obmuq5YXA0aMN8CotjS92NxBF4sK9WFPRLyT32nIdwrHHNq6UvzZDIu7evboy0YIR9
         bZ5J8gUMuDEcItYcSaro5RfJrMNhZ6NBSjqvgr5l8Fyk9UxYsnKv6S9egG+ZPkFTmH
         Lix7K1WxJFv+8RWxy/rMIwSAXUJ4J5ula/zYxTg5LOXCVofHwCTOF5or42UCBp74oO
         1q3zoLBkPLNZ8bGT9lkcrNFHTjBBL/HSHszgTnjCasfiA9R/vxyZRfagY+AI6o1naQ
         a1MplYzy/xLIQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-imx@nxp.com, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, shawnguo@kernel.org, kernel@pengutronix.de,
        s.hauer@pengutronix.de, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        festevam@gmail.com, Julia.Lawall@inria.fr
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220301081717.3727190-1-jiasheng@iscas.ac.cn>
References: <20220301081717.3727190-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: mxs-saif: Handle errors for clk_enable
Message-Id: <164624045208.1145067.12901529281090150709.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:00:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 16:17:17 +0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it, like mxs_saif_trigger().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mxs-saif: Handle errors for clk_enable
      commit: 2ecf362d220317debf5da376e0390e9f7a3f7b29

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
