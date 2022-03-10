Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB74D47CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbiCJNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCJNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:14:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121D7C792;
        Thu, 10 Mar 2022 05:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C7FEB82618;
        Thu, 10 Mar 2022 13:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDAAC340E8;
        Thu, 10 Mar 2022 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646918028;
        bh=hLAwTLXVIMcSoOs+DZE5AFrkLCUXZidEtWnQvIrw/tU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=n6ZAn42uSq803NRWqlQCNO1MoJy7a11DC3hZHbv1j6suwf4QD3Ye56cQcpFoikUtt
         vkWv2HNPhmZ0FZEnvA5Tkd2QGAVXCunRFU23qWBEDXEoH9Noi5r/29OPlrZ+KK4Y/m
         shqQA4BDUnllAv7q6k48yn/G/KG6zvyi20Ot4lL3GwuT2rYnvd/9PcxckR9WZRJ1cZ
         1hrUqAOhTn2SlOnP0xNqI3s4DNyLkwA4rOpOb5V2a5AxBlLsRZhGsxOw4JFz3kPxPi
         3j1IReqmSFNZyfz56xywDTUA9CY/Vmxp2L3d82UZgMIXELuTTO2Si9Hr52vbfkCs2H
         rrrtQTMzSlwHQ==
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        alsa-devel@alsa-project.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220309164116.178685-1-colin.i.king@gmail.com>
References: <20220309164116.178685-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: atmel: mchp-pdmc: Fix spelling mistake "microchopnes" -> "microphones"
Message-Id: <164691802584.2018412.7073594890516356081.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 13:13:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 16:41:16 +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_info message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: Fix spelling mistake "microchopnes" -> "microphones"
      commit: 6b6bb5e26222021abe1c5360f43b4c2ff1dd012f

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
