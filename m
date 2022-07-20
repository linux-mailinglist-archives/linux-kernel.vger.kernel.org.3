Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE657BF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiGTVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:07:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC41A07C;
        Wed, 20 Jul 2022 14:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0455BCE22D7;
        Wed, 20 Jul 2022 21:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CF4C3411E;
        Wed, 20 Jul 2022 21:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658351240;
        bh=KT0MDTe4I14XJ9G4qNy1ibxlgS5Etqvlq1vDOT8v2A8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QVyfAmegKg5T13oaAgr7O4f1JgcvZEA/5kXb9bsiUJb9gZvXeYWq9E7Nu97KbRNg2
         C5TKVcDQmkiVshPsnmn5Ecd97Lnq+frt4+11SMn6p7+G2KzSg75JOzc8u9SylZ4SuL
         hnF/wlSoNiGQQz1cR7bGwwzGnHIUFHL4wOtHGujcNMUX+TuhDcx8y2dXNmENo1PHsL
         utQje8b0QNAVjiB8Dw2atXzFPBQ1KP8NtyvBlVQTUGMuAHTd4jCr+l+XPRZpFaSPw7
         IUB1OteLYL8+3+TzM5G/USrli5RixEkf2FjZ3knqnKepx5bkbeXCObbXDuuLZwCjiT
         1cFkf+58VuzzQ==
From:   Mark Brown <broonie@kernel.org>
To:     amit.kumar-mahapatra@xilinx.com
Cc:     git@amd.com, linux-spi@vger.kernel.org,
        lakshmi.sai.krishna.potthuri@xilinx.com,
        linux-kernel@vger.kernel.org, amit.kumar-mahapatra@amd.com,
        sai.krishna.potthuri@amd.com
In-Reply-To: <20220713164529.28444-1-amit.kumar-mahapatra@xilinx.com>
References: <20220713164529.28444-1-amit.kumar-mahapatra@xilinx.com>
Subject: Re: [PATCH] spi: spi-cadence: Fix SPI NO Slave Select macro definition
Message-Id: <165835123856.909862.1674350119538638.b4-ty@kernel.org>
Date:   Wed, 20 Jul 2022 22:07:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 22:15:29 +0530, Amit Kumar Mahapatra wrote:
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> 
> Fix SPI NO Slave Select macro definition, when all the SPI CS bits
> are high which means no slave is selected.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Fix SPI NO Slave Select macro definition
      commit: e1502ba41699736c578ba9d61ae6285d49f6921b

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
