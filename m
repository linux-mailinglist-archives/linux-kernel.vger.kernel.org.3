Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711C2583F29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiG1Ms0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiG1MsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4ED29832;
        Thu, 28 Jul 2022 05:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBF19B8243F;
        Thu, 28 Jul 2022 12:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B40C433C1;
        Thu, 28 Jul 2022 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659012501;
        bh=oKG0k/HCujEOjDRj8n7oPM/49lyliRDHFtvxw2due3U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fvlzfp7ghRMCmqTdOLLf2dA33B5w/JPPu+qcpHNBy7C6r3tIpxK2bbFmBhL9Ij8QM
         2xaSzjtvGqWM6WYwHygCYiM1GpbL0SbHlwIDPzp4bUiWnHwAHmxIBPO81JlcIKP2BI
         MzPHghVbW6WAj4XYbr9OqER6tCDRXZJvSCX+tWv1Ym56mqMfc0jAQatiyt5Hy0VWDh
         kEuog6oizp9fOcjPfi+Qaz6u6H6Bgk8CcN6IGgI0ruGujAlpCpJgQ/JPfcsP0XAVmq
         VVCSRlpc9ryeR2WAnQyPe5yrrAhpmW5V6gAWYrulFSlgJi2NlJLK0pR6TOu3T2ATJT
         gBjZyspmM8snw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20211006180810.GA913370@embeddedor>
References: <20211006180810.GA913370@embeddedor>
Subject: Re: [PATCH][next] ASoC: q6asm: use kcalloc() instead of kzalloc()
Message-Id: <165901249963.1738594.15790903946126347978.b4-ty@kernel.org>
Date:   Thu, 28 Jul 2022 13:48:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d1cc2
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 13:08:10 -0500, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6asm: use kcalloc() instead of kzalloc()
      commit: 40d060b8158e26438398bf1132925f666e3b6480

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
