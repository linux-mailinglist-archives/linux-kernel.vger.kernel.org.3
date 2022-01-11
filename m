Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581FE48AF69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiAKOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:21:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60098 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiAKOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:21:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59EA61672;
        Tue, 11 Jan 2022 14:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBEAC36AE3;
        Tue, 11 Jan 2022 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641910914;
        bh=WFkEfIk0EPbaH4qxJesgqVL1hwKqSCeC9eRpCsYeSCU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tmn8ApV+ZT/n93k+ZaXeFgYjILZ7pKrB5724CQziINRpFL6NWh+FhCrJuks02XoHx
         MHn7lJL74Z1TYA5pDe0PIKoifFvUfeElWNs1GY+m1YenuY9d7BfsPCRp4tAdicLj+2
         VeWVIJhrDgc9uiQA1WatdJSNqj/If5PN79CT2U9ELGGRty8zd9oPwvgtf3jpMULCjQ
         iv1V160DDbO9PYvaQuiIlTjjr/mQm75VV/qgjtb5v/aREJBZ4vAVzaMAJOpdCR+DAn
         5tp5EexXN8Ch5VqIK9P1jne3RHQspYE/c/yTnZpt95IeYG+5JvvrgEvnb8o2kMM2nL
         MXhuEKGJ+mR/A==
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Watson Chow <watson.chow@avnet.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20220111072657.GK11243@kili>
References: <20220111072657.GK11243@kili>
Subject: Re: [PATCH] regulator: max20086: fix error code in max20086_parse_regulators_dt()
Message-Id: <164191091249.1756603.9938107427709378697.b4-ty@kernel.org>
Date:   Tue, 11 Jan 2022 14:21:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 10:26:58 +0300, Dan Carpenter wrote:
> This code accidentally returns PTR_ERR(NULL) which is success.  It
> should return a negative error code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-linus

Thanks!

[1/1] regulator: max20086: fix error code in max20086_parse_regulators_dt()
      commit: 879cf8006475642b747aaaa4d06f7044ab2de794

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
