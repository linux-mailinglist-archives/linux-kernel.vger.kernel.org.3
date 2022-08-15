Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1144859325F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiHOPqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiHOPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:45:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165AC28;
        Mon, 15 Aug 2022 08:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE3ADB80F2B;
        Mon, 15 Aug 2022 15:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C419C4347C;
        Mon, 15 Aug 2022 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578313;
        bh=JwjxJ7MOVdbsgqpb/k0rGtudkHpbtxGUbAtOmA+7kb4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=tsqfhZF0byibwTSWDbd8UBOt4qmu251PmImxGxyvih5jtAVHspXV8Bu51VzsPeM1U
         oq8g/FuG5Hj72UVtFgziDO9U27EZZRnKIvdFF6g0RAmp+IsSkcZNelH3ffc7HAg0qw
         1YPMFyCGw0I8cN27fVVcGCuhFtRUDuZo1rI2yNfIgBmyigj0ra2Gpzh7WrTia0H4vB
         v5/GQn5Xhb3dSct2jCO56KXXGQqzOEuG8Wg7EVqgb7HEWTRIZufGztGmUf3YWb7mGw
         Yc2gVUl2s1eNjrWS6zlQSyORnqVoFFb2UNHG7mJcdl17dcMQXoNODBQBVSSsEBfODd
         p3d1SN03bHSbA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
In-Reply-To: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
References: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi/panel: dt-bindings: drop 3-wire from common properties
Message-Id: <166057830909.697678.2981260978895066117.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:45:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 16:13:11 +0300, Krzysztof Kozlowski wrote:
> The spi-3wire property is device specific and should be accepted only if
> device really needs them.  Drop it from common spi-peripheral-props.yaml
> schema, mention in few panel drivers which use it and include instead in
> the SPI controller bindings.  The controller bindings will provide
> spi-3wire type validation and one place for description.  Each device
> schema must list the property if it is applicable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi/panel: dt-bindings: drop 3-wire from common properties
      commit: 41f53a65444997f55c82c67f71a9cff05c1dee31

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
