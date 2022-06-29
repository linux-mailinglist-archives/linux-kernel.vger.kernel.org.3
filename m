Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD05601ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiF2OGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiF2OGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9145C29830
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB2761E8E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D25C341C8;
        Wed, 29 Jun 2022 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511554;
        bh=UXDs+9EDFfkEqRLNHkEcBDaysFo8turPy2dmuBxmfJ4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=f+tSxA9fD18Ch8FstmtZaJmIY64RcpJ1qwT8gvuEvfD9XOQlOEEGGRY27sIUxA0B/
         y3KojJCRSOzB0gfpVG/CJik0zla6JTYj8hcMPW0BstI3Q+LLttSt7zno5q5M7ysXqw
         6Y/GVEQPFeFjr9sSj708R7U26awNgFs8eIzcerhnds5Pj/+8irzxEj1WNLVc7gpgMo
         tw8zn45LNdLIAJixJ6nkppLw84sfSlp6E0v6N4RaqQ/qOyQ745tA211doMFzNF1w3F
         jsnFzIH2YrDYRlUad5jqq51N/1uE9RfnH94XcZXCf4r9FIAA9eJ6ALt7Ipm1AS3j9S
         D6RBELTngJLyA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, alsa-devel@alsa-project.org,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        shengjiu.wang@nxp.com, Xiubo.Lee@gmail.com,
        linuxppc-dev@lists.ozlabs.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        nicoleotsuka@gmail.com
In-Reply-To: <1656405589-29850-1-git-send-email-shengjiu.wang@nxp.com>
References: <1656405589-29850-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: change micfil default settings
Message-Id: <165651155180.1437597.12670748028235515625.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:05:51 +0100
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

On Tue, 28 Jun 2022 16:39:49 +0800, Shengjiu Wang wrote:
> Previous default settings resulted in loose dynamic
> range and low sound level.
> New default configuration changes:
> - outgain = 2
> - quality mode = VLOW0
> - dc remover = bypass
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: change micfil default settings
      commit: 3b13b1437dcce4469db575c60d1da4fa9ff80694

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
