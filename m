Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F059F86D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiHXLMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiHXLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DC67CA9;
        Wed, 24 Aug 2022 04:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5405161931;
        Wed, 24 Aug 2022 11:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95404C433B5;
        Wed, 24 Aug 2022 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661339544;
        bh=H+veo+Dao6bkJ0QMyFov+hU73WKqs+8y5v0OSddUH8Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kBHMSKXnm0q0/ig5wiPntO3Jl5ZlIKYg+9lyllxyXo7josUAAKfnl1BGY3qq5uhyO
         Z39yjwD4/NFhx2B6Wc/+r0hxaXJ3UbARfcsvcwDHtrvsdD9i4JhAPciVl3T+CrM3hE
         /EfTraglUjPsMItvnKtQPOtWdoDhkRmhY/G/3keG1xGxXbDlJUrW1CZutdptQFqyPk
         xmLku2O2USngmtzYaRvm9/aAWs6ObNDWc20kLO8WBsH/+ochtgPB/WbGdw8JMgyDNG
         LzO0IgWc0DDMNlWKK3zbXjCzwriQw4vMTPFYeOP0n1m836BgYwak6uCgFGY1uhlIZY
         l8v5dwKXirf2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shane Chien <shane.chien@mediatek.com>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220823145649.3118479-8-robh@kernel.org>
References: <20220823145649.3118479-8-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
Message-Id: <166133953831.17904.2785802329558247784.b4-ty@kernel.org>
Date:   Wed, 24 Aug 2022 12:12:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 09:56:39 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
      commit: 9e10a1ded6a1b7ffacbb2d9c75fe6aa91623051b

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
