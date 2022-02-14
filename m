Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEE4B53CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355425AbiBNO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:56:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355426AbiBNO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:56:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3363F488BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3237611C5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48C8C340E9;
        Mon, 14 Feb 2022 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644850558;
        bh=ClzPXiHGSV1D78vo35GeeCpuxD0sHuhefm+2UeDa9fk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=goysGbYO/E6BNSGxe3aWMtmFrEx9FaRj053wc7JSgtgi55QmQGG6ioP4E58NK2A7V
         lZS9b/Jrjl6g+VSzzoGGAB9haXAh21AY5oEb0miEynxOwsupy5juGJbcrx3XZlp+5S
         JugTZDouzwjRs/Mv/zRAPLQ9uNV/t5ZRyZlyoU4L2sruQ74sSwQ89VlLS5CwTVXvKA
         cuoAe/fI+3DkOaC2LyWC2UxGyKrmu52ii1AXwL1xbuEjbAqZ7G9ohKS8S05kX13rWQ
         VaaGKsizr5evLX29H6X9PiA28jHP6FI2Y1gmirz2OzU/8b3LnBkIKJmioL4h5xz5Kg
         fPzYiYPyT1fjA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
References: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 0/4] ASoC: pcm3168a: code cleanup
Message-Id: <164485055645.397940.4337733738992515921.b4-ty@kernel.org>
Date:   Mon, 14 Feb 2022 14:55:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 11:42:16 +0300, Nikita Yushchenko wrote:
> These patches clean up pcm3168a driver, without introducing any
> functional change.
> 
> Nikita Yushchenko (4):
>   ASoC: pcm3168a: cleanup unintuitive mask usage
>   ASoC: pcm3168a: refactor hw_params routine
>   ASoC: pcm3168a: refactor format handling
>   ASoC: pcm3168a: remove numeric PCM3168A_NUM_SUPPLIES
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: pcm3168a: cleanup unintuitive mask usage
      commit: 0c483a07e92638aca1f7d42a4986e32c58d29ad2
[2/4] ASoC: pcm3168a: refactor hw_params routine
      commit: c7270209fc6fc377ba5813e8d5b2ce2b26352ee7
[3/4] ASoC: pcm3168a: refactor format handling
      commit: 6bfc1242ee995f23f8c167bf1308a43b86560fce
[4/4] ASoC: pcm3168a: remove numeric PCM3168A_NUM_SUPPLIES
      commit: 3e63d3c1a2e52fb60d66bb23cb62c92c92ad0a3f

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
