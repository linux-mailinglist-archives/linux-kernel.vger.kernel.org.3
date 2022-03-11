Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF474D6963
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiCKUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351199AbiCKUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:23:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6F66F9A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEA98B82CFA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 20:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550CCC340EC;
        Fri, 11 Mar 2022 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647030164;
        bh=0Q2U7gB1v+g5WWvIldVX0hUeSGrWPkJ2QT7hjn6A0Yo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QrVweqGe+GyInwxsZiO6a4v37m+fStgNRwpgwYYe+wdYOpr1QEr16v3JBShPhcu5W
         p5gWAnI70O7KmRuOEcFUAwUyAdWVHSPo55JRgeKkPx8o+192p2lGZzVufBe6r3oxx+
         Kne4VEGgJsx0iz9PaGLGyiWFoBSplemkoNSdyQRy5DUauhKU3PS/GWroxfJ9eJOSqp
         QPV1tOfIGrfYFouBVYCnwcg0QKAALVZRhJEEh15pIS39J/inyGYGt+JqSMAncpeZ+y
         4SnLMiQJapma1nhXZj2Z2Av+xjEY1L13ioaoICTX2PxFF5grbbXdfkTKakC8JWapVc
         Jb2xQlBUVGPlQ==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, ludovic.desroches@microchip.com, tiwai@suse.com,
        alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
        nicolas.ferre@microchip.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        codrin.ciubotariu@microchip.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220311112818.1482372-1-claudiu.beznea@microchip.com>
References: <20220311112818.1482372-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] ASoC: mchp-spdifrx: fix typo
Message-Id: <164703016207.264137.16463689754378807280.b4-ty@kernel.org>
Date:   Fri, 11 Mar 2022 20:22:42 +0000
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

On Fri, 11 Mar 2022 13:28:18 +0200, Claudiu Beznea wrote:
> Fix typo in log describing failure of devm_snd_dmaengine_pcm_register().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdifrx: fix typo
      commit: 886e09c77d2b48559d26928a5705a20ef3ac117d

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
