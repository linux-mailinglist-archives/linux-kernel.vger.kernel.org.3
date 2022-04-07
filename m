Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B04F85A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbiDGRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiDGRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25437196101;
        Thu,  7 Apr 2022 10:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F96D61597;
        Thu,  7 Apr 2022 17:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019C5C385A9;
        Thu,  7 Apr 2022 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649351580;
        bh=GBt4PUS2fgno+UwF/Aa8hXaiVk1GCJZbQR8MKbe6zrQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CcdFHzg3VV6DcFogTNUaEhjsfeGTa19fo0x8cHrJKn9GQSxALlzZa/8jCBmiVXaCk
         nzZ6ur8nPashDm6q8BdhVmKPjLdmF2GXi87mnsaW0TyWILIX+fmcTajcjwh0O6mv0g
         NGE6Suh0wZEQxBaQ9kYmu82FNVcYiYdGLEIWQ5PBKyMXEeVwgQUZoni2DAs5WkIUs2
         Njp0mO2+U2gr7MMY/Xf/InJB5k5sH8eIFIAeNGoi3avx+x+T3+aB1nlPJlTwLKhPrb
         vijXQ/MTCxRePjtAmX/vJlVgJF1twkGQih38+YWP+ZDpykyW1hOX1zSkIcJ3TO+lO7
         md52LyPJ+q0aQ==
From:   Mark Brown <broonie@kernel.org>
To:     vkoul@kernel.org
Cc:     linux-spi@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20220406132238.1029249-1-vkoul@kernel.org>
References: <20220406132238.1029249-1-vkoul@kernel.org>
Subject: Re: [PATCH] spi: core: add dma_map_dev for __spi_unmap_msg()
Message-Id: <164935157872.1057547.10486810513176613790.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 18:12:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 18:52:38 +0530, Vinod Koul wrote:
> Commit b470e10eb43f ("spi: core: add dma_map_dev for dma device") added
> dma_map_dev for _spi_map_msg() but missed to add for unmap routine,
> __spi_unmap_msg(), so add it now.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: core: add dma_map_dev for __spi_unmap_msg()
      commit: 409543cec01a84610029d6440c480c3fdd7214fb

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
