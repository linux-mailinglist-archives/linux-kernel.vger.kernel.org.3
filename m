Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12A2559BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiFXOhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiFXOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:36:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC260E1D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D89E0CE2A5A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B398BC34114;
        Fri, 24 Jun 2022 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656081342;
        bh=t/Tf6J/AANuVldAvrbb1l1OA4Ss/PFndiFh59pDsU/o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RCGpbBTyD76YoVkatmj8Squ9IMzjadZE+jZnOY9R11r52qjKSGEHg3EhHiy7okVTv
         mB07dyC5yirbzQFV2nl4vP78c2wisWp5jr0X1gvgbg2UlQg/ZCqLQI73y3BUGXlVrD
         liwNuSMaPPuDf35KEkHTQQi5qZyFXBYGf8NH37HFE7zJ5zgHzaBxum0WiZRqYqnIuZ
         t9JFLs4WcBR4o+zpDk0S1UhM9z4456uZdXAUAMpm+EnFG8L5A5vR7ntEpMkusdAQmH
         qHUFpXrD9QyFkrm71oerugNAUWq7asR0llnPjtOWgKlbdTx92usJZBKY5KEOVWY3gN
         924C5Mr5WDFmA==
From:   Mark Brown <broonie@kernel.org>
To:     james.schulman@cirrus.com, cristian.ciocaltea@collabora.com,
        tiwai@suse.com, lgirdwood@gmail.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        perex@perex.cz
Cc:     kernel@collabora.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220621213819.262537-1-cristian.ciocaltea@collabora.com>
References: <20220621213819.262537-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH] ASoC: cs35l41: Add support for CLSA3541 ACPI device ID
Message-Id: <165608133945.445804.16792879989339290449.b4-ty@kernel.org>
Date:   Fri, 24 Jun 2022 15:35:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 00:38:19 +0300, Cristian Ciocaltea wrote:
> Add support for the CLSA3541 ACPI device ID used on Valve's Steam Deck.
> The driver is fully compatible with the indicated hardware, hence no
> additional changes are required.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: Add support for CLSA3541 ACPI device ID
      commit: 658e95953075ca781ef8712d0a3203e485888c7f

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
