Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3559A8C6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbiHSWro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiHSWrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA31610DCD4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5777661826
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7AAC433D7;
        Fri, 19 Aug 2022 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660949259;
        bh=T2ZIY+4uZ7FtlXL26qIP7vtXP3FByMTOuhwzDgOCdlM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T3tGisiXjhDAPfJeYTTCWjlgvPt5eplr5dVivhuV+unKd/nTVWlXBBpKocKpjkpWu
         Un6iuen5du6PXW0//lXn2yalqVRBFagPUE9pRDaXnGMlGM9Yv6GfCmxqbS/riE5jRo
         OZ8fOU2SEmSCmC8IQHsydZPFvDNa/kNT7CvOnuj0uM7tBN5/9NG4QJCG+8TE6TjG51
         wnv2LK0IbsPJ03uQRAJ3rmnMK0+GGIbIZvTd3ngQD9SC5HfkhDQUhv2d0PtiVq/4oK
         Pw7wH+wHIvkkJm4CyRY5qfl89z457MfkbTJh30bKbvuYGiBQMNaFjJ5pu8S4gqDFpI
         DlFdrLABjlkrA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     venkataprasad.potturu@amd.com, Vijendar.Mukunda@amd.com
In-Reply-To: <20220819073758.1273160-1-yangyingliang@huawei.com>
References: <20220819073758.1273160-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 1/3] ASoC: amd: acp: add missing platform_device_unregister() in acp_pci_probe()
Message-Id: <166094925849.19151.6188249886261583368.b4-ty@kernel.org>
Date:   Fri, 19 Aug 2022 23:47:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 15:37:56 +0800, Yang Yingliang wrote:
> Add missing platform_device_unregister() in error path in acp_pci_probe().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: add missing platform_device_unregister() in acp_pci_probe()
      commit: 6a4ce20fd776d2fd19ffaf85cf34a53761e2c888
[2/3] ASoC: amd: acp: switch to use dev_err_probe()
      commit: f89a8c5bb3489e43ff87b5f91acc8db66a168e8e
[3/3] ASoC: amd: acp: add a label to make error path more clean
      commit: fd8ec75207588f85c622ee49e5f32267d2406d92

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
