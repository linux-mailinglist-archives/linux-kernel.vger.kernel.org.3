Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4948E58AB83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiHENU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbiHENUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17F5FE2;
        Fri,  5 Aug 2022 06:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A54AB60A69;
        Fri,  5 Aug 2022 13:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47829C433D7;
        Fri,  5 Aug 2022 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659705648;
        bh=HW5Lw6f9czoMMC+SckAxWTPiwXMoqHH9pzjFaYeb6CU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SzmHZZQF1IzJguvnwsVa22pzlcrAgkDAETHC+VZ3y6UYarg1fPLA3TSA/QxYEVn2E
         qVLOeKIBxTdNrAYA4CGu/IhugVxDUjJU6zPDcpaYXcpXsaPhwoPW//oyt3knZ4W0Ze
         Kwb2hbnJcjMSLGK5dBvsjmp98HAQgycnRg6vnl2dKBoFdNbCA8HOE00UftF2KbMOFn
         ToEIowD+f5oEClal6ttxEXnz7urCGyRkGL6XgArm3zAOYR/FXiRtjCJW/j6Cu0T8Ro
         9K8yG49Q61auFDs9Bvl/aVZAxR0rzpU41V62OSK/owBnVBE20irR4hb0AGjRB/CrlB
         FWSR9A2Lx6dFg==
From:   Mark Brown <broonie@kernel.org>
To:     Nick Hawkins <nick.hawkins@hpe.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220804161823.20912-1-lukas.bulwahn@gmail.com>
References: <20220804161823.20912-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for ARM/HPE GXP ARCHITECTURE
Message-Id: <165970564600.1040888.14372925011980629843.b4-ty@kernel.org>
Date:   Fri, 05 Aug 2022 14:20:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 18:18:23 +0200, Lukas Bulwahn wrote:
> Commit 8cc35b86546d ("spi: dt-bindings: add documentation for
> hpe,gxp-spifi") adds the spi dt-binding file hpe,gxp-spifi.yaml and commit
> a1848b0fa251 ("MAINTAINERS: add spi support to GXP") adds a file entry
> hpe,gxp-spi.yaml in ARM/HPE GXP ARCHITECTURE. Note the different file name.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: rectify entry for ARM/HPE GXP ARCHITECTURE
      commit: 706864c99e0e2d301da9e749395909bc309c50a0

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
