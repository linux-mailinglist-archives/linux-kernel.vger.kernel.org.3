Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA20561B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiF3NcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiF3NcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7EB366B7;
        Thu, 30 Jun 2022 06:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF78A61F89;
        Thu, 30 Jun 2022 13:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDAEC34115;
        Thu, 30 Jun 2022 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656595932;
        bh=P4ygcIAZvGne77x7p3ESNwZJYO63gwNBVMImtEJj/Aw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uaLMUe0Kjgw7n42wD8QtWWvbYn63qmHgABLj0+dirlxPm7dLoQ8BxA3CimjMDUhB8
         e52pmNAiqhXWOJIukn5AgG8zcO2cEcVKw6PmvTkMXeZpYrLSqdu0NVy1ydMyH/DKCQ
         hVyKYIazGjilWAK6i9GvmJuKaMeV2ACUWbmJ7b54Rxqb8zaHHWyAyTXxINIA4pvCV2
         5cPn/IJ2TYqaYYAhLIxFRsaRWcRtibZ6tdmN6QgyNvALkv9pMsmzgXlgvaTjy4Mmft
         HeUzOxJonMkfb7otYacjhbuGzEPksBxuETqyuyMf8KJwSO0Ao4SEhOb6rWrX0RChNV
         Hfc/RZV5a/NPA==
From:   Mark Brown <broonie@kernel.org>
To:     stephan.gerhold@kernkonzept.com
Cc:     bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
Subject: Re: [PATCH 0/3] regulator: qcom_smd: Add PM8909 and fix pm8916_pldo range
Message-Id: <165659593011.540699.6977460772131709701.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 14:32:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 11:46:11 +0200, Stephan Gerhold wrote:
> Fix the voltage range for the pm8916_pldo in the qcom_smd-regulator
> driver and add definitions for the regulators available in PM8909.
> 
> Stephan Gerhold (3):
>   regulator: qcom_smd: Fix pm8916_pldo range
>   regulator: dt-bindings: qcom,smd-rpm: Add PM8909
>   regulator: qcom_smd: Add PM8909 RPM regulators
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: qcom_smd: Fix pm8916_pldo range
      commit: e8977917e116d1571dacb8e9864474551c1c12bd
[2/3] regulator: dt-bindings: qcom,smd-rpm: Add PM8909
      commit: 8cbb948a7cc2875d09234e2ce0424bc501c370b9
[3/3] regulator: qcom_smd: Add PM8909 RPM regulators
      commit: bc4d193238be4ef8ecee1ba0e0371169ad448c31

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
