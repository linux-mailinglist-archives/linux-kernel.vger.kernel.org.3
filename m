Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025AD4CAAFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbiCBRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiCBRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:01:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08DE92D02
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB08618F6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A5DC340F2;
        Wed,  2 Mar 2022 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240456;
        bh=5tZBPMx5BMT71ax6op9U51BLeLidIvFCtNHBOzWsyM4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G2zrAx1WltNmVJHM/cDy0B/Hce9rxkBhDWGeljawipdKHrkjLj1FJOmjeEHTU0Lts
         5p/MdSbdY/OqH40/y8O/WlcW5YelC1DDvyWFrN+Xu2bsXdBiTwfXQr74e38skMmuGw
         AxZFCzt0RAPzR1KnLA/CGWh+owGwFlvSwdKDQGqk58LfJEUASJ4c2It9BDpl3P1Koj
         NmKTq6Sk84vFo+MApyiqn8yE7dDlsL9V5QmS0uayTkvd4iUPArd9LIYM1e2gn9ErW+
         +SG/eldt2o9DZ68sNOwVXtQ6N1arcSIdoSUoT4dzPvea15RGGMTKyfQVlds2MenTtX
         aemk39rg+IKDA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        yangyingliang@huawei.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220301084742.3751939-1-jiasheng@iscas.ac.cn>
References: <20220301084742.3751939-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: dwc-i2s: Handle errors for clk_enable
Message-Id: <164624045500.1145067.2482712182081585715.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:00:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 16:47:42 +0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it, as same as clk_prepare_enable().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc-i2s: Handle errors for clk_enable
      commit: 45ea97d74313bae681328b0c36fa348036777644

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
