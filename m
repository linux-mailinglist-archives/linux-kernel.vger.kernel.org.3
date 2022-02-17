Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828814BA5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiBQQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:22:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243041AbiBQQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:22:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62320ADBB;
        Thu, 17 Feb 2022 08:22:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43438B82362;
        Thu, 17 Feb 2022 16:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61194C340E9;
        Thu, 17 Feb 2022 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114956;
        bh=wVvGcJR4l3gt7jdAyEG+jd928oSBFZz7g56i8F4aG9Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j16fSdpSMjjHy8XkFnCr0a1GZiXYg4O8hyycv/1TbWR5V/1Hri+nd4MOq8QGeeoN8
         gO5NsGLEs4WaqM5iPkBaadtA7HrasRZeqvZB2RY9Xw3ru3dR5TLWO6nNapYDefi0GE
         9zCAaouf6ZYc2Toi9H1EDxMYfCG4sqc9dbXM0aR/qQY2ptk/uYhktwBRdKfTd/Kyoj
         wq034nZhpQJlGSCY0ki1T+2/433xJJJN/j2UqczDa/Jv1DCtoJHaqlX069xwC3k6AD
         ak7BCSnm1KnYGwNDH7oxJICR0fd0p2zpUKb9lfo/akW5Vj9+wKQ2x/NtkSB2HFYxit
         mmwtD7WT8sP/g==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, tiwai@suse.com,
        bgoswami@codeaurora.org, judyhsiao@chromium.org,
        bjorn.andersson@linaro.org, perex@perex.cz, rohitkr@codeaurora.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
In-Reply-To: <1645017892-12522-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645017892-12522-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: codec: wcd938x: Update CTIA/OMTP switch control
Message-Id: <164511495209.1843697.14605850089293661207.b4-ty@kernel.org>
Date:   Thu, 17 Feb 2022 16:22:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 18:54:52 +0530, Srinivasa Rao Mandadapu wrote:
> Convert gpio api's to gpio descriptor api's in CTIA/OMTP switch control.
> Remove redundant NULL checks in swap_gnd_mic function.
> 
> Fixes: 013cc2aea0f6 ("ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: wcd938x: Update CTIA/OMTP switch control
      commit: db0b4aedfab396a6fe631f5c3bb34319770f0581

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
