Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92D570340
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiGKMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiGKMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BC064E38;
        Mon, 11 Jul 2022 05:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60175612FF;
        Mon, 11 Jul 2022 12:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D865C34115;
        Mon, 11 Jul 2022 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657543614;
        bh=91LChIjA/yC+gDOQ1hEP/lcsSuByR55QeaCtjgKDdUw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ixwy+O7FgaQ2AsM/+UA6KKdRBxNkbw17vYMJORAplsHoCrqOLs/vvqhrwDven5JVs
         mLiPRkwRWFgdmYPEuDvhUGL36DuWY//J/i4pWw2EO1RKmt7H6kxNKfACjTrtqnLpCk
         kSlZlW1+aiXWRGAzKThEm2sltcd9Mta6u5gnWwsabV3oGEQ1HA+QVtHODeTDzf+hjA
         JxF9aU3LOaGWjqL4CboWLnIU4ZVxFqz0Z0789BKMHk8RB8s+7T3633K9kRMlQNGvxN
         15/OyFBFkLacvWe7VmjgStNydowhE0Hs4T8/jOpb1/VYQH58vsNAdX6AOzk6r2byfj
         Iq2fE5vlvEmGg==
From:   Mark Brown <broonie@kernel.org>
To:     andriy.shevchenko@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220709000709.35622-1-andriy.shevchenko@linux.intel.com>
References: <20220709000709.35622-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] spi: propagate error code to the caller of acpi_spi_device_alloc()
Message-Id: <165754361383.221560.3802799989187684621.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 13:46:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2022 03:07:08 +0300, Andy Shevchenko wrote:
> Since acpi_spi_device_alloc() has been designed to return an error
> pointer we may now properly propagate error codes to the caller of
> it. It helps debugging a lot.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: propagate error code to the caller of acpi_spi_device_alloc()
      commit: b6747f4fba399a73a87fac80ac1d0c952a44b222
[2/2] spi: remove duplicate parameters check in acpi_spi_add_resource()
      commit: cdb0cc9379f1b4fa5ea3e0492bacf8008f3f4e5a

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
