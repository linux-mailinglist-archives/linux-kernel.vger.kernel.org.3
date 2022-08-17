Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F1E597124
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiHQObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiHQObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:31:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804848F975
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDE00B81DEE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E690C433D7;
        Wed, 17 Aug 2022 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660746663;
        bh=8Cxt79lJcoOCLhow0rXoihH+uKypSMqN8m02vofybPw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nrPQswX/hxhZzeSSdtpKOiaJLE74v/Ru9ACezTS7Sv+AdoG9XBHiz14KT2vX8Hwjv
         muNzs6Y/l9aD9zrFoK2SI2uju8ng7unIBjgxs4Qqc9/jzUfdiyqi7ekft9ZQAYjm5B
         j1yupZqONvw/FoCtHi1l2eg1JA8nvx/Hn1tBD104QQhGWJLp1aiImSpujPGzJvQj3W
         sViVoevg8P8iDiMr5eO9+wwffjyy9n5puH7Vp8qDiLtDg5+im3iKUqoLXbqtw9Yqmw
         Utj61PkQoLjPBoYceK5PA012LGmHy7OefNfWaWbqKMBChWOvogWH3GDMmx7ndegyTX
         uP+JBliZx1rQw==
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     shenghao-ding@ti.com, kevin-lu@ti.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220815112715.21617-1-luminlong@139.com>
References: <20220815112715.21617-1-luminlong@139.com>
Subject: Re: [PATCH v1 1/1] sound: Add a new kcontrol
Message-Id: <166074666231.210979.6764076566414910636.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 15:31:02 +0100
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

On Mon, 15 Aug 2022 19:27:15 +0800, Kevin Lu wrote:
> Add a new kcontrol for phase calib
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: Add a new kcontrol
      commit: 4e82971f7b556cff3491c867e8840e7d788693b9

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
