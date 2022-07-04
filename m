Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0059565A7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiGDP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiGDP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:58:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F66101E0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B005B8114E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 15:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED676C3411E;
        Mon,  4 Jul 2022 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656950275;
        bh=1E1E7hQgiteHL2Gs8XLqTIBhCoUZep/DLAZWhET/WuI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N2xnvGJr8PmDQcW+8VqQwBy0czRaBGH237+6xYUWZKLxtcpOEyy/1bapz+Z/EoNoU
         Rk0Jca/ijfd/bHAGvrTpC6bTzigkl6zkbqF3vgen9XmldWlFwD9HxfL+OVY9YoMhvc
         QAymAMWrJW0EDclvAQJ/PoBbmA5z34d+ZKJKWAQDhCnhMUmo6C/VaT1r0tDxmXMpGR
         0HUKxb14RYB7XQpMl6Cu3xg23WBeL7l4bKsYmOv6509pNZj0jZach/2w+nAEBClpPZ
         aMtEiChH/gqqhdth7VhGMNhAbxEwQz0tSsYS+9xQMESVuOfJKAMxYB04rKwWV1UDRh
         j940EY8OqsFEA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        shengjiu.wang@nxp.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com,
        festevam@gmail.com, nicoleotsuka@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1656899417-4775-1-git-send-email-shengjiu.wang@nxp.com>
References: <1656899417-4775-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_micfil: Add legacy_dai_naming flag
Message-Id: <165695027267.481068.6982856158106721474.b4-ty@kernel.org>
Date:   Mon, 04 Jul 2022 16:57:52 +0100
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

On Mon, 4 Jul 2022 09:50:16 +0800, Shengjiu Wang wrote:
> Need to add legacy_dai_naming flag otherwise there
> will be issue when registerring component, that cause
> the probe failure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_micfil: Add legacy_dai_naming flag
      commit: 978bd27c9aed13d7d739bdcdcf98cbca9106b0ec
[2/2] ASoC: fsl_asrc_dma: Add legacy_dai_naming flag
      commit: 446499743b26958a58891a8f9a061deb5cce7c82

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
