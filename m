Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0FD544E78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiFIONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiFIONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:13:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5AC703E6;
        Thu,  9 Jun 2022 07:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2791161D47;
        Thu,  9 Jun 2022 14:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB52C341C0;
        Thu,  9 Jun 2022 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654784000;
        bh=fgW9SgIxOe3MEyVRhxoDRyRIWcYYtHacDWK0P92cUMY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZjjbC/J3NCnWN8ZqPKE0f7wS0KjQMgU+ZIsmeVBQojNwNZtZKb20tQTiNWjEz8SO7
         83S+6TbnE5iViQSPX+U9HoqvzZ/y8TMv+Hcvn9Zv+8yEEd8amNHM2E5xXrVvzSkk3R
         dur1c2JgJdculRxJR4B4yQZLC/WjwkUzTLpKPRoGhWuIi8dy/mDxeroEy+flwClsbm
         r1YTbncXcUP/xjqOtw6XwvV0pVy5629ym485/euNGP7Kg1QCLOsFojmEU1VPwyKlqj
         0MgAAyMkP03AioQzFmYxqMU6Uci/aOFudGY+dQLK4UA/SI35j3UNHuq9LGZ+OQUuob
         s66qzaZNDjw4Q==
From:   Mark Brown <broonie@kernel.org>
To:     yang.lee@linux.alibaba.com
Cc:     abaci@linux.alibaba.com, lewis.hanly@microchip.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org
In-Reply-To: <20220609055533.95866-2-yang.lee@linux.alibaba.com>
References: <20220609055533.95866-1-yang.lee@linux.alibaba.com> <20220609055533.95866-2-yang.lee@linux.alibaba.com>
Subject: Re: (subset) [PATCH -next 1/2] spi: Remove unnecessary print function dev_err()
Message-Id: <165478399889.1092145.5682711038335760840.b4-ty@kernel.org>
Date:   Thu, 09 Jun 2022 15:13:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 13:55:33 +0800, Yang Li wrote:
> The function platform_get_irq() never returns 0, and the print function
> dev_err() is redundant because platform_get_irq() already prints an error.
> 
> Eliminate the follow coccicheck warning:
> ./drivers/spi/spi-microchip-core.c:543:2-9: line 543 is redundant
> because platform_get_irq() already prints an error
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: fix platform_no_drv_owner.cocci warning
      commit: a4f26ba2608c9ff736a9ad1348aa8078f0b03f81

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
