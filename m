Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335ED4A047C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351805AbiA1XrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347866AbiA1XrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D9C06174A;
        Fri, 28 Jan 2022 15:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA17961F31;
        Fri, 28 Jan 2022 23:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02819C340E7;
        Fri, 28 Jan 2022 23:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413630;
        bh=iNytjglSwIU8s0+h6erELVVSV91M1C1VRXtxDVxTAac=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s4r58rKCpAZku+KAwDpt6mdrvCK13XEAitBqpT9R3cb3LDZy7wri6BuXyPHq3s81o
         x2kOReJ4kjwUQ4PuJe6GxOVGwvzs9tSUdwROMoXFAFdz4nPX4LRtt9pPZPcKoZEJUy
         jI+AamI5iB8S2eY+6YnYWM9yKQ2qrwA20iHpIeYyeRZC6f3CVBbmqPaL6GvqLXpzop
         q7jQ18fhWalMot6OvOHphHHTdfL7DizgqBvB/0ALIXc/MaZJgSkixrD8S1kZ/1s8L0
         KGKeJBTiPgNHfo33AXlecs0Keng1mMlUzjWlCoarbMeScwpT3/AEFW2LcN+quFJMVg
         0j581gynUOX8A==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <1b14e4ce91a33c16b2c655389c728071a9c9aa2e.1641643601.git.christophe.jaillet@wanadoo.fr>
References: <1b14e4ce91a33c16b2c655389c728071a9c9aa2e.1641643601.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: qcom: geni: Simplify DMA setting
Message-Id: <164341362873.694916.2694684212503292812.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 23:47:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 13:07:54 +0100, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] spi: qcom: geni: Simplify DMA setting
      commit: bef8c5fdf50b573351571e94525800c41d9830f2

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
