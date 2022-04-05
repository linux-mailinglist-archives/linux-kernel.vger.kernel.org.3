Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A6F4F3DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387594AbiDEPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbiDEJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B0DBD05;
        Tue,  5 Apr 2022 02:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C8F1B81CBE;
        Tue,  5 Apr 2022 09:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C1AC385A4;
        Tue,  5 Apr 2022 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151110;
        bh=akJwXD5N3s4UPZe2aQccirJblgU77qRMdXJ8Vx02u74=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QY5Z55casbm5lR6qsgeuDF3G8adn/VXiErF+RjsEtRsfg4GpaCYaLtvuCO7PosAxH
         kkHB4iFMUltTTxoOVUAWWxvmuuENoZDt3kuzHs39r1ZJlxfJo0FdygNGNwcPqzn05n
         alNWru1jDELUfjINuCrFeKn+QHu7c7guZdOzI3Ydp+JBlBhvMWG3hlkDXFuvqSvHwJ
         U7Q/Eb5Lx3JOF0FPj5sUmQgVwgZuTweYoqr0Xm5Xuss8HGf8VTC/aTBs55mnupUSb6
         0Gns2AVqDzFaYzE8FSOdZR42prBZ4S4Y3h/Je4fBzLhPxmb93jke+bOB178wwnQJwf
         mSfQ0BvfzW62w==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>, povik+lin@cutebit.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        marcan@marcan.st, alsa-devel@alsa-project.org, sven@svenpeter.dev,
        devicetree@vger.kernel.org
In-Reply-To: <20220331000449.41062-1-povik+lin@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
Subject: Re: (subset) [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
Message-Id: <164915110754.276574.17127953624002951420.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:47 +0100
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

On Thu, 31 Mar 2022 02:04:44 +0200, Martin Povišer wrote:
> I put together a machine-level ASoC driver for recent Apple Macs (the
> ones with ARM64 SoCs) and want to gauge opinions.
> 
> Commit 1 is the binding. It is some subset of simple-audio-card with
> the extra distinction of allowing multiple CPU/CODEC DAIs per a DAI
> link. I want to draw special attention to the issue of describing
> speaker topologies. The way it now works is that the driver expects
> the speakers to be declared in a fixed order in the sound-dai= list.
> This populates a topology the driver expects on a particular machine
> model. Mark (in CC) has made the suggestion of keeping the topology
> descriptions with the codec nodes themselves in some generic manner,
> akin to how sound-name-prefix= already helps identify codecs to the
> user.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[4/5] ASoC: Introduce snd_soc_of_get_dai_link_cpus
      commit: 900dedd7e47cc3f8d93dfa0ae6ac6cf49eda0c97

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
