Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927A34F649E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiDFQAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiDFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FA4758E4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F8D8615B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EC5C385A7;
        Wed,  6 Apr 2022 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251725;
        bh=wrlDarUYr+POHLopISxa2klaErhzsz1GFbTKgE4YGMQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=hptvgCYbXfPVMNu4m4jzXX5XKLZ+8spVqUxqesj7+kKljTkTZXRdUMBGSiO4IwHAS
         uev6Ca/DMhcBHB7QvdZW6dTp9SZbU0M6bjfPH3rNgfyFbuBDRJcR/7TEXbIcR08i2B
         tdSQWEGfbUSPwUUZRZa3IcACiZBcvpoUKlf10Gy3jlQzVcVTKktXvyrR/dT0+T17P2
         Vir6B6DzJEfeK6XicRH+xjKF2bGwp1lZVvSqmAJ3YkoIrdtFFczsJ3mm9JUFU24f2w
         7iYNoZqGzpkcV64hUuo6iFUJBdZC6KpujTdOGIpynnRKqooIOAYTarQQiJfweOy6eF
         RDIalhj67V7EQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, colin.king@intel.com, tiwai@suse.com,
        weiyongjun1@huawei.com, jiapeng.chong@linux.alibaba.com,
        linmq006@gmail.com, frattaroli.nicolas@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        lee.jones@linaro.org, macromorgan@hotmail.com
In-Reply-To: <20220404090753.17940-1-linmq006@gmail.com>
References: <20220404090753.17940-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: rk817: Use devm_clk_get() in rk817_platform_probe
Message-Id: <164925172314.83821.3548187523065750918.b4-ty@kernel.org>
Date:   Wed, 06 Apr 2022 14:28:43 +0100
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

On Mon, 4 Apr 2022 09:07:46 +0000, Miaoqian Lin wrote:
> We need to call clk_put() to undo clk_get() in the error path.
> Use devm_clk_get() to obtain a reference to the clock, It has
> the benefit that clk_put() is no longer required.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk817: Use devm_clk_get() in rk817_platform_probe
      commit: 8ba08d3a367a70f707b7c5d53ad92b98b960ee88

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
