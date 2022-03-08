Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499C94D1EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349086AbiCHRZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349305AbiCHRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B055743
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55001610A5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D218DC340EF;
        Tue,  8 Mar 2022 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760067;
        bh=HBG0QEqFPkobnElfezVfJiP5rXTwhi4PFEhGZ7aJJ9M=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=of6u8aJiy+Ddm/KXOLGXRkf4D4/NEXnkDfsrYRCX1tA1hAg4M8YILKSlnNhX+9Ivv
         3g0ftwuMlkoJ+lgvUuOUU5tLuJ50DLlgTJEV/MieiWQJEd9tyStksVONO7E14uwFWz
         JeKFi2aU8hn1IbThJJdnaNNdJTHH4ERUFo6CKQS8xI75WsqtASMwuidI5rMpza5q+d
         oFGzh2SmtZCtv6F6H2DZMoogsqSkgzTAB6kYHVD5tOgni/XcVm3Wf5L/F9t5Z6M6Q7
         jrA8TClViMalNOFpCtmW7I6RHoZg1QKOQO8wrmCl8Lh36uifyeBdbyOuEqK9K/Bh9N
         6RFwn6CtrnZAw==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Viorel Suman <viorel.suman@nxp.com>,
        sound-open-firmware@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
In-Reply-To: <20220308023325.31702-1-linmq006@gmail.com>
References: <20220308023325.31702-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Add missing of_node_put() in imx8m_probe
Message-Id: <164676006354.54315.10445621693654106619.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 02:33:23 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Add missing of_node_put() in imx8m_probe
      commit: 5575f7f49134c7386a684335c9007737c606d3b5

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
