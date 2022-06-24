Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B350559C06
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiFXOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiFXOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:36:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB3056C07
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CCAEB82925
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646D3C341C0;
        Fri, 24 Jun 2022 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656081347;
        bh=fES71k0ZtQMfRPu9DCT9ZOVYdQvNBjl3fNHC6w3pSEc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Hsmdt5LTyq7cqedpM7gD3mcbjTqTZVbXcWKBNDxL/nyNXh7QuMwjQ7X3ZkyQfEMS5
         Kdh+uekKRjxFdw0vb9b8c6lwbHpQqddsFR4oHiVYwa5BNCUy3eHchli72h2SDIuN41
         eWKSgqEpPHVxgOfnphX4wAtuA0nksQX4p+f8jQbXuc8w9G32PNwcLP4/fB62l3+jqw
         H0LDGLFIFqEz8Kb63K/UqL4SxCQ3FOJjUFbQiuYnFn8KnA0LwJ/rtjmUCDKd0108Hy
         cAyth5zSs6zw/PuBediVxP+YxqQUm/7CT5eQ6Td9KeKJ1juFc97abm97Yy0gvZjprA
         ZtYgphvV7oKDg==
From:   Mark Brown <broonie@kernel.org>
To:     jiapeng.chong@linux.alibaba.com, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, perex@perex.cz
In-Reply-To: <20220624082745.68367-1-jiapeng.chong@linux.alibaba.com>
References: <20220624082745.68367-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix missing error code in rockchip_i2s_probe()
Message-Id: <165608134513.445804.8165290048747586515.b4-ty@kernel.org>
Date:   Fri, 24 Jun 2022 15:35:45 +0100
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

On Fri, 24 Jun 2022 16:27:45 +0800, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> This was found by coccicheck:
> 
> sound/soc/rockchip/rockchip_i2s.c:810 rockchip_i2s_probe() warn: missing error code 'ret'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: Fix missing error code in rockchip_i2s_probe()
      commit: 7f6409fd9b54b6f56444edc996cd28059f215415

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
