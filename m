Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB5510235
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352619AbiDZPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352538AbiDZPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:54:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A604E2BB15;
        Tue, 26 Apr 2022 08:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61F52B820EA;
        Tue, 26 Apr 2022 15:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6149C385A0;
        Tue, 26 Apr 2022 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650988268;
        bh=0op5gOSPyhcXlJpeXQJk2qphC7Q7xqa4KX+fJeEk5kQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UUHpDsnMAyTkg2jZaUn2OzPGndeDCaRuDVChJFsFxjtwG/7O9W1qkQpL3IMM3OcZS
         D903zhCbNxZIj5DX7G7TksVlZbc5T9fzRdwR2R736IbtCIvN6odwqKpupFM+jJB2NY
         xYcygYP2pdUlLvQDg6aWL/q5dzqTfj4AxcIPNbQfzrf3XGIiOgaXIuAeVGvgOnXuo/
         +YUwgjooJJIWJHe7gGPXGGHbMiXC11iTksNKi/nORoOjRaA71vR2QDDo+KbpN+eO2g
         /XeTgXOe9yUDRb+4euIIqIJFbASwzaykIh/544Yn5z0oGq7XACs8cItStmGXzob/4G
         KOJSJj05tb03Q==
From:   Mark Brown <broonie@kernel.org>
To:     markuss.broks@gmail.com, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        robh+dt@kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, lee.jones@linaro.org,
        mazziesaccount@gmail.com
In-Reply-To: <20220423085319.483524-1-markuss.broks@gmail.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
Subject: Re: (subset) [PATCH v5 0/5] Add support for Silicon Mitus SM5703 MFD
Message-Id: <165098826550.1750312.1746077609633234428.b4-ty@kernel.org>
Date:   Tue, 26 Apr 2022 16:51:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022 11:53:13 +0300, Markuss Broks wrote:
> This series adds support for Silicon Mitus SM5703 MFD and the
> appropriate device-tree bindings. This only adds support for the
> regulator module, leaving room for other modules implemented in
> future (code for other modules is really not ready for submission
> right now). Silicon Mitus SM5703 is used on various mobile phones,
> mostly Samsung Galaxy (J5 (2015, 2016), On7, J7 (2015, 2016) ...).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/5] dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
      commit: d496d68d6ba6debcc135794edb5fdc5a5b4531f1
[5/5] regulator: sm5703-regulator: Add regulators support for SM5703 MFD
      commit: e8858ba89ca377064da130d09648c99683f8bd90

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
