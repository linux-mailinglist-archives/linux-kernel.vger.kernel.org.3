Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0662A596FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiHQNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiHQNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:35:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C02B284
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F01AEB81DBA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A65FC43470;
        Wed, 17 Aug 2022 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660743299;
        bh=eJVtRzX/9/CdVlc/4i2NIHnoFK5P2DVWnF7vucMWtrM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tqIwMh139l3DPFU9GLLlZEgw37Dx4GGCo1Jf0jW/BjEQeNauMBQn0fVM3rPnmhgiB
         DloyYPyUPTOrXcmETHgSX9z3L8yZXqOXhkmleyEMTc8dTyth+Ct1iSqmGZ1QXThHPV
         siGg1b71a1HjkdDwHbuv92TUIrVv+DRFU+oL/Mk3ejecAgYu9wX6UIxSKK6ZrD7p4/
         ZJSnlTgh70uQmV0HJwUH0VdkoDGChJdIg7SsHh4RmsLSNSQdZpD/qM7skE7qPVEaWd
         zFffg6pxmGdSm/PIblPzT77/Xctud0bcY68laQIZJnlkkJ37ZhUzdlMugmFDhRX3jY
         fQo/bkoYYTNww==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220816204832.265837-1-linus.walleij@linaro.org>
References: <20220816204832.265837-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 v5] regmap: Support accelerated noinc operations
Message-Id: <166074329897.125185.17964276260701925828.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 14:34:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 22:48:31 +0200, Linus Walleij wrote:
> Several architectures have accelerated operations for MMIO
> operations writing to a single register, such as writesb, writesw,
> writesl, writesq, readsb, readsw, readsl and readsq but regmap
> currently cannot use them because we have no hooks for providing
> an accelerated noinc back-end for MMIO.
> 
> Solve this by providing reg_[read/write]_noinc callbacks for
> the bus abstraction, so that the regmap-mmio bus can use this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Support accelerated noinc operations
      commit: c20cc099b30abd50f563e422aa72edcd7f92da55
[2/2] regmap: mmio: Support accelerared noinc operations
      commit: 81c0386c1376da54f05d6916936db5220df9f97d

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
