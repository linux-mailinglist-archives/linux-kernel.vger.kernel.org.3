Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00D56020B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiF2OGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiF2OGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC32A40E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A9261904
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FBFC341CB;
        Wed, 29 Jun 2022 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511559;
        bh=ZdjWjB54cbHRycxjLjITQrOn43M908WL8or1/9HBUP4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fU2BuCn79mheeDdDSP3MX6LYQ+5ckPhDuYaqjp8b1HSv4cqiAXAJNAeTOa9TyAs6K
         Q3iRARr/muciSSJsFU7N7vAOGSd/FgJB5CqSYLyV26WGaGpUJxPbz1L06vtQyqiCwv
         TVQ3NNbgZM84meUWk09BU+U+4oH39ksuPITo7PGRDqG//Dk6hw/3dUXx7S1RhBhjLk
         Mos9iiiXXADkMbS21xZIL3BCJyIRqkOeafCV6NfGDuC3kw4qzAyc7+hRq1ztBH9hEL
         nhlZeS3sWm1R+6U8JgJXlLy3x6ZqG9/ZsBHhKBsbbAJGf3dqH9pZ/czKHtNKl66bSy
         +ffyJlifgrTrw==
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, judyhsiao@chromium.org
Cc:     alsa-devel@alsa-project.org, wenst@chromium.org,
        Rob Herring <robh+dt@kernel.org>, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220629080345.2427872-1-judyhsiao@chromium.org>
References: <20220629080345.2427872-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v1] ASoC: rockchip: i2s: Fix the debug level on missing pinctrl
Message-Id: <165651155754.1437597.8598340692080624115.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:05:57 +0100
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

On Wed, 29 Jun 2022 08:03:45 +0000, Judy Hsiao wrote:
> Use dev_dbg on missing i2s->pinctrl as the pinctrl property is optional.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: Fix the debug level on missing pinctrl
      commit: 48620f17e071060092197a09663a1c1fe6207829

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
