Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022574DE30D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiCRU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240948AbiCRU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7004AE2C;
        Fri, 18 Mar 2022 13:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9ED360EE8;
        Fri, 18 Mar 2022 20:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ABBC340E8;
        Fri, 18 Mar 2022 20:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647637088;
        bh=dJlguLWz9Eu/tegMYxnjfLVGayVps0C/hKd+hIGT7B4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pZXbBUJxjPvbTDOofi7A65A0oJxaDpgdoSyqFMBL1b8skBA1pr5sk6EEHvwXPDgPJ
         G6aqR+QI54plcHRBllUdGK22TZLn9KHYJGRgBTFKLjGp1o1iinjAT+fzphATgd8nTh
         4s5PSbQwTsK4JASrNggdyparqjPjfJQZ2EAmR+DVGaTnNxzTQT9arnt6JCLfIEpK75
         XaDRBPZwpQCCa/FvoZKgoo/EK49xE2YokGrd4cYWD9i5LPV9LiuUnMI60pR/Cva4SW
         jvx9qTXCE3lL6xxynwVewN+nB6P7SqF8HYyKlrSJCkWG5wwpX+/XYB1lamXSvjgX88
         9VVfcePRTflMg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220317211426.38940-1-eajames@linux.ibm.com>
References: <20220317211426.38940-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] spi: fsi: Implement a timeout for polling status
Message-Id: <164763708679.2336580.18094786186372148755.b4-ty@kernel.org>
Date:   Fri, 18 Mar 2022 20:58:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 16:14:26 -0500, Eddie James wrote:
> The data transfer routines must poll the status register to
> determine when more data can be shifted in or out. If the hardware
> gets into a bad state, these polling loops may never exit. Prevent
> this by returning an error if a timeout is exceeded.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Implement a timeout for polling status
      commit: 89b35e3f28514087d3f1e28e8f5634fbfd07c554

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
