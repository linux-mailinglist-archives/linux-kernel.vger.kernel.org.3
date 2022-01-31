Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911CE4A4C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380552AbiAaQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:39:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48100 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378669AbiAaQjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:39:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 560D5608C1;
        Mon, 31 Jan 2022 16:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF5AC340E8;
        Mon, 31 Jan 2022 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643647181;
        bh=gh0ij36m+BkjuG9o19AVvOS7Qg9b2ckuyQQVFCDdQZE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z3K0Gir315HthdqnazCCJ/E96tk2sk3bdH+Q+n0BR6QlvRs8hgqXomtzEtb09TwMe
         vfRErpaa2vSxGIUxun/nhRTk1fVyS5h2LjSpIU+ztxqKfZdHHUic75EhA77maoAgFH
         SSrkFvPAdMs9bb/miCpYOWHY+8yqwhMfK6/vxWkU36LZdFbczFB27Smkv767dYtPRN
         6UsaGH9RYn7hLr4u0eJwpqG6uJO2adfig9YrT62Nj4OYSNoKzkrhVoXtq8gRvJdTB3
         0ljWZ9MtmPG8fvgikE8KIuKP9BSMof8TUOUlqSds8gcBMCutatvVQvicovJwNpb2WU
         piuYWJh8JebNg==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220131141708.888710-1-benjamin.gaignard@collabora.com>
References: <20220131141708.888710-1-benjamin.gaignard@collabora.com>
Subject: Re: [PATCH] spi: mediatek: Avoid NULL pointer crash in interrupt
Message-Id: <164364718000.1030778.7318932635935946052.b4-ty@kernel.org>
Date:   Mon, 31 Jan 2022 16:39:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 15:17:08 +0100, Benjamin Gaignard wrote:
> In some case, like after a transfer timeout, master->cur_msg pointer
> is NULL which led to a kernel crash when trying to use master->cur_msg->spi.
> mtk_spi_can_dma(), pointed by master->can_dma, doesn't use this parameter
> avoid the problem by setting NULL as second parameter.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: mediatek: Avoid NULL pointer crash in interrupt
      commit: f83a96e5f033fbbd21764705cb9c04234b96218e

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
