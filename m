Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6305104FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354050AbiDZRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353916AbiDZRLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14F340EE;
        Tue, 26 Apr 2022 10:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4584D6159F;
        Tue, 26 Apr 2022 17:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE08C385A0;
        Tue, 26 Apr 2022 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650992869;
        bh=dgLR3TJhT/EC15yAj4pcZSpH0ev/CMEBayE7jUH2n2k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R6yCjZh9Pd5a1cJfpZbK4GvKX+nR4A/muitN3gB2kT+ln6pKlwWs4cb+jM4qax83X
         ItwRgJI57HCHD5rhEVHZymhSUa6z36Q5RVNNAoBDb5nAZo9aWwz8xm4fM2ftT/HkWu
         yxhMqsrvwFA/G6VqWKp6MPs8k+9n70C3ANdRJrJT6PAkUbAQmYKDcHzBjLdK5JTjfV
         xllp1hAQvdKGXQGAjJljA+UylV3BxUHY+rQiZOmFfZ5izY2QQQu7kCRmgYLA4doyRh
         j0/1zc7QdVTdTPeB8gh1qmoOh2wqX0emkCbWyzbc0qnK3+yrTi4ZzgT5AH5JNnNtjs
         tCO95OsDKH+rw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, robh+dt@kernel.org,
        judyhsiao@chromium.org, agross@kernel.org,
        quic_srivasam@quicinc.com, bjorn.andersson@linaro.org,
        bgoswami@quicinc.com, alsa-devel@alsa-project.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        quic_plai@quicinc.com, swboyd@chromium.org, lgirdwood@gmail.com
Cc:     quic_potturu@quicinc.com
In-Reply-To: <1650374329-7279-1-git-send-email-quic_srivasam@quicinc.com>
References: <1650374329-7279-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v2] ASoC: qcom: SC7280: Update machine driver startup, shutdown callbacks
Message-Id: <165099286607.2323572.4725275320203551447.b4-ty@kernel.org>
Date:   Tue, 26 Apr 2022 18:07:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 18:48:49 +0530, Srinivasa Rao Mandadapu wrote:
> Update machine driver startup, shutdown callback functions to avoid
> sound card registration failure on other platforms.
> Without this change, platforms with WCD codec is failing to register
> sound card.
> 
> Fixes: c5198db82d4c ("ASoC: qcom: Add driver support for ALC5682I-VS")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: SC7280: Update machine driver startup, shutdown callbacks
      commit: c85f533d51ca42a461a61303322b0cf74fb75a6b

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
