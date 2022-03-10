Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB034D45C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiCJLgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbiCJLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:36:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12414235E;
        Thu, 10 Mar 2022 03:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3EA6165C;
        Thu, 10 Mar 2022 11:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8EBC340E8;
        Thu, 10 Mar 2022 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646912134;
        bh=pkk4N3eCD0H/JMi6+p8qQuPegRrrIJ1gxJThJ3WAz7Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nck9PWgTGt9VgQJiLBMk/E9xtUhXAQU0MI8dImqhzOCPyKGigBYqMgLnvL3Qqoj3f
         Zh2ncEh/f9gWX8HLYrHcb5Dt32AkmiAFkSLWI0zwFa13eUCL3HCZfAs1vMjbQfYIcC
         E3BfMl5PXHuUUss6ee45f2i++98qX8ALuV03hrnY0KVUyLkq2XnYtaBDKHPCSA4hQp
         LCdsCAnIXDTzmRGL7irJZGlBm8b54o96FZE2XiwYtrNk1KLgMcTpp44fY9ISh0PQoZ
         g0k4cQJhwEIkiNmzNTOhYpMh2C472s7kHFmOr1NB6GY1adZxUmPvNlXUCCieHf1OKu
         o2jHOZ2LuHHvA==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, cy_huang <u0084500@gmail.com>
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, krzysztof.kozlowski@canonical.com,
        devicetree@vger.kernel.org
In-Reply-To: <1646812903-32496-1-git-send-email-u0084500@gmail.com>
References: <1646812903-32496-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH v2 0/2] Add Richtek RT5190A PMIC support
Message-Id: <164691213322.14059.3681107079269316589.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 11:35:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 16:01:41 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series add Richtek RT5190A PMIC support.
> 
> v2:
> 1. use standard bindings regulator-min/max-microvolt to replace
>    fixed-microvolt property
> 2. change dt-bindings sample node name from rt5190a@64 to pmic@64.
> 3. add dt-binding header to defin e the opmode mapping number.
> 4. refine 'richtek,mute-enable' description in dt-binding.
> 4. due to fixed-microvolt property removal, use of_regulator_match to get
>    the regulator init data.
> 5. fix checkpatch warning and error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: Add bindings for Richtek RT5190A PMIC
      commit: b77e70f6b8f2cc62fba847f3008a430a09ef275d
[2/2] regulator: rt5190a: Add support for Richtek RT5190A PMIC
      commit: 760423dfad53877b468490758fe7ea968ded9402

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
