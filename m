Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A252F130
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351985AbiETQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351998AbiETQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:59:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB951862B0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 340DBB82CC9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D16C34100;
        Fri, 20 May 2022 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653065930;
        bh=3azuETAmGZlEwX/wPLs4EOiDGdGEXJV56CdJtxT8nI4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XUPFO+qtP/NLt3gMki4chQI1J4qFlh9mUpktQbMvpfuLd4VkyhdV90Z+NKIvQ1nn3
         COTGJObBu6HwIh4z1UM3WxRKsLxnYyvYqtigLgixZgEvfTVunwrs5wYxghMbOrF10Y
         fK+pnsP1hEGrKm+GICIxLu2S+LBZlkASF5xd+VX6fYBOf4WFD8wDulrgHI4GPuZMvo
         Pzd5xbKwi8CBaS73oJYKow+H/AjyjZ7+Khc/bBK767qmX88EuvqsaXVwi8iiMjss4W
         pfc2EZx6ZnfkJ+slzGnhg1N7tYaTY/akWKWsph29YcAt8Pwq17kUwpg+UNJsNryLjC
         p4FlZ7AhwVFZQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, khoroshilov@ispras.ru
Cc:     perex@perex.cz, ldv-project@linuxtesting.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com
In-Reply-To: <1652999486-29653-1-git-send-email-khoroshilov@ispras.ru>
References: <1652999486-29653-1-git-send-email-khoroshilov@ispras.ru>
Subject: Re: [PATCH] ASoC: max98090: Move check for invalid values before casting in max98090_put_enab_tlv()
Message-Id: <165306592925.462688.10342904304525051880.b4-ty@kernel.org>
Date:   Fri, 20 May 2022 17:58:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 01:31:26 +0300, Alexey Khoroshilov wrote:
> Validation of signed input should be done before casting to unsigned int.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98090: Move check for invalid values before casting in max98090_put_enab_tlv()
      commit: f7a344468105ef8c54086dfdc800e6f5a8417d3e

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
