Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD74DB977
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358023AbiCPUhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358032AbiCPUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F46E4C0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8286561423
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B9C340E9;
        Wed, 16 Mar 2022 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462958;
        bh=AG1wtDx7BWSkmwerI9/9JsW5Jg7gueu8xBwV1c9teE0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=QJX+NWofTH7Ok9sdiFlR8DEYOvBVyM+xeaC/RQfoT8TfaB6Mv3zb3qDz3wDAIeHKL
         obgPL9L6k598FlLUzEfdbY69Fakin3pC11JZrfnY1m9Hh06Sdi/oDmid/W2gTQ1pom
         8NltZFnAnDE0Ijo0Og7zcX/cwDWqgQj42QwhZacmKH1BCVNTVzbMGSHZj+kmzNXZEe
         NcOaSOAXcLYOyJ4SpCIKrwOaiHcUdiXUBaOZMdh4kP3CDs5h309NQ+7t+16+JYfUCS
         AlElBsQdO+nczG01jxfm5IRb/U+xv0Ehgl/Uqvk/nippeGLh0vLd+kYmahV8J76z/v
         5qNfYmk2iuoSA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Miaoqian Lin <linmq006@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220316083631.14103-1-linmq006@gmail.com>
References: <20220316083631.14103-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: codecs: wcd934x: Add missing of_node_put() in wcd934x_codec_parse_data
Message-Id: <164746295687.1220201.2304000170447062243.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:35:56 +0000
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

On Wed, 16 Mar 2022 08:36:31 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> This is similar to commit 64b92de9603f
> ("ASoC: wcd9335: fix a leaked reference by adding missing of_node_put")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd934x: Add missing of_node_put() in wcd934x_codec_parse_data
      commit: 9531a631379169d57756b2411178c6238655df88

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
