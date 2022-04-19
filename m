Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD45076EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348032AbiDSSAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiDSR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8C11154
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C00AB81900
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE04FC385A5;
        Tue, 19 Apr 2022 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650391032;
        bh=Lc9zJeVdQ8rSijbGWdZIUTMzP4mcZbhXcP12WkMoY0g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t6vhbZRocd5W6GZWTR/08VvQ8eS+DwOpURNeDh2mGGxxKl4nJxOmcryDju8eejWpq
         e/TdCHwlEzdwlqqU3Z44aiHqfJOBhycK6uEKaI7iIlTdlOalUdVqf83aEsUt2syOW2
         NSClbiY03npA0NlvMW//IZnqpQf30OGX3d09/QP3Ky1zlAWAdhpUqsrKyVSCb6/XxW
         r+u1ZWNE6CQzAbaoaTnTg5iExYffGz9uw/dlKHrwzKNwBwWRT5OPLbsXLW5VtZJHCt
         ubd5uFE33c50r/gNM9ic2Sqyjy/laOJXT5u4joE9azVTb1gTcFeuWmFjqMSQiNn0jT
         Hif8cf/+yPCfw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, zealci@zte.com.cn,
        chi.minghao@zte.com.cn, mcoquelin.stm32@gmail.com
In-Reply-To: <20220412071030.2532230-1-chi.minghao@zte.com.cn>
References: <20220412071030.2532230-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] regulator: stm32-vrefbuf: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165039102938.1157438.13016498609633823663.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 18:57:09 +0100
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

On Tue, 12 Apr 2022 07:10:30 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: stm32-vrefbuf: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: bfb5711e2455a239ad64dd5151fb16d195329d46

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
