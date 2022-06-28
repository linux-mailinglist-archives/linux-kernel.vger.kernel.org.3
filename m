Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801EE55CB96
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbiF1KbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiF1KbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D12F644
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 876CD61917
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A675C341CB;
        Tue, 28 Jun 2022 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412281;
        bh=mcPN7dG6WI58otz+ZI9udh4R7IN2jCr0gOc/tSKYAfw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=X9rFU3VYYeqd5S9pHXRgih16ZwUvg9n3UCsF7+lA+qStGBB0Nr4Xh6d4E4wyL7W5c
         lzIE5hFJyUT0s9q082VKMHFs9SsW/kmEkA40+pEm8EAiUaGU4UYfaqBDIhx9PgZ8N6
         +Ry9kg8tCFosPQl3YNFjYpzhGIRYHcOtST1pa+LAEWkdErQaGrb6zxWpw/KC8GFPAC
         T7DDBYKumCB2eetgonh+XLIege1CZI2+lO59i3PO15MBErszPQLbJ+1OPWnEr/K38N
         wLiA5nTw5cEcnXwcyqIF9MXMOcXN8bCwUa5Lo9TU4y1qmyuDn5LQ/AJV7M3D5tzOTM
         xe5WzBJkoEgtQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, s.nawrocki@samsung.com,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220627141900.470469-1-krzysztof.kozlowski@linaro.org>
References: <20220627141900.470469-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: samsung: h1940_uda1380: include proepr GPIO consumer header
Message-Id: <165641227908.254424.11381365474563768174.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 11:31:19 +0100
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

On Mon, 27 Jun 2022 16:19:00 +0200, Krzysztof Kozlowski wrote:
> h1940_uda1380 uses gpiod*/GPIOD* so it should include GPIO consumer
> header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: h1940_uda1380: include proepr GPIO consumer header
      commit: bd10b0dafdcf0ec1677cad70101e1f97b9e28f2e

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
