Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933975810D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiGZKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbiGZKK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:10:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731221AD9F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B60B81269
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C61C341C0;
        Tue, 26 Jul 2022 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658830255;
        bh=ogVKEyH2n6wMwdJQk64NIQ0QlsvgWIhFyxyWcaMBLaM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=uPMPk00K6JphqqEuwMR2fgOgr8BEkA20bhMx47J1UOOpD9XX7yhNXbWnds8MaBOAS
         Bt7wUHkQwZL+/f+NTxv3BPQa1naZ3n1+zPOEeLL6QGnM6pNd1X/6CSPrzk0u/j2P8i
         EsXASVsHHzQZCbltIe9vG9MfBlO2De0ItFwM2e7O1/IQsNCM8/Ae+IDcqNCHomBDbx
         VFGpleNa7lKhfc5q3L/uHBusc4kR89fSf7/5W3xHKWHGmVfzxVCDjdylNW676/YCR0
         1EHHuEvq+fof6pwWnyqPhr8bjH3IrFgQr5vVoDK5rHu0Df7hnnxHDR/TwMifxqBNnF
         IuYyOjipJ34mw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        steve@sk2.org, alsa-devel@alsa-project.org, perex@perex.cz,
        ryans.lee@analog.com, Ryan Lee <ryan.lee.analog@gmail.com>
In-Reply-To: <20220723015220.4169-1-ryans.lee@analog.com>
References: <20220723015220.4169-1-ryans.lee@analog.com>
Subject: Re: [PATCH] ASoC: max98373: Removing 0x203E from the volatile reg
Message-Id: <165883025392.54936.4365512627715267394.b4-ty@kernel.org>
Date:   Tue, 26 Jul 2022 11:10:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 18:52:20 -0700, Ryan Lee wrote:
> The 0x203E speaker gain register should be non-volatile.
> This register value was not able to be synced because it was marked as
> volatile.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98373: Removing 0x203E from the volatile reg
      commit: bd1963d837a082e1083cd396803d3d263a9ef68b

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
