Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDC4D0879
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiCGUjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiCGUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:39:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438155BE3;
        Mon,  7 Mar 2022 12:38:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E0B8B81709;
        Mon,  7 Mar 2022 20:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E4CC340E9;
        Mon,  7 Mar 2022 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685533;
        bh=KA27SdryLbPnkh3rfZAdOozWzNDVVpE2KeuHZzwvVVw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=szA9oA7W47vE/7bENsFKNQzaXoniTyADLF6/Uga+raJym/KdYMs2ya+fEmIV2SsN+
         WaBQYa5xlyV5I6uNXazuBH0D9YPKc9SH8HnkS032P+t0Ht+P5kOHTlXO+bnKeEDJaY
         dsUNQv7Cc7DUyGtGxDIZlaC65BKMZ6d+WFcKJBC45n1lVMMydolNkygGhqHuh5W2t2
         VcHHeY6dyBO4TTbq3urCIAKsV+sQcvDCsdZs9lLnkpkYEFeGxOMuRKwdN0RlzZOAlW
         2HzXFa73G/SeC2RYvMoDwu4HZr9TcZ0mKtS32VvT1TUdOgm+dC99mmeXhZhdcc3k2M
         m6wbQWN2V2uLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 00/20] Support external boost at CS35l41 ASoC driver
Message-Id: <164668553095.3137292.5295823555240044073.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:38:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 17:30:39 +0000, Lucas Tanure wrote:
> Move the support for CS35L41 external boost to its shared library
> for ASoC use.
> This move resulted in cs35l41_hda_reg_sequence being removed,
> and its steps were broken down into regmap writes or functions
> from the library. And hardware configuration struct was unified
> for its use in the shared lib.
> While at it, some minor bugs were found and fixed it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[01/20] ASoC: cs35l41: Fix GPIO2 configuration
        commit: 03a7895ee701e873c88c06bdb830ff40adb2be73

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
