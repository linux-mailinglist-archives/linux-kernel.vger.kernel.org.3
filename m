Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7F55D0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiF0UTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiF0UTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:19:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D142F1EAD8;
        Mon, 27 Jun 2022 13:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A69EB81B1B;
        Mon, 27 Jun 2022 20:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B42C3411D;
        Mon, 27 Jun 2022 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361148;
        bh=C2qjYmuV60Qu5KvUhBVP6x+pgLCW3knDlTonYpWpK/w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XZ/rc208PUx8G6v/nKveA/8TDJ6aUaLxeJ8dASXThTOfmjAN7OEwDh8AmtvPeL97P
         5qp68vNt2wDPCbEkBjE9h4SWBZC3PI8oGP9sLn60PvTKY1IepPJl2xQiRZe3xLnfDf
         nSYjKA5qZGXQ85zu2X1gr/BHdHhIyAVq0PnBG0qMPCg1wUMb3MHYjjnpxY/9P3sbEW
         pyWT3PVy1nbhqAMcfH1u+bPywqguFOjD/KytFJxZwmZMt4g4nz58O44zY+Hv1oDG5o
         Ss8QCmtJQapvR83PQkhTWUMMJ0ZiDn8jIWYORGeU66mK0cZcRkJ7WlnwevvBwORgnk
         t2EGcjGNBNukQ==
From:   Mark Brown <broonie@kernel.org>
To:     jarkko.nikula@bitmer.com, tiwai@suse.com, perex@perex.cz,
        daowens01@gmail.com, peter.ujfalusi@gmail.com, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, dowens@precisionplanting.com,
        linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220616202645.1645972-1-dowens@precisionplanting.com>
References: <20220616202645.1645972-1-dowens@precisionplanting.com>
Subject: Re: [PATCH v3] ASoC: ti: omap-mcbsp: duplicate sysfs error
Message-Id: <165636114606.3997797.14770643051127333961.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:19:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 15:26:45 -0500, David Owens wrote:
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requested
> probe deferral:
> 
> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: omap-mcbsp: duplicate sysfs error
      commit: 6d31e225742a1955db8a0c6f6f52beb748a2895e

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
