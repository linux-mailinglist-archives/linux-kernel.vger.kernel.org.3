Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6E4D9C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348755AbiCONmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbiCONmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0C52E50
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE6461639
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B6CC340E8;
        Tue, 15 Mar 2022 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647351651;
        bh=rB15jefk1fiKFT3D0NNHU4Fk5hgD3hG+otjCotjN/DM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WxUAWQttd/6YdYNDkB7yuJP9wMbFpNJObXx1YJykBwSETwW7Bb6AKe7HU3xIR/1oK
         D1BXxiZG+lnwEb3pDqS8LlxqzZ/lE15fBkewaIyckUYd1O9+juyY9rjRe6d1+uF6eJ
         P+/yggdn8A8HFuiUWaGabJseFS70nGtuxk6OIququv0UHz8Y1i21XdYPvbbo4ONSxm
         AqwTvec1OnOJlIBtGe39eZ1MJUw4eC1yeOrWx7Qf8b/aedV/FJ1i+qgWtXad0XRpU6
         cXEZcpp2fUDXq3bq3lECGo1gwZ/uPf4WzkRFe4Kcw7lW7fb4PcMcUpTsIAtzgc3vYA
         mpo1Gd9G24uYA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Haowen Bai <baihaowen@meizu.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <1647315190-16139-1-git-send-email-baihaowen@meizu.com>
References: <1647315190-16139-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] regulator: vctrl: Use min() instead of doing it manually
Message-Id: <164735165025.3687510.16559712947613083098.b4-ty@kernel.org>
Date:   Tue, 15 Mar 2022 13:40:50 +0000
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

On Tue, 15 Mar 2022 11:33:10 +0800, Haowen Bai wrote:
> Fix following coccicheck warning:
> drivers/regulator/vctrl-regulator.c:188:15-17: WARNING opportunity for max()
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: vctrl: Use min() instead of doing it manually
      commit: 8a317e00798ac0893042e63807429ffddce52a34

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
