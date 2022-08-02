Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19348588321
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiHBU2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiHBU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:28:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7ED24098;
        Tue,  2 Aug 2022 13:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C917614C0;
        Tue,  2 Aug 2022 20:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DDFC433C1;
        Tue,  2 Aug 2022 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659472084;
        bh=pLUb/kBwLxEZnU56D3TMn/JIiow5Blh2ylmpyRYmNCg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ASI1cyci/LKUxzn/fna6gubkBPHoIu4tBvFmJnZStkwcH08z4LAFzDLsEqvqj5iKs
         OS8tme1Uni1AAWMbXO6HRIOlEoosb768s9SYs+XsDjrCsiK9kqcGG2/50/ipRZzX/k
         1ojCQoPr7Ql9avtF+rvh0Y+wzPFJ7GQc45GLTPlBzWNwYlVIhA7Mz11Aq/CEGm1J4f
         2ggvp9b4VhjU6kyhzcgzTZ299Br+/yHT110J9VfXXRtgjK1WlIde6Nd+3xZxykasfQ
         4NkG3E1DM8qOU6W4JXzILPdRWtsIzLPOw9WbmSHf61Xnf6bxxZbZCBhLTIL0KUr4jU
         N8mtuPCla8wEQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frieder Schrempf <frieder@fris.de>,
        linux-kernel@vger.kernel.org, Robin Gong <yibin.gong@nxp.com>,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Per-Daniel Olsson <perdo@axis.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Rickard x Andersson <rickaran@axis.com>
In-Reply-To: <20220802064335.8481-1-frieder@fris.de>
References: <20220802064335.8481-1-frieder@fris.de>
Subject: Re: [PATCH] dt-bindings: regulator: pca9450: Remove restrictions for regulator-name
Message-Id: <165947208205.2174956.10539628877269191065.b4-ty@kernel.org>
Date:   Tue, 02 Aug 2022 21:28:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 08:43:34 +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The device bindings shouldn't put any constraints on the regulator-name
> property specified in the generic bindings. This allows using arbitrary
> and descriptive names for the regulators.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: pca9450: Remove restrictions for regulator-name
      commit: b0de7fa706506bf0591037908376351beda8c5d6

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
