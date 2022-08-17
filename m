Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6775974C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbiHQRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbiHQRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C08F958
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92EF661222
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2272CC433D7;
        Wed, 17 Aug 2022 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660755950;
        bh=Yn4G40jkutTkprAgt1jA1gv9HiNNbx0FrohF6j9SElE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JHMiiRftde4ztyr+xYc/KByPBkP/hAf2Be2S6ME3hvu5Ci9CsJ7Fy9MF/r5RLyYlv
         KjcuiIj/+S+bzm8ZE9XnX9VLomegsXPQYC/RaruLK6qbram82CO8poNvxWv7bhh0Ym
         BsHzz3EgQ/F2MKgOiZlvoNGsWaLyzHRSOQXRH+2SiNNj6xb0HcXo/aOlSwxqpqTPGh
         hdzVQA5RYrhCcpc87CwV1vEM1TMWt5ccnW/FaI92eRVdjDBAtMvjblvBxPUBVmMQ3q
         IvqBXrbDxirVEq3Fy/JlDrQpNisdQqto+uOGLhU5dJIxmkzPSCDvqPRPHBQNQfwzLf
         sFuQhBqWTJsww==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220817125508.1406651-1-rf@opensource.cirrus.com>
References: <20220817125508.1406651-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-utils-test: Add test for snd_soc_params_to_bclk()
Message-Id: <166075594887.566556.11485960261417126250.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 18:05:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 13:55:08 +0100, Richard Fitzgerald wrote:
> snd_soc_params_to_bclk() calculates the BCLK from only the information in
> snd_pcm_hw_params. It is therefore a subset of the functionality of
> snd_soc_tdm_params_to_bclk() so can use a subset of the test case table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-utils-test: Add test for snd_soc_params_to_bclk()
      commit: e32e23a2b588424aec0c4c4435530f8022318b8f

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
