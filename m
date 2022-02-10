Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298884B139B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbiBJQx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:53:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244914AbiBJQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14135F9;
        Thu, 10 Feb 2022 08:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91B861D98;
        Thu, 10 Feb 2022 16:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87251C340F0;
        Thu, 10 Feb 2022 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644512001;
        bh=QQhZfdW64LTpTkLBsJ+VYIpO4vR+c1i9aVKNRteNGfU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=aC7WTNGhTPm1hBOHvQVzXbUElSHcZi9uuXPhurKvDjM9axlvLpQ/UTuTYL3vIK09z
         ZloXBcJiGJ2Igf+rmTwm47sYB3pR1DlJaYXR/8Wz0MXSDiH+0RO5cktiqR4IsQgeW0
         auiF/H07VVs7elCjViBK09S0nRfTm1x1646rTmx+5ygUvYzmrIsKAdeZ9s+W0D2L+u
         vKFBZ0+0G0CEWHGJxVE6jw87bGe3fa8nBIdYWVW+C+kF0KXNREs9ucN1VNi09U485e
         uF6w3uZiK98tsffgldc/+8MShpKQWcwsVxWOR4GqkvCVMth3ci3o1QbFmId8g02K1c
         40FGcgKQi5dsQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        alsa-devel@alsa-project.org, Jonathan Bakker <xc-racer2@live.ca>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 0/6] ASoC: dt-bindings: samsung: convert to dtschema
Message-Id: <164451199927.2625306.12763946891056497371.b4-ty@kernel.org>
Date:   Thu, 10 Feb 2022 16:53:19 +0000
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

On Sat, 29 Jan 2022 13:23:51 +0100, Krzysztof Kozlowski wrote:
> The patchset is based on Rob's sound-dai changes:
> https://lore.kernel.org/all/20220126231427.1638089-1-robh@kernel.org/
> 
> Changes since v1:
> 1. Correct samsung,snow cpu/sound-dai.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: dt-bindings: samsung,aries-wm8994: require sound-dai property
      commit: 7f021b723ea51ae94329e6d76f68189e1696deca
[2/6] ASoC: dt-bindings: samsung,arndale: convert to dtschema
      commit: 0412539614a223817646150d910ab6fedbb80507
[3/6] ASoC: dt-bindings: samsung,arndale: document ALC5631
      commit: b6145d8f0d6436a83a31024d4f9953d7088710b4
[4/6] ASoC: dt-bindings: samsung,smdk5250: convert to dtschema
      commit: 6752770d590594ff42fc19e74c30059d34f133af
[5/6] ASoC: dt-bindings: samsung,snow: convert to dtschema
      commit: a7e5305f7ab03cf3ae19ddd3f29919a7a2da0e5d
[6/6] ASoC: dt-bindings: samsung,tm2: convert to dtschema
      commit: c1fc51ebb098cd43a68ebc82fde51364c207de32

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
