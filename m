Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87C950A445
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390103AbiDUPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390157AbiDUPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2459443FB;
        Thu, 21 Apr 2022 08:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 518FAB826C3;
        Thu, 21 Apr 2022 15:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D584C385A1;
        Thu, 21 Apr 2022 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650554977;
        bh=EKJGYb/V8GuIQV2zCWM7O0DO+UDppn4OJfYvUz7po+4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KBNkMN0czT2PfINytqkWxw1iGN4gSdEllXA54JqEFZuLV9p9bixBRSxFeZKAU9/0s
         7BPtvbembm1+MwxHSY0i4mtQ5XPeZ0WRnQD38MTtlsrQCFPxPHuZE+AIz7jnHaG8f8
         0FP9oiLMkEk3tFOFZBrJ2XzSi86RFOCp9KzTYcwj8ozU0LDgvNRbYPG37sctnCBvRs
         +kXi5SWfTAEmJ+q6KKcefT+QlZEEl8HsxdaknJpbDBAUojHtkGtOZL4Y/o9eHxqqaU
         POI5VH07vxnQHLGMsfaPBIKlnmrAPnMgkDxdJLxrVHtViSsGnXnq5waTbQnfV4qDB1
         YnS1BncQVESGg==
From:   Mark Brown <broonie@kernel.org>
To:     p.yadav@ti.com
Cc:     tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        tkuw584924@gmail.com, michael@walle.cc, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220420102022.3310970-1-p.yadav@ti.com>
References: <20220420102022.3310970-1-p.yadav@ti.com>
Subject: Re: [PATCH v2] spi: spi-mem: check if data buffers are on stack
Message-Id: <165055497529.347641.5916575094061881222.b4-ty@kernel.org>
Date:   Thu, 21 Apr 2022 16:29:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 15:50:22 +0530, Pratyush Yadav wrote:
> The buffers passed in the data phase must be DMA-able. Programmers often
> don't realise this requirement and pass in buffers that reside on the
> stack. This can be hard to spot when reviewing code. Reject ops if their
> data buffer is on the stack to avoid this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: check if data buffers are on stack
      commit: 8868c03f3ca584abec7bb53d6c3f7c5ab6b60949

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
