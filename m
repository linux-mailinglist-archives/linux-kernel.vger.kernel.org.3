Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97653FBCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiFGKqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiFGKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C873ED72F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5292B81EF8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0A0C385A5;
        Tue,  7 Jun 2022 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598740;
        bh=tMS1gG3dXMPWf84lcdBNSw3MxsgI83j5BwdlSZTqOaA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=fSj1nLhWMxGdMrbyxQD622Xxcv9d4lhwS3PvmyWltkid6i7b3ugUjtTYNQ9Gc2VqJ
         7Nh/qd88jGvpD9J70u5ab46ybKz2OpUxLau3iYDBPrwl1Dj9UWVpld1nrLTgdwBLnt
         B/Kl3yGmPv/9zut2uRxca/zlmMg8QZf6D9YdhUOtNh73aWRctSII5RstzBKKqZ96vg
         u/qW2ZDK3NMvLxKL/mrvq/pusJ/s3sdPEVivGeUHDMEk4Ew1XYBdarVjJ/Rlqk+GYy
         TEqy3U6uNwiq/Y4JXILcrm06XtAp/1852GT+15LJ0aqrYowdrIsQyHPOCffmca/tNe
         ekQ2oT+q0CgGg==
From:   Mark Brown <broonie@kernel.org>
To:     cychiang@chromium.org, chrome-platform@lists.linux.dev,
        linmq006@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        tzungbi@google.com, Takashi Iwai <tiwai@suse.com>,
        groeck@chromium.org, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org, bleung@chromium.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
In-Reply-To: <20220603131043.38907-1-linmq006@gmail.com>
References: <20220603131043.38907-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe
Message-Id: <165459873804.301808.717161588235185866.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:38 +0100
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

On Fri, 3 Jun 2022 17:10:43 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe
      commit: 0a034d93ee929a9ea89f3fa5f1d8492435b9ee6e

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
