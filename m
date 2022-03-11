Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9F94D6965
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351212AbiCKUYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348009AbiCKUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:24:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C259811A36;
        Fri, 11 Mar 2022 12:22:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DDD561F75;
        Fri, 11 Mar 2022 20:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64346C340E9;
        Fri, 11 Mar 2022 20:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647030176;
        bh=hGX9MsfyNkk7q3/BlkAl2hVFK1xekhCsP3ahf/1eBZ0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FZzy1vAB32AauL3AM70HR1hnX/R8uBfnFcrLuxNFJ4LdBrP9hRWNqjgcNYG1J910+
         kcAri5HLRJBA8JFJ9aCMIdsF98nNIGg/RNiNxDDK3Z8os9YY6XwQEpWFDpqJz3kIRk
         pUpK/bxQXOMUiu27vQt6Ob4btlk81yQIU6W52k4pbNM0cF9KK5+oSp/hCTs0DAHDN6
         7HIObJDUhp6ALhn1Evz9oSegoPYoXaJuE/PYWY8Fbghhng20eSNEsTTaPvwQi33uhx
         hRssiLji+0majkXHLAHJ2cdqbsGHjevGMKK7ZXdAzdgSmuvIyNDdNg13jwFW8lB2LM
         wmkX3ROltPnbQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220309171847.5345-1-singh.kuldeep87k@gmail.com>
References: <20220309171847.5345-1-singh.kuldeep87k@gmail.com>
Subject: Re: [PATCH v3] spi: Update clock-names property for arm pl022
Message-Id: <164703017513.264521.4229870520812086440.b4-ty@kernel.org>
Date:   Fri, 11 Mar 2022 20:22:55 +0000
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

On Wed, 9 Mar 2022 22:48:47 +0530, Kuldeep Singh wrote:
> PL022 has two input clocks named sspclk and apb_pclk. Current schema
> refers to two notations of sspclk which are indeed same and thus one can
> be dropped. Update clock-names property to reflect the same.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Update clock-names property for arm pl022
      commit: 1889421a891ff439b25495011b8b75f81660abca

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
