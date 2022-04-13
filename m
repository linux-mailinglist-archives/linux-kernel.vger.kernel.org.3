Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34A04FFCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiDMRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiDMRii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:38:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9F6C96B;
        Wed, 13 Apr 2022 10:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5175B826A8;
        Wed, 13 Apr 2022 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC72C385A3;
        Wed, 13 Apr 2022 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871374;
        bh=H8GenBwc8iPYziig6AwYbCZeMOO2GHqplRSzgouvEDs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Q0Jwdjf4UMGAaRi8gmSZBhSkM+Z3hNXElMJ1NjlzWUd9AwemnbJ21cRN8xX6ums3V
         24MzaBAOZMpmFG/EcWkPvISm6xSgza5e/Ka7BbH2i9i7fMpuyRryPjUli8wCGbdFLA
         F0XiG9HAmyZwWuhumls0FdUUH5ODEZiIToqTHr8hXTGBOiO3e7r0lKMr0P7P7qxUl6
         7FjQSaLba58qbbiaKKRSnZ26LI/vEpF0wESX6tu1tbCfqeSv7ydCTajhe9W29U4ZjH
         cBly9Zw+s7csShPlOwMu0JKuMxHd1rZ5f+H4oGpXxUMvoYdvdDMJsKIJGs+xV9ts6B
         mXPxdocoosdNg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org
In-Reply-To: <20220411105903.230733-1-krzysztof.kozlowski@linaro.org>
References: <20220411105903.230733-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpmh: document h and k ID
Message-Id: <164987137219.70067.3953392874175019418.b4-ty@kernel.org>
Date:   Wed, 13 Apr 2022 18:36:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 12:59:03 +0200, Krzysztof Kozlowski wrote:
> Document used PMIC IDs: 'h' (sm8450-hdk, sm8450-qrd) and 'k'
> (sc7280-crd).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: qcom,rpmh: document h and k ID
      commit: 619fdc47f821139f312a87b397a75ff69ec6f8b6

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
