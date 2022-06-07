Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43465409AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 20:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbiFGSL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 14:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349894AbiFGRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:51:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F72C104
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0AB1BCE1D50
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC63C385A5;
        Tue,  7 Jun 2022 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654623510;
        bh=a+3hVu4CEwKHNolyHlKtH7BP/4ObQEO8NwiNOI1cL80=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FB9AYFJrhSiOoJ41euHMFKlYGxQHT3qcWi1/meTwBCgOk4VUHWbhzAa4v5LmXvB/K
         ajcm+AqeXGL/HCvA/Xa07jwCs0czVdxeptxs15vRB4e9404i5cmMhnTy/bU9z/uBs3
         bPkTF0rimOtuiPMeCwWNWoqMWSH9uVHcriI3cgvsASfcUeNhTWRmFEJdhEIcYuQ8gf
         iQfGVGQorQD/XB7DpVEwtoueDBHjcPZpoZW3dthWQEEdnsPNGG4Zh8EA/Pt1rA+J0W
         rnONhaYICxE6gw5L8VJAJ/r0GB3bQxSsqfFJnI728O5gzAXGqaI3BxouqajIJcwl+N
         9T/kyy+ye5+ZQ==
From:   Mark Brown <broonie@kernel.org>
To:     robimarko@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, sravanhome@gmail.com
Cc:     christophe.jaillet@wanadoo.fr
In-Reply-To: <20220607124759.775133-1-robimarko@gmail.com>
References: <20220607124759.775133-1-robimarko@gmail.com>
Subject: Re: [PATCH] regulator: mp5416: remove kernel.h include
Message-Id: <165462350917.3096919.8940550391219657945.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 18:38:29 +0100
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

On Tue, 7 Jun 2022 14:47:59 +0200, Robert Marko wrote:
> Driver does not seem to utilize anything from the kernel.h, compiles
> and works fine for me without it.
> 
> So remove kernel.h include as it pulls in a lot of unused stuff.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mp5416: remove kernel.h include
      commit: a8280a5dd5a425bd33d858ac787defdbad47362d

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
