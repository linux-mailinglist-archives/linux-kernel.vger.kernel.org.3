Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB449CEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbiAZPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:36:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53990 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiAZPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:36:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DD56145F;
        Wed, 26 Jan 2022 15:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC57C340E3;
        Wed, 26 Jan 2022 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211410;
        bh=ETf0rJxbftTA/jiqhFbDahtNpchbae/ooNKqObBqa/0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oIAHtKbdEAe1uPjUtl4s+b35uf7zk6JlrxqzinelpgnpeTp0OC0UMWgKMcJ+c6j9c
         fnSQKTk/cMS3x6RLwzJrjzeXms2Kuab7iHwVmNPu3e5J0BQPoOppU6wOF2EN+5jSPc
         BFSzC6j2ONieVRw78fvwlVBZhlJgAMrlzl4zLzUik+wL8IyIr4qJKsg5LOfY3CtD1I
         REdurVtCyFWqaGnpLCsJjaCLx9xZS3lpevWrUkAf5EnWXxgRgL7U5WRjT9E8F+jgAs
         0YmqdfG4WM8TFKVi8pgIIDN1NwP4YiZFdsmQvTe2L348oj1HghNeRb7FXxwH7yX1px
         Zox0Cs3CyN7Aw==
From:   Mark Brown <broonie@kernel.org>
To:     Romain Perier <romain.perier@free-electrons.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20211206101931.2816597-1-mudongliangabcd@gmail.com>
References: <20211206101931.2816597-1-mudongliangabcd@gmail.com>
Subject: Re: [PATCH] driver:spi: change clk_disable_unprepare to clk_unprepare
Message-Id: <164321140894.490397.924789471812651456.b4-ty@kernel.org>
Date:   Wed, 26 Jan 2022 15:36:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 18:19:31 +0800, Dongliang Mu wrote:
> The corresponding API for clk_prepare is clk_unprepare, other than
> clk_disable_unprepare.
> 
> Fix this by changing clk_disable_unprepare to clk_unprepare.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] driver:spi: change clk_disable_unprepare to clk_unprepare
      commit: 90cafce461de108bfb07c06148395dc86c3fcd23

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
