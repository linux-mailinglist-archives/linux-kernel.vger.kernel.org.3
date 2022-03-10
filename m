Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB184D47D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbiCJNPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbiCJNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:14:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBD278926
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B27FB8261C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D35C340E8;
        Thu, 10 Mar 2022 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646918035;
        bh=t2XbWwQwvFMkiF2+x62xGVRkeCafGaXLEBPkGZlDV0E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Kd3PDT/WHiC0r1y03Q9M9UNClYYdwsirULQWFXWuwXuGjnNLph6HgKPPd/A8QeImb
         EinmR0G3aeTUv1e9T3mu4l9gFOM8zVDD/eF+2pbBvdOuewP8bI4espTABMiHg6CGzF
         FPBMA6BuWGslBd0AOh1pO1+Fn+IupyZRzK/Cm4wsUZ3WtZi97iN+Cb8B6xmEczAxDc
         isEuU5Vqg1F60Jud761jRazT83SfiDMiyQ7MKCk5MUUX71un25KK7XpFETsY9m/3bA
         t/OcZ5PgchwWdbxi+JDpaOHXPiDtMgDXxukd0wCWnXDzWY34OWm+P0PQYz0esItPiV
         3OKywL0t0lepQ==
From:   Mark Brown <broonie@kernel.org>
To:     s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, linux-imx@nxp.com, tiwai@suse.com,
        xobs@kosagi.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        Wang Wensheng <wangwensheng4@huawei.com>,
        nicoleotsuka@gmail.com, shengjiu.wang@gmail.com,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, kernel@pengutronix.de,
        Xiubo.Lee@gmail.com
Cc:     xuqiang36@huawei.com
In-Reply-To: <20220310091902.129299-1-wangwensheng4@huawei.com>
References: <20220310091902.129299-1-wangwensheng4@huawei.com>
Subject: Re: [PATCH -next] ASoC: imx-es8328: Fix error return code in imx_es8328_probe()
Message-Id: <164691803138.2018412.9652252221395822627.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 13:13:51 +0000
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

On Thu, 10 Mar 2022 09:19:02 +0000, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-es8328: Fix error return code in imx_es8328_probe()
      commit: 3b891513f95cba3944e72c1139ea706d04f3781b

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
