Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41694B50C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353714AbiBNMzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:55:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353677AbiBNMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:55:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7461FA189
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:54:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B7CB80E9E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF29C340EF;
        Mon, 14 Feb 2022 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644843288;
        bh=EZW3lZdYq+GDhRswwuSuTJNnoxG+mz66jlbpxWVjOPc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z+LqobOgcNPpGIQKZeXly1CZFQYHP/Pa0RCpIJasnKK5I+3gaY1Df3z2vBo589xWf
         Bt7muIar38rlbBK4RBGdPv/fHz5X3Uq6BB8M8daWflMk0FBvxF8rTonasVfts1cIsr
         owq472aANMm5bgwVbw9OCzm5Z8E9JpoPxZMAqZR0q836PeSGaStg9qCXYUzoZX03CX
         3gEEkPxsEYbVMezfBlo7INNeH3z7UNwHz9Ko6xxR2c1R4qtn1PEwZFujj0dMJsZSsB
         Hu7d7E69/9nPfb9hqCI/60GBcxzX3mfpwDEbYgqh0gL6JCyuy2XY+nbdKfJH0Kz6M3
         PW44gM2Bw21DA==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, lgirdwood@gmail.com
Cc:     kernel test robot <lkp@intel.com>, kai.vehmanen@linux.intel.com,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        alsa-devel@alsa-project.org, daniel.baluta@gmail.com,
        daniel.baluta@nxp.com
In-Reply-To: <20220211082631.179735-1-daniel.baluta@oss.nxp.com>
References: <20220211082631.179735-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: compr: Mark snd_compress_ops static
Message-Id: <164484328683.12994.13325430085185619773.b4-ty@kernel.org>
Date:   Mon, 14 Feb 2022 12:54:46 +0000
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

On Fri, 11 Feb 2022 10:26:31 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Functions won't be directly used outside of compress.c file
> so mark them as static.
> 
> This will also fix warnings reported by kernel test robot:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: compr: Mark snd_compress_ops static
      commit: e7c799e76f070b4ac13498e532574466064ad6a5

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
