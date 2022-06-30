Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C3561ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiF3PKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiF3PKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016012B193;
        Thu, 30 Jun 2022 08:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 926EB60E94;
        Thu, 30 Jun 2022 15:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382C2C34115;
        Thu, 30 Jun 2022 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656601818;
        bh=kns8+0qB725KuYwFrosVJmskFRLv475UVQh24jxqzZw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WrXzuKEL8eXydybg6sjJbvmscFiKhPlUHIJpUtZxuOJCd/rTV+d9ja4wH3dd1+H7T
         ErfJZinZnpjw4d+d4JrFD9T34LMc4CxF/xqXdnqCBZd1DRCDsH9SD49poMgCSnu7Cj
         Iv4SGD6GdR11jwQ5rLxXKnMrPbsbOnX9O5aQdHIRXeEQCSQavSfP7xBCRtHsD2iAIS
         vPdbLz9KOs5YVDCP9gQjsmTo9YMi2mj73Az+FICT7h646wa6ASCOR6rKXTfNs55PrZ
         oecVsVZ3hFiul7itI7kAG4tKsZyCkePxEHYVQRBaGyIZ4QGutRt5rj8y+Fq0F/+Geh
         /iOZkBn5AoOhg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, thierry.reding@gmail.com, lgirdwood@gmail.com,
        jonathanh@nvidia.com, kunyu@nfschina.com, tiwai@suse.com
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220630020347.7148-1-kunyu@nfschina.com>
References: <20220630020347.7148-1-kunyu@nfschina.com>
Subject: Re: [PATCH] sound: delete a semicolon
Message-Id: <165660181594.664251.10913007808464337942.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 16:10:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 10:03:47 +0800, Li kunyu wrote:
> extra semicolons could be deleted.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: delete a semicolon
      commit: d8d6253b36f55d199590ef908712fe52bb39ee97

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
