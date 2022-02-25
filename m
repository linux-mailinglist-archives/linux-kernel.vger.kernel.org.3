Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8B4C4C79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiBYRgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbiBYRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5D20DB3B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90BB261DD1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A167C340F3;
        Fri, 25 Feb 2022 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810557;
        bh=qVI0tY3mXIJAD7LbgficgjWoICY03B7IiXWloXU6Ens=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mU1kqIleufy7p1Q4BlouNh3VhI+wmYA+pAaGe5c4z/BuCepa4JrKL8xdGHsJKa5h4
         ACH9h0hB04CyTCbuFgbNXYkF4dn6pJjO8RjkV1EtBsKo+cbwpfG5wC3WiaVxbpLyvw
         vtSnnEQuAu5EKecWIP6AuBS2I45LSXxaieAg+0dPIu95beX6dF6ehjpJ3ggBvrgg5a
         nkGvixkgXGhxanZahY4E9jveqjk8zSVHE2vrNuHoXVDURRQXzPh4DD7bEdHoK3kVWy
         zwYsRKoBtoYG9+fihWZRQezOOfwTerS56L23Nz3C2ulPOuSdpqhy2M4KKc6qhWR6TL
         F3kcHDLRS7S5A==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        quic_srivasam@quicinc.com, alsa-devel@alsa-project.org
In-Reply-To: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
References: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
Subject: Re: (subset) [PATCH v2 00/16] ASoC: codecs: add pm runtime support for Qualcomm codecs
Message-Id: <164581055516.2548431.8597662663166708968.b4-ty@kernel.org>
Date:   Fri, 25 Feb 2022 17:35:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 11:17:02 +0000, Srinivas Kandagatla wrote:
> This patchset adds support for runtime pm on tx/rx/wsa/wcd lpass macro, wsa881x
> and wcd938x codecs that are wired up on SoundWire bus.
> During pm testing it was also found that soundwire clks enabled by lpass macros
> are not enabling all the required clocks correctly, so last 3 patches corrects them.
> 
> Tested this on SM8250 MTP along SoundWire In band Headset Button wakeup interrupts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/16] ASoC: codecs: va-macro: move to individual clks from bulk
        commit: bed17757521b8beee2b565ce7860808a6a6e37ed
[02/16] ASoC: codecs: rx-macro: move clk provider to managed variants
        commit: 70a5e96bad592145ba25365689a2d7d8dedb3bd9
[03/16] ASoC: codecs: tx-macro: move clk provider to managed variants
        commit: db8665a3e904f579840417f9414415c4dd54ac84
[04/16] ASoC: codecs: rx-macro: move to individual clks from bulk
        commit: 43b647d9940454263421f9a1c756680bdf1d443c
[05/16] ASoC: codecs: tx-macro: move to individual clks from bulk
        commit: 512864c4ffa70522b9c44d5b40c15273330ae9c7
[06/16] ASoC: codecs: wsa-macro: move to individual clks from bulk
        commit: e252801deb253581892ca6beba625d553d63d538
[07/16] ASoC: codecs: wsa-macro: setup soundwire clks correctly
        commit: 05a41340e56f716ef9f83006990f6eea153c5fe0
[08/16] ASoC: codecs: tx-macro: setup soundwire clks correctly
        commit: 31bd0db84c6010cd6cf38048570b51aaae26d91d
[09/16] ASoC: codecs: rx-macro: setup soundwire clks correctly
        commit: eaba113430d6c5e2c74fc8061fbd86efc000e99c
[10/16] ASoC: codecs: va-macro: add runtime pm support
        commit: 72ad25eabda0ac2b13ab8f418dc5d360aded172c
[11/16] ASoC: codecs: wsa-macro: add runtime pm support
        commit: c96baa2949b245da7e0d0e9e2a44cd4471c9f303
[12/16] ASoC: codecs: rx-macro: add runtime pm support
        commit: 366ff79ed5392ac518fd43cb44f82f63b87c313e
[13/16] ASoC: codecs: tx-macro: add runtime pm support
        commit: 1fb83bc5cf640c821910424cd237e2df1e81be6f
[15/16] ASoC: codecs: wcd938x: add simple clk stop support
        commit: 584a6301e1d548b2875a47b44f6aecb70a80ee53
[16/16] ASoC: codecs: wcd-mbhc: add runtime pm support
        commit: cc4d891f1876242400ef21d95ab9e9553e9d10b0

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
