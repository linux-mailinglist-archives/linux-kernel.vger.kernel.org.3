Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC349B1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353452AbiAYK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbiAYKU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B66EC061763
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBBD1B81751
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92ACC340E5;
        Tue, 25 Jan 2022 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106050;
        bh=7KMZbdLA3JGGWK1HPak5egeulhdFSxR5vmut9dFA5S0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b+eaIpF5SssFfWSjSFSEzXXW62NuSz4G8pOz2GMTki7Lhv3jgnMur2ECDCfDfXNb8
         BFuzxS5mhZ4P4zI4ttbxjgHTswm8Do98+SSMge6EcvJsGxFsjhCjeIe2amDZl2is34
         eQoFKfRj7GGgxYhGO7pHLr0phsK10/Qb/8uwCFUvtStXRYNDb5dd8515wJzFIEmUOi
         1zB+PNTnQ0mQ/CwXCBFO+zoL0u/WXzWJxn9PRH6VUuLA34SXmq7QYiJABc5Vn4MkBr
         cQzWy7knh0LlY4dLb9hoHQuhZ7JKDHrDHCTPidgIAceMkDWrGmfcR2AodJZR7lL7j1
         kX/nMbNwcKp1g==
From:   Mark Brown <broonie@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20220113144259.355845-1-luca@lucaceresoli.net>
References: <20220113144259.355845-1-luca@lucaceresoli.net>
Subject: Re: [PATCH] regmap-irq: Fix typo in comment
Message-Id: <164310604941.74982.2461375736544607384.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 15:42:59 +0100, Luca Ceresoli wrote:
> This is not a resource manager, it is a "Resource managed version of
> regmap_add_irq_chip()". Fix the comment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Fix typo in comment
      commit: 1056c41634d400cf88d30580dc53270030cb0ace

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
