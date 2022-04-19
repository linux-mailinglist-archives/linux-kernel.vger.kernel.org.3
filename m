Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F64507CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358304AbiDSWsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358283AbiDSWs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BBF245A2;
        Tue, 19 Apr 2022 15:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F13617F2;
        Tue, 19 Apr 2022 22:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0ABC385A7;
        Tue, 19 Apr 2022 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408344;
        bh=vinjbCr2cqAUFbMYRfTjkaWIL6tzOCUsHeU/5hr0Oq0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tgoe9dvqctmAAxtku0c8okp065Y7+Via8jNZqziMGYOO+mvl3kWd7XkW+Bntd5tVl
         MK0bWI0ExTfncjSoCmjvbA5MOSSQb11BhsJ53KfrxfCSlokKhLfLrWC5Sf74+pzOfI
         LTZfLuXrgaSe8EKtTZJr8VUgRY/cvx1dJ+n3//KrSffCka9jmo+zWCckmtJFNYelq2
         0bvlrh2Cz95cMPVzHXyyDTLuKDnimbi9cIusnYSyZc209ZEVFJcxA0duy7HyPQPHmG
         CpmWXHKX2QJdmOqOKSe5QDtMna6huw16GVccFvieg68sRjM8e1l7OgpgtJP8nllHq0
         W8lX1OTqGRt9Q==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, ldewangan@nvidia.com
Cc:     chi.minghao@zte.com.cn, linux-spi@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn
In-Reply-To: <20220412070951.2532157-1-chi.minghao@zte.com.cn>
References: <20220412070951.2532157-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-tegra114: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165040834196.1910395.6477833304505061712.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:41 +0100
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

On Tue, 12 Apr 2022 07:09:51 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-tegra114: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 58b1efe2c1722cb47e5b1f49b79a50338428acbf

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
