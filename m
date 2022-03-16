Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC62F4DB97D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiCPUhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358031AbiCPUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD764D269
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D7ED613EF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5CDC340EC;
        Wed, 16 Mar 2022 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462966;
        bh=J8cE2oxTtiVUydoOJrk2olXpmW5RsNMRyw3bjSmHe+I=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=T9Qr3JkC3g+FD01GFXej2Tvf8AsrUWoEY5J9eCgLGZRJSitWgp2vVVYF8lZtVaP29
         nr401EC0hUijGNoOH6At74EMcR+6ncFJt13bc2YOPXylRts+JhHnj7N0CxcM78lQ5V
         NAo+xVjV6DlERoLcf/mQUPZu9MdgnflZnWlD7PgxSAG4r2hahIKueYNSSQPklRc52X
         fH3jK8N+a5krVILHUNNhcBPpBgarZ0k05NmNsS31QLj727F9MNotsODPoZIAl/0xPG
         hDO4j6cQbwjsigORS65FwBhLDLf8WkJavgTnROu+SjIhU4vqlEWqlJ+4KYnbAj3M6T
         IS7c/YJRuLyFg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Miaoqian Lin <linmq006@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220316041924.17560-1-linmq006@gmail.com>
References: <20220316041924.17560-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: msm8916-wcd-analog: Fix error handling in pm8916_wcd_analog_spmi_probe
Message-Id: <164746296435.1220201.18023236522112794929.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:36:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 04:19:24 +0000, Miaoqian Lin wrote:
> In the error handling path, the clk_prepare_enable() function
> call should be balanced by a corresponding 'clk_disable_unprepare()'
> call , as already done in the remove function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: msm8916-wcd-analog: Fix error handling in pm8916_wcd_analog_spmi_probe
      commit: 9ebd62d60edcd4d9c75485e5ccd0b79581ad3c49

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
