Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B93543DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiFHUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiFHUqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:46:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC18EBE95;
        Wed,  8 Jun 2022 13:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 882F8B82AD5;
        Wed,  8 Jun 2022 20:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18903C34116;
        Wed,  8 Jun 2022 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654721201;
        bh=udUB2vdgzbcLCJhRmJJ6lL9erLr3XMY3MY5ztaq+DZM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dXuv9pwKGuKFH73K8UJqRujqHEBsOcgbNrQY9EWMzGLcAdfWbGeDA347OJFue0nIN
         vf4fiDPzGC5bZz/DtaIwy6QR/GLFPkS0Ffq/lo0ALQe2nAydi/+KD6hufN6o2gn76g
         YwLWHoA3nbzq9+NO7Sd0xINIgIH4Bpt4DvXztwRj4Daw7/6AgVwMMg1IE3TfGtr/9Y
         JDGYOeylgEYLxmKHPsRVd1VN+c0MlYvzE4F9nNzQY/4SjI7nadgV7CZKiXImKVnm82
         9OTxUJCi+04dbOaWZzBE1Sv6AHL07muWYDqDbuuDYqIWL26X54uWPcx/tnfTBUc2WW
         DRVbm1SCugYNQ==
From:   Mark Brown <broonie@kernel.org>
To:     david@protonic.nl
Cc:     linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        andy.shevchenko@gmail.com, linux-next@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20220608153309.2899565-1-david@protonic.nl>
References: <20220608153309.2899565-1-david@protonic.nl>
Subject: Re: [PATCH v2] spi: <linux/spi/spi.h>: Add missing documentation for struct members
Message-Id: <165472119981.3018494.3607522399467236617.b4-ty@kernel.org>
Date:   Wed, 08 Jun 2022 21:46:39 +0100
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

On Wed, 8 Jun 2022 17:33:09 +0200, David Jander wrote:
> Fixes these "make htmldocs" warnings:
> 
> include/linux/spi/spi.h:82: warning: Function parameter or member 'syncp' not described in 'spi_statistics'
> include/linux/spi/spi.h:213: warning: Function parameter or member 'pcpu_statistics' not described in 'spi_device'
> include/linux/spi/spi.h:676: warning: Function parameter or member 'pcpu_statistics' not described in 'spi_controller'
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: <linux/spi/spi.h>: Add missing documentation for struct members
      commit: 5dfac65b621733e69b789150a0a3f1bf2f9095a3

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
