Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8F59ECCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiHWTrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiHWTqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC505A15F;
        Tue, 23 Aug 2022 11:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB76F6170D;
        Tue, 23 Aug 2022 18:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DEDC433B5;
        Tue, 23 Aug 2022 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280634;
        bh=Oyq3LAklv8BSoebYYWHKIy5H9iMh+4uB439rsWCYqJk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XoZeQPipdtTarbtkshQSe12v5T0JUKXWQL33TnqBdI0ZyeJjx+IMm1F29DMTHxtOU
         i86mANEPVU9AA3QQXinb2Vo6yYzVsP2/E9AuP7QpQ51xcqfnglZq+upx0dFofMfwrQ
         IUksfOAVEFwLaONGuLz1Iv+I9WixBNsB4PRW85fnkWqECojsBHABBS2j+I72b73N9b
         E682Xl1EdaW0bQnAMIStv73bqKJ8MGYorGJGrIj+DJE0Ab7hAQSsUS5RGUIkuAo4ax
         ve5aDYmbFheIBWO/A5tg3ZmC9jab8dtmxpbqAx5xU8u7m6Ak8vW/kHE0lPAU8j8VDu
         aTLIlFM4x6ezg==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Robert Marko <robimarko@gmail.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Andy Gross <agross@kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20220823145649.3118479-7-robh@kernel.org>
References: <20220823145649.3118479-7-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
Message-Id: <166128062992.1031899.17043641765652674620.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:50:29 +0100
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

On Tue, 23 Aug 2022 09:56:38 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
      commit: de6fbef10c4b9c589f3b84bd926e56ba742263ea

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
