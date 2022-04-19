Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C667F5071D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353829AbiDSPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353834AbiDSPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF513F6E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4964561656
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC0EC385AC;
        Tue, 19 Apr 2022 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650382184;
        bh=jeuAQBpU0IHUM+HhJwHhOHne7mMnnHWM5rRI0BeHijg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cyR57D2ICWHJ/NMVxwPTme78WwAyiGmCp6E1vMcQLNezlDTTMo4Qi+NCx3ByGkdHm
         8onsLupf7HSN5GlA9sxsO6ltkXc3CaxajXtN5b14mzhIw7DmFK6FTPrMagLY/8eRPX
         OLxy69BEW/PNM3pwHW0wykCV/J3zdmLZiGFnKCXDtCcSvqVtc5e33UWHpQUGHywpL0
         sw1B/5Th0+O9UtAkJJqIbAoKSRcFLmYVyls53zQ3RNrZC5yB7/Ix/XQ2ZvCwCkHk2Y
         j1LcAD3HCj+Yhg01CgPadYViGxZXjNdqDXEpiAPh+zaIZAczcEGXd3n9Wx113zbBya
         b0IbYQUGcu1ZA==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, lgirdwood@gmail.com
Cc:     zealci@zte.com.cn, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
In-Reply-To: <20220418110259.2559144-1-chi.minghao@zte.com.cn>
References: <20220418110259.2559144-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: codecs: wm8962: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165038218304.995461.12975238868778224251.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 16:29:43 +0100
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

On Mon, 18 Apr 2022 11:02:59 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wm8962: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: e65f2fce08fc708e65b544131999bdd933d09164

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
