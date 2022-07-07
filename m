Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6356A97F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiGGRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbiGGRYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:24:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA735A2D2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00111B822B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 17:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72576C3411E;
        Thu,  7 Jul 2022 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657214660;
        bh=PJWosiBSr/Jo2n5fQ5/FKsus3qGeZ8zXjOaJiRvPKhY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EICthTyfj4eOlgLgxPHvd8oUs+GkQRoBCa7JqXrRG+Y52cMsA8M1I0RlZY4n13f4K
         TOlIirKsI34gIbYOHZw36vEcOyQbLCIj8QuV4iu+rX3qlQ8dQN+TnNGi6zfKM+n/WD
         4rYPjXHVQGZfUAIZJlgqwGdqbtYcvPVM5t5ztF8JNVhIOTjAjBpOrWXUrMbdaiYnqo
         fiQVEWxEzcmHOSXlVp9361dZRoKM2jM8C6RPg0xLpGrDKDfzP7udtFKORnpepx7BnF
         ONawH5UnjQhARG/1l0UB6iwpQlYM7rvwEDmRRSFMkjzQZpVHdRgaHss6rYgLuTTrOk
         r6tQcIve+hnRg==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        festevam@gmail.com, tiwai@suse.com, shengjiu.wang@nxp.com,
        shengjiu.wang@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1657192806-10569-1-git-send-email-shengjiu.wang@nxp.com>
References: <1657192806-10569-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_utils: Don't use plain integer as NULL pointer
Message-Id: <165721465817.2940958.17759682147989552170.b4-ty@kernel.org>
Date:   Thu, 07 Jul 2022 18:24:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 19:20:06 +0800, Shengjiu Wang wrote:
> Fix sparse warning:
> sound/soc/fsl/fsl_utils.c:125:31: sparse: warning: Using plain integer as NULL pointer
> sound/soc/fsl/fsl_utils.c:125:42: sparse: warning: Using plain integer as NULL pointer
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_utils: Don't use plain integer as NULL pointer
      commit: 050237e6b0bea0fafbf7d3d57e717c6fa1e4e819

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
