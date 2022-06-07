Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5953FBCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiFGKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbiFGKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EECED798
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ACE3B81F09
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BADCC3411F;
        Tue,  7 Jun 2022 10:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598742;
        bh=fYxNbwPSVr/66WMOgiyAGOorrBlpKFmsqN5lemf2nIM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=YoA4Ppkdp8AYFYI0bTkAynYDmgn6Kjb0j8j52AYcOjvg2skP8HrPDqsdk7FRjeXJ4
         8YuXB1NwYrdz1GjnDaHNjm13NRM9a2v4iBfO0ebsSBuOxL6MeaUE5jLs4vvafmk44E
         Qwx4+Lh5QDoPKqE8IfpWcCnCPjho9CYCEDXj755TdJ8HaJCeuJihXr1S/LVEZXKpb9
         R4GCmR7+/IcGTAv7mee/R9UdWK3mfcXB55l7bV1kfhdzaHN9n2URpyBiDt2I4lARll
         y9/vNDqWBBvfeyuGY1zMKR0TggR9hhjahf7Sn2yms33cZXmLCyNv477dofcxi7PhDq
         PoJGyovBoxX+Q==
From:   Mark Brown <broonie@kernel.org>
To:     linmq006@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        krzysztof.kozlowski@linaro.org, Takashi Iwai <tiwai@suse.com>,
        s.nawrocki@samsung.com, xc-racer2@live.ca,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org
In-Reply-To: <20220603130640.37624-1-linmq006@gmail.com>
References: <20220603130640.37624-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: samsung: Fix error handling in aries_audio_probe
Message-Id: <165459874083.301808.8944605604871415466.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 17:06:39 +0400, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> This function is missing of_node_put(cpu) in the error path.
> Fix this by goto out label. of_node_put() will check NULL pointer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: Fix error handling in aries_audio_probe
      commit: 3e2649c5e8643bea0867bb1dd970fedadb0eb7f3

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
