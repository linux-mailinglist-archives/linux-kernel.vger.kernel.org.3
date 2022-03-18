Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF724DE304
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbiCRU7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiCRU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:59:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD451B9B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70FD2B825A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831B0C340ED;
        Fri, 18 Mar 2022 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647637070;
        bh=V4OSHyfOu4o/KO9DW2GDd6OSr61IpFYVtU6AC8qxpzg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R8KnqL3lbzAbRqVEnAHgMUVQOda4ULxu+k1FJvxSsXabvOwm66pKUCgUmViWEHRZh
         oi3K0ZZetJfEW+Ab7gYQLicXP0EaV0i/mJ3FxtvPlKf8xKVDcQN4EpGmwNfLFPQ+7V
         fzNg/2xtdSy9ImA12olArM85adR2w1/cEtVCUxjT3lh/VUE2S8v+tA23CkfqqGl8pC
         4oSCbWMSkplPhM6S8Mer1rE2wLJ04oCZWyG+EbhJe3KFlxXjQ867u3NfCWkXDryUEN
         8tEWR5QRtJytUhH75xrl8Nr5MGPQwAcjzTDJr5e1Pb7DZVjb7YWpzK4tc4ilAIS7bA
         /0TD+qFDyRKGA==
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>, shengjiu.wang@nxp.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        festevam@gmail.com, Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com
In-Reply-To: <20220317041806.28230-1-nicoleotsuka@gmail.com>
References: <20220317041806.28230-1-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Shengjiu to maintainer list of sound/soc/fsl
Message-Id: <164763706824.2336370.5050558733573751779.b4-ty@kernel.org>
Date:   Fri, 18 Mar 2022 20:57:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 21:18:06 -0700, Nicolin Chen wrote:
> Shengjiu has been actively working on latest FSL platforms and
> keeping upstream effort as well, while I have been working on
> other subsystem lately and cannot guarantee audio patch review
> in the near term. So replacing with him in the maintainer list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add Shengjiu to maintainer list of sound/soc/fsl
      commit: d1129bbe141bf08c19d44a701869ac0780754e86

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
