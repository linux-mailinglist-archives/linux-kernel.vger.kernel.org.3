Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622D9520369
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiEIRVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbiEIRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729224B5BD;
        Mon,  9 May 2022 10:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B81FE6155B;
        Mon,  9 May 2022 17:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4641CC385B2;
        Mon,  9 May 2022 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652116665;
        bh=/vK4hUOw5XVzRCz9/q9BHaDHH7etX4k7UQOvk8DgWS8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gCsrO0C+bYZ/fHs1oJCf4AMGfTrJSzwOMuhCfjt/XmGRTrgzPIR+B6p9NmeMLZLCD
         4LudReQE+eKCtnC9S7sQ3LZ3xJwwh9xwHEUCqWGLixZsWJR/WwX9nfkEjBGwSQ4Cx4
         Wwo3bqP0R3R45UaLPOeLY4um28DSZm8LC7AA2kU3pPnxayOW3zvdRnXQGWLW5Rjrm2
         PwLjzvdU67ApymHm6qL8R0fes/Bhkw73qWkujPLE0gIVrVfxA6XYzo/ZfE02zriWpa
         vMKnO8zadPBp46V5WSXYRGii3ty1lYnyuehqGWxEcWlbY/YAZ1tRRR4RxaSYWHkVUY
         IcChFz6cpW/mw==
From:   Mark Brown <broonie@kernel.org>
To:     nfraprado@collabora.com
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jiaxin.yu@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, shane.chien@mediatek.com,
        linux-mediatek@lists.infradead.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, kernel@collabora.com, tzungbi@google.com
In-Reply-To: <20220429203039.2207848-1-nfraprado@collabora.com>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
Subject: Re: [PATCH 0/3] Add missing dt-binding properties for audio components on mt8192-asurada
Message-Id: <165211666198.1065748.1151009730882312510.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 18:17:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 16:30:36 -0400, Nícolas F. R. A. Prado wrote:
> These patches add properties that were missing on the dt-bindings of the
> audio components used by mt8192-asurada. Namely the i2s-share
> properties for the sound platform and the #sound-dai-cells on the
> rt1015p and rt5682 codecs when they're referenced by the machine sound
> node.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties
      commit: e056cf4341ae3f856f1e38da02b27cb04de4c69b
[2/3] ASoC: dt-bindings: rt1015p: Add #sound-dai-cells
      commit: 2f45536587e53a7a22024e12fbe97ef13598e623
[3/3] ASoC: dt-bindings: rt5682: Add #sound-dai-cells
      commit: 0adccaf1eac91a2c2ee6a54a6de042affe9860f4

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
