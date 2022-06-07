Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2153FBE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiFGKrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbiFGKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A951F1351;
        Tue,  7 Jun 2022 03:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91540B81F06;
        Tue,  7 Jun 2022 10:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4F9C385A5;
        Tue,  7 Jun 2022 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598783;
        bh=9+pUEn/bG4fcSHXKfmjMEcgyn72cKoDXq1ZmWQ/qRH8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kex5OYMLDyO2+xhikta2ZmdqKF7VR7MASVYbYxiEvAYLOZlqAI+moQ+gH8k9rRbvx
         Ww9rDiQYQaZDjkruroSeg/paozDYytCbLOirvesWH75amyelz0s5aFJkwKowQUkwOZ
         eGRivwx9tttRSZR8/yIYXcryZOrq6lfqySn9kZLdXX3Y/J3QGAJgKAInECVSgVjuxS
         19mN2BzJtAjLbB127+lhVoJgdZ1MlVIl9Sd03olb5NoImS5O1Pvce/zADKIes0KYFV
         Jj2JHbFoXInLzS5sVVogUl2TyO1pCUOx+ML6dMjF8nYeWBKforx488UCE7zNA6Io7l
         fojxb6C/ICyag==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        tglx@linutronix.de, christophe.jaillet@wanadoo.fr,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <28c0833d4a11f8f75f385e5aad93c23721b06c7e.1653724847.git.christophe.jaillet@wanadoo.fr>
References: <28c0833d4a11f8f75f385e5aad93c23721b06c7e.1653724847.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: ab8500: Remove some leftover from the "Replace GPLv2 boilerplate/reference with SPDX" rules
Message-Id: <165459878149.301808.7387374939170024578.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 May 2022 10:00:53 +0200, Christophe JAILLET wrote:
> The "Replace GPLv2 boilerplate/reference with SPDX" has left some empty
> "License terms" paragraphs.
> Remove them as well.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ab8500: Remove some leftover from the "Replace GPLv2 boilerplate/reference with SPDX" rules
      commit: b521e85eefa384a5c31984b1a7e0d71b762c9663

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
