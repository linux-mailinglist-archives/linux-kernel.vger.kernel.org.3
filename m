Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D34CAAFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiCBRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243589AbiCBRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37445A9E1E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:01:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C932C61922
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227A3C340F4;
        Wed,  2 Mar 2022 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240461;
        bh=y+uH68d5vOrwOdfWEH+3AUW1R2sFaFUxb00XYMAIJbs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PD046Pi2CB9w8aa3ZwREtbhdUmxerhXJ5fRlQd9Qvrc8oWXhfucHYcdH4ekUar4Xg
         L6HIkrPfFeCfiU3RmfpDNZFK9slcTTQwKCKM8S3tipuR0WpyGLzajJw8I+D1775vg8
         TahVq0a3LkOgP0I00qSdukWY+0Fs6cT/zPtKZ4thLNA53Otu5mZteY5UJPj1PoUyv5
         Mk5/TwywvIv7K4eHtpn/pC0UkdQi3rnjN5W5cp30vT+1N+Ve92Kl8RzcXuerek6O+5
         G8ppwQAO8emEBLAqQE9tSqGiKBPRk6eE/MZodBYtsbYCRRnCUhozkjuZdyNEpgx2uA
         Of0tBKjjgUxSg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, codrin.ciubotariu@microchip.com,
        perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        claudiu.beznea@microchip.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220301090637.3776558-1-jiasheng@iscas.ac.cn>
References: <20220301090637.3776558-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Handle errors for clk_enable
Message-Id: <164624045886.1145067.17267254890476226513.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:00:58 +0000
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

On Tue, 1 Mar 2022 17:06:37 +0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it and return error if fals.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel_ssc_dai: Handle errors for clk_enable
      commit: f9e2ca0640e59d19af0ff285ee5591ed39069b09

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
