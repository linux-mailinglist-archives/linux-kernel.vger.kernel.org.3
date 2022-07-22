Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F357E976
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiGVWFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVWFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:05:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35076E2C1;
        Fri, 22 Jul 2022 15:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F40E621DD;
        Fri, 22 Jul 2022 22:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5D5C341CB;
        Fri, 22 Jul 2022 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658527545;
        bh=dlW2CQz7TWp6qIiSdmuvBHnY6y1qDLdv1Y57CrSoo9s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bq1FJmzvcM+BRuBbyq2synnPToejL8zu+N/RCRfBxAd+K5pUa9xHiD8H4MlwYe8ft
         T4AQfaIjbrNPtDX5NiGxOaMpEngXp++3c+2qGFw1t2Hr48TLYMngEaDEUQQzu0Sod5
         Y9muRh5wrVhBz0h58jId9A+Zf3dgHWtNYUF1VQxWEUTI2aOrpeD6ePkqGq67lCC7GH
         tfqVGAH7bzN10fhIi+XF38BvDvtV1lq91cMnmH4QsGKubSphpb5rOvujFgOzCnelHQ
         qFwpDxSrgFtX6RX7RbDvPRiIol6FVcteY/dVpEdWX9IHPrOnMFg+ehq6RU/i7wtuj+
         g+SbNZa2hqc2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Ryan.Wanner@microchip.com, lgirdwood@gmail.com,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20220722152945.2950807-1-Ryan.Wanner@microchip.com>
References: <20220722152945.2950807-1-Ryan.Wanner@microchip.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Message-Id: <165852754322.1234289.5406223462611245285.b4-ty@kernel.org>
Date:   Fri, 22 Jul 2022 23:05:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 08:29:45 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert atmel i2s devicetree binding to json-schema.
> Change file name to match json-schema naming.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
      commit: 6f78675445ca243229303cd72898c4a2b95a2bc0

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
