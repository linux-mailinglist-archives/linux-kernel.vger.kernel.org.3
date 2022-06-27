Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA65155D089
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbiF0UTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbiF0UTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143861E3F6;
        Mon, 27 Jun 2022 13:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D5FC6157B;
        Mon, 27 Jun 2022 20:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E1BC34115;
        Mon, 27 Jun 2022 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361145;
        bh=AopzUSqPXSHo18J552vDhBqM08Y7dy8OrW6rgjrW1ls=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KFg2cZmYg7/VfA3qIVivStEeALhJmdSxXC1sSadEFNECvuw6kH64Abzr6oC2Axgx9
         OvllhhpKWzuLcCYsW9U+ezDd47fKWowLKdxg3l6xHRsv4gqo99UR1myo8KwOx7Jbwg
         AXNbr5khSBuwfLl+YbaVsvgMLIKsIqTUrrOG4VKThelwywvqso1fNIfPfRrXWvId1j
         C8XgKI1/5IHtf9UAztqg57ON2NzLPg1lWxBC0DwWOvFI0VvEr35PggCfG0ANRyydvg
         z2VNYQ1xqVT36Hehrs8N0j7QZEbEUzFstompjvy15ecfPhaSIqgAJ/7aCd7VgLM6gm
         KukB1AaUpc74Q==
From:   Mark Brown <broonie@kernel.org>
To:     jarkko.nikula@bitmer.com, tiwai@suse.com, perex@perex.cz,
        peter.ujfalusi@gmail.com, lgirdwood@gmail.com,
        dowens@precisionplanting.com
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220615150955.4140789-1-dowens@precisionplanting.com>
References: <20220615150955.4140789-1-dowens@precisionplanting.com>
Subject: Re: [PATCH v2] ASoC: ti: omap-mcbsp: duplicate sysfs error
Message-Id: <165636114384.3997797.13146235738897882917.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:19:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 10:09:55 -0500, David Owens wrote:
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requsted
> probe deferral:
> 
> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: omap-mcbsp: duplicate sysfs error
      commit: 6d31e225742a1955db8a0c6f6f52beb748a2895e

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
