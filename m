Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7A47E6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhLWRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:18:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51698 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbhLWRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:17:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6D08B81CB9;
        Thu, 23 Dec 2021 17:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E29C36AE9;
        Thu, 23 Dec 2021 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640279868;
        bh=PYFd/8WKxYSicgciwMr/3nfIc685h5djJrnBhSTvnsk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eRlp0CE+kl1y6gybl6CWA7O8k4G3AsXUYVVIu7HjjWPFDvoAlMbes12UDJG70gq2E
         K8oX2nmvNjnZFp2lTMGBqXV+1R/C1K/ERBr6sACJT/lBwfnR6w17KYkjR5zzYrgQmP
         78ZSBjx3VZMlRCmCG4R+cLKeWYm7dQvLqUHbZW43Os5LBQ1Sxw9OLh9ZAcaVY36sNC
         qFP1J8kPq3o4EoYQS28px/w8RqaqmC3o2cFli2aA245x7OE+HMsrhziu6039KSkEsj
         h3T9lWTAblfzeJI1bmbXZ0qm1yMcOpeU6FG7OqiE1UjT3N+xfbDmKINEBbJRRxU9Li
         MHsy4mgxbU7RA==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Mack <daniel@zonque.org>
In-Reply-To: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
References: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] spi: dln2: Propagate firmware node
Message-Id: <164027986671.1292948.16058553633248228163.b4-ty@kernel.org>
Date:   Thu, 23 Dec 2021 17:17:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 15:54:21 +0200, Andy Shevchenko wrote:
> Propagate firmware node by using a specific API call, i.e. device_set_node().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dln2: Propagate firmware node
      commit: e6609c26b3ab71aa3ef2f7f9524a066a863a7f18
[2/3] spi: dw: Propagate firmware node
      commit: 27b6965ccb72e658eb2235f564a04d2775c956cf
[3/3] spi: pxa2xx: Propagate firmware node
      commit: 12baee68b2df6847f9a26ee82f30aa5f52c6d0d2

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
