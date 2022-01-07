Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4F487900
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347812AbiAGOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:33:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38376 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347818AbiAGOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:33:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBB0AB82644;
        Fri,  7 Jan 2022 14:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEB1C36AED;
        Fri,  7 Jan 2022 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641566003;
        bh=XpC4iy3Wb54mjzJCc5dEyAGx4lQ5Vi8idM4VXGnKmRo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=auRVN/jTzeqI2OT5yqvJPIWAWU45SnSvRphCF8M6vGCERAgfPjKnBLyFSfnk5Tdt6
         uxJ7aDQnIXrIwN3FBsfJyc19DlH5DYBHwr5ypL/uMOjFh1NAC0f61yEM+OZAnzniTH
         nFYOL4U7z4kYi4SunO+I/SstlM6sPpo8C6/QONsOnhTjo2z+7w/qIlalMLGGvcqUTo
         ZXMnrd6RqfU1FQY3DJ0mY3KbDl98unPyUvK7TIK16R7fScszQeDgPmRJxXyUA61bFe
         h7USu0CD4PevQgzGEWIPXx4SD48Xc19UlEKu/2cFF1ZdxDLTV+vja8CY31olxXdo+5
         NXXpO3gBRteHw==
From:   Mark Brown <broonie@kernel.org>
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220107024631.396862-1-qhjin.dev@gmail.com>
References: <20220107024631.396862-1-qhjin.dev@gmail.com>
Subject: Re: [PATCH] spi: atmel: Fix typo
Message-Id: <164156600175.2077509.8473980991619848547.b4-ty@kernel.org>
Date:   Fri, 07 Jan 2022 14:33:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 10:46:31 +0800, Qinghua Jin wrote:
> Change 'actualy' to 'actually'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Fix typo
      commit: c8c9cb6d9fbeace1c5509f4bb2f3c32095cda0d0

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
