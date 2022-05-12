Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C68525292
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356475AbiELQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352659AbiELQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908F63393
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A512E61FD8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14DC385B8;
        Thu, 12 May 2022 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652373115;
        bh=h9Kzf5/SsxRvY1gZjEU/igSn6fpGqPvspFpuVtnK7kg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rTvb2kyn7eb/9ukf8eciK2lLPwcjnxvnLxM9dpZrft3IfljA2cbtJluyjuT1n1jMH
         Vs5Z4tv+Rd2RZrxL7VXxSkWZ4BaBTUlRRlSE5dG4xrPlZDH5cbEYevBxXMCyayeVBR
         oNUTzQbIH59naXSQ6qj7RePOy56WOl9xIpp34+pKlUKS1sp1GCAHunQUjRI/PBidi7
         k+Hv3ggAN//z0IzCVH8Job6hYYLQWQcKYjS+otsDnTMTx5gI4hoaAHeMlFK3oWoEY+
         BwC2p8UaLodULQvI4znXS1LHvZqvdXSKPGJu8379wV0PW19mYGDNgIIgiLd6xSBQ8x
         46WYRbHyyoYew==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com, tiwai@suse.com,
        zhengbin13@huawei.com, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, sound-open-firmware@alsa-project.org,
        perex@perex.cz
Cc:     gaochao49@huawei.com
In-Reply-To: <20220512013728.4128903-1-zhengbin13@huawei.com>
References: <20220512013728.4128903-1-zhengbin13@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: amd: add missing platform_device_unregister in acp_pci_rn_probe
Message-Id: <165237311250.1053236.5667344558272155246.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 17:31:52 +0100
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

On Thu, 12 May 2022 09:37:28 +0800, Zheng Bin wrote:
> acp_pci_rn_probe misses a call platform_device_unregister in error path,
> this patch fixes that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: add missing platform_device_unregister in acp_pci_rn_probe
      commit: cbcab8cd737c74c20195c31d647e19f7cb49c9b8

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
