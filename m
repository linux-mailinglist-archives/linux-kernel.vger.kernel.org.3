Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3901153FBE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiFGKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbiFGKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A178EFF11
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D984F61552
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D4CC34114;
        Tue,  7 Jun 2022 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598778;
        bh=yC8T59/BRz/X+JQAGI6Qd3OPd0knEKaMRtnGwawWGZ0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZR9M1HA576G0+38VjdH59zkBtS7IVBu0+sGDgE+T0hGBANC9CdwjgIzCtFCWFpqqS
         i7UVNw+QSu8iIaL3zH8F2/V6QGgQLB8hqJbw2i+3dF+pARUuMd+MWTXj7LMivPV0lV
         T0iWWl0GBhI8hicugm5FwMQQK5HwYyjhJH7txhg2fh0OoVHSXEB7zSCvOUnXTJsCcq
         qvaiNO9iNuW1/FUXE+r7F6HrsHSNGZEGmbUq9UeItxUMRiwR5GGyhDdtiP2ENhat+H
         Ohx+86yp++tUCljsC25Pcnt0HuQIr5UW5hpPOwCKD74MRQuZ4WovsgRwD0hj7PzK19
         08NimK5PxNlAw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com, lgirdwood@gmail.com,
        shengjiu.wang@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1653966123-28217-1-git-send-email-shengjiu.wang@nxp.com>
References: <1653966123-28217-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add support for i.MX8MN
Message-Id: <165459877588.301808.14404334130275114401.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:15 +0100
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

On Tue, 31 May 2022 11:02:03 +0800, Shengjiu Wang wrote:
> The SAI module on i.MX8MN is almost same as i.MX8MP,
> So reuse same soc data as i.MX8MP.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Add support for i.MX8MN
      commit: 9688073ee98cb2894d5434fe91dd256383727089

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
