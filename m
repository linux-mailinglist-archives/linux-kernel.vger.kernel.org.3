Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1F50E712
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiDYR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbiDYR12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA241307
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47C4BCE18E7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F697C385A9;
        Mon, 25 Apr 2022 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907460;
        bh=kGNKLYoYkIqyAIUqooIaCkDmUVcEL/KHpxMnxdUnrRc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ACFU4LD7VqRkiZApiylS1fOnq2RPRL/i0D0eEj9j11l26LRlXNcUfP0flySj5nH0N
         CZlLTaf5OfTdKYlW0x6/U5oEkxP3GmCRzI/SvYuTAYpM6532fGOpywGxCsqV+QkHGV
         LxkWTwG4Zd1nyQRDO1RxXZRvTRyLHoKOsxoRIfkf0dLx+Y57vhwkT9qwBodmmK0HeM
         B0GuAsX4WQ8V8bpaPJHRorlMNc4R1NKVtP0hI8a8vowE/JtKfPcxddIVPZObFqC0D4
         kKg+/OZyqoXeL6xYRlriZYJuv/53u9bhPuE21qxkmamjf07huqSwwbCLzzsYTuV3Lh
         Y02qO6wjsch3g==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>, lgirdwood@gmail.com,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, shawnguo@kernel.org,
        perex@perex.cz, kernel@pengutronix.de,
        Nicolin Chen <nicoleotsuka@gmail.com>, baihaowen@meizu.com,
        tiwai@suse.com, linux-imx@nxp.com,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1650509120-25377-1-git-send-email-baihaowen@meizu.com>
References: <1650509120-25377-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: remove useless null check before call of_node_put()
Message-Id: <165090745710.583823.18355681135160167823.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:17 +0100
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

On Thu, 21 Apr 2022 10:45:20 +0800, Haowen Bai wrote:
> No need to add null check before call of_node_put(), since the
> implementation of of_node_put() has done it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-hdmi: remove useless null check before call of_node_put()
      commit: 666b0cad75dc9517100295aed590aef2ff9a73d1

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
