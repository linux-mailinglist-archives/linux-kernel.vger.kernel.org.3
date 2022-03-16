Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278294DB971
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358003AbiCPUhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349967AbiCPUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC1D65817
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A13B81A71
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6810BC340E9;
        Wed, 16 Mar 2022 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462945;
        bh=Q9MaDhAnGACCcyapv0JtCCj4Kw8dJ7djLostnoDnvI8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XIU0kiSow2df6hM+NlsEOZz+A1EZQz8rETYeg6bDS7LLYQvNVJ14AU+My4R5XItuF
         j2u55/CvxXdF/siCNnYZTsDtHbj+DyXAWGBD1QEgfXyU83uRbu3nYFphV1wXP3q8u5
         0mhlrhE2G/35AF1ODngY3CS0xY1wDEOJbRtTZt+mYTdmbOWGeLD/PBHAgTq4gncbRP
         OF2FfB7zc63TUa1HvrUKYryl+brgnOF5Y3taOtuvOxl8zXoYc/T+D/YlKxfz7N/s8h
         rIfaSPRXLc1+rI3OouXiG6FNVlxpihw1BAOx++DXsEjI0THvpfbukT1jsCYVLOuCHC
         88COmUasxYLSQ==
From:   Mark Brown <broonie@kernel.org>
To:     xkernel.wang@foxmail.com, tiwai@suse.com, perex@perex.cz
Cc:     s.nawrocki@samsung.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, krzysztof.kozlowski@canonical.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <tencent_EC21778DC383823CBC4069EA9F0B84943905@qq.com>
References: <tencent_EC21778DC383823CBC4069EA9F0B84943905@qq.com>
Subject: Re: [PATCH v2] ASoC: samsung: i2s: check the return value of kstrdup()
Message-Id: <164746294312.1220201.13120834563042031092.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:35:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 18:36:45 +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kstrdup() is a memory allocation function which can return NULL when
> some internal memory errors happen. It is better to check the return
> value of it to catch the error in time.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: i2s: check the return value of kstrdup()
      commit: d39664cb758e9e329ac3ba05bd4f813f928f63c2

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
