Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3614FFCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiDMRid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiDMRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C956B0BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3563361EC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C00C385A3;
        Wed, 13 Apr 2022 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871368;
        bh=83gawc2ryUKhE6nTyQqw/IKIOP5+eSo7X0LmsnEkxxU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hMlgxCqVBchlxxtQtNi462qSDjM3PPMbcYvrY2aav4Z1yrBKaZiz8PY37R+jcTOuc
         BwMAMCtObxzPuFsXRalmx7zq5VB1lqHEPda8Swvh3c7dXrZwdKC4uJqJHpZJSIt12N
         zUZC1wrG0bIWqLOkoNLKAzTJHuWuhkSS+U6a/ZcF64cG4QLL7mB7ZZ5SoDYotishQd
         Z8ta77FD7r/sBPCVOnZRvblCwsLoUgftWsaLmDvQGuxQJdMFL0AXuIdwPmdL50D+YW
         Iaf7gZO+tgrXEJGuuCvwRxWo6K5vBANnXHMYxeOWrd64iPtB3lhE552pMq6JdnDi09
         nawLRpT3cOjhA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, zheyuma97@gmail.com
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220409143950.2570186-1-zheyuma97@gmail.com>
References: <20220409143950.2570186-1-zheyuma97@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Check the bar size before remapping
Message-Id: <164987136564.69869.12166607399991821172.b4-ty@kernel.org>
Date:   Wed, 13 Apr 2022 18:36:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2022 22:39:50 +0800, Zheyu Ma wrote:
> The driver should use the pci_resource_len() to get the actual length of
> pci bar, and compare it with the expect value. If the bar size is too
> small (such as a broken device), the driver should return an error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: Check the bar size before remapping
      commit: 5947b2726beb61fe7911580f239222ec9c4f6967

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
