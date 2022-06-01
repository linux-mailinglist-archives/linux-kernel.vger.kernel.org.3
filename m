Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850F653A531
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352860AbiFAMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbiFAMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:39:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979D6F4AF;
        Wed,  1 Jun 2022 05:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03007B81A1F;
        Wed,  1 Jun 2022 12:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014C5C385A5;
        Wed,  1 Jun 2022 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654087141;
        bh=oz8sdc7YaS+FFTgKgy6l95sNhmT8mhsukKDSp5YTO+E=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Q6V8+TDacXi+hfE0nCA8Pfr3DoocD4CpoV6wnc7O9MAix/RSZ/py2Sq0HpzbEv+aa
         sd3CTq1nwwGllq5NRbvYKNY3pxTBFmSoA6UZn/kBqRmdRCpA6fs69SqFCHxKZyzYui
         F1OdZr6/u3xQAr/aLuaIFgXnlPJ3OAnF2bwJMWFP77R//Pc1aRz2aal9VPPhcrScwt
         uHSYS8Dd3DFpsAmprYO17DihetBLvzmyVL653vDqdlqYibs98OW5WLWIrf1iYqggaX
         VcQIS1voPUapva66DDJPDncoHoN+XwKEh2l6Z5wts7JD5w5yPsSKX6anh2OlWfDKax
         xkXscJTSDJwMA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, quic_srivasam@quicinc.com,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        judyhsiao@chromium.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, perex@perex.cz, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, quic_plai@quicinc.com,
        lgirdwood@gmail.com, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, agross@kernel.org
In-Reply-To: <1653660608-27245-1-git-send-email-quic_srivasam@quicinc.com>
References: <1653660608-27245-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-platform: Update VMA access permissions in mmap callback
Message-Id: <165408713769.3032499.9376939250680150345.b4-ty@kernel.org>
Date:   Wed, 01 Jun 2022 14:38:57 +0200
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

On Fri, 27 May 2022 19:40:08 +0530, Srinivasa Rao Mandadapu wrote:
> Replace page protection permissions from noncashed to writecombine,
> in lpass codec DMA path mmp callabck, to support 64 bit chromeOS.
> Avoid SIGBUS error in userspace caused by noncached permissions in
> 64 bit chromeOS.
> 
> 

Applied to

   broonie/sound.git for-linus

Thanks!

[1/1] ASoC: qcom: lpass-platform: Update VMA access permissions in mmap callback
      commit: ef8d89b83bf453ea9cc3c4873a84b50ff334f797

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
