Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E34F42BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiDEPWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbiDEJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B483DCE26;
        Tue,  5 Apr 2022 02:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9C361368;
        Tue,  5 Apr 2022 09:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42851C385A2;
        Tue,  5 Apr 2022 09:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151149;
        bh=LMWjnRihmAkYJ4VE026+EhIuf0h/R47oaYeDgl0V7PM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YFSU+3oYLQYgTZ0hlJ0IlSF1Ou+RUMIgREyudOvmFbgFptcZI6uUNOyQpx7QOtVXM
         VId6j+7j0Knrvvi+/1P5/FnhR5m69iy1fwCmFHBxwkVnj2x5oH7yV3EREKgdXcAJlx
         ZXGrZ8g3OBO+7sH1hvV0T3Tv2Xn6IfCMpnU/PrPVRBzUtrJwtjH9S+tQ21D6QSaSRb
         lY7GwdZgYaDBRg7b5IiACltkwJCdgeJQIPwc6k5PaNBfEzj4ZvgNa4Jn01N6SX6cU0
         QMf8Wzw/lB3A6TOyc4mmWGxMYelT7/T9DQ5ShXW7Nwsjhk9+FveJFdXdFxJiDeKxiz
         blXpxRCQ0yBkw==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, krzk+dt@kernel.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, singh.kuldeep87k@gmail.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20220328192006.18523-1-singh.kuldeep87k@gmail.com>
References: <20220328192006.18523-1-singh.kuldeep87k@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names
Message-Id: <164915114699.276894.10846659082729207410.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:26 +0100
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

On Tue, 29 Mar 2022 00:50:06 +0530, Kuldeep Singh wrote:
> Add minItems constraint to interconnect-names as well. The schema
> currently tries to match 2 names and fail for DTs with single entry.
> 
> With the change applied, below interconnect-names values are possible:
> ['qspi-config'], ['qspi-config', 'qspi-memory']
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names
      commit: e23d86c49a9c78e8dbe3abff20b30812b26ab427

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
