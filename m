Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38DF4B6CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiBOMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:55:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiBOMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:55:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A96434A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4010ACE1F19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDECC340EB;
        Tue, 15 Feb 2022 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644929690;
        bh=SQleo2xlXQWhTxSpmfgwhq3x/rAKEffiIU7ixrJ2MH8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Iw+UDR0ws5T+eQlhqHc2gSURHyTJyK7DDQlfBbWOU8d7rh1IpoUEBwZiMg9N1zpBx
         y5o629uw3g+laYyt4slP0DThP+lOh5+GE/1vI5GiX+HaDNSkXqKJ0XHz3I/80W9udE
         DF4qLam+AuI9f68/oRmkXrlR3Ig9abt1Myl4o/QlfD8AnX03r/gmKL/wKZfKelQu5r
         CFLrw+GoBYWvS2O7xjrOtKeGop39oqSdiYXcGMh7zEAKsIatWgiqw242y/czJzxXuH
         dnozGW113Uh4UY4Z/waTYY3IYMUB65akRVQ8CJV53NBOKchfqTVv3zy3RZZVvJ1Xxc
         6lN3IDKvlt1jA==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com
Cc:     fred.oh@linux.intel.com, daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220214071330.22151-1-peter.ujfalusi@linux.intel.com>
References: <20220214071330.22151-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: Makefile: Fix randconfig sof-client build when SND_SOC_SOF=y
Message-Id: <164492968840.13815.4226647286187449899.b4-ty@kernel.org>
Date:   Tue, 15 Feb 2022 12:54:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 09:13:30 +0200, Peter Ujfalusi wrote:
> Intel's kernel test robot found the following randconfig combination:
> SND_SOC_SOF=y
> SND_SOC_SOF_CLIENT=m
> 
> In this the sof-client object is not going to be built into the snd-sof.o
> and we will have undefined references to the sof-client functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Makefile: Fix randconfig sof-client build when SND_SOC_SOF=y
      commit: 4965e38fa064056021254af4656b1089a42dc764

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
