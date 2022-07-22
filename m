Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0FE57E78B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiGVTjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:39:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76774DEC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C66B82A1A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 19:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11267C341CA;
        Fri, 22 Jul 2022 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658518773;
        bh=pTCw8ObXsDCRk0h5jJUavUZSjr/XJYr7gxR45qvE8nY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UDjmED47uZ+4Boj+sIyCQNmprg449KHHSlhBH261Qa+HAVgZy1Go92lIzsIU9sVsI
         SQb+2985ikSNT6tvxCIz7vbL0Su/LiBjnOnJjZaV5Ckprqn2fAqE6crpbOIqmTDVMP
         2ne0mNp3nTqGzPLapehEd4A2sm95OzK07BVEVdQw2r+vGUeOB32FkzSAdSS04mwA3e
         OjOvl4mXPpCxz7SObHP2oGfwufxXFLmI9g6Z9PzucP3n0r+QAAKBCu2qQTp3qYmi95
         XIHaX5dX67/7F0L2Iqvb3avwbVyGApFPuKf9iLgyGvzew5Ch+A+SFyfIh5q39z0eoc
         oUBUHMAks2fbQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220722092700.8269-1-cristian.ciocaltea@collabora.com>
References: <20220722092700.8269-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2] ASoC: amd: vangogh: Use non-legacy DAI naming for cs35l41
Message-Id: <165851877179.1163063.11067472493999733976.b4-ty@kernel.org>
Date:   Fri, 22 Jul 2022 20:39:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d952f
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 12:27:00 +0300, Cristian Ciocaltea wrote:
> Unlike most CODEC drivers, the CS35L41 driver did not have the
> non_legacy_dai_naming set, meaning the corresponding DAI has been
> traditionally registered using the legacy naming: spi-VLV1776:0x
> 
> The recent migration to the new legacy DAI naming style has implicitly
> corrected that behavior and DAI gets now registered via the non-legacy
> naming, i.e. cs35l41-pcm.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: vangogh: Use non-legacy DAI naming for cs35l41
      commit: b340128432a2b8849cc34f9653d7c43c83102bbd

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
