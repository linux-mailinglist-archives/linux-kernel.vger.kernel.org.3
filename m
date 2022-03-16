Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A874DB972
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357969AbiCPUhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357959AbiCPUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A14768FAB;
        Wed, 16 Mar 2022 13:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6836141B;
        Wed, 16 Mar 2022 20:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E25DC340EC;
        Wed, 16 Mar 2022 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462951;
        bh=tXKQPeY8zGH086upulVCq8kvmhNYSUEo8dfrTojYtdU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H4x0a0iaDkGpX6y3/Ss2M5CeT3Uh4WRBoZlZ7u/NkjU5vEUaq2yw0FkyDV/JfIIHf
         hDRlXiQVuZT7msJs8ZiHvXphh6AS0I5ahfrZFcO46X2i8F6dq2lhr1+/sJTrujbscE
         xwx3SX1frbyKNKsbVHjBerViTQzcxeEJXKlAtw1K+o0qNZ7ygKwc9aNc8WpQB9hdVZ
         PB2Au6/80c8iC7MFLjnmyye+DP9tjRWYpGhkVtREumlZVnNQrRxZ+55Jlg+EMz0O+5
         hkVBpjktK7kBiP5NX0LHZzJC/sGEyghYjRPePVV76xVcwgBRJbKw4QNVPu0hRNDzJN
         CNQAiS94J6WHg==
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Takashi Iwai <tiwai@suse.com>, linux-omap@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220315230816.2964577-1-colin.i.king@gmail.com>
References: <20220315230816.2964577-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: ti: Fix spelling mistake "cant" -> "can't"
Message-Id: <164746294890.1220201.4043765909932401819.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:35:48 +0000
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

On Tue, 15 Mar 2022 23:08:16 +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: Fix spelling mistake "cant" -> "can't"
      commit: e8ca4cee43fa9d841d25c2b98c9c3a3390593094

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
