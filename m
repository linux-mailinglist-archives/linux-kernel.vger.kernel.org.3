Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72B55CCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbiF0UTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiF0UTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7741EAF5;
        Mon, 27 Jun 2022 13:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45D9F61749;
        Mon, 27 Jun 2022 20:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17C7C34115;
        Mon, 27 Jun 2022 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361150;
        bh=yXcCDa02Pb/sLH1ELYF8BJG91/X5CPQ+JW86ylnakJQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iXqf5ccLqMwaFW61gUboVSI30DUgWqxa/h12Sm8iyH4BK5cr/cCx0+2tJ8BDZ7bLf
         zETrLvBSbjbgIUGN6bN+x5vh4cGNTsEYly/eBkhF+Qb16aBCPxx38Wo+swxRbLQ1ky
         b5qJNG6DkBCrY+k4UeCV+u26trxtRoD0KTJJnqEH4rfON9P+uSzosduQFUSCKG7Ebz
         9C78TDqe/pjix1/kjgnKAuKuyXSEdAPjLR4K0lZMbxCpFT6biSE6qfahi44qiaVXI7
         CtwWfGnWOvfb86Hzs4FkyBXYmjN6xLPq20Kv7M+i3kLN1NjO9NOhUYCIBSnTY8KhS3
         IMMPr+9KN3H8Q==
From:   Mark Brown <broonie@kernel.org>
To:     jarkko.nikula@bitmer.com, tiwai@suse.com, perex@perex.cz,
        daowens01@gmail.com, peter.ujfalusi@gmail.com, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, dowens@precisionplanting.com,
        linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220620183744.3176557-1-dowens@precisionplanting.com>
References: <20220620183744.3176557-1-dowens@precisionplanting.com>
Subject: Re: [PATCH v4] ASoC: ti: omap-mcbsp: duplicate sysfs error
Message-Id: <165636114844.3997797.17880127627282990674.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:19:08 +0100
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

On Mon, 20 Jun 2022 13:37:43 -0500, David Owens wrote:
> From: David Owens <daowens01@gmail.com>
> 
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requsted
> probe deferral:
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
