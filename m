Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7BB50A706
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390744AbiDUR1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390580AbiDUR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:27:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE03EAD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9799AB8287D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D343C385A9;
        Thu, 21 Apr 2022 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650561894;
        bh=Hm+I89eVrNyoJRbqZk91HLSchEvg3AO8RSEtWGOLKoo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Dfp6quhOYeuRtwn65OAUcbicpbFm9dCk/TRcoYo3F2AnU2dZ2xMcu/vrHPR1FxTlJ
         rtsb+fxjit/c3C5VK/dqYk2/pjhX65t/mS55HIwkK1u5a+0+lx6WK7Yv0JBvvNBM4+
         c7mh25GPsHFghTYwivjBKjq4+ab/sge/cR2osOb2Mo8q6GvwFdm6s8vkrYzoKznHw3
         zXM8li55buc9pBP9m/7f3M/GxdwfMUZf1nJr4iTVctng5j2MM9JXZILo1AxCUyYIl/
         PHEgPldmTCzr6duwXjf0g2EubiHqh+z8sShkX3M/W8Hga4oYgE7QC+INs+rdaFYW2p
         iHYWjRFV2zPRA==
From:   Mark Brown <broonie@kernel.org>
To:     steve.lee.analog@gmail.com, lgirdwood@gmail.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        perex@perex.cz
Cc:     krzk@kernel.org, ryans.lee@analog.com, nuno.sa@analog.com
In-Reply-To: <20220420044900.2989-1-steve.lee.analog@gmail.com>
References: <20220420044900.2989-1-steve.lee.analog@gmail.com>
Subject: Re: [V4 1/2] ASoC: max98390: Add reset gpio control
Message-Id: <165056189236.376935.16493956574599176087.b4-ty@kernel.org>
Date:   Thu, 21 Apr 2022 18:24:52 +0100
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

On Wed, 20 Apr 2022 13:48:59 +0900, Steve Lee wrote:
>  Add reset gpio control to support RESET PIN connected to gpio.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98390: Add reset gpio control
      commit: 397ff024960634962af93e9e2775fc0e4fe7de92
[2/2] ASoC: dt-bindings: max98390: add reset gpio bindings
      commit: 68514c9f6aa676f98328844336fc4400244a8479

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
