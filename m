Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5559332C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiHOQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiHOQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:25:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D84727149;
        Mon, 15 Aug 2022 09:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9334CB80FEC;
        Mon, 15 Aug 2022 16:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD97C433D7;
        Mon, 15 Aug 2022 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660580588;
        bh=sVw0jX2MDbbtxdw3C7N48E1ZHL6zGdjBiKamZBFLaoA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o9tAnFaExPSXTyRBiAxWXv+fgfGnQRgJIs4/Y+AT47nw+QMibM9bsfkUSr23qz7i4
         EpJrNbvhV+sEZdnS3yWNFXDbMYWW5VKphYVIe3Lp2M1dCX98SnW1J5cCnfFFlcG8LU
         i3Xtnei8VmL0yF9og2KubxN4tgPXY/NwBdQfEZjk3KZ0ALnB+5xhR0XYSP+XKCVqSq
         j6dqLl2SJG30+ImCqHWIevyheqhSqcv9wyQhzLHklDiX6pYPRbvF6098NlVHSvfpHe
         Fi0ppRp3S/Ww2eK+pJTNICA1MQvUX47gyNi4vrn5RhySJ2Evu5aOpmhEPuJWyKlSnF
         RPgTvzlN5cz5A==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <63efe8fe4e25a8ac386762d2d7cfe9bb9482333f.1659814389.git.christophe.jaillet@wanadoo.fr>
References: <63efe8fe4e25a8ac386762d2d7cfe9bb9482333f.1659814389.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix a typo in a comment
Message-Id: <166058058662.769843.9592183911230477031.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 17:23:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Aug 2022 21:33:22 +0200, Christophe JAILLET wrote:
> s/TLV320ADCX104/TLV320ADCX140/
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix a typo in a comment
      commit: 98c17a01bc5965047890bd30c95966007234e6d1

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
