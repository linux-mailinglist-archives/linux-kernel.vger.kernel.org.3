Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F310B53FC0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbiFGKtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiFGKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E3F339C;
        Tue,  7 Jun 2022 03:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7250361555;
        Tue,  7 Jun 2022 10:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B2EC385A5;
        Tue,  7 Jun 2022 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598802;
        bh=ekCfkKozMAzzyqQ/p4pW1Ae35RQKaz4B54eLEG/rnjc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JqHZlsBZwDXTasm//ds0HqKarYsEhRH1fwC9igTIFRrDWx/c5FJAHd0KKah8AdhKf
         i6WZsg21jMm0vKb9OGi8S1j9heMiDH3hTumfVCI64axpLs3VZUvmR+MHz2plDO7FOp
         hwWXrDhZbyqCCWnFL3HjGUHP5rJ3Tw8Ky6YgWgtvSMQNP49TvAwzHbB3DwyB7eGQML
         UehZ8IOSI01ma6CVdIXmpOIiieh0EN9jmhOnttI5FGLtEUJfY18yZ/YQKLqjsZv595
         BXnG3/gQ1QMmjyf1/As4oY66qESXfliUDw7wIFNnyT4MtsxyLdO4Wwupf7h8R8wf19
         rQ/0QxrdYehSQ==
From:   Mark Brown <broonie@kernel.org>
To:     fancer.lancer@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh@kernel.org, p.yadav@ti.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20220525210053.2488756-1-robh@kernel.org>
References: <20220525210053.2488756-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to spi-peripheral-props.yaml
Message-Id: <165459880111.302078.11490460900047946308.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 16:00:53 -0500, Rob Herring wrote:
> SPI bus per device properties must be defined in spi-peripheral-props.yaml
> for unevaluatedProperties checks to work correctly on device nodes.
> 
> This has the side effect of promoting 'rx-sample-delay-ns' to be a
> common property, but functionally it's no different if it was defined in
> a Synopsys specific schema file.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Move 'rx-sample-delay-ns' to spi-peripheral-props.yaml
      commit: b658be56e867061a0d5496e837f350974ada5c89

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
