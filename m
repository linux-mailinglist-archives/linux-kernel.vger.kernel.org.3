Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32757561984
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiF3Lqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiF3LqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E225A44B;
        Thu, 30 Jun 2022 04:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A8A61639;
        Thu, 30 Jun 2022 11:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1447FC34115;
        Thu, 30 Jun 2022 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656589580;
        bh=B8ISvDEASl8FP59YKzwtXMHgySxwzT/4KstMqaLQL5o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FLT1Xl+igkEAna5MAvod65f8ERT05WB3ErDtcs6yKGTb8XubADtJ40Ru8AIM6vWQM
         Q+ULqAkMw1S/1DhbomngHfKp6IN4Ch0Y6QYH52ugCPKXK1R5su59g2TIIDhz9Tk8tG
         e0T4Kv8saaI7vxjcR3kqn8JQm9HAtqBz4hudBsTTP1wAA1pYHvEBLfPE45mC7X6APU
         mwSWzvcVf+yzfVmUG+wiPeGHEMzMLk0uKCtzTw7kKQnNTK8nxiXCherSLolKqByfFy
         FOCpeHQnrEyzUblulmpVZ+Me7AdTvaYoYPwV0LAR4AsjolUWGzUUE9t13tD13MeE0l
         14sUTDuKSoFBQ==
From:   Mark Brown <broonie@kernel.org>
To:     clg@kaod.org, linux-spi@vger.kernel.org
Cc:     andrew@aj.id.au, joel@jms.id.au, openbmc@lists.ozlabs.org,
        p.yadav@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        chin-ting_kuo@aspeedtech.com
In-Reply-To: <20220622161617.3719096-1-clg@kaod.org>
References: <20220622161617.3719096-1-clg@kaod.org>
Subject: Re: [PATCH v3 0/2] spi: aspeed: Fix division by zero
Message-Id: <165658957778.347350.13855044340681991332.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 12:46:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 18:16:15 +0200, Cédric Le Goater wrote:
> Here is a small series adding some debug and fixing a division by zero
> on a board using normal speed reads.
> 
> Thanks,
> 
> C.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: aspeed: Add dev_dbg() to dump the spi-mem direct mapping descriptor
      commit: 8988ba7dec43aabd43adb1214b922b8873e9da88
[2/2] spi: aspeed: Fix division by zero
      commit: 30554a1f0fd6a5d2e2413bdc05389995d5611736

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
