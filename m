Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1747436B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhLNNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:25:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44678 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhLNNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:25:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76B14B819AD;
        Tue, 14 Dec 2021 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA7FC34605;
        Tue, 14 Dec 2021 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488341;
        bh=yXIzX5c7RJNbpI4F05h03Tzmpjdlu8bnLoX68HUsQhE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I+I+uglWydf58yYTyf6fUiz2XTOZOgxTlYnHlj2w99Sv2RVjy5fRAGa0VLRTJtPyO
         P0nBQ3ATZm+nhFCwLOkmYYv9HA0LsZXCD+cSH1OfCaHUr2onJ0rssbWvyC9GDs86Hx
         TCmm8eSCDydyQsBOzzQcjqThuIZlSPUNDOYkFAXn9GrsVB6zBQFBTPbyiAHP1qllrm
         dimujZ8/vovcWZjVs8QTG5FgnKlDrhiqE/XaiWSgi9/mwmX0ZzAwgK9r1z27iE517/
         I24+4rmMX3zD3l86xx5z+3xoWNqI8zzCZ5I9enFJ2a5v9gi2keL5/QYUu7ikQz1XBy
         CdSZoD8D/BZ0A==
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-spi@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210170534.177139-1-marcan@marcan.st>
References: <20211210170534.177139-1-marcan@marcan.st>
Subject: Re: [PATCH v2] spi: Fix incorrect cs_setup delay handling
Message-Id: <163948834010.2873853.13670994709038773953.b4-ty@kernel.org>
Date:   Tue, 14 Dec 2021 13:25:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 02:05:34 +0900, Hector Martin wrote:
> Move the cs_setup delay to the end of spi_set_cs.
> 
> From include/linux/spi/spi.h:
> 
>  * @cs_setup: delay to be introduced by the controller after CS is
>    asserted
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix incorrect cs_setup delay handling
      commit: 95c07247399536f83b89dc60cfe7b279d17e69f6

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
