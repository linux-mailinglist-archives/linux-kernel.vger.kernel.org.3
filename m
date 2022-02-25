Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0984C4C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiBYRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiBYRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4971CDDD8;
        Fri, 25 Feb 2022 09:35:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 737F6B832D7;
        Fri, 25 Feb 2022 17:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4110C340E7;
        Fri, 25 Feb 2022 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810551;
        bh=yn+4QGgrb+hRdHd7URm2rvtm9OKXT+OZKFqIplXZbrg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A/t86dbFxRwK/irOOihhpq+yEV02CjMZ05GfgR2oppe70ni7L+m0vCmyEMSrb6BaF
         vLkbUGvwZQMX5hPnIp0lXgwiY5sM8rMUkw/y7Gm3QtJCoe3tU61jPwvcN0rUNDcMIr
         3fBEb2KseT2hBANbJUQb6a9LnigH3AipRorE50vWOZeeYnrPhbMNZmNnZHlKCjuTxe
         NN2caP1MgF+n2LSAsmN9HB4FLFcWFk5qQDDnmJMiySfh3ITliOutmsHiNohPt5Y25t
         TxHDwIgFaj5OFw5GafqC4pk5kKhLGfT86/LM0VlTmtq6FRnddQKl/NMVVPzv+/1Yt4
         wn6eZCLx77eYg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, quic_plai@quicinc.com, robh+dt@kernel.org,
        perex@perex.cz, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, rohitkr@codeaurora.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
In-Reply-To: <1645792943-24845-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645792943-24845-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-platform: Update warning print to control excess logging
Message-Id: <164581054746.2548431.12085357818762890090.b4-ty@kernel.org>
Date:   Fri, 25 Feb 2022 17:35:47 +0000
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

On Fri, 25 Feb 2022 18:12:23 +0530, Srinivasa Rao Mandadapu wrote:
> Update dev_warn to dev_warn_ratelimit to control excess xrun logging
> in lpass platform driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-platform: Update warning print to control excess logging
      commit: 5a5d2316a5292222383d4e3589b8f5144f7c9b49

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
