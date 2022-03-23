Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901794E5B66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbiCWWmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbiCWWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:42:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0776940A0C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C35B81E0A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52BAC340E8;
        Wed, 23 Mar 2022 22:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648075239;
        bh=RbOdPqbhxGrwIjd5F9+NTMrXJ8ByftUFEWoffmPPe54=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EOP5UqAOrS8EbGf7HZzC3CQdKfQQOK6kppJo+ofuy2SHB4wOm0QPn8u6wHopxj6I7
         45dcN0ApTMvaur3P5Xx04dcBLIQSMdUZueDYBINsR/o+FFtb1qfgqvHEkpAVB3WBu6
         70g3nsxYd++mF0Xa4ModnnS5XXFrVPZtDz9Q504MYr/Emm+zcU9pt5bGeB/eNPXtOA
         iWvNL1lq672QhFYNHzeGBeSQYjmmA8MDS/gR1nfuIiMnW50Og4ykN23dIzOpH2K9r9
         wZ+Wk9TcaOitC4US1UnGlHvXwd6PU6DYtsuyYhHPS8aKlRrpbAPzmeUwR0Tp2CPUEn
         uQYTsRDgBxXMg==
From:   Mark Brown <broonie@kernel.org>
To:     frattaroli.nicolas@gmail.com, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com, Meng Tang <tangmeng@uniontech.com>,
        heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220318100146.23991-1-tangmeng@uniontech.com>
References: <20220318100146.23991-1-tangmeng@uniontech.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s_tdm: Fixup config for SND_SOC_DAIFMT_DSP_A/B
Message-Id: <164807523757.1203347.1168659607344775709.b4-ty@kernel.org>
Date:   Wed, 23 Mar 2022 22:40:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:01:46 +0800, Meng Tang wrote:
> SND_SOC_DAIFMT_DSP_A: PCM delay 1 bit mode, L data MSB after FRM LRC
> SND_SOC_DAIFMT_DSP_B: PCM no delay mode, L data MSB during FRM LRC
> 
> Fixes: 081068fd64140 (ASoC: rockchip: add support for i2s-tdm controller)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: rockchip: i2s_tdm: Fixup config for SND_SOC_DAIFMT_DSP_A/B
      commit: 2f45a4e2897793cc6ae25f5fe78b485ce7fd01d0

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
