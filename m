Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026654D087F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiCGUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiCGUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:39:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71825F27C;
        Mon,  7 Mar 2022 12:38:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E427B81678;
        Mon,  7 Mar 2022 20:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE90C340EF;
        Mon,  7 Mar 2022 20:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685535;
        bh=IczVIEqb6AaHEk7+JrFH5QdDCzyGgkNzceWdxmxtv/k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fsMsdlYSr9NuIGcpaFoZyCrdVV/y2+FHkSIONOp0ga7XFSp3QXshse3Af8Ekd++xu
         yaD6x78uG8IpiOZ4yTRLz/XgE8qhuPPsF/ra0ISOKmVRbgvJJ5PbFxjHRj9Wqk5RKD
         Z3jqWdNmvzlXkt/23YNoLS4Oitl9xt5uRFIF4IcnXcQkVFljQb1osqHz61DhBIcS79
         BGZA03BzbIF7qKY4f5fMjXDSd4N19wqmx48Z5z3x4wSeKFF/rKvVv1i3jxzpqDs8dC
         uHUsnvD9apPTHzkTh1uXLhv5m6I6Hiyknh/bfIhTHZtsXCYYL4QAan6f5fwGDStC4v
         8p848uoMaQ/lw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v2 00/20] Support external boost at CS35l41 ASoC driver
Message-Id: <164668553317.3137292.18136754541525028176.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:38:53 +0000
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

On Fri, 4 Mar 2022 15:07:01 +0000, Lucas Tanure wrote:
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

[02/20] ASoC: cs35l41: Fix max number of TX channels
        commit: 16639d39bdf577168d3fe34315917a94365c8d19
[03/20] ASoC: cs35l41: Fix DSP mbox start command and global enable order
        commit: 5e02fb590e83684f63217f93a9cdeabd6a925f9c
[04/20] ASoC: cs35l41: Remove unnecessary param
        (no commit info)

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
