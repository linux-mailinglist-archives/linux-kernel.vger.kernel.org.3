Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01AB51C38D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381148AbiEEPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381127AbiEEPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:15:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A3A19296
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B606EB82DB0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D23BC385AF;
        Thu,  5 May 2022 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651763533;
        bh=0D7MU0dHkdxGOE7RXexlR/iR0tAYQw8+ivhRWjMp3FA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=agnsg3TYnwpX6aPG9clT2R2gXSbQqDEzIxmBhg26tkwdUNDbOZNE36zATNUWDZQ2o
         7vRcwxtXNheKa7AfP1EH7J3TNuHB6FbnbZ3BqIsKWlStqbmviwNnJ6mgvItQvdVE5Z
         VHTEitiQq2SGquRDA3E7RYjzqFP5VmKmZbItMRVpp/rh8/wDjRJ0GP3fdSFsQBAvNX
         DGrUtguzIspgflva/h4TvNF2u/Mzfgm1g+qOXVduyW5gQmENDXnPeegYIzmlWNLoai
         iaxAyDL8/+lN9+1gLHmAjE4M3ODJDfe8Pr0HE5NhTaBI3WIChrDAs1nPTTrj4RbtUi
         /esxfEI2tDc9g==
From:   Mark Brown <broonie@kernel.org>
To:     j-luthra@ti.com, peter.ujfalusi@gmail.com
Cc:     lgirdwood@gmail.com, tiwai@suse.com, j-choudhary@ti.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz
In-Reply-To: <20220505111226.29217-1-j-luthra@ti.com>
References: <20220505111226.29217-1-j-luthra@ti.com>
Subject: Re: [PATCH v2 RESEND] ASoC: ti: davinci-mcasp: Add dma-type for bcdma
Message-Id: <165176353126.543130.13376348569850557799.b4-ty@kernel.org>
Date:   Thu, 05 May 2022 16:12:11 +0100
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

On Thu, 5 May 2022 16:42:26 +0530, Jai Luthra wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> Set DMA type for ti-bcdma controller for AM62-SK.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: davinci-mcasp: Add dma-type for bcdma
      commit: ea706e5604e6d68ec7ec7243f0af0b569045e925

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
