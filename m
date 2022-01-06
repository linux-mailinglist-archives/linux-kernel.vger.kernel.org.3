Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814D3486B28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiAFU2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiAFU2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A670C06118A;
        Thu,  6 Jan 2022 12:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6FB61E16;
        Thu,  6 Jan 2022 20:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF730C36AE5;
        Thu,  6 Jan 2022 20:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500916;
        bh=b/lnSyPUZvmRkpkf3M9HGG79TwkLoB+cQSoOb4PH7Ec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qtGk2179/FtqC4QB0oJSeU9ORB8b6AkTj8Uu/cjbWBOesVnIv6M1j51qdox3CyQZU
         yUqH/OYdl2+fLjx6Yu9iXaj/VRjvCSIMPBaXLaP0iwA2/m1JYfEBAH2QJySWNUt5Fn
         VROc59x/OES7coCycWFV4u6KTQ8Y5JGfXeRSzwh27KOFSv/F68ITLR9hjApzvm4tfi
         xSa966zi0N8LwR0wfDogdIzmmCMSefu3kUseKTgFyloiZJ9nPzoziOpdtt0vhGNT6p
         0UNoq6XCW3UDcjhI+G70PmXnYbzWtzrb0OVRyrSmQb+c/h3d2ox6AUf19UZ2uhbzxe
         TBXtK5zzFRtJA==
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20220106182518.1435497-9-robh@kernel.org>
References: <20220106182518.1435497-9-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Fix example 'interrupts' property
Message-Id: <164150091444.2243644.7719770746568612726.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 12:25:17 -0600, Rob Herring wrote:
> A phandle for 'interrupts' value is wrong and should be one or more numbers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: mediatek,spi-mtk-nor: Fix example 'interrupts' property
      commit: 3e718b44756e2829e7189a9504aa7a6d7f394d6c

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
