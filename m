Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE5514AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376282AbiD2Nm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351284AbiD2Nmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191CCABB6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58818622D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D7DC385AC;
        Fri, 29 Apr 2022 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651239565;
        bh=JvP9fnRkQuEqW2o+SUEjMSyAQxZhbmgFv0N8A+pXzAo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lz6y7TP3AyQbpY4PFmMB2WHj9LF8FQwgh7gtT0icuH8/t7xknapu/6Xq1Wjtd6gfi
         J+wFzh39NsceR3sp4JIvaQahBfJ8/wDYxahxdJBu8lDzDyEJC7pciYff7jqENVd2gD
         G4YmOETd10KPUZdQWfGlPs47FD56RiCBP8kXX1SiZp29ybieIuidk76R5RjgNUFYvj
         GvN/qCOd3STSKD4+AsK7QtDB6/VL86DZ5xif5JygaFtfw6wcXJQ3SQWBzpww65M1jm
         T1wutzOD4JmQqqQMERV1I66VLyQI2w6s560AleWS0CHQNKXVMko5ddGlxFKI46l/pm
         GmwIeDldv8GDQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org
Cc:     peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, rander.wang@intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com
In-Reply-To: <20220426132539.416676-1-yangyingliang@huawei.com>
References: <20220426132539.416676-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: sof-pci-dev: fix missing pci_release_regions() on error in sof_pci_probe()
Message-Id: <165123956371.69278.7447283193421745642.b4-ty@kernel.org>
Date:   Fri, 29 Apr 2022 14:39:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 21:25:39 +0800, Yang Yingliang wrote:
> Fix the missing pci_release_regions() before return
> from sof_pci_probe() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: sof-pci-dev: fix missing pci_release_regions() on error in sof_pci_probe()
      commit: bdc8cd505b5312c3b26f13f0b6a567d97d55e715

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
