Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1FA59EE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiHWVQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHWVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:15:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85035110B;
        Tue, 23 Aug 2022 14:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD63B81F3B;
        Tue, 23 Aug 2022 21:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BD3C433C1;
        Tue, 23 Aug 2022 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661289333;
        bh=ENj0h/OaTgIdV5SUrWyPWA3nYKs7CRWRwhzMPXuiZf8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mCY6k/QjFtBM0L+FAW7xOwTfxm8RXkpK+gPkTtoHv1QATQ883+u8pm/7j4YJAQn2J
         bkgTwJPevp4u7tY4SWXCq/IjiuUuy4h2lRTb8cQLTETz2bXSr0da3mtfznohal+cx8
         3ewKAVJSgRBf7dwpKth+YCcZs/4utBag2/fKTF4jlimS5UUO3ioB88/dcoHkIINLr/
         UOFmNp2JBh/n621JhBoAW1Ki6GWzdWKzYiCKqudTNFkLjvoUy9NLRwcXjyZohwak3B
         6ETRnr6tV4rwTP0WBA/bMbDHEjxdcTBbqsqUn0+dZWZVOLKBvyX+8Ywn+QoW0hzdJ+
         Z8Kc/j5Vu/gXA==
From:   Mark Brown <broonie@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Robert Marko <robimarko@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220802221112.2280686-1-iskren.chernev@gmail.com>
References: <20220802221112.2280686-1-iskren.chernev@gmail.com>
Subject: Re: [PATCH v4 00/13] PM6125 regulator support
Message-Id: <166128933023.1993124.17537668863029691140.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 22:15:30 +0100
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

On Wed, 3 Aug 2022 01:10:59 +0300, Iskren Chernev wrote:
> This patch series adds SPMI and SMD regulator support for the PM6125 found on
> SM4250/SM6115 SoCs from QCom.
> 
> This code has been tested on:
> * OnePlus Nord N100 (oneplus,billie2, SoC sm4250)
> * Redmi 9T (redmi,lemon, SoC sm6115)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/13] dt-bindings: regulator: qcom_spmi: Improve formatting of if-then blocks
        commit: ac71792707226d1210127611bb622c0362cbff25
[02/13] dt-bindings: regulator: qcom_spmi: Document PM6125 PMIC
        commit: 5b2a085baaa15d04396889228f1e11d2cb86b916
[03/13] dt-bindings: regulator: qcom_smd: Sort compatibles alphabetically
        commit: 901421765ee1e5501c15a3b76ce926e0cc4967d4
[04/13] dt-bindings: regulator: qcom_smd: Document PM6125 PMIC
        commit: d95fe1788438cceab40af5f3f9e9fe15d8c07101
[05/13] regulator: qcom_spmi: Add support for HFSMPS regulator type
        commit: 2785025495b6bd630648f8304f8d932b0d0a9f2a
[06/13] regulator: qcom_spmi: Add support for LDO_510 and FTSMPS
        commit: 0d1cf568b4e0c65cb533fef2c116fb2883803c53
[07/13] regulator: qcom_spmi: Sort pmics alphabetically (part 1)
        commit: 046d7e3246ac028bfe583b4c3bed9530a80004c4
[08/13] regulator: qcom_spmi: Sort pmics alphabetically (part 2)
        commit: 9a2da0749ce37d4a74f7becf3b09bf2e0169145a
[09/13] regulator: qcom_spmi: Add PM6125 PMIC support
        commit: e62ef4a9f936326e702ef08ea3f65b62bd7d108b
[10/13] regulator: qcom_smd: Sort pmics alphabetically (part 1)
        commit: 8e584e84ae65ecc9ee90b187d4b7782dc881e4ad
[11/13] regulator: qcom_smd: Sort pmics alphabetically (part 2)
        commit: 13b3d00590243888563cb63b88538a4c60bce57b
[12/13] regulator: qcom_smd: Sort pmics alphabetically (part 3)
        commit: a39d0100572e188f00ff4d224af9694c7eb3eeb5
[13/13] regulator: qcom_smd: Add PM6125 RPM regulators
        commit: 95b5f3ef4c0cf553a97dd7ce7d6ef85415388011

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
