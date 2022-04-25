Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62E50E726
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbiDYR2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243994AbiDYR1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9340E7A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 025C1CE18D9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0FFC385A9;
        Mon, 25 Apr 2022 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907470;
        bh=wR6QwiYHfKAcBGUMoPjP37+zT0CNZmW2bzNlKdAnf3c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A00jWK36DDeuaoE2AbqqeRgIuxEP96TCZNIBcviBUay0V0bB8WthOusz2FyFGhXR7
         GSWeLJeqMxQ3KJpm0aoZx4LU3bVq/qoYDVNCm/TSRCkm1T1/MCYPXk/RUO9oQCHUPu
         hMYcNydcyuVpj2cJGL6D7QBh9kht/A2bM6ry55Mm8J1wEel0+5kQMpghPUptzZP9y9
         TVH6v4urd4S+x89ebiJHPVPIv8R7AtTb4yctgoqG2eRYK0STYplzy6scAnn4rQf2n1
         ih+COAC0h70nmA7Af70hTbCRfWmeXJpJXHOrxKCLOKoB9jy3XDtxeNIjsv50G5+J2z
         +6Dzu6cwbj4Ww==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220425125012.3044919-1-rf@opensource.cirrus.com>
References: <20220425125012.3044919-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/2] ASoC: Add macros for signed TLV controls with callbacks
Message-Id: <165090746914.583823.3259652116452681676.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:29 +0100
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

On Mon, 25 Apr 2022 13:50:10 +0100, Richard Fitzgerald wrote:
> This adds SOC_DOUBLE_R_S_EXT_TLV and SOC_SINGLE_S_EXT_TLV macros for
> signed TLV controls that need custom get/put callbacks. These will be
> needed by future Cirrus codec drivers, but are not particularly exotic
> so could be useful for others.
> 
> Only change from V1 is sign-off on patch #1.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc.h: Introduce SOC_DOUBLE_R_S_EXT_TLV() macro
      commit: cf51406ccb083941102fc101718d4c0a25b17917
[2/2] ASoC: soc.h: Add SOC_SINGLE_S_EXT_TLV macro
      commit: 5349c0c93d15dff27d99fec12fc82040fab340bd

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
