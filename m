Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137694F4156
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381937AbiDEPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346600AbiDEJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24220DAFDF;
        Tue,  5 Apr 2022 02:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C87C9B81C9A;
        Tue,  5 Apr 2022 09:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81866C385A0;
        Tue,  5 Apr 2022 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151061;
        bh=L/0Q71877NZ2dI0wBiiMHZiv88UEejC3hMOyoQIhhOM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AgDJjONY1wQTxOWX0xahtmDF9bEXicjJL27tCntdMedb4VNO9KYvVoiAWMZPjA7Lj
         5NnZrRhEeZ9zt6Pa0v0rHidk3XSkliXvAN+6REZapyLd168aFSyhQUMPoT5KUlGiX9
         ePo3rAwYd/Yl29hQUC1h1tC6GjJf5RFlNwriiPrAo8/j8ff3cJBV/w39v07IR114oQ
         AdcExNHquO/rGrr82eqJTDlim0QeYHEdOWUdYFS6eulDqg16E2wPB1WyIxiN3IHc3u
         9Bk+i9XHTAC2gT9z5/hqWISvs0kDF3NYSuEWlES2a11NSIwETChz3aEgX1Ye5jeVGr
         AoigEHcyZE+IQ==
From:   Mark Brown <broonie@kernel.org>
To:     quic_plai@quicinc.com, srinivas.kandagatla@linaro.org,
        agross@kernel.org, judyhsiao@chromium.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        quic_srivasam@quicinc.com, robh+dt@kernel.org, swboyd@chromium.org,
        tiwai@suse.com, bjorn.andersson@linaro.org,
        alsa-devel@alsa-project.org, perex@perex.cz,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_potturu@quicinc.com
In-Reply-To: <1647965937-32203-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647965937-32203-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: codecs: Fix error handling in power domain init and exit handlers
Message-Id: <164915105825.276574.11537900689104070957.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:30:58 +0100
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

On Tue, 22 Mar 2022 21:48:57 +0530, Srinivasa Rao Mandadapu wrote:
> Update error handling in power domain init and exit handlers, as existing handling
> may cause issues in device remove function.
> Use appropriate pm core api for power domain get and sync to avoid redundant code.
> 
> Fixes: 9e3d83c52844 ("ASoC: codecs: Add power domains support in digital macro codecs")
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix error handling in power domain init and exit handlers
      commit: 1a8ee4cf84187bce17c76886eb6dd9389c3b99a8

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
