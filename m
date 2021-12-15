Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB49F47606E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbhLOSOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:14:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37406 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhLOSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:14:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AE61B81999
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FA7C36AE2;
        Wed, 15 Dec 2021 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639592054;
        bh=TP76EnotThLbbhCYm+vAG3sh3TqTKaa+2TLkvRyqmBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E7p3W7Hot+i4JpIYWGwFGk0/0/GAOHYooihWuRwg8rXP4eOhgi+HrzOfbwkU+7dw2
         2InBZ5urhlyWuBVPkjsA9ouBdGB80BVLOfaB/fY/hqaWF1lOMLBgPHgWQ1ZmJPsIZW
         vWaTUgYgNFGFMTXI4wOB7P9nlEiwmNkuMNaiqpWrcA/Bmw1yasxIMinMjwtqkd/001
         HS61PnNiwSJUmAxzKqEGK5r/0qq2bHbkc3Xs/TRANvJEpyrjd28SmKHHw5paluuZxV
         5bv5b12R8ztqWWquLw+m6TVEgrn4weya8+XavwrnHaVDfROLzg2XibMlbGv7aEJ+DK
         IZ7C77Fg4B3gw==
From:   Mark Brown <broonie@kernel.org>
To:     oder_chiou@realtek.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20211215031550.70702-1-jiasheng@iscas.ac.cn>
References: <20211215031550.70702-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: rt5663: Handle device_property_read_u32_array error codes
Message-Id: <163959205325.2218314.11285157350197840732.b4-ty@kernel.org>
Date:   Wed, 15 Dec 2021 18:14:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 11:15:50 +0800, Jiasheng Jiang wrote:
> The return value of device_property_read_u32_array() is not always 0.
> To catch the exception in case that devm_kzalloc failed and the
> rt5663->imp_table was NULL, which caused the failure of
> device_property_read_u32_array.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5663: Handle device_property_read_u32_array error codes
      commit: 2167c0b205960607fb136b4bb3c556a62be1569a

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
