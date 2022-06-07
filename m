Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE84653FBC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiFGKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbiFGKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84833ED72C;
        Tue,  7 Jun 2022 03:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 397A1B81F02;
        Tue,  7 Jun 2022 10:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAA3C385A5;
        Tue,  7 Jun 2022 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598725;
        bh=MpaIdGbaKAMBLJfa7jevH3NryJ/FF1rB5km3FqsCypk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aWZvLnCXNcZk7SwWw2ChEM3DWON75dXOgbPugmTAyNwp7ROOhIZxRO2RQSkV2Kqb4
         uRFokkW1iMplAJjN2TojScugvWjd7nvDluhm+KdNPXmrhB94/P3yFuleLxa3P3ox9K
         rHLJsD7VPK4xP2E22Y5Jekg1UCqMLSlrcDlJPHAAEQDAYAQJHlQdzAtoBs77T46SKG
         7YyWkdty4tRz8t85Jod/xSwFQc04CE5lvdUJ18J+SZo9jhLbb9JV0w8fiB5/Im28pX
         xuPdtLcr9Rs0XIrpiMUVtcvFHEGGKtkP4xT1IRvpbfd9O9vzycEXIZyYnx8u2F15hI
         zkGHTj5Zs0Nmg==
From:   Mark Brown <broonie@kernel.org>
To:     Julia.Lawall@inria.fr, Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org
In-Reply-To: <20220521111145.81697-79-Julia.Lawall@inria.fr>
References: <20220521111145.81697-79-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] ASoC: amd: acp: fix typo in comment
Message-Id: <165459872329.301808.12651579852525968637.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:23 +0100
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

On Sat, 21 May 2022 13:11:29 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: fix typo in comment
      commit: b661a848a50c0cc3e0b79795c74469d7b50ff4ac

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
