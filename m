Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F351AFF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378479AbiEDVDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbiEDVDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:03:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3A517FD;
        Wed,  4 May 2022 14:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96C5FB8293F;
        Wed,  4 May 2022 21:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4714DC385A4;
        Wed,  4 May 2022 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651698005;
        bh=5Nf3iyTvgGnwT20t1hf3sHDL9Ia6CNjfhok9FG1zJ9Y=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=aiFVKPs62c0odAocD0BRu2jLYyKCUrTTOPiJvbDNsUrPmaaG13/o+l14i0ovljyNe
         mSBkFdQgO6z4Ocz6x/poZ4hRcYR8J/bK5UkxqFiTXtgqdpFMqjKPDkdNSKte7GUE6F
         dqva4pjX5ji5KNg8Z6Cok/D68R+QLrQ0cfUbZbPDxwflGV11D82H2qv2xiVqrjU/MF
         Roiz18j6W3OYH+VxsqZfdYg0Kt9Av+46hCRcnHbZnp5v/hsIVCBnbxNH7sdIj886s6
         HsZSOtr3QcXrRp6zBQdy70ybPeVcuJ6Vtsn5guB4vSJTZJLJ6F6bRG0CCqcz6Usa7h
         EBhLOWD71+d2A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
References: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/3] regulator: dt-bindings: qcom,rpmh: minor cleanups and extend supplies
Message-Id: <165169800298.1752583.17813272460576782096.b4-ty@kernel.org>
Date:   Wed, 04 May 2022 22:00:02 +0100
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

On Tue, 26 Apr 2022 12:54:58 +0200, Krzysztof Kozlowski wrote:
> Extend the RPMH regulator bindings with minor fixes and adding narrow supply
> matching.
> 
> Changes since v2
> ================
> 1. Remove "defs" method, because schema nows allows unevaluatedProperties
>    without references to other schemas.
> 2. Include maintainer change patch, previously sent separately.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: qcom,rpmh: update maintainers
      commit: a6d889a8fdbb8cb4b0d01f30f93357f3ffd61f06
[2/3] regulator: dt-bindings: qcom,rpmh: document supplies per variant
      commit: ba5d99609a5e6a3d0d9ac2574250208457d839cc
[3/3] regulator: dt-bindings: qcom,rpmh: document vdd-l7-bob-supply on PMR735A
      commit: e84f3c41a583408c7c67ed7824a7ff14ff40d045

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
