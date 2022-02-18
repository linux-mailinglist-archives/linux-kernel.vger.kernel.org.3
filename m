Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD34BBBFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiBRPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiBRPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:19:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772DA3DA6B;
        Fri, 18 Feb 2022 07:18:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A0361B7A;
        Fri, 18 Feb 2022 15:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69094C340E9;
        Fri, 18 Feb 2022 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645197537;
        bh=D4BKjKmfO9VPwjNBNaV2DWrd8VLCYTCR0ePXzbsAIYQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S7sGT/gsI2grYWYaTbAd1nfgMsDmLuaiQsj0hYGmj9N3TA63870HdRO0Dx6XnnNpq
         RNviPNXdIxgIHtK/mW81bQPf9RoW1l/UhGyx5Juy319WUfhjHRPndb7CUi/8yO0YK9
         gklWtykV0W0jgGfrtDWb7R39PX7XREG2JakCTIeJjTi5fk08MLFlmDkUS3Qcf27DiD
         tfa4s1uUNOa3WZ21oJS8HMJrOeWTeyOOd0EBqvsvUcgN++yzIYonPO1eJ+92tsgyG3
         Ic0i5HyFxmrNL0j0rYlqMICVPIFSh++mcPuevDKjju4jijMzhYBWQ5v8Ys/l0ACL2q
         6k3Ehizk6DQ3Q==
From:   Mark Brown <broonie@kernel.org>
To:     lhjeff911@gmail.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20220217010024.111904-1-yang.lee@linux.alibaba.com>
References: <20220217010024.111904-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] spi: clean up some inconsistent indenting
Message-Id: <164519753613.3453177.8421347157521956741.b4-ty@kernel.org>
Date:   Fri, 18 Feb 2022 15:18:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 09:00:24 +0800, Yang Li wrote:
> Eliminate the follow smatch warning:
> drivers/spi/spi-sunplus-sp7021.c:379 sp7021_spi_slave_transfer_one()
> warn: inconsistent indenting
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: clean up some inconsistent indenting
      commit: 07025ceaac9f4f7a9e1a3285c3216469bf066320

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
