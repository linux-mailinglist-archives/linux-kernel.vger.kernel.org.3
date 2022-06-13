Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBC549D60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348501AbiFMTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351329AbiFMTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2615B53A4D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B697F60C7C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D829C385A5;
        Mon, 13 Jun 2022 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655141075;
        bh=Yfd8oObXlM/ZCWAU7i0mU9j0IUS8Yl6DblSQpJitmMw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C5eKTx9eucuFYYu8JuLnFw1I1MydHnPyC+B4YNp1yNeWNu/cbpVB8grEPD/ZAaqMX
         qtZ0/QCbgSUR4FLdot2sUviil3JMTUvcUXAB1EPhB7aIroi1VMFUvSc0ZJhyt8ZYcF
         +QWeGhuXIIlpsJdGRvYp/I/ndr4yIIY6rrYY4NBZvBs67gDjVoAZaAoAix4JYzCZml
         mQX53zLKU3YlRMcNTj60lP/Uirzy0GZYCxLvq6540Cp5Q94+UwhH3rXCMcpGy07c5x
         pbXvRgwv//Wg1A1zKWcQSNExwWES43oMyldAFOmOAH6GcC2lASy8hrZl6F2Bmce7fM
         HARuI8xX0Oxcw==
From:   Mark Brown <broonie@kernel.org>
To:     David@fries.net
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <YqbNnSGtWHe/GG7w@spacedout.fries.net>
References: <YqbNnSGtWHe/GG7w@spacedout.fries.net>
Subject: Re: [PATCH] spi: spidev_test: Warn when the mode is not the requested mode
Message-Id: <165514107437.671611.16068844407175899226.b4-ty@kernel.org>
Date:   Mon, 13 Jun 2022 18:24:34 +0100
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

On Mon, 13 Jun 2022 00:39:41 -0500, David Fries wrote:
> Print a warning if the device mode doesn't match the requested mode.
> The user doesn't enter the mode in hex so it isn't obvious when
> setting the mode succeeds that the mode isn't the requested mode.  The
> kernel logs a message, it will be more visible if the test also prints
> a warning.  I was testing --quad, which is unsupported, but doesn't
> cause the mode request to fail.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev_test: Warn when the mode is not the requested mode
      commit: 41ecad2c3cce807abf32bff879cef5dfcacae363

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
