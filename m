Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B285AB27D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiIBN72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiIBN5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA06D6B9A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4756E620A5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C8DC433D6;
        Fri,  2 Sep 2022 13:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662125433;
        bh=EhfAqx7+9bqHRSvR8s0IzuAeBJ94yTCCtgQttzyRyrM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T8egBlM44VGvdGuf/AABYh9pMmfSkUlbBA6v8xFzS4UMIm9lwLlsnqdYsKnkar+P8
         u4xqYuAy76I4ZfYqoUyjPDSS86C8eDGGvxGkl2u03chFR5kcgxxKDxDJPYqVxHmSDY
         4xAEWIUqShXzMtnOirb7oAdiZbcFuKOG/iJjsgdCXYizHIQ+wQDCuOg2u5j/sJRbC3
         G5JXnSbKNgh8p6EAzeuZHeAuCd/Gt8WAVqXIq4cSDDRCJinJlJvTdvsAAx24mJqgtY
         1LojI21lxF/gG/a+hf0DfcylydAiR1Q2pgZdAN75WRl5nk/XB+Y5j3E9xwZVMb+VPT
         6frM37yANPD5A==
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        kuninori.morimoto.gx@renesas.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220902013030.3691266-1-jiasheng@iscas.ac.cn>
References: <20220902013030.3691266-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] ASoC: rsnd: Add check for rsnd_mod_power_on
Message-Id: <166212543201.44289.12872080973862311815.b4-ty@kernel.org>
Date:   Fri, 02 Sep 2022 14:30:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7d1a0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2022 09:30:30 +0800, Jiasheng Jiang wrote:
> As rsnd_mod_power_on() can return negative numbers,
> it should be better to check the return value and
> deal with the exception.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: Add check for rsnd_mod_power_on
      commit: 376be51caf8871419bbcbb755e1e615d30dc3153

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
