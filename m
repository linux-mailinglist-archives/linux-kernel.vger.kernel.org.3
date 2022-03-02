Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2CF4CAB00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbiCBRBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243597AbiCBRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:01:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A9C7E99
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:01:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02199B82105
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC051C004E1;
        Wed,  2 Mar 2022 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240462;
        bh=zQgX99RnmDfopMg14Npy7ylLj4lE4ZQcG0Wt4mJO/ns=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z2zBthAA3qQf62InUSodEhXBrKOBe0x7MWbBYY1wqRCTi32kpGGBma4gaacqrZl85
         721ybwPBYNV5JtBQXfisKS/iC3r6oRiXLxVX44c/xW5+YQwMlCdriDPjvtg4PhbzDo
         13LQt0llKBuSyFvPVk+ZuYxKNnwVWT8Vgu0gvG/J8C3D83c/f1Zg8PNOVwWNHoyfBQ
         fPVQ/kQv78TtNYNStBXD8WLEUhaQnYZoj8uuDyScjqI/zvVu42yQwWc5Wt8b8H8om4
         Mo6f0HJucb8GkjjH/gm/vjuyCoEnnQLEfkbomNTZDpEdKUc4QCb/FsLxgQ5l2/6B+W
         oaxyK+cVweUEA==
From:   Mark Brown <broonie@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>, tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220302081502.25367-1-nizhen@uniontech.com>
References: <20220302081502.25367-1-nizhen@uniontech.com>
Subject: Re: [PATCH] ASoC: amd: use asoc_substream_to_rtd()
Message-Id: <164624046142.1145067.13335367262835814922.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:01:01 +0000
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

On Wed, 2 Mar 2022 16:15:02 +0800, Zhen Ni wrote:
> Uses asoc_substream_to_rtd() helper.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: use asoc_substream_to_rtd()
      commit: a2253ec7aef2c942630ecbe3380690bd3a704a94

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
