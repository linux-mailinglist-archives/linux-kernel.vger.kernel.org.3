Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582264F85A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbiDGRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiDGRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4CF19480B;
        Thu,  7 Apr 2022 10:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB77D61142;
        Thu,  7 Apr 2022 17:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE615C385A0;
        Thu,  7 Apr 2022 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649351575;
        bh=26i9YiJ0LUa3SscrOC47GksLYUOjvRayjQaMcOHxxsY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BlAxl8hJWMVA9YwMLF4R5S0+5oerQ85Ii9riJxXGFVBSbllAolp/Qz2xXjiZYZUwe
         hE+ol5t/xlpjOjX+tZ+jzMwFtu4lEOrha9U/TtjWBLdKT1y8VTS2n7UawdUSzTDag4
         axFt5t7MCIQ8tuThYlmw2LarWTho6YRSX0HTLR/ZrgOJxJAifKjagEY5c6lC+U4bFC
         D/+3t/dgtF4fYJYTVD+Ps98kCgiY8kCpvIkubt2sQD+h1HYY2z9Bs2IizioqkkVSNo
         Vw//5E4mW1aMICSAnJXO9SdBYaEYM9pn/mGz8BjByE7DxRYpVWmENHrS0XWBoJfzRI
         wIbpjcFHrQ5lA==
From:   Mark Brown <broonie@kernel.org>
To:     amit.kumar-mahapatra@xilinx.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com
In-Reply-To: <20220322150018.12736-1-amit.kumar-mahapatra@xilinx.com>
References: <20220322150018.12736-1-amit.kumar-mahapatra@xilinx.com>
Subject: Re: [PATCH v2] spi: spi-cadence: Fix kernel-doc format for resume/suspend
Message-Id: <164935157367.1057547.15609123677992731951.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 18:12:53 +0100
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

On Tue, 22 Mar 2022 20:30:18 +0530, Amit Kumar Mahapatra wrote:
> From: Michal Simek <michal.simek@xilinx.com>
> 
> Kernel function name don't match with function name.
> 
> Error log:
> drivers/spi/spi-cadence.c:661: warning: expecting prototype for
> cdns_spi_runtime_resume(). Prototype was for cnds_runtime_resume() instead
> drivers/spi/spi-cadence.c:690: warning: expecting prototype for
> cdns_spi_runtime_suspend(). Prototype was for cnds_runtime_suspend()
> instead
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Fix kernel-doc format for resume/suspend
      commit: 4df6836dbbdb6a00af5f9ab6233e33cec3a73961

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
