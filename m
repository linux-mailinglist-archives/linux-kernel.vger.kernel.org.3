Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A225B1D70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiIHMnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiIHMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:42:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56187E5818
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86B83B820F3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13557C433B5;
        Thu,  8 Sep 2022 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662640966;
        bh=qvuIBK510EN7O/FMzgVwGP3upPVbCj22HKVOyWgYzm4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ttztZwTQdfiY725FJwQpHtF06zRglzvuZKMk24GU1XYbFzf32rN7MxaTPMiJGr/r2
         Y+Cp/UX3sEFFhCWP8e2MhpZLQNqyhCWCyhRyolKVAPDZPTPLHoVuXuYHgQm/4fNjse
         Gli6gFh2dptIgNAWX8oRT13fUpzQ0VJKFsHHiR5Ihd2P1iL/fUc1UFiTUwOVhJUkM+
         s1rsmQfedq0wHEhm49vE8KFrS8f1uT2EimPCsSEt/MOSeIqenuZ4Q0EpxEO4Iz2oHe
         ZtKvm8hquKNZ6s6GktmwC7Zl7sU1Wgmsyl+CgcppRvJ/jwQTjJCItha3mysYBiXDvR
         5f1st1A93WzKw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1662622316-23426-1-git-send-email-shengjiu.wang@nxp.com>
References: <1662622316-23426-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: ak4458: Remove component probe() and remove()
Message-Id: <166264096479.88408.4541345666660844637.b4-ty@kernel.org>
Date:   Thu, 08 Sep 2022 13:42:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 15:31:56 +0800, Shengjiu Wang wrote:
> Most function in ak4458_probe() and ak4458_remove() are
> duplicate with dai ops, so remove them and move dsd_path
> setting to dai ops.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4458: Remove component probe() and remove()
      commit: e9e7df88996d64544178f48b0299dfe736c6aa22

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
