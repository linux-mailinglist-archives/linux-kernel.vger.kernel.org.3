Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3C34F6D66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiDFVwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiDFVvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E9DF50;
        Wed,  6 Apr 2022 14:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4A37B8259B;
        Wed,  6 Apr 2022 21:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA13EC385A3;
        Wed,  6 Apr 2022 21:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649281439;
        bh=Pt9dNZkY47pwmvmzw2l5RPQKmk3rUPiXwLVBiv+3418=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=RKlOfPtcf9IvG9go3O5eJII31c0SsxFDXJvq6fGyWc+keiTYvDfQ3os+y7+WQ9mCY
         qIFhNKR15A1Z+eZREmSK5m7hfbEKmxMXP+iBGrXkfluiIKNfOJWZb1cKeIA7KVg8FI
         w//jGz3eZ+Ll5IpaloVOZ/33lfjzkYM+pEFKJ588rBCMv9uj6c4C6N1GHLKVQ5rS9t
         fXySDHXuaC4eMZG9KKvtMNjPabjPriMivRG9Zz1xcExYiyk4NuBJk4lLrT9qeP1Ndx
         mo8dFVACIgjU+et211rDlISGoj4W1pPMXWIh3EWer6jsJOp/g/YpyUqss9Cf4PV7BG
         9lHZF0DslL/FA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, agross@kernel.org,
        dianders@chromium.org, Krzysztof Kozlowski <krzk@kernel.org>,
        quic_srivasam@quicinc.com, bjorn.andersson@linaro.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        swboyd@chromium.org
In-Reply-To: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH 0/3] Update dt-bindings for sc7280 platform
Message-Id: <164928143662.571581.13530656297112594722.b4-ty@kernel.org>
Date:   Wed, 06 Apr 2022 22:43:56 +0100
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

On Mon, 21 Mar 2022 14:26:18 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to update required clocks, power domain names for sc7280 platforms,
> and add mic bias supply for wcd938x codec.
> 
> Srinivasa Rao Mandadapu (3):
>   ASoC: qcom: dt-bindings: Update bindings for clocks in lpass digital
>     codes
>   ASoC: dt-bindings: wcd938x: Add mic bias supply property
>   ASoC: dt-bindings: lpass-cpu: Update clocks and power domain names for
>     sc7280 platform
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: qcom: dt-bindings: Update bindings for clocks in lpass digital codes
      commit: 852fda58d99a6c397f8303a8cd8ccec8702d82f5
[2/3] ASoC: dt-bindings: wcd938x: Add mic bias supply property
      commit: 9108c3446f6e86146f0d3141b94415eb98c39566
[3/3] ASoC: dt-bindings: lpass-cpu: Update clocks and power domain names for sc7280 platform
      commit: 98b7630a583fe970f59742dc855d1c03e258d645

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
