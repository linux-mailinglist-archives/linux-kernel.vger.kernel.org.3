Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2218D4E7B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiCYUdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCYUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E6890AE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8335261D43
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B2EC2BBE4;
        Fri, 25 Mar 2022 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648240267;
        bh=FycWHzxQ04zpxhwqUWo2/O94K5XkFQApiHddF1z90ZE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VMLwv2SXI7sAXxmLr/JFAGsqzoi0PtHhpxK76sdkI15a7cxecBooiIWGO/BqUrPHK
         UdSGBGsqdcmjfwTZ7OGatDtj4n+jguuqkGrFYoR9jHSuicSFN9E74N5uWG65t+f21y
         Aq0hC2/umicnKXIAQqOkrabQPeB86YZ7g4enyx3mtMxzv7ZLGbTAD4Kl7EyF4sWM6n
         AIo25j2R3bicQ84ZtIrF3GZVQztxVb6I/id6MDsAmuuoNmq3hyWnZIrmEs1xI0jq49
         n/R+fambkh8ZI14RBFKZIJtGi1I+n3UrI3z2vNSqlUTl6B9WXbyun1s2hJmNCzLO2R
         AHtLNl6Tek+Aw==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        Zheng Bin <zhengbin13@huawei.com>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, daniel.baluta@nxp.com
Cc:     tangyizhou@huawei.com, limingming.li@huawei.com
In-Reply-To: <20220323092501.145879-1-zhengbin13@huawei.com>
References: <20220323092501.145879-1-zhengbin13@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: Intel: Fix build error without SND_SOC_SOF_PCI_DEV
Message-Id: <164824026450.2684178.16201590071915953774.b4-ty@kernel.org>
Date:   Fri, 25 Mar 2022 20:31:04 +0000
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

On Wed, 23 Mar 2022 17:25:01 +0800, Zheng Bin wrote:
> If SND_SOC_SOF_PCI_DEV is n, bulding fails:
> 
> sound/soc/sof/intel/pci-tng.o:(.data+0x1c0): undefined reference to `sof_pci_probe'
> sound/soc/sof/intel/pci-tng.o:(.data+0x1c8): undefined reference to `sof_pci_remove'
> sound/soc/sof/intel/pci-tng.o:(.data+0x1e0): undefined reference to `sof_pci_shutdown'
> sound/soc/sof/intel/pci-tng.o:(.data+0x290): undefined reference to `sof_pci_pm'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: SOF: Intel: Fix build error without SND_SOC_SOF_PCI_DEV
      commit: 664d66dc0a64b32e60a5ad59a9aebb08676a612b

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
