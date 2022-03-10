Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE924D45C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbiCJLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbiCJLgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:36:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BB142361
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6869EB823C3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DF3C340E8;
        Thu, 10 Mar 2022 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646912120;
        bh=TWvMPTJzJ27GVP5gpFDJ0b1Mu0lLmlwPszikGKU7gBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SjxVeEe3tindzUNM1tmZ9KNYMK0v6ASZA/EP3CEWuJevKVaibwyTz/JylOfKN49Ch
         vajwUmReDfpo9oUzy9cmeuD+ZjDuZxo7PIms1b7lgKWNYjMVIZmjqmnE7VUoTpHJH4
         bV1dVMg0luDW1Z0EetyLJUBmzsmxbeZROjO60vCEY7MOedZWPk2SfmdYMR4AVVkty6
         2h3faUwC0+5+bX2jWGgq8KqNwANm25FAu6kpFp88VEzrCPXvaJZfx+onlYqDkdC2WB
         b0bogAhhXetSurArqeFqRRSR3pm/ygoB8LYRyke36XtQFUX5h/brgWkwt50zcSMfi/
         ezbFSUgwrivRw==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, perex@perex.cz,
        tiwai@suse.com, nicoleotsuka@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, festevam@gmail.com,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1646822293-26965-1-git-send-email-shengjiu.wang@nxp.com>
References: <1646822293-26965-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_rpmsg: Remove SET_SYSTEM_SLEEP_PM_OPS callback
Message-Id: <164691211764.13798.1783261167562942909.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 11:35:17 +0000
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

On Wed, 9 Mar 2022 18:38:13 +0800, Shengjiu Wang wrote:
> For sound need to be continuously output at suspend with rpmsg
> sound card, so need to keep the clock always on at suspend,
> then suspend & resume callback is not needed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: Remove SET_SYSTEM_SLEEP_PM_OPS callback
      commit: 8b1d3b733f3e6acaab6c6bc9968ee0e058900a7e

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
