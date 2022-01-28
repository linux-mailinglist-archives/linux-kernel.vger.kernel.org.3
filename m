Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1E49FD67
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349874AbiA1P7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349852AbiA1P7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:59:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99BC061759;
        Fri, 28 Jan 2022 07:59:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A047160EBA;
        Fri, 28 Jan 2022 15:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142A4C340E0;
        Fri, 28 Jan 2022 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385552;
        bh=Q+BPaVhBVlW6t4xHAF0VLYQt97JYB6FoKzavbL55ZHI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S9Mpsco7qCfmzeupEOyoqLxlHvn624icZbHOwhqyOfQa/fzhzqvUNKP3IW1iXN+Bh
         v+nMn9R2jKpaJbVz0waAEceREATYi0yVBnRDtC5bVu5IU9sm8NU3LtCnf6vOjx8Pzf
         nh2Ri4WaM475ZtupJVFJnt2ioGmV2wHAlqPdmHxnh5x6ChIDE6ZksJWruLyYTNWtKg
         pC+1ouKsRRV9pNVZ/2098jbz9dNY/qxMhIgGMQSLvIyZsev19ydKKpw4O0EVEDlfBL
         HCbKQ9MYNl4X8QyJS3wXoCkqkNCmOROea+eooIRONTIKNl9JZQDrpRtSV6AJovIibF
         P1VXKTxlm9DwQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, lhjeff911@gmail.com
In-Reply-To: <20220127115815.3148950-1-yangyingliang@huawei.com>
References: <20220127115815.3148950-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: Fix missing unlock on error in sp7021_spi_master_transfer_one()
Message-Id: <164338555080.1711510.748078666368788162.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:59:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 19:58:15 +0800, Yang Yingliang wrote:
> Add the missing unlock before return from sp7021_spi_master_transfer_one()
> in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix missing unlock on error in sp7021_spi_master_transfer_one()
      commit: 20dc69ca1023b7e4c4af3c3495aa5a91e1a9be39

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
