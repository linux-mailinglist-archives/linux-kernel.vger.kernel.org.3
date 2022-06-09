Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA9544E77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiFION0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiFIONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:13:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF44703E7;
        Thu,  9 Jun 2022 07:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D77C7B82DFE;
        Thu,  9 Jun 2022 14:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB63C3411B;
        Thu,  9 Jun 2022 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654783998;
        bh=/Jb5puY1IwHHQl2pvtto5BvzvEL2zeQNG34C1ZK0RVs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a1QKtQ3nr3lj0XZvJ7QXDxrIDq2RN1M2ZSfhWMpm0T4jjwCkL7hB6wCnqXucgyx5J
         DqThJeiD7o6u1/wNV3qxpNyMUUEdgWvtkVH7M6KKhrndUV3+hQcPqzJ/YCn9YY6BNr
         kIUo7CBEGZy5pEowLnj18uIV0KBTZ5rOpz2GLhGEA+4hRN4yv6A3H4WrZ770Eww291
         OZus9PmoHC7hn+nQwJsyBAnFNorXmrzKbqeI03qHuHDC3MW2ugccVZPqM0IYXQfwI/
         Hztzd7a+4clC9M9nuLTvCsfhp+QwzZELOwkyAZUARNgKuQfh6Z++VAazafm12Mtr3G
         xnsF5lSP4PsnQ==
From:   Mark Brown <broonie@kernel.org>
To:     yang.lee@linux.alibaba.com, krzysztof.kozlowski@linaro.org
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com
In-Reply-To: <20220609071250.59509-1-yang.lee@linux.alibaba.com>
References: <20220609071250.59509-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next v2] spi: Return true/false (not 1/0) from bool function
Message-Id: <165478399683.1092145.4129788000879075205.b4-ty@kernel.org>
Date:   Thu, 09 Jun 2022 15:13:16 +0100
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

On Thu, 9 Jun 2022 15:12:50 +0800, Yang Li wrote:
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> function.
> 
> As reported by coccicheck:
> ./drivers/spi/spi-s3c64xx.c:385:9-10: WARNING: return of 0/1 in function
> 's3c64xx_spi_can_dma' with return type bool
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Return true/false (not 1/0) from bool function
      commit: 0356163e5883e298b518cd16517be633824987f9

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
