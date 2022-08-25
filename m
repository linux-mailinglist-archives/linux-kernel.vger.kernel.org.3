Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24985A15C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbiHYPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242824AbiHYP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8EBB699;
        Thu, 25 Aug 2022 08:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACBB9B82A21;
        Thu, 25 Aug 2022 15:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C9C433D7;
        Thu, 25 Aug 2022 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661441297;
        bh=tQWGFhVvmwiIylyTB+mN9NpSEl/M7BY0JbIVV60nJlo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p2/k2n3t2NusXB/mMXR36VkEbFi1NSsN0LfyUFY80h3jfsDzX7RYJED4dCwnDdTSk
         SqTXz7uf/Sfvnk4SZnOF9GUVRtIA0T4jui+lEQ604JTXiFCAb8ZMRQ25Bls/dDYEq/
         uYC9akkLYxXaXp9JKNO0kowcq8n/JRLfSVkPI1J7MLpWmSa6E3z4WSp48a2g1k9iiz
         2LGy/bsC/Kwj1+DMLIaMMFHZYIASkdjTLIUB35OB+fpirsdwc5IC4nsfsr4W7kYYzU
         ssXjEe6phpMNF4wANWthAgyzCpzAe3uIF09gXsQALoqhp5LjLlXKDqYROPLQnQG+rs
         plD447l54U17g==
From:   Mark Brown <broonie@kernel.org>
To:     p.zabel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        sven@svenpeter.dev, marcan@marcan.st, povik+lin@cutebit.org,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     asahi@lists.linux.dev, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, alyssa@rosenzweig.io,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824160715.95779-1-povik+lin@cutebit.org>
References: <20220824160715.95779-1-povik+lin@cutebit.org>
Subject: Re: (subset) [PATCH v3 0/4] ASoC platform driver for Apple MCA
Message-Id: <166144129265.526663.12769625949004805936.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 16:28:12 +0100
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

On Wed, 24 Aug 2022 18:07:11 +0200, Martin Povišer wrote:
> sending what should be the final touches on Apple MCA driver. It most
> likely goes without saying but please do not merge the DT additions
> into the ASoC tree.
> 
> Martin
> 
> Changes since v2:
>  - fix Mark's style nit
>  - order compatibles in schema
>  - redo the DT additions for t8103
>  - remove stray unlock in mca_be_prepare (and rename the locking patch)
> Link: https://lore.kernel.org/asahi/20220819125430.4920-1-povik+lin@cutebit.org/T/#t
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
      commit: 6ed462d1c1167506479089e655355b3c123fee89
[3/4] ASoC: apple: mca: Start new platform driver
      commit: 3df5d0d972893d3c0df5aead8152fe1ad48ef45c
[4/4] ASoC: apple: mca: Add locking
      commit: 4065f0b25b7b30ba4dd4665deb5305ead1c0db25

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
