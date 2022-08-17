Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41AA596F92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiHQNKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiHQNJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:09:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485BC357D2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6306BCE1D0D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC5C433D6;
        Wed, 17 Aug 2022 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741749;
        bh=6mxl0UlXmn/Urxz4PY2fsLTMgZGiOV0yNNacP8ll6rA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eEkK9YlRU159rfalKUjWT9uAgaP2fS3t+iLB/jh6gJbe40M8m/w6WQD4zyQM8MAiD
         rLJlzCGWRtKOQKn/7Idm8zKe+n49jCIQELpUtWiK2otLeU/xiVcDSIru8nN1JzU+T1
         waKJAXDRS4EdaC2JarCoaj5jCdcmPl+BACQ2yMzldukrXFeIt9CKq+b7M8zPoD97U8
         vYY0Y2JH1cSrcMyFSn2OwZtkM7i1N1iTwWPQuFgW9TSq/Yx8gSH6y2CMSWW2hc+4c4
         uRGL7wvr7RXXuJ22TJ2T+/xV9e26FLQxp4TEQo4wHiSXI+hqPrHvGNV3OTZw+06XkM
         qJhujyFkqX83w==
From:   Mark Brown <broonie@kernel.org>
To:     Xin Gao <gaoxin@cdjrlc.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220816175105.8084-1-gaoxin@cdjrlc.com>
References: <20220816175105.8084-1-gaoxin@cdjrlc.com>
Subject: Re: [PATCH] ASoC: Variable type completion
Message-Id: <166074174811.88107.17955474893626943229.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 14:09:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 01:51:05 +0800, Xin Gao wrote:
> 'unsigned int' is better than 'unsigned'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Variable type completion
      commit: 1b5efeabf75a74043f1eb509ca3ac183b3ffaf89

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
