Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34F4F7F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbiDGMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245372AbiDGMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:55:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFF259B58;
        Thu,  7 Apr 2022 05:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF0161366;
        Thu,  7 Apr 2022 12:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1672CC385A7;
        Thu,  7 Apr 2022 12:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649335979;
        bh=yyt0fkY+OiU6yD+EkfeH4xIYmR/qozETlEVmaOo3eWc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XLPs56zj2KFjCgl3aufO8uTuY6UuttnvDpQhSv9IM3z4T3KILbsMium+G5WoHUXro
         n33yIeWltQ1unN6/Vn0BUfrUz38ntDANNZUgpDTwyBnTzh+z69HnL4yodgZmeME6Gz
         Y7gJRRuU5vBOXhk0rYrH0CQqCVALHDnfKt0X1SyhL6qWoQsW9BLUZs1thLQI2KaHy/
         9n7vzqc0odLXL+4DCHSqw/3MTqo67gYnc8Ponb9WmXD5wydUDkQ2Yr/2Ar47ELV9rj
         ueIVvN36TTtzEM3UFOOw0fF40k4yYI8jcMtilaXsjj3Qlx27rg5bVcE/vLWjwtQ1gr
         vm4ahJUQuIXYA==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, u0084500@gmail.com
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        lgirdwood@gmail.com
In-Reply-To: <1648294788-11758-1-git-send-email-u0084500@gmail.com>
References: <1648294788-11758-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH v2 0/2] Add Richtek RT5759 buck converter support
Message-Id: <164933597780.2466529.16895833631668270427.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 13:52:57 +0100
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

On Sat, 26 Mar 2022 19:39:46 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series add Richtek RT5759 buck converter support.
> 
> since V2
> - Fix typo in title description.
> - Put allOf and if/then to be together.
> - Change node name to generic 'regulator'.
> - Remove seperate wdt_enable variable.
> - Add of_match_ptr in struct driver of_match_table declaration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: Add binding for Richtek RT5759 DCDC converter
      commit: 2a826d9c4251e4a64aa79113aac8cedf7cd0ff57
[2/2] regulator: rt5759: Add support for Richtek RT5759 DCDC converter
      commit: 7b36ddb208bd1744f4769f11e530bc08c3701964

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
