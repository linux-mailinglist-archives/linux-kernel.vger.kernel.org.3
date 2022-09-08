Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C75B1D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiIHMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiIHMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2A6D21C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372EE61CE5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED797C433D7;
        Thu,  8 Sep 2022 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662640964;
        bh=37cWeoqH7Gzne38FCrMcNkjD+PXkpO/LbEOstYxMLno=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M4RUdgwvzlEQfim9qXJ441hh/BHscU0kgTV6UsMa+oQGIKjoHf6+ki/q5Ar37xCAd
         HeKVNhanydWqI1h8ytT2EPnQgYS+QcgannGglwCjUjHOxCpAd9UuEjrWZVnzDBwZIG
         mfbXqFdSV08wg5MivYul+I0CAXOXT/1fn5LiR566AW45vgkcG9sydlGAPODZR1/UVQ
         YAhU0nXROs7XdQ80b1hckbek3TTyMJQISjuBBS9rMhz2+3se3uBCTHQuYcgLtEqg4h
         fwmcA28ptADnic3tS7Ue/2JD6ABuyNMR1sDOpQp0sn253vYY/vmV1mA3crBdDEGq+x
         R/MEb/oEwnHCg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, linux-kernel@vger.kernel.org,
        Steve Lee <steve.lee.analog@gmail.com>, lgirdwood@gmail.com,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     ryans.lee@analog.com, krzk@kernel.org
In-Reply-To: <20220908060359.13606-1-steve.lee.analog@gmail.com>
References: <20220908060359.13606-1-steve.lee.analog@gmail.com>
Subject: Re: [v2] ASoC: max98390: Remove unnecessary amp on/off conrtol
Message-Id: <166264096268.88408.10282562173881107177.b4-ty@kernel.org>
Date:   Thu, 08 Sep 2022 13:42:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 15:03:59 +0900, Steve Lee wrote:
>  The Amp is already control in userspace before trigger calibrate function.
> Remove unnecessary control in calibrate function and
> add condition to check calibration is ready.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: Remove unnecessary amp on/off conrtol
      commit: 6ac246105b4fd737ed51b8ac3ef031f837686dee

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
