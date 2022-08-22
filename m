Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68E259C18C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiHVOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHVOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:25:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85EF2D1F6;
        Mon, 22 Aug 2022 07:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 916D7B81238;
        Mon, 22 Aug 2022 14:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76526C433C1;
        Mon, 22 Aug 2022 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661178296;
        bh=PiktLoy2IS2EfJ927VEsYS/q/dcy6NlvZDENwVBGB5w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QrLNpaspeL5WMdkHA6jOAuKWgVw6AhxGf7tvw7BFaQKSi5e39Y64Djfshm6Hd7R6V
         qjMKDcayPGV/zSVRoM0ycZEgEMlnq3oxrz2B2uo2IhOQRCnBD4dCg+03+YEO9BCVTC
         S1TF4oSRjiix1IBqYBB2lYLIpgvQN7gful9RrCpxu3LO/euPnX7ESoRyRWagLU0/Os
         w0rRFOOwuegGf6D2GvTuTLATG29byW+WMjKLMGi+EtPGzc4LDEp3WdCq51sNbMSy4N
         J7nJcovexmOE21p4iydqe3JWbvGvT4xrZHI9fYbPC0n667UQn1A5e6t9Rd06Ip6ngB
         T+vcq5dDUmLVw==
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        chunxu.li@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220820071925.13557-1-jiaxin.yu@mediatek.com>
References: <20220820071925.13557-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: fix DMIC record noise
Message-Id: <166117829418.94797.5869443265207499782.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 15:24:54 +0100
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

On Sat, 20 Aug 2022 15:19:25 +0800, Jiaxin Yu wrote:
> When the first DMIC recording is power down, mtkaif_dmic will be reset.
> This will cause configuration error in the second DMIC recording. So do
> not reset mtkaif_dmic except in "MTKAIF_DMIC Switch" kcontrol.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: fix DMIC record noise
      commit: 221ab1f0bf46236cf1a3fef5298ff5894acfb0c5

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
