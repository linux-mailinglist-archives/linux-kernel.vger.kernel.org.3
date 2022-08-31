Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292125A7E06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiHaMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiHaMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51835B8A54;
        Wed, 31 Aug 2022 05:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7F8A61A27;
        Wed, 31 Aug 2022 12:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D36C4314B;
        Wed, 31 Aug 2022 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661950382;
        bh=dGvlxWA+Q7QU9nq7L7VQgKMY4srrIa1uYv+f3xokFnU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aIQvwTntpJHXV3hd+ksJeY0N2s/A5bfTvXwwPShHyhcz+dRW0xaLI+OAzEjOgig1Y
         lFMmGdaiA14oiC35gSK/Ac8A+pljsvWcvyhIE3n/g8Av+UFDZqatU4HhhvMw9nSYQD
         vNQW5P5gIeaSzL4heUkARWiIMtbpctHvq0MR/DfU0JoiYlKkQnMv0X2Fqf4/JPQTch
         A+FIIDakjHzaUUOTBBom98xddR2t/hoNUuQ9FaH7Eh4l2v8uY4nFf8AGLyMKMV8hU8
         LHjweaOF4e4eSaeFXNH0s5S/bLXWWPAa1twXHLQNBovb4f0PmU5x6elDsejaSrnDpV
         ZtRuOGa7vr1uA==
From:   Mark Brown <broonie@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        lgirdwood@gmail.com
Cc:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, bjorn.andersson@linaro.org,
        robimarko@gmail.com, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220831080503.17600-1-jean-philippe@linaro.org>
References: <20220831080503.17600-1-jean-philippe@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: regulator: Fix qcom,spmi-regulator schema
Message-Id: <166195037974.99335.15195185114132333580.b4-ty@kernel.org>
Date:   Wed, 31 Aug 2022 13:52:59 +0100
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

On Wed, 31 Aug 2022 09:05:04 +0100, Jean-Philippe Brucker wrote:
> The DT validator reports an error in the schema:
> 
> Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml: ignoring, error in schema: patternProperties: ^(5vs[1-2]|(l|s)[1-9][0-9]?|lvs[1-3])$: properties
> 
> Move the unevaluatedProperties statement out of the properties section
> to fix it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Fix qcom,spmi-regulator schema
      commit: 475043fabe8c58fb18c32c7942d8754897bd11fa

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
