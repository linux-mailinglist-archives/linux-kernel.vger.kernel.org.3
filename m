Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110D34DB98B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357975AbiCPUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358106AbiCPUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B96E4CE;
        Wed, 16 Mar 2022 13:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3037FB81D4B;
        Wed, 16 Mar 2022 20:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8120C340EE;
        Wed, 16 Mar 2022 20:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462979;
        bh=JU8bh3oAnltrOOy06ldYgVZ5Y6Ez415dRPGhjhNXI+8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dkigp/ew2LlyYiIX/WtQlQxT9L0mCFauK3ZYoa+ytfxD3roeluVrS+NCOM1mGKwfw
         C8MMTGadaO2euJJ5gMh9QlpNP8Yafn/yEDvk/moK2h8D4POeD5z7wZmsiZKjmDW48G
         xbqGpUjVPnB5UirO1+ED3kkBRAq/vQJT55XFubusUeNjiFrhdCwXUk0hH1SAdlqjRJ
         qglioYLXBH7HIVFvUFjwgbSx5W3QnyhUcsTI3tBbhm79uo3QF6Xe2JGjHAmxFefZLm
         f1UNGPakEPDnTfYAvrPML7P9aIvju6uPwfpQpOLkwDDhTB55FwOknkM+pMnrUeGUip
         QYfaSz1hybr7A==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, thierry.reding@gmail.com,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-tegra@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        ldewangan@nvidia.com
In-Reply-To: <20220315023138.2118293-1-chi.minghao@zte.com.cn>
References: <20220315023138.2118293-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: tegra20: Use of_device_get_match_data()
Message-Id: <164746297766.1220434.5469365380012677264.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:36:17 +0000
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

On Tue, 15 Mar 2022 02:31:38 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20: Use of_device_get_match_data()
      commit: c9839acfcbe20ce43d363c2a9d0772472d9921c0

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
