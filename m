Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4444F4C7D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiB1WYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiB1WYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:24:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBAEA747
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E46C360B8E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B637BC340EE;
        Mon, 28 Feb 2022 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646087034;
        bh=kmmO+RzqRGfoiBuIIpliqpBCDbphzDc2IaMtK0kWQck=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bi3YjKzx+OWycH2I+7UzWSMgXJIQNyAdTLV1/+Jp8YfJLfGON6ffAlpIzMwoq/4fs
         V41+A/NfE8U35LEGEgfIE6w+4qjysElj3nfOJZc6xPYUe4zDOCGgNeq5LpKZyJJdSX
         XqJa0uIVWdOBFXij7bAwEUmkxJThQqcP7G/vhBb/V9XXvw3CaAbwOamoVCBKdfL+kF
         iioHbxfqe7ZhTpfZaR2Vc0N7nkVh1gPiVTgJXwcKV31w/intcyG+4ziQa+Hq/o/UHW
         MmfV/tXTHFBJu571PKT0O2iF7EAPE845Zoa/tceIxCb/k4uk0GhsiVq0lbk9tPaFZP
         FB838omNDlorg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        quic_srivasam@quicinc.com, lgirdwood@gmail.com
In-Reply-To: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
References: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3] ASoC: codecs: wsa881x: add runtime pm support
Message-Id: <164608703245.3143764.4501147946855964018.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 22:23:52 +0000
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

On Fri, 25 Feb 2022 18:07:16 +0000, Srinivas Kandagatla wrote:
> WSA SoundWire Controller does not support Clock stop and performs a soft reset
> on suspend  resume path. Its recommended that WSA881x codecs connected to this
> are also reset using a hard reset during suspend resume.
> 
> So this codec driver performs a hard reset during suspend resume cycle.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa881x: add runtime pm support
      commit: 8dd55245836119ee3636543b6c2597efd78e643d

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
