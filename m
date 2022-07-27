Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684125833F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiG0UKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiG0UKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 16:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29A56B97
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F1A761A6A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5837CC433C1;
        Wed, 27 Jul 2022 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658952639;
        bh=RLryZK18O+ABsv/1lGgmCNX3hO98CNsOxCCA0dlEy0c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Naxm0hKo/NSRdQvPmAeLlnmypQ7jOKaUjRzxct/QSxvI9l8egmZ4Xb8lUi3wtDvcx
         arMIjV9oJ6sXYSemhWE5LSB38K2GZYXjdK3+uKebmttlN/3xlcOUH/gU/Fqy5sNM+7
         bRS24pn0ue728Mr4vzSKziDQtGG12zpC6Xrn06lRpP+o3sPWk+luVD3xu+UFKsoKl7
         BO5jjnhbE296lmIseT5u/OJitR6/cHpB3yVEloKR5l5xCwl4K2+DGF2wGsSA0az0fA
         jaMKUl57ffL91dIq1ov2m2EEoW++GHz2UN/VZjlARDpvuSJ/thJnBCcLounLnS/x+d
         3WLEe5jVrP/Eg==
From:   Mark Brown <broonie@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>
In-Reply-To: <20220727132637.76d6073f@endymion.delvare>
References: <20220727132637.76d6073f@endymion.delvare>
Subject: Re: [PATCH RFC] regulator: mt6380: Fix unused array warning
Message-Id: <165895263806.3544585.667891678901862229.b4-ty@kernel.org>
Date:   Wed, 27 Jul 2022 21:10:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d1cc2
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 13:26:37 +0200, Jean Delvare wrote:
> With the following configuration options:
> CONFIG_OF is not set
> CONFIG_REGULATOR_MT6380=y
> we get the following build warning:
> 
>   CC      drivers/regulator/mt6380-regulator.o
> drivers/regulator/mt6380-regulator.c:322:34: warning: ‘mt6380_of_match’ defined but not used [-Wunused-const-variable=]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6380: Fix unused array warning
      commit: 9cc0590ae351a354c51375a1ee22edc2e4931fd0

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
