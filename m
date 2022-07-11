Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDED4570A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiGKTLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGKTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:11:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73757261;
        Mon, 11 Jul 2022 12:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44EC1B81188;
        Mon, 11 Jul 2022 19:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E36C34115;
        Mon, 11 Jul 2022 19:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657566662;
        bh=yXhkVbVh67uXcHmQWn7bZ3DiQSUD7W8fS3r9Eddqk0w=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=YPLO447vQWfxvSQbgQX0jfEiQiTJKw2AV3ERghPf3DtVLqKSxJs0+1xh/wPkdwbQn
         DjM3c+hkmgPIVrfJvJa3LG+i0SyYQs+Mqs3Vf7E9ruSpRnwa8rJl1mNgbUt883tJUn
         Dyw5fcdDf5+Inhvt9X7b3fqe2vq0uqiVrRMtSW7+OMXpnEC6HSwF4Iolb5aBJul9aM
         yt7y8ck4nPf+8ICqAz4gf3JB5WGV0s9lMi6g1AEeugMkYgfVes/wQCowpu+4VoVjia
         rQ9SDH1KexXh0i2ECclD6tqMsE/IBa7TOBguzS3KoraKm7Rvat1i5S9lT605N4Yhfh
         I4vp8W9ffaiYA==
From:   Mark Brown <broonie@kernel.org>
To:     jic23@kernel.org, lars@metafoo.de, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        linus.walleij@linaro.org, agross@kernel.org, robimarko@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
Subject: Re: (subset) [PATCH v6 01/12] dt-bindings: mfd: qcom-spmi-pmic: add support for PMP8074
Message-Id: <165756665871.1166849.13520807599525950221.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 20:10:58 +0100
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

On Mon, 4 Jul 2022 23:23:51 +0200, Robert Marko wrote:
> Document compatible for the PMP8074 PMIC.
> 
> I planned to convert the bindings to dtschema, but there is already a
> patch to do so [1].
> I will make a patch to add the compatible to dtschema once it gets
> accepted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[03/12] dt-bindings: regulator: qcom,spmi-regulator: Convert to dtschema
        commit: 0b3bbd7646b03920e81efa376dee08f5b288c05e
[04/12] regulator: qcom_spmi: add support for HT_P150
        commit: 00f6ebbd0177a4cb15b353bbd4eaee6372fdbbc2
[05/12] regulator: qcom_spmi: add support for HT_P600
        commit: 3d04ae8e3e916bc298b674613565d5b26cf1054a
[06/12] dt-bindings: regulator: qcom,spmi-regulator: add PMP8074 PMIC
        commit: 044750573903595765fa52ba9e1aadc397d591df
[07/12] regulator: qcom_spmi: add support for PMP8074 regulators
        commit: 34ceb6a6ef87cda7629fd4ebe0074d9b5c7613d9

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
