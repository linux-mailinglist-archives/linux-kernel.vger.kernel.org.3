Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50450B81A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447811AbiDVNR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447845AbiDVNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:17:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05C2580CB;
        Fri, 22 Apr 2022 06:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D404B82CC4;
        Fri, 22 Apr 2022 13:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C385C385A0;
        Fri, 22 Apr 2022 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650633285;
        bh=ORwNkiby2RNyL2m/1KS8cO2QComBwAdtXIB1jK0vHTo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=BaQ4NKv6TDZwLyR7t3vX6hDJSB/p1GExF2pBumfyITdm2Kiv/o2ngfY2Mj3Rqqi2F
         2bKWHXhwvJRZW85sE14gnU2TQQYEO5MdrsuakCzD+xHbItXdshUykMBqnlHXw/5mco
         svzTdCfQTwQ2HfXWGHCZoDgH3OuYz3uhZ6pUlDGxwOhrX9jUoW41I1FGrqw5j5+jYM
         e4rT2InR2TptOavNtxj/EBYZ0lDmUgY+zfNjEcgkuSj8Ay74KowdpLVO56WhJFGz8+
         +B4/P1jHkfj4SMQcP5vGh0Iog6jct8TSt32w1JjZz/80SVtuPVnmb9gYMHzbMmEzV5
         QwXMD3d0CW8JQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, zhengyongjun3@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220422062641.10486-1-zhengyongjun3@huawei.com>
References: <20220422062641.10486-1-zhengyongjun3@huawei.com>
Subject: Re: [PATCH] spi: img-spfi: Fix pm_runtime_get_sync() error checking
Message-Id: <165063328423.414237.5668240958783910154.b4-ty@kernel.org>
Date:   Fri, 22 Apr 2022 14:14:44 +0100
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

On Fri, 22 Apr 2022 06:26:41 +0000, Zheng Yongjun wrote:
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1, so a test for negative
> value should be used to check for errors.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: img-spfi: Fix pm_runtime_get_sync() error checking
      commit: cc470d55343056d6b2a5c32e10e0aad06f324078

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
