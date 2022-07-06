Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44B568668
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiGFLIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiGFLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2780627148
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCDD61E62
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D17C341CE;
        Wed,  6 Jul 2022 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657105684;
        bh=BZCKP5tZSxu06QM9jLVz19aqimTq9g4sT3WFL7FeJ4E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O/7alNDvspGn+ZqprEjuMKPkSKP26SZSop292NkkrTG8BsJx5GMSdUjndI/d1X7ZQ
         Ycz/B4nBUt9dBclWPJmC7QlzEsPRcWrSyDnwfdyTYBUxd0SkODNAX2Ig1EPUu3FNOi
         2Xq/0pBw5ft+FMxg/YujRFrE9TpOvWlyKfO/4AILfzhOHdaWnuR1Nqos7QTTnBAAk6
         T6pO++OEfDcVUorOvziBsXRn9ks3qxLyz5yCiRqCdwCCD265bGGB4tKhb4n6EUciNw
         Tx2L9yE4z7ZYKo73ICdTCKMrJFEd5Me+HvUf+bgO9m3o5EBR1os8F0bDO9s9/qog8N
         AJ2C6Qu+NeqHA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        andriy.shevchenko@linux.intel.com,
        sound-open-firmware@alsa-project.org
Cc:     ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        kai.vehmanen@linux.intel.com, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>, daniel.baluta@nxp.com,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220705161102.76250-1-andriy.shevchenko@linux.intel.com>
References: <20220705161102.76250-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: Intel: bdw: remove duplicating driver data retrieval
Message-Id: <165710568133.237380.11160938064727349127.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 12:08:01 +0100
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

On Tue, 5 Jul 2022 19:11:01 +0300, Andy Shevchenko wrote:
> device_get_match_data() in ACPI case calls similar to acpi_match_device().
> Hence there is no need to duplicate the call. Just assign what is in
> the id->driver_data.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Intel: bdw: remove duplicating driver data retrieval
      commit: 0d356c186ffd6d4c3e10abb283379d09a93d2515
[2/2] ASoC: SOF: Intel: byt: remove duplicating driver data retrieval
      commit: 65b6851d243ff54cbd4adfb887a8af9d04b7f286

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
