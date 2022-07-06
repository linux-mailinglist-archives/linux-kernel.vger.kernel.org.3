Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570ED568666
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiGFLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiGFLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:08:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C602726AE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FCC1B81BE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0FDC3411C;
        Wed,  6 Jul 2022 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657105681;
        bh=V1oSo1AQmycapa1vVwI/k7VAl2IrguFLziT4xpVLFFg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=opTtOxdI5xvrP0TP3NAnHQpjFjAMLrMAhnVoku5qb5xPU7gWUyHerSDmeyaCbYOit
         RkN+XAn8A8veCuvPoDJNKriz2hO16NHYRLA9lkdM5hNjSxMkoaNqTt+/NlXWs7Yz7g
         F9oqzQddZ31R1ex2saHY4LfHVVMhFw2ianPouThUpl+AnsSvJUI6inqBqvd/CiSRIH
         5qmoiqG/bih+0OazWwJx6TiCw/L+l/BHiG0ie2C80XcalQEM9om6ebY5k1aVhKmbDA
         BdYFRCernxQpN6CvPILbxUvPzG3gxiq7TM0NAWXDVsck/7YZl3Dpk2DdkRWcvmRbLa
         Aps25WXt0hUBQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        andriy.shevchenko@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, liam.r.girdwood@linux.intel.com,
        kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220705155813.75917-1-andriy.shevchenko@linux.intel.com>
References: <20220705155813.75917-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/1] ASoC: Intel: catpt: remove duplicating driver data retrieval
Message-Id: <165710567856.237380.17954574328777286737.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 12:07:58 +0100
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

On Tue, 5 Jul 2022 18:58:13 +0300, Andy Shevchenko wrote:
> device_get_match_data() in ACPI case calls similar to acpi_match_device().
> Hence there is no need to duplicate the call. Just assign what is in
> the id->driver_data.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: catpt: remove duplicating driver data retrieval
      commit: b03bd215742c620812e47a9ef5f08e4e0e5f0a1a

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
