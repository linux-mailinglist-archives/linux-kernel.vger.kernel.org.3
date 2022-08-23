Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA44A59EACB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiHWSR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiHWSQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:16:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141787C303
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51351B81E5D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4849C433C1;
        Tue, 23 Aug 2022 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661272318;
        bh=0OW8QTWj8leOwIvSI2jUOoZZICwcZkui2kQIaQN1eUw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r/Q9NnLhKgHnZDH15hdmsXxlREi3PAhN4fMAUd7WvnrzkcYkX0zZ4uMJ1N7QPvUoK
         BP6jdW/tqF0Eoe42IWCReMYN9fkT0arN4kvio/mi41D3Zwaca4m9aqnBDwGZP5tNkB
         Or3PaFCUSQ33r252+rbjKuaJwA1a90YazOnbR9277a3SjC4Mxob2FMllIS9LQZAa2r
         661EHm9mg0PsD4A/GGbcpY/US7uxtrtHwQLyxHJ7MI9yWP5I4ySqs9uhFj2OYGwLsm
         419O1yEeYEZph+Dgzjuer6YrdFb5YppGRwGziZJ0KFIqeEdMxS2OqAI79WPWz21X0C
         ALxVEPWnym87Q==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, Xiubo.Lee@gmail.com, perex@perex.cz,
        nicoleotsuka@gmail.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, shengjiu.wang@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1661247308-2650-1-git-send-email-shengjiu.wang@nxp.com>
References: <1661247308-2650-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Fix supported clock DAI format
Message-Id: <166127231558.397935.4810940436556797260.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 17:31:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 17:35:08 +0800, Shengjiu Wang wrote:
> The MQS works as codec DAI, not cpu DAI. It is
> clock consumer, not clock privider.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_mqs: Fix supported clock DAI format
      commit: 1faa6f8274e2b08a38c0cca74113dfb26c6ad7b7

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
