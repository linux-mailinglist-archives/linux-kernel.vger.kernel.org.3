Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE93C572191
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiGLRJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGLRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:09:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B8321E36;
        Tue, 12 Jul 2022 10:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFF8FB81A8D;
        Tue, 12 Jul 2022 17:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD57DC3411C;
        Tue, 12 Jul 2022 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657645745;
        bh=8XLl6DX1xCwKSbulZKVgXe9qPNJcpvyKwGwWPAR1wds=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nUDUPV2GngSEYoVwVjAK6dbxZrNvmtqyx2dQxCXY1Tx5FqbUppl2wOl2LN5jgcgOV
         8KsfCctTJKrQBpGhFDP55zyEI/MalHSbtdpxoSsbx/0oXnQa75p3CpPetDB8riEt2w
         VJB22QAjDe1gudINeog15/Pvpx46mcktKNgizxyMUU5mm67lIJtwbIv/KxyK79ZsNl
         sud65oNaMIxaaHRuMPKOuuxPyxrIwCKG+xArssWLxKNOCZJyeenPPFKfK5faUdHQ+C
         ciLHMb2oTdfIIrO9VYv8xxOmdzBttRzo01/hlQT6cH66hi4qZhxDa5V9q2AGLbLd8y
         V/rF19MOELsXw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, Boris Brezillon <bbrezillon@kernel.org>,
        han.xu@nxp.com, miquel.raynal@bootlin.com, haibo.chen@nxp.com
In-Reply-To: <20220711160802.4938-1-han.xu@nxp.com>
References: <20220711160802.4938-1-han.xu@nxp.com>
Subject: Re: [PATCH] MAINTAINERS: change the NXP FSPI driver maintainer.
Message-Id: <165764574341.452521.3874597198173899387.b4-ty@kernel.org>
Date:   Tue, 12 Jul 2022 18:09:03 +0100
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

On Mon, 11 Jul 2022 11:08:02 -0500, Han Xu wrote:
> Haibo Chen and me will take over the NXP FSPI driver maintainer role.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: change the NXP FSPI driver maintainer.
      commit: a77c46f2b4d48a81f36442ee0c2160baebf6c1a0

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
