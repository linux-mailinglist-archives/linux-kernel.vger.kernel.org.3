Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B935751C390
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381141AbiEEPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381117AbiEEPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:15:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764852AE10
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E0EAB82DB5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D15C385AE;
        Thu,  5 May 2022 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651763531;
        bh=Y0IuJJqIEp7GuoZ8/5wFaics5bILpDhKmuqI09UXn+4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qVTGJpl21CtUQBcmXS/xmx/XqtlBAbk638DuX90EtnFpySE34rSgEKSkN3MyiXAMe
         vRVDkLuljCq7yUopS4s0z8S31+pcQzQLLaR34Ulm+oNTKPUt3CLhqc0yCCQ/VtuIc6
         BsE9+sdEMBC+6ZqHsro9RKUTt8B3FAemxdYauPpOBRMHwMbenUcr1ONmiRfS+1kz4M
         9OfwHphrwEQH4ItyV4QBRIjlPNOXIJPM17o+Jhn26X6+WqytzcDonQyKQovkZTjTPs
         KS2252mZF/jnZb0rXyPFcGp+MZtPJHXyUv2wi/d/m3OIWlb9yFdmIfJNVOyS0p5E1b
         pZS6vEVqNPuBg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        nicoleotsuka@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Xiubo.Lee@gmail.com, perex@perex.cz, festevam@gmail.com,
        shengjiu.wang@nxp.com, shengjiu.wang@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com>
References: <1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: fix the naming style for mask definition
Message-Id: <165176352745.543130.8069953691884090444.b4-ty@kernel.org>
Date:   Thu, 05 May 2022 16:12:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 15:34:07 +0800, Shengjiu Wang wrote:
> Remove the _SHIFT for the mask definition.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: fix the naming style for mask definition
      commit: 101b096bc2549618f18bc08ae3a0e364b3c8fff1

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
