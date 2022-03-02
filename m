Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C94CAB0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiCBRCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbiCBRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:02:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4542CEA35;
        Wed,  2 Mar 2022 09:01:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C50A61931;
        Wed,  2 Mar 2022 17:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9ADC340F5;
        Wed,  2 Mar 2022 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240479;
        bh=AfNG9ohs+uRSHFziQ1qvpTshDdViBr7Tt1H5eVjkx8A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dLLbDPpaWiWEJVkYE7ls9DFB2x6hxN9IqyoDPdOLUlh+1Cqf+0LiWCawII24nNg2f
         wnv1FtO6Y46fYSHqT+HRMvTCYOaHdGUtlaSan9G/huGLIXfQ6eNz+H/Nn1sf7dq4oM
         foA80xVsKDt6BclFkGl7Gb1j1pbCgvUa5JXMgdHyGyKb+IAj2WCQpm7LFA44HPx4EC
         YSZuhV2O3FktFdSq7oZ1LCIRFygzXjqLumBHEJAQGELz3FMidBMLjFfG8bEx99CZFa
         GArQ/s/JbN0NY0ZjV3HnHduDIZ/wFMiMTPGliOZ65ejSq85sgtg1qGclSzd9GhHfKD
         BHVhpPU3PsOcw==
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, michal.simek@xilinx.com
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302092051.121343-1-jiasheng@iscas.ac.cn>
References: <20220302092051.121343-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: Handle error for dma_set_mask
Message-Id: <164624047848.1145410.6180924431652390122.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:01:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 17:20:51 +0800, Jiasheng Jiang wrote:
> As the potential failure of the dma_set_mask(),
> it should be better to check it and return error
> if fails.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynqmp-gqspi: Handle error for dma_set_mask
      commit: 13262fc26c1837c51a5131dbbdd67a2387f8bfc7

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
