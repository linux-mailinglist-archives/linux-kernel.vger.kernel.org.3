Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434250E70C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiDYR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiDYR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04340E71
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E8D61501
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1491EC385A7;
        Mon, 25 Apr 2022 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907449;
        bh=igC0ln6z4ICo6ruvrsN2YbYFK79LIxKWX9Rvb44n6u8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KViDhhEVNj1ZMJuVPkbgL6JTA7Y1qc5POj9NALGnayCO0s7fKQL4glnXOovcs0KN0
         0Hj/GramaJewFU0IOqKsIhkXU1sMHpe9LW55Qe5R4+VxAosw2uU0lH+2FK9g7AZ3v+
         etbUTLjcbaH0rwO+lYpt9X0kmYNx1qpGyhEU1yDB2NMSd3AfMYBOQbeoEcy2PAJX+W
         Tr27uWkBvrKxGtU48QU9+11jRGcqzZa8GecRNdJBFMNVVgtjl/7RmyGlHnCs9UZsfr
         YoDsuWHkXGwiCsemLxpjIQ7vcdqLt854THYdm0xpIAJ2ErE8Z2BcbFnkRYenfcigP3
         glA8kuQIjNDjg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     alsa-devel@alsa-project.org, chi.minghao@zte.com.cn,
        zealci@zte.com.cn, linux-kernel@vger.kernel.org
In-Reply-To: <20220414085310.2541546-1-chi.minghao@zte.com.cn>
References: <20220414085310.2541546-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: img-i2s-in: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090744779.583823.15729249408440513217.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:07 +0100
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

On Thu, 14 Apr 2022 08:53:10 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-i2s-in: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: e5737cceeee5c085f6f4ea76ae99e67e4ca1bdd5

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
