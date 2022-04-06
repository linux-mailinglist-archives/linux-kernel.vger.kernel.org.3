Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E014F647D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiDFQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiDFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6E4758DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F1FFB823C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80402C385A3;
        Wed,  6 Apr 2022 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251722;
        bh=n/JgBGkv76rAadiPYeLsGzGK5LmEb9eNvnNd99U9w1g=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qfzJNddMgQFeTdBNzMoi2OmmWw+A0vNEwfyJ8pC7/lh+AwHChiI3qM3gZRvkTric6
         d/u6k/0vFIc0+csVlI8bNUfzsEcD/pvYbFFviln8iQV4py7OH5TK+/QIM/TsirH0bv
         r1afq22WYMBmbefQqcL/nCsSr0kH3Z3G8Y+dIamOlCW9b4JE+XLTqe9Yn9gFzRmsiv
         d728gKV/FivyBeA5zr4AZB7m7wQa63qee8YDyIujufG7xEWfYV6HCb7r5H/9awI4AO
         A80Ga7MYFp8tYQbUefK9E85bXJaHKmKU6/mGlwdzb01YGG9pcuPtZKunFGtK7no2xE
         BInV5rIg3+2og==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, tiwai@suse.com, linmq006@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
In-Reply-To: <20220403115239.30140-1-linmq006@gmail.com>
References: <20220403115239.30140-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Check failure for devm_snd_soc_register_component
Message-Id: <164925172124.83821.13118805516714327451.b4-ty@kernel.org>
Date:   Wed, 06 Apr 2022 14:28:41 +0100
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

On Sun, 3 Apr 2022 11:52:39 +0000, Miaoqian Lin wrote:
> devm_snd_soc_register_component() may fails, we should check the error
> and do the corresponding error handling.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: msm8916-wcd-digital: Check failure for devm_snd_soc_register_component
      commit: e927b05f3cc20de87f6b7d912a5bbe556931caca

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
