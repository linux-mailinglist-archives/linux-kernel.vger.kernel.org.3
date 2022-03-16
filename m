Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137484DB97E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358052AbiCPUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358028AbiCPUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EEF6E4CA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58544B81D46
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D87C340E9;
        Wed, 16 Mar 2022 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462964;
        bh=77CmR3PRSwOpZa9z7OgyvODafo7b24EZUQZHs/ST0ng=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UTtcv3eY8E4C0fvZnR+ahydqPhx746oNIIajfmRyjKxWB6o1ntmXUEEnW5lQascjJ
         M/zUbqvteX9kodh6f08YNHCKyEqdmMTXszuE+b0ktl3EqDYuMtJQG1IcT66+fngLso
         rCfiI6QqkOMQqD0GZlgEtSt7BJ39QK5oWLaHUnaMpFBlztAapmY9mU92wfpdXWy30l
         bD6gf2Cvr1ejg9Iu+yYq8zJEpokFiA8rBefU32SZU7YKmo/vsOjRPmI3v72R9WmsJC
         D6eReQ1PaYAOfejFDR6yaN1gQNainZrXMnJp2b7NcPs33k2BRgqYW1d125pD0C6ORN
         cxYM+6w3RTDjQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, Vijendar.Mukunda@amd.com,
        lgirdwood@gmail.com, Meng Tang <tangmeng@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220316091303.9745-1-tangmeng@uniontech.com>
References: <20220316091303.9745-1-tangmeng@uniontech.com>
Subject: Re: [PATCH] ASoC: amd: Fix reference to PCM buffer address
Message-Id: <164746296229.1220201.5798586348184991333.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:36:02 +0000
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

On Wed, 16 Mar 2022 17:13:03 +0800, Meng Tang wrote:
> PCM buffers might be allocated dynamically when the buffer
> preallocation failed or a larger buffer is requested, and it's not
> guaranteed that substream->dma_buffer points to the actually used
> buffer.  The driver needs to refer to substream->runtime->dma_addr
> instead for the buffer address.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Fix reference to PCM buffer address
      commit: 54e1bf9f6177a3ffbd920474f4481a25361163aa

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
