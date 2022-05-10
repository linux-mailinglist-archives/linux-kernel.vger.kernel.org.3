Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09C521628
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbiEJNEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiEJNEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:04:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF98465C3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E851B81C63
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DF0C385A6;
        Tue, 10 May 2022 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652187641;
        bh=4aegVx1bOMbLneDfROhebeBKe1d5jbRdV2Z+Zar+nNI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ryn/8gTlGyzSBiHX7d023CICVL2MkYdLHKt+8cgyidnnTBre2caYVMd63vhG+q7Ud
         /SOTwoXmTsoZg4F2buLSYAnsz1jlrYlPkDMkDhGpB8Qhna418/PtS7aytkpKBRSOAQ
         KOm2VXzevc5NKSYfhgIoerpoCzx26nRY4mEMv+1eB83r6NHD0B+fsI28xBdjoe9huC
         oYZWctMEVmTJrhaGaBz3eweuSbhi0ZRnogujPN4nCeYrSrsfYaaxfo5XBCA+msdDiI
         E3MWMP51H6fcIq4sNBFdI04S16Ac55g+ctjcQ8GKUcvd/9kVpjRg0bc4o4W5LsbBHV
         JOsedRqsWuISA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, zheyuma97@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220509085925.1548328-1-zheyuma97@gmail.com>
References: <20220509085925.1548328-1-zheyuma97@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Register a callback to disable the regulator_disable
Message-Id: <165218763970.65921.14217933077833683707.b4-ty@kernel.org>
Date:   Tue, 10 May 2022 14:00:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 16:59:25 +0800, Zheyu Ma wrote:
> The driver should register a callback that will deal with the disabling
> when it fails to probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Register a callback to disable the regulator_disable
      commit: e1c9f68aa23a8bf98e956e92e61293ef51bd6282

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
