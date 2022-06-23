Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C901557EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiFWPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiFWPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25731357;
        Thu, 23 Jun 2022 08:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3183961EDA;
        Thu, 23 Jun 2022 15:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC4CC3411B;
        Thu, 23 Jun 2022 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655999328;
        bh=tP5tWUbsTQDyyLj7te8Y5iEraMYYD/V8xlcCjt/tgjk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ScTvqzj5l8QF3PH8z2ERvm3+5OVyM3Db3ljY0oRdGehYt6kg8o5tu6DVPf3Xi4Wiv
         ZFHu7rNT4FC07+x2qoXkAZbA44Sk9hKggDPTvU/hj2YIs7YSrWcGtJ6tSHgWbr90P6
         8g8XvfSPnAsmCGC3uSLdF+QPcLprkf0XULgnQnPAZHHcifRRTxAlgIYYeNgV3hNPWA
         uRNJaTPz1OVoJ+u/K3KGsw97V4nEjxF0dcv4VjVUEcqxwbPgCMvqDLnAZxWvy9R78v
         OIISyzWc5mpf7zATk291xcwkIl3p5L28EG2D8s1ZeIxVu5gh1eQUx8ySgid7zda93x
         k0JDtEryl4M1w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220623140547.71762-1-eajames@linux.ibm.com>
References: <20220623140547.71762-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] spi: fsi: Increase timeout and ensure status is checked
Message-Id: <165599932743.321829.1888055158569368470.b4-ty@kernel.org>
Date:   Thu, 23 Jun 2022 16:48:47 +0100
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

On Thu, 23 Jun 2022 09:05:47 -0500, Eddie James wrote:
> Only timeout after at least one iteration of checking the
> status registers. In addition, increase the transfer timeout
> to 1 second.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Increase timeout and ensure status is checked
      commit: 40308f9642a85c30fa7cc5ab8672020cb96ecb66

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
