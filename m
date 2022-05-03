Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA2518905
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiECPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiECPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D59C3122D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C54BD6168F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD40C385A4;
        Tue,  3 May 2022 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593064;
        bh=hSdtLWnFhnL+q2IrRIAJ6CuFJO3duTcEEuWOiCS1WYw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YwrW16WNgVDzMoiIpkKmDkKdOtSX5LTMCQr41Lpvv3f5BO+DQJBV24PAlSiwChsS1
         4UWIDcN5BC7LvDQpT034JUcgovUvvc9CBsNgxfdYeErKZRFG/U2o68Cm5yQEb8tPaY
         KMjEa4FjWRcsmi5tBn1ATUJih5zlpXQY5tpCB2Cl6hy6IHYmAbPiXQm3B4f/8Od9qm
         9gAp4RxtEWWHrUKH9r/V9/YGFpo5UTL/wQiFbZsUz8rM5uLNomKSQzjSEu/VMe4Fl1
         ydaqomZh4tbG6UNexpd/m7nGuKo9FFhHGkIeLGBMhXBhbG4g+VVuACPzDUNukANo2w
         R2PL8ZZSywajQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, steve@sk2.org
Cc:     linux-kernel@vger.kernel.org, wsa@kernel.org
In-Reply-To: <20220501171009.45060-1-steve@sk2.org>
References: <20220501171009.45060-1-steve@sk2.org>
Subject: Re: [PATCH v3] ASoC: tpa6130: use i2c_match_id and simple i2c probe
Message-Id: <165159306303.184114.6148689854400519585.b4-ty@kernel.org>
Date:   Tue, 03 May 2022 16:51:03 +0100
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

On Sun, 1 May 2022 19:10:09 +0200, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
> 
> The i2c id table is moved up before the probe function, as suggested
> by Wolfram Sang.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tpa6130: use i2c_match_id and simple i2c probe
      commit: 55d2a66cfec6a4196243940f754f5b34dd2106bf

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
