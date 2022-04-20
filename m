Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C2509231
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382584AbiDTVnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiDTVnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDAE2FFEE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D871061975
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CC4C385A9;
        Wed, 20 Apr 2022 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650490852;
        bh=hJ4Cnh58Gh4Afg8kZfmnguM7Bo4hwgAMX8DV3JNSniw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R7T8gMSbfivvxJfUlI1y/F6TZeVLsQDOD9tZhN/odCiTjLKcj0kubeSOTHxayi38y
         Q8IEToUsWyI+fLD0hyKFo9DPCD7SYnoybKrzu5I6haKkEJQDa9RVbWr+LGa+jfi060
         e9hGkTrYqPe1Gmzme8DFd3B86eNioisbdqDoUrkOZT5vKnztwKD4fhBOVlIp87GdAq
         76DgI70RBnQCp/GK1OODawTGZRtucDhVzr2Zj3+E0HZJPcaCp+brNgmQrH+N42+QHd
         5iFVS37hScFMzuvFV7oDnDYD+MuQBnnXhNgHpyphlOiGKjIYY5zAJwe4/xrllz+341
         Du4NbuMpxgYFg==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@nxp.com, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
In-Reply-To: <1650251910-8932-1-git-send-email-shengjiu.wang@nxp.com>
References: <1650251910-8932-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: dmic: Add support for DSD data format
Message-Id: <165049085059.138067.16136927619532559711.b4-ty@kernel.org>
Date:   Wed, 20 Apr 2022 22:40:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 11:18:30 +0800, Shengjiu Wang wrote:
> Add DSD format support in this generic dmic driver:
> DSD_U8,
> DSD_U16_LE,
> DSD_U32_LE,
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dmic: Add support for DSD data format
      commit: 3271be0628917a97d8757b02b5bc40856fd03476

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
