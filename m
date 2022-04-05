Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12474F41A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbiDEPRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346731AbiDEJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073A6DB496
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 987E0B81B14
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C060FC385A0;
        Tue,  5 Apr 2022 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151094;
        bh=uenQ5PTJTk45mI+LcbrDbJhSKL0UrjCnt82W9zY+s0I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CF7a3xLAF/P87ypUF0Qng9SPB+YI0nG0+F1zbYVUhGjH9ey+WsqUhUCZYp4M2/Seh
         v0HRD4ZUjlDgqGbSJK1lZcCkfqLFX0xyQQuFfNNnRtHO1EsNvLhLoif/j5B+0qXZkn
         nsAggl7EESWkqAmr0h1B54qZeBYXTVCxdrfyCgCmv+QsOboWkRiuuC6INLeHES710C
         zc+Qms5U2WuykD2XD5M1m6FgthS8uIeAWSqme3JJS5w6jkuCwmTwhi+jmVmF1AT/8c
         9LX6dRtB3BVD3Ds/Y7ArU5PMZRaX6kMvb2xxBMYtFh1eCbuwiCTUKpFP66Ha91o472
         nKLHvWPYzlRNQ==
From:   Mark Brown <broonie@kernel.org>
To:     krzk@kernel.org, rikard.falkeborn@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>, s.nawrocki@samsung.com
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        mani@kernel.org
In-Reply-To: <20220330204227.25081-1-rikard.falkeborn@gmail.com>
References: <20220330204227.25081-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Constify snd_soc_dapm_{route,widget} structs
Message-Id: <164915109148.276574.7227991139286446163.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:31 +0100
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

On Wed, 30 Mar 2022 22:42:27 +0200, Rikard Falkeborn wrote:
> These structs only have their address assigned to the
> dapm_{routes,widget} fields in the snd_soc_card struct,
> both which are pointers to const data. Make them const to
> allow the compiler to put them in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: Constify snd_soc_dapm_{route,widget} structs
      commit: 5449fd7bd01fc13266979a6ab48493d4d2e43725

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
