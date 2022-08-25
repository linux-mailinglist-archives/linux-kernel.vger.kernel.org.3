Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E23D5A118A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiHYNJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiHYNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:09:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AECA2624;
        Thu, 25 Aug 2022 06:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C3C1B82959;
        Thu, 25 Aug 2022 13:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E236BC433C1;
        Thu, 25 Aug 2022 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661432969;
        bh=n9FdWV1rX6KZV8pRSmKnIwmA0z4iq3Uo4w9iPI6L1Eg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V1AE72eHteIKzuaYW4Uf10xpfvRpHb4Cur/hwVrYg4J3D8IeFZo0c98NLrEAdkh0/
         7uQ/IMl1ce+FeLPaKoNo5Uohsna9CHPnekxzO6p9jvdS8/s92JZuJXQ/bRWsKky56H
         Xh92dDyvek8cE2FXoy3ZLcwScvY0PqYSDJWb40ru3CJ8ijxGu5VgG1sbAi33rsGf7d
         PX4RDQZCtB7f5FbPHrjnkpSdiNKENHSeePUaqWMsE2UgNZN0Wbk/rF3TdT6hJwyxse
         28lf/QDCEl7ny2fA/SwR3sV+XBc8ae91hbGaQvp7CpYv3z1LtkPGVDnQdiLsm96HnM
         29O9uenpL6+qg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>, tony@atomide.com
Cc:     lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20220825070438.128093-1-yang.lee@linux.alibaba.com>
References: <20220825070438.128093-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] regulator: drivers: Remove unnecessary print function dev_err()
Message-Id: <166143296765.103302.873436683404178323.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 14:09:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 15:04:38 +0800, Yang Li wrote:
> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: drivers: Remove unnecessary print function dev_err()
      commit: d46f737208a45ddff2aef4b57218caa0476af2b6

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
