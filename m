Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B45408BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 20:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349121AbiFGR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348150AbiFGRkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9086B003;
        Tue,  7 Jun 2022 10:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AFB614D8;
        Tue,  7 Jun 2022 17:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948BC385A5;
        Tue,  7 Jun 2022 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654623214;
        bh=Lk4+xjJRHwdFc/LovKppznE7yFQsbzVIbVHDMQnayTs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l4aDlf+uVpJEHdQOfzIMYm09KQjrAuAw2erK07aLAfug5ApRDy1XlakPrXXiRYdjx
         H16vDx4r+ESt+hngYJXiiLR+NzX5bjXB+UX50eIiQHeC1sQOeRnW2ql7bkXl2FhIFY
         zvqjlWqXvCxzwZUuRJ47iIY8Sl6vBWGvDk87EojOv2ovl5aTPm4MAW5/Qof+2ZHvIF
         sQ1u65bcdOaqbZkxoIVS+cTTL3OofM4gnByabptzabArXTJKGrA6Wv1ovXhL0cBfn4
         TEbO/RAHe4ZpSpMwoI+6bGvSgkXl30yo3ZJb4OBym2lEY88l++N09PII2NnRNC9/7N
         J8WhjYZ+EDjYg==
From:   Mark Brown <broonie@kernel.org>
To:     conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, daire.mcnamara@microchip.com
In-Reply-To: <20220607073833.2331539-1-conor.dooley@microchip.com>
References: <20220607073833.2331539-1-conor.dooley@microchip.com>
Subject: Re: [PATCH 0/2] Add support for PolarFire SoC's spi controllers
Message-Id: <165462321288.3040195.2196860226827286633.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 18:33:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 08:38:32 +0100, Conor Dooley wrote:
> Hey Mark,
> 
> As it says on the tin, here's a patch adding support for the spi
> controllers on PolarFire SoC. The binding for them was already
> added in 5.18.
> 
> Thanks,
> Conor.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: add support for microchip fpga spi controllers
      commit: 9ac8d17694b66d54b13e9718b25c14ca36dbebbd
[2/2] MAINTAINERS: add spi to PolarFire SoC entry
      commit: f303c6b26cede1aa137dc3e10eee78a80cde9999

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
