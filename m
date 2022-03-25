Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08D4E7B70
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiCYUc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiCYUct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7FD2ADD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B55E61D41
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC89FC2BBE4;
        Fri, 25 Mar 2022 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648240273;
        bh=xc0Jb3PKpEDJuUYFldqh9/0DWPQIShZi48qV5UReoxw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C3ryX5W9KH4CtdQCwLkRvdvXsXUz9Jm2oBVqthe5gQXB8UU/JVNdzKi/hiQIIf3Ej
         x8FfC6xa25XJpWDUfIduseeHrMc7BLTByoZhNLJytE53oViN14SrRYHb/rFhl/2OnE
         xXltXkOiXMOZ6JoxRJuzeBsIRd0i7Xpz1LCFzt/yfd56efqZUzhWrprD8QZuYb9SZG
         wtzGwaMEpT61NStZ7H6wo8yUS3j4A3M1RyYTjy4B69YfryszL8DNUgPNzHWmEJ49Kd
         JIzr29gmPzOFwlVALSQAQQkxN8wxhr+jGwfZelb8RKkmvNgSOsI3YBQbsSSXsh3YD+
         SM8MrgIDhOYDA==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lucas_tsai@richtek.com,
        lgirdwood@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
In-Reply-To: <1648171577-9663-1-git-send-email-u0084500@gmail.com>
References: <1648171577-9663-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH 0/2] Fix rt4831 regulator active_discharge and bypass
Message-Id: <164824027262.2690421.16602981472244896326.b4-ty@kernel.org>
Date:   Fri, 25 Mar 2022 20:31:12 +0000
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

On Fri, 25 Mar 2022 09:26:15 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series is to fix rt4831 regulator set/get active_discharge and bypass
> 
> ChiYuan Huang (2):
>   regulator: rt4831: Add bypass mask to fix set_bypass API work
>   regulator: rt4831: Add active_discharge_on to fix discharge API
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-linus

Thanks!

[1/2] regulator: rt4831: Add bypass mask to fix set_bypass API work
      commit: 184ae0e32bc990bba203b60503df89c9f8865f13
[2/2] regulator: rt4831: Add active_discharge_on to fix discharge API
      commit: aefe5fc3000a24869edbf7bb657adf28372ec158

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
