Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93C752EA9E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbiETLTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348455AbiETLSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:18:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC20154B3D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41ADA61DB4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B16EC385AA;
        Fri, 20 May 2022 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653045529;
        bh=UhFND29rKzFNk/PM3lmGrodeQwn/fNPjQBAAKBp20gY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qYqeBTUNoNrIVAwTHKSCHB3plxVJLKocoriVJmA4aOa7hh3BcI12PHAdCbTd4+ih7
         orY0T+lvoqnSV587qMOMU8jApzkpzW0m5sQ15uJxkoEfCSNxrgUEad0krHecwGmnj0
         3tG6DvV+kxmPB6Ic9xgJT0dxoDNkTgf4cz0TRWgz6D6Swn+XmuTLJbAER0y/Am5cDn
         v4JtnIe17vTWVc0pr+B0sHFCSET0ozsA9ZrBWfesyTASYP8bQ+DaDRZVrjiYP8WSho
         XoSgPkp09sgS2m1HXPcdPHFusSNmURAWfoHzgphCFbiKJoXilhxDiAE5DmiU7WhCxl
         JBLRGl/oEvUcg==
From:   Mark Brown <broonie@kernel.org>
To:     yc.hung@mediatek.com, matthias.bgg@gmail.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        peter.ujfalusi@linux.intel.com, Allen-KH.Cheng@mediatek.com,
        kai.vehmanen@linux.intel.com, geert@linux-m68k.org,
        yangyingliang@huawei.com, wanjiabing@vivo.com,
        sound-open-firmware@alsa-project.org
In-Reply-To: <20220518125902.13407-1-wanjiabing@vivo.com>
References: <20220518125902.13407-1-wanjiabing@vivo.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: remove duplicate include in mt8195.c
Message-Id: <165304552575.45439.1697552885187311521.b4-ty@kernel.org>
Date:   Fri, 20 May 2022 12:18:45 +0100
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

On Wed, 18 May 2022 20:58:57 +0800, Wan Jiabing wrote:
> Fix following checkincludes.pl warning:
> sound/soc/sof/mediatek/mt8195/mt8195.c: linux/of_platform.h is included more than once.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: remove duplicate include in mt8195.c
      commit: 0f653c95c4f4b6b623ce8bd995002daf8032bfc3

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
