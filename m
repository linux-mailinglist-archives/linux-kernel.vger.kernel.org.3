Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C165124EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiD0WGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiD0WGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:06:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93757CB34;
        Wed, 27 Apr 2022 15:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 813E8B82B0C;
        Wed, 27 Apr 2022 22:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BB7C385AE;
        Wed, 27 Apr 2022 22:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651096969;
        bh=779XAAml1P7LYYjmSE8qDzdFvoLhDHfypjKmhQlkb18=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nvj3vMOyHdOu/t8NlZgWt1JFNpHE3hwPq1nCzT3c4ctQNsJzomK2FAkGdWqOQGjfr
         ITdn56I/7ckabcgWlh6/2VpyhGLkkhFu/jcf+JiIb0NIgrQjkdDDyVJarEfZ42cdFG
         bCxA7sdHb2uYmPKkQhJQE2+hF+FA0af3acLY4rY4kbUk7UALAkK+vqLM8G+r48t7DN
         5luglzoKJ7gpX1jn3hWZzvhCn6DSgj7P1hJzKKK4f+8notzGtSIsHsY3jwAh5d7Eg/
         XPXPRf6a6H9oEkiDCADuP+ghyVcez75cPtmNRdfBCy/cxpY7VsDOwXfs61fMrNkiBA
         z78srTySqhZMg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz,
        prabhakar.mahadev-lad.rj@bp.renesas.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     biju.das.jz@bp.renesas.com, prabhakar.csengg@gmail.com,
        pavel@denx.de, nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be
In-Reply-To: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 0/3] ASoC: sh: rz-ssi: Trivial fixes
Message-Id: <165109696658.498174.4698247588451201645.b4-ty@kernel.org>
Date:   Wed, 27 Apr 2022 23:02:46 +0100
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

On Tue, 26 Apr 2022 08:49:19 +0100, Lad Prabhakar wrote:
> This patch series aims to fix trivial issues found in rz-ssi driver.
> 
> Cheers,
> Prabhakar
> 
> v1->v2:
> * Updated patch description for patch 1/3
> * Patch 2/3 unchanged
> * For patch 3/3 dropped devers action and instead called
>   rz_ssi_release_dma_channels() in the error path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: sh: rz-ssi: Drop SSIFSR_TDC and SSIFSR_RDC macros
      commit: 17a1fef58c65ec9c9a15dd60386712567ff28d45
[2/3] ASoC: sh: rz-ssi: Propagate error codes returned from platform_get_irq_byname()
      commit: 91686a3984f34df0ab844cdbaa7e4d9621129f5d
[3/3] ASoC: sh: rz-ssi: Release the DMA channels in rz_ssi_probe() error path
      commit: 767e6f26204d3f5406630e86b720d01818b8616d

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
