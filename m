Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AEC52669C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381442AbiEMPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350196AbiEMPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:54:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F622922E;
        Fri, 13 May 2022 08:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3674EB83064;
        Fri, 13 May 2022 15:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01633C34116;
        Fri, 13 May 2022 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652457255;
        bh=oPnnP+7310ZzsILLFGsZw9UnRq7eBN3g42/zPb06xHA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HpT41x7IT1pqhmJwDEbOJMLApDGEbfWnmlgeYtunIRHG16K8qnXOr8ml26fjbWQJU
         HQPtJLq2UqWHhlI7kc3AjucXhkWVy1mj3U5OP9gpdopLeRXWlwKWDHqfkCl23McUo2
         ifbV2roYjKKXigES8c0WKpRkBtmcu5y8RtB5797jPgLd/+IyFiIuuQvddXQEhwGGPb
         ebs8uY6rZH9QQ2p5iBYre1LAoQhH5gOPiBKb3K2XZ/aLUY3gfNxCOtCegJCkQDiife
         FhvPTj1yL4/rQ3CdpW7TLYJjLDqZvGUkoqShq3KldGkwaUbS4ADQp0s+7FkIJC5XlR
         PYtGfr7I29dlQ==
From:   Mark Brown <broonie@kernel.org>
To:     amit.kumar-mahapatra@xilinx.com
Cc:     git@xilinx.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220512145025.20205-1-amit.kumar-mahapatra@xilinx.com>
References: <20220512145025.20205-1-amit.kumar-mahapatra@xilinx.com>
Subject: Re: [PATCH] spi: spi-cadence: Update ISR status variable type to irqreturn_t
Message-Id: <165245725372.1679896.7997399327405027224.b4-ty@kernel.org>
Date:   Fri, 13 May 2022 16:54:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 20:20:25 +0530, Amit Kumar Mahapatra wrote:
> Data type of status variable, that hold the return value of the ISR,
> should be irqreturn_t & not u32. This patch updates status variable type
> to irqreturn_t.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Update ISR status variable type to irqreturn_t
      commit: 22d35e40419a2ac0914fb6b05c8781c9af8d4126

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
