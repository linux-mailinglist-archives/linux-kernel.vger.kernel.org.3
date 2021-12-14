Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C949D474369
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhLNNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhLNNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:25:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C776C061574;
        Tue, 14 Dec 2021 05:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57A91B819B2;
        Tue, 14 Dec 2021 13:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC96C34601;
        Tue, 14 Dec 2021 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488337;
        bh=xs9CT+vT0I9XeRbtg41qzxnI/2QJY28FPfoerDRgjQs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BD44nH7qLcwnHh34FdJHiDW7qsALFz2mZp9Waw9ACsWkS0UHT7mU9VATPk+S9VApi
         r7L7f9SvSf/sFbiJR0lpiFXk7NYXzbsWOg/jdcfPvsFGlS8h+sEeXhHVNlBQy5weuH
         eh+4iVErBr4Nhi3KiRDiaftr3a8Iu3nA/yeQTIoOQGekHMwRvEs6GiNzFOJpkvCYLU
         oCT8s/w5b8123BDZImXGwRaIrknBRCcJpcKEhYW5CnyKJbKmUmd0eTfSPK6piKRIuD
         Vz7t1Q7kSZ2+5Fn5yHntAi5puyWm9wnuYTvQF0R/1pr+IHCfQLxF9AflOWU5Zqpefq
         kDFYgOLnmM6AA==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, tony@atomide.com
Cc:     Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, linux-omap@vger.kernel.org
In-Reply-To: <20211213021655.435423-1-chi.minghao@zte.com.cn>
References: <20211213021655.435423-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] drivers/regulator: remove redundant ret variable
Message-Id: <163948833549.2871967.7166900849826265039.b4-ty@kernel.org>
Date:   Tue, 14 Dec 2021 13:25:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 02:16:55 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from twlreg_write() directly instead
> of taking this in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] drivers/regulator: remove redundant ret variable
      commit: c57dbcab04449ec869561a9056d0de1a07cbb863

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
