Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BF4C7895
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiB1TQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiB1TQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:16:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00DEE4D30;
        Mon, 28 Feb 2022 11:15:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98AABB815CB;
        Mon, 28 Feb 2022 19:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE39C340F1;
        Mon, 28 Feb 2022 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646075756;
        bh=3bz7Qsk+snnXqiot5wWBZHY9JSrCtvtcLoIgzffSDeo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bKW3ESh7tv0gSsPTb5mEFFgrQeiokQxiZOcnp5MTxI+YZwiZu5V3aQKrDkufSZmCr
         OGnZW+oZDnSBuD809U730F9n11csXcyR+ZaBEFXH9NXWa4/JvxFpSDL9N+cPPZo3FC
         ZPi3xs3sE0anePHr17TA42bvJQLX4lJ/CpNImk2IP4lyXEzesvi9uE9jj/yvzMf9td
         uJ7XI/DiovqcO+KD7BXT4QG6OOt+xRFV2xsUpN1gx1e56IB0R6tEq8mFymaS3/BDIb
         kY8TLCHBEVj6o3TCFE8YS5k8cSjzPN9gwPcxy95HDSnYSG749MQ58zerECrGoKkcil
         FOYPBqifMrczQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org, perex@perex.cz,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        tiwai@suse.com, lgirdwood@gmail.com, swboyd@chromium.org,
        agross@kernel.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        rohitkr@codeaurora.org, quic_plai@quicinc.com
In-Reply-To: <1645898959-11231-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645898959-11231-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v5 0/2] Add power domains support for digital macro codecs
Message-Id: <164607575278.3538791.10960449349795091046.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 19:15:52 +0000
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

On Sat, 26 Feb 2022 23:39:17 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add power domains support for RX, TX and VA macros.
> 
> Changes since v4:
>     -- Fix uninitialized variable return error
> Changes since v3:
>     -- Add dt-bindings support.
> Changes since v2:
>     -- Remove redundant local variable.
>     -- Update pds error handling sequence.
>     -- Update module description.
>     -- Clean up pds init function.
>     -- Remove redundant arguments.
> Changes since v1:
>     -- Add missing macros in Kconfig.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: Add power domains support in digital macro codecs
      commit: 9e3d83c52844f955aa2975f78cee48bf9f72f5e1
[2/2] ASoC: qcom: dt-bindings: Add bindings for power domains in lpass digital codecs
      commit: 6619c7d4379aca716a90f7581be2853071c086f6

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
