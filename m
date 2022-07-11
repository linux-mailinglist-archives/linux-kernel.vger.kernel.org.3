Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A81570487
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiGKNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGKNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F334D809
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3548614B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F271C34115;
        Mon, 11 Jul 2022 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657546936;
        bh=p8ORd2QPR8RvrqSvkiemyZJhadncjyk4UWpXgXg70WY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ldoLgmodCYQDgStD4Vaqe5rs2omN2SKIuO4JfFJXoFYyKPfbijaa1TCZ5mKesN9Al
         qzO9CVdPg/qbr/arCiVJHeULdG+8FeaDVxn00mjkQSbgXqfjO4CEZWbxk+mEdvRc8U
         jza7EZVVyL9wW5r22EXOOmRVtVWW7TrzV+BXLTw6X8QZ4Ryw8+ASimKL68GgZ+mU+H
         eD4Ih7SSiyEqdtAaPYsU8vHqY2kWRpZwXBfc/M9TXFjDbVfla/fHz0cS1JoDfARR/o
         N+f/JFBNdC8bKodbgVpoW0gX829ViloCIzQ7D5ykdz+xIEh7f+nsg1RyqAcdWAZEtN
         QN+zNgD9+TjYw==
From:   Mark Brown <broonie@kernel.org>
To:     jiaxin.yu@mediatek.com, lgirdwood@gmail.com,
        angelogioacchino.delregno@collabora.com, tiwai@suse.com,
        hbut_tan@163.com, perex@perex.c, tanzhongjun@coolpad.com,
        matthias.bgg@gmail.com, colin.king@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220708024651.42999-1-hbut_tan@163.com>
References: <20220708024651.42999-1-hbut_tan@163.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Remove condition with no effect
Message-Id: <165754693321.334539.8263656402397393470.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 14:42:13 +0100
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

On Fri, 8 Jul 2022 10:46:51 +0800, Zhongjun Tan wrote:
> From: Zhongjun Tan <tanzhongjun@coolpad.com>
> 
> Remove condition with no effect
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Remove condition with no effect
      commit: 19bb587f3ffcb9c166bac2debdc3b08fb362c0b7

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
