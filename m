Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88A59ECB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiHWTrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiHWTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F34D1E14
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 141B561704
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92FFC433C1;
        Tue, 23 Aug 2022 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280605;
        bh=mtEmXoG1/qwtxZCLtpWfBQdyoqhvKwZ1HGbxl8n0VV4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mP9deo43+f6dw1Q3G2HmJkMvJ9R7mrHyPm8bllirJQoA6bgw/Gri1EXTSDz0QqPhe
         hwsZd6c9WiabbUhdQbMJkNMNXAPhHpEVEnowsmEqTNFoyGo2tQ40CQmB/M5ccLLI8X
         QV28o3A21I/GYSkYmIdTRmvLQJPGaU4DB+zSsvyI0hj51BZE2glDe3h3+rx999f99N
         ajeG7ZPVlZ33SSKG5SQztcpftURZdIkQ5tKtMucloAJiamBQSnhGqdK6jbQXcodpda
         fkrDMx5aMt14gG+b5Qr8r1RmthU1jeLOweT4P6apqPh7PrjajbbCDOAS6kSpXshoU+
         Eb6uQAJToLKVg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, cgel.zte@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, claudiu.beznea@microchip.com,
        tiwai@suse.com, lgirdwood@gmail.com,
        Zeal Robot <zealci@zte.com.cn>,
        codrin.ciubotariu@microchip.com, alexandre.belloni@bootlin.com,
        perex@perex.cz, alsa-devel@alsa-project.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        nicolas.ferre@microchip.com
In-Reply-To: <20220823075335.209072-1-ye.xingchen@zte.com.cn>
References: <20220823075335.209072-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ASoC: atmel_ssc_dai: Remove the unneeded result variable
Message-Id: <166128060268.1031684.14434690087050758502.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:50:02 +0100
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

On Tue, 23 Aug 2022 07:53:35 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value from asoc_ssc_init() directly instead of storing it
> in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel_ssc_dai: Remove the unneeded result variable
      commit: 62bd431bac942c90d908b1681d04f0c577f6c70f

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
