Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234FE4FE751
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358483AbiDLRkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358478AbiDLRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556662BDD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA10BB81F62
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5614CC385A5;
        Tue, 12 Apr 2022 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649785093;
        bh=TZTX+w/+zW7qddMqOIK0hPgH/PbZ/aVnw54OFqAFprU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qk14KPFhxSpUtSDDpUrQPtmZKHEA8QRq9okCEXCsHg7m5qRx9Tl19b6P4UV0kjHN+
         za0ptCA2WKxtEBh/kq/2dh3a2OTm4Ik70VdQNLgGzXMesS0HljfDMg5G0aFMmdiPoG
         DZzLJ2y0JhfoEQPVjC1mwsWJK1nqO1in92GR7ByI9Dwq1UBP8AA2W5y6y9M/DPsd2t
         qX4ifT9/av9A/kwhrASs4L97lM2Gx6IO7EurkfutQOVtK36zievHtBaK0HTpxPzdoR
         ybQJmXHCw42SSGwgg9mZmvCYtLDvA0x8XViMREzYB/ALeUybnEP4IFiDEbwvIXW2gc
         f3bSF/fKG82uQ==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar.Mukunda@amd.com, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Richard.Gong@amd.com,
        lgirdwood@gmail.com, Alexander.Deucher@amd.com,
        Takashi Iwai <tiwai@suse.com>, Mario.Limonciello@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        dan.carpenter@oracle.com, Jaroslav Kysela <perex@perex.cz>,
        Sunil-kumar.Dommati@amd.com
In-Reply-To: <20220411134119.1767646-1-Vijendar.Mukunda@amd.com>
References: <20220411134119.1767646-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: add new YC platform varaint support
Message-Id: <164978509107.404572.15074301323548091062.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 18:38:11 +0100
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

On Mon, 11 Apr 2022 19:11:15 +0530, Vijendar Mukunda wrote:
> Update PCI revision id check for the new YC platform varaint.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: add new YC platform varaint support
      commit: b1630fcbfde6c071d964b1c475871db0ebc96048

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
