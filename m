Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF874D0895
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiCGUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbiCGUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00E7793BE;
        Mon,  7 Mar 2022 12:39:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A1A614F9;
        Mon,  7 Mar 2022 20:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45C3C340E9;
        Mon,  7 Mar 2022 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685579;
        bh=KN9yxE31a5svK2aTQL4rOTd36S8lUFGws5bJTk0xiWQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=slNCXCaeDC4jT9VEPW1UY69kzV36HL12zqsQgLqXDZMDgQPKZ0I53rxwE/DN0sBPS
         trF8fGd3rn+Z5suybMQq2Se+jJVVQ65E4wcTBTpa476yY7Fknw9+Le5shohZS8pSdl
         QxMIof7Tj3mXsh+znlYWUcKCWusHC+EsbYdQp3UUEht88KVs+MweMnJNdcKNm7WtDf
         tf3n+Popxwfhcsrr6mgSdzRZ3gA4e9gzT0JiGyOz4rzLUYrK6S0Bxa1UHEMs7sQOwP
         suyphoVhLw8n2PwwwQCYvnMRRgTqKsPudiovHBgI94xNe1fGFOg+0fH7kYWcwyGMGL
         7vyCtNczIUDXg==
From:   Mark Brown <broonie@kernel.org>
To:     Xingbang Liu <liu.airalert@gmail.com>, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302071521.6638-1-liu.airalert@gmail.com>
References: <20220302071521.6638-1-liu.airalert@gmail.com>
Subject: Re: [PATCH] spi: qup: replace spin_lock_irqsave by spin_lock in hard IRQ
Message-Id: <164668557835.3137564.7060095667175202829.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 15:15:21 +0800, Xingbang Liu wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: qup: replace spin_lock_irqsave by spin_lock in hard IRQ
      commit: fa0f3db49e10ac61774e1c90167ec79429d6fd56

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
