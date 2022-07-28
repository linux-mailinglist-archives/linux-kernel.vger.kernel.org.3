Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35925835F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiG1AWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiG1AWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCDD4B4BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADE06176B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D99C433D6;
        Thu, 28 Jul 2022 00:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658967740;
        bh=HxiryJ8L9JZnkbc4LNGwPNPSKfAYMYLquH7AyHXAAYs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T73HDmQuknGRE227L8b0rFz7NW90PE9+O8+rrub5aPfbZZUXoQ7lE0dA8N3vwBWE8
         ZEbHwIVXh1AiNCcJGr+bk8Gqg4Ag9BD9Ng+NnJwrd6O9NT776CTOgX0/IHnrojTWQh
         fh8F4emFryx1afKSQ5EUnvNWvKB7pUaSGc0LM6nqw5qdEnsZPrdlwosj2EeceaRrDU
         Uk5XUbu+DbSg/9xhsA6j6mtidObqDYUvig3gD6QExQPdndHBJX2RVYmBC/Z73IdGdi
         9iLl8tdzXuGSyvpqYDqizv8h8PQb+KvmdTP1S4Gydsgetv7eyaCE1zpSVSWUCYvMQw
         rfQJJ8GeQH8fw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, lgirdwood@gmail.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220727090814.2446111-1-claudiu.beznea@microchip.com>
References: <20220727090814.2446111-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3 0/2] ASoC: atmel: one fix and one cleanup
Message-Id: <165896773851.4001859.16860255721720252799.b4-ty@kernel.org>
Date:   Thu, 28 Jul 2022 01:22:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d1cc2
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 12:08:12 +0300, Claudiu Beznea wrote:
> The series adds one fix for mchp-spdifrx and one cleanups for
> mchp-spdifrx and mchp-spdifrx drivers.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v3:
> - changed cover letter title s/few/one, s/cleanups/cleanup
> - fix compilation error and warnings
> - keep only patch 1/5 and patch 3/5 from previous version as the rest
>   of them were integrated
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mchp-spdifrx: disable end of block interrupt on failures
      commit: 768ac4f12ca0fda935f58eb8c5120e9d795bc6e3
[2/2] ASoC: mchp-spdiftx: remove references to mchp_i2s_caps
      commit: 403fcb5118a0f4091001a537e76923031fb45eaf

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
