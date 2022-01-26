Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33D49CEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbiAZPhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbiAZPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:37:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15AC06161C;
        Wed, 26 Jan 2022 07:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 830D1B81A00;
        Wed, 26 Jan 2022 15:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD180C340E3;
        Wed, 26 Jan 2022 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211420;
        bh=hNOKklvlwxJZmyMa/W1F50My2/RcSPvGhMZ8nBY8rXk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a7LYtmTn1Ixx/Fo0nsIspm48/FpMqc7WLCEnRJXxEzbRRYn2ue6oY9XDL2hX0JdXk
         nSeQ/GpeujgEgvuCBZz6B3AFD55nqN/gtfT/wEZpHt48k/SjwM+L0Cz84a6ghfoOEJ
         XqAiGOS/2GXKvD2YyPSMczrUj8TPwZiFaMtX+qTLSGe+hC2rximJFNtaHouk1PG86Q
         ozmUko7St0lfBCgs3AWLdO+qjlEJkIG0PJsYDJr3MNQemuy+nqesuUIpfTVKkORw8d
         bu6HaY+ufA9gCIQzMgveg702W/kfs8O5Mm8TSaEEqG0zKWVqReyblQNqybl89vZv7t
         nwJRjou4JUfrQ==
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, guochun.mao@mediatek.com
Cc:     srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Bin Zhang <bin.zhang@mediatek.com>,
        project_global_chrome_upstream_group@mediatek.com,
        kernel test robot <lkp@intel.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>
In-Reply-To: <20220126091159.27513-1-guochun.mao@mediatek.com>
References: <20220126091159.27513-1-guochun.mao@mediatek.com>
Subject: Re: [PATCH] spi: spi-mtk-nor: make some internal variables static
Message-Id: <164321141754.490431.3020669404541003433.b4-ty@kernel.org>
Date:   Wed, 26 Jan 2022 15:36:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 17:11:59 +0800, guochun.mao@mediatek.com wrote:
> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> Variables mtk_nor_caps_mt8173, mtk_nor_caps_mt8186 and
> mtk_nor_caps_mt8192 are not declared.
> Make them static.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mtk-nor: make some internal variables static
      commit: 474fc2e6395d62758e80b9ea65f61339296355fc

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
