Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25FB59152A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbiHLSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiHLSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94530F1B;
        Fri, 12 Aug 2022 11:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FB9FB82525;
        Fri, 12 Aug 2022 18:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAE4C433C1;
        Fri, 12 Aug 2022 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660327213;
        bh=RUyifO+SuzkUG8vhy8bG0g4+yNHSyLeRRkgb2Ml0tfM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=XE7THWHBMCj2imEQ/4KKcPf+ZyA/Ot8+Q+hDrYQDsb6KMNKjBwKgfUMatMQL0qC/x
         753NX84Os9k8nvXZHXLuVLzONfNvuNomjBFyXceZLU6tf1zuUdopWNKM78XwTaTDG4
         bKjNy+kNuU2YNEiJpXGJ9Hcl8d5Az7psxKJMi/3X/T+adCsqOiPPJv8KEurb5dolEr
         E6W8MNCMnQJSYdTZtPTjj0BjiD93xW/4yMZpjNvigxP0Uv6j3aBaEUXr9AEkRvnh1x
         82buIN8l7TuPV/vRbFRot+0xd4sCqhFN7GIsM5ywLtW32qRUCl25CxL3U+0AkQH5xC
         qn+/t4t8rCONg==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20220811063826.7620-1-krzysztof.kozlowski@linaro.org>
References: <20220811063826.7620-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: Drop Pratyush Yadav
Message-Id: <166032720990.92213.8782937797034359058.b4-ty@kernel.org>
Date:   Fri, 12 Aug 2022 19:00:09 +0100
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

On Thu, 11 Aug 2022 09:38:26 +0300, Krzysztof Kozlowski wrote:
> Emails to Pratyush Yadav bounce ("550 Invalid recipient").  Generic SPI
> properties should be maintained by subsystem maintainer (Mark).  Add
> recent contributor Vaishnav Achath to the Cadence SPI bindings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Drop Pratyush Yadav
      commit: 2fd92c7b8fe2cfc634613dc093d0f507c7389ea8

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
