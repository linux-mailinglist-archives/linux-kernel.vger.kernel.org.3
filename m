Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C8568AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiGFOJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiGFOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48F13DE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB4E61E5D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243CFC341C6;
        Wed,  6 Jul 2022 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657116577;
        bh=+JtukXBA766gOI7S3LFDUUjkO+RnBFyznT0x7iJLGpA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ImFBD4gU9gBuLfbijkPj7gCgLLRFFXMCCBb0xhqby5u4CwArtAnozBT0FWEUO/8Bn
         5cQ42fRrPuXZDf7msTYW7K6VtX/c3F+NErpP/l0NDYRVf5Ym9zWxn4+vz1ihuO34BB
         u0SDBSHshhs+eV4iF52qHv9zgc9qrtc5b3aV2jaowZ48ZyeWqp6xCGq8ctx8yA3l6U
         IIue77kxvs3TMml1o6y72CU//lTz6Yz8DxLfP2jNds4ZHs5UI1qF1QDWGMZByVSRmg
         LOsbpbTvTVOGCtZqMQAGAgiZWZjQPUoI3YA3e4iPE8pSCA0fXGWTn95wypP1xAKV9u
         r8ht0ZBwfNqKw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, cezary.rojewski@intel.com
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, amadeuszx.slawinski@linux.intel.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        sfr@canb.auug.org.au, hdegoede@redhat.com, tiwai@suse.com
In-Reply-To: <20220706062952.251704-1-cezary.rojewski@intel.com>
References: <20220706062952.251704-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: Intel: avs: Fix i2s_test card name initialization
Message-Id: <165711657487.3718491.15631357198534177792.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 15:09:34 +0100
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

On Wed, 6 Jul 2022 08:29:52 +0200, Cezary Rojewski wrote:
> Update printf formatting as 'ssp_port' argument is of type 'int', not
> 'long int'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: avs: Fix i2s_test card name initialization
      commit: f1fd46e068f52893608469df98d4608672e3e45f

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
