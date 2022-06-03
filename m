Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857353C941
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbiFCL0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbiFCL0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E733C4BE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B924D612EC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C8AC385B8;
        Fri,  3 Jun 2022 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654255599;
        bh=ePO0oMd2hXHYFPqfmas8/MfHkG7JTc+UdxPVMGtLXe4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pnONbZ2p6xrbNb/5sM+6UQ2uRrIeoBT8/15qzNLogMvQ9Gfo5fsJU/j/ecWglLvVW
         0btgbzLyxwPCTNL5rGrrGhe2EufbpK9AJ4iBhFbTrUtlGj0wE9Q9arzpEqOzfwv2r2
         YbPRrY2P12+3IcDDelAHKOhcDB5eNnf+YSBqR2ReJwB9ewBBsk5tCkhfiMu/iSRfj2
         nzz7ot4TH1zkn0jphhCf1yrGdug95EaYO2oX1zjTqmjBotyQFmBV0sTSKin7oMSZ7E
         29CtqlBLvyhJWRmB1OgPQyIE+Qywk1eW/RvCok8Y+WtBO1XpRd6iay9bBmYIVj5Gm1
         DJS3eVvFTAAsQ==
From:   Mark Brown <broonie@kernel.org>
To:     brent.lu@intel.com, alsa-devel@alsa-project.org
Cc:     yung-chuan.liao@linux.intel.com, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        tiwai@suse.com, perex@perex.cz, yang.jie@linux.intel.com,
        xiang.liu@cirrus.com
In-Reply-To: <20220602051922.1232457-1-brent.lu@intel.com>
References: <20220602051922.1232457-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: cirrus-common: fix incorrect channel mapping
Message-Id: <165425559642.3863069.12777301220337016957.b4-ty@kernel.org>
Date:   Fri, 03 Jun 2022 13:26:36 +0200
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

On Thu, 2 Jun 2022 13:19:22 +0800, Brent Lu wrote:
> From: xliu <xiang.liu@cirrus.com>
> 
> The default mapping of ASPRX1 (DAC source) is slot 0. Change the slot
> mapping of right amplifiers (WR and TR) to slot 1 to receive right
> channel data. Also update the ACPI instance ID mapping according to HW
> configuration.
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/1] ASoC: Intel: cirrus-common: fix incorrect channel mapping
      commit: d69a155555c9d57463b788c400f6b452d976bacd

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
