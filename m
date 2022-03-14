Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D94D7DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiCNIze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbiCNIzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2485F205CA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9EF861253
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC8C340E9;
        Mon, 14 Mar 2022 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248062;
        bh=p4ElLYQEUziQquOXGjlyVsfodhAUjuWMOWPfRqiA1CQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ClgaSrxx+YK8DEi3hv7eB7Q+IoSshccFeUtdX8T5E6uFsQpYY+Mm8cVEPPRapks/L
         IkLFlZBfuDEyoN6cE70GklFm24i3tIPac8h5UjBPeV1V1d3CsjdbaPdl/a6nXV3hha
         f+RYjYBwZ+YUmW+V8usHP6corE2R9hEJipc6rjNI2YT+vSYqcmffAzGwWeZJ644MfR
         3q49nU6yqtfAP/XyhGhYrRiRrMUy5DZNMM4xCspBvQG6KBCQtUtg2KNcWe0KhMb2zL
         iiVhPfD40byS0Xf9yK4sV2SqRB1dT+CDMJY5jhDZHJo36kld1DYgQXrwTPZA2xEsXL
         ZK5vSmvdltg2Q==
From:   Mark Brown <broonie@kernel.org>
To:     vkoul@kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        perex@perex.cz, lgirdwood@gmail.com, dan.carpenter@oracle.com,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20220310030041.1556323-1-jiasheng@iscas.ac.cn>
References: <20220310030041.1556323-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: soc-compress: Change the check for codec_dai
Message-Id: <164724806003.972788.200710356447512162.b4-ty@kernel.org>
Date:   Mon, 14 Mar 2022 08:54:20 +0000
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

On Thu, 10 Mar 2022 11:00:41 +0800, Jiasheng Jiang wrote:
> It should be better to reverse the check on codec_dai
> and returned early in order to be easier to understand.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-compress: Change the check for codec_dai
      commit: ccb4214f7f2a8b75acf493f31128e464ee1a3536

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
