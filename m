Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42A551D63
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbiFTNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350084AbiFTNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:49:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0A2F032
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1954B811C2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51062C3411C;
        Mon, 20 Jun 2022 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730420;
        bh=HHDQX3NlnZLPN1fa0iK8DZnWO6BfR1zyzteOcjoiVi0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jDPIXvHQX18UEYQlx4HNpijY7v08HdK6Z59LniMV9r6zv5YWWaYLYW5omi0xo5tNJ
         52P7pJC3yL817qJOTzi74pG3W7u4Z/7jXhpc7DWmoDsN9qbXbqyTomZp6cfw4YnywO
         EEJVxNjLTLRMQN1V6UoboeIjDmsV+CROjfZe5DP4TwrNJfEc1JJyN/B/a8C5ko9XrT
         X2HCWjphlXV+qI2lCAcoWuJ2G5xfQFw5n/cWypFAuQMewZSrAx+kcJS7vXd0I21Vf7
         M2GPQ3hYyJyz19+E5VOD6xwj2Y5LOg5cKW4cpIgMPfILwACbm/v91EaCZjFutI8SUj
         E5RWkgbTxPEgA==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz
In-Reply-To: <20220617210230.7685-1-srinivas.kandagatla@linaro.org>
References: <20220617210230.7685-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: update ASoC Qualcomm maintainer email-id
Message-Id: <165573041905.667528.13097598599735683089.b4-ty@kernel.org>
Date:   Mon, 20 Jun 2022 14:06:59 +0100
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

On Fri, 17 Jun 2022 14:02:30 -0700, Srinivas Kandagatla wrote:
> Update Banajit's email address from codeaurora.org to quicinc.com, as
> codeaurora.org is not in use anymore.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: update ASoC Qualcomm maintainer email-id
      commit: ad9894ac6cc1c1f7c36451d508d69f6ba677834a

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
