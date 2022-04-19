Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB5507CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358291AbiDSWsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358283AbiDSWsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:48:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8FE22B3B;
        Tue, 19 Apr 2022 15:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42086B81BE6;
        Tue, 19 Apr 2022 22:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC753C385A7;
        Tue, 19 Apr 2022 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408335;
        bh=vTGOoGH3WL4t+K5hjT3fOIsQUCqwOhxMdLX4FUnejkw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VPQOfbnq24XMytlvijUyiPqSC93HPPnYa/2Uu3LE7/cH6MevQDjz8sz3xWJLmnj51
         3QfFx5OW0GMbl4nofkLBy4uFe0xVErMTEw/8p0NfXVu96YihyBn1sgfsKnQiUGpe+l
         VO/pwKzrP5Qu53iO9O7VVaB/8ChyGDFR40evdZBX2MSIE0dyeRFp+AYjg1LIwAA+pr
         qdUne4fHBrFEP2GmESTq9OCwwW37l3gt5VyHaS9Px9596r9r3sUgJK+SHTdMrEO7VO
         A0U1SQyoOYCt6E/KNKC54LkYcQaL7U567/AcgIFoMxxHhMRPCAB6JzGwmOdJ2ZqRix
         9bVJwapQarrFA==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, chi.minghao@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220408080931.2494356-1-chi.minghao@zte.com.cn>
References: <20220408080931.2494356-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-ti-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165040833446.1910395.11471746578040440326.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:34 +0100
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

On Fri, 8 Apr 2022 08:09:31 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: c03ae4876fd54822a22375aa4fc49736a8c3a5d4

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
