Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E014B5620
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356330AbiBNQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:27:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiBNQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:27:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C40C73;
        Mon, 14 Feb 2022 08:27:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23DA361482;
        Mon, 14 Feb 2022 16:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418A5C340E9;
        Mon, 14 Feb 2022 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856048;
        bh=4OKuG2LEadxl8fctPRW0BKh8+ifLIIssXuNLgxWqWro=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=uOtYrzcA/YsfJA6XweiY/nP1P/mXNGDAyZO/UTBB8rvuilPXUJSLKlAmnE8p6ICkh
         RS7F2VIZiixaCuNIz5LUNgNKDvjWbtBrxrus2rAFWSBTR4gmSMN8X0xfYUl7Dhe8aI
         UhY+nMa/WFlnU4ShMhzobZQmP2K+L86gpdnpFlbzWL1fVva94CAqv+Y1qniV4/2Zod
         iocqggfX4q5RJgZSrY/52XdTaHLjOjkEMIV2IfhbNhOykBguVyTu7JZkjVWIhYD6b8
         bZkwrL6b0T4pkZrTdtthkRGVE25eaphC0kxLd7AhohMTGEFxhrSAx93FkYdggP3kfT
         1fEA2CPcdh+5Q==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org,
        devicetree@vger.kernel.org, quic_plai@quicinc.com,
        robh+dt@kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org
In-Reply-To: <1644668672-29790-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644668672-29790-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH 0/2] Add Euro Headset support for wcd938x codec
Message-Id: <164485604498.2890761.7849400676064736149.b4-ty@kernel.org>
Date:   Mon, 14 Feb 2022 16:27:24 +0000
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

On Sat, 12 Feb 2022 17:54:30 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add switch control for selecting CTIA/OMTP Headset
> 
> Srinivasa Rao Mandadapu (2):
>   ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP
>     Headset
>   ASoC: dt-bindings: wcd938x: Add gpio property for selecting CTIA/OMTP
>     headset
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset
      commit: 013cc2aea0f62f864c8497b8497299bed4a248fb
[2/2] ASoC: dt-bindings: wcd938x: Add gpio property for selecting CTIA/OMTP headset
      commit: 20ea94bc5317475af70f003075e7988715457d66

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
