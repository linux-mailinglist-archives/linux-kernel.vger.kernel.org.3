Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC242461C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbhK2QvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:51:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44784 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346054AbhK2QtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:49:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC2C2615B4;
        Mon, 29 Nov 2021 16:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AB5C53FAD;
        Mon, 29 Nov 2021 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638204361;
        bh=blHCuFSgnzoonBNL41NypLd/Bi9PMrGDZmo3EyI0HK4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nvJwEl1kcTnyplO4R2LB8soCnO+uiVFpq2RoGIFriNAun5nipEZnQ1b8TMcCQtzYD
         fo3tvXhD/QfsCTE23Rsh2LBxYvQHeLfIWsTJ2UhSvfuNkEVsNa5dq6a4w6etnJ/otj
         tENadgrzxp2hPQw1j9Cun8WlCKjJoVTLUBZyi8iD62b0ceTwH48Ifz3ZRE6wAtG4jL
         FqlPck9agpfn5q3gFnjQcCQnxjDWaNfVIO8+2C5fx/YdRMCENQi/SEB273ZcmmjLCT
         H84h2sqj8sTSgu/IDq9ZEmM5KqCY5aHXU4m0wJbwyOFpRVjO7VD0khoD5WV8MVHdCT
         osswrD9e2EjeQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jonathan Cameron <jic23@cam.ac.uk>
In-Reply-To: <20211123192723.44537-1-andriy.shevchenko@linux.intel.com>
References: <20211123192723.44537-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] ARM: pxa/lubbock: Replace custom ->cs_control() by GPIO lookup table
Message-Id: <163820435904.1716922.8146043021583191938.b4-ty@kernel.org>
Date:   Mon, 29 Nov 2021 16:45:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 21:27:21 +0200, Andy Shevchenko wrote:
> SPI PXA2xx driver supports GPIO chipselect by querying for known
> GPIO connection ID. Replace custom ->cs_control() by GPIO table,
> so the driver will use generic approach on this platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] ARM: pxa/lubbock: Replace custom ->cs_control() by GPIO lookup table
      commit: 342e3ce0f6f4691b31b1c7c9c3ae37160c4a82d2
[2/3] spi: pxa2xx: Get rid of unused ->cs_control()
      commit: a9c8f68ce2c37ced2f7a8667eda71b7753ede398
[3/3] spi: pxa2xx: Get rid of unused enable_loopback member
      commit: 8393961c53b31078cfc877bc00eb0f67e1474edd

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
