Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3D593325
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiHOQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiHOQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:25:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C526109
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF444B80FE3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDF5C433D7;
        Mon, 15 Aug 2022 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660580584;
        bh=YipuA8xpMD2cZk8ply93QvmLbz3xg3Y7+lnuxBQXklI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UQzwbZrooVjpbDPace0kLOhxBm3O3DWQtQW7YGvpCe+OBpnNQI6Uu3D7FCGAFtnQf
         7VTWS2+uph5eR43mbHEIK8Li/bJGBYONAgjpTJZnMhETjzwrgD9L0fcl58QZQa5Eeo
         FrSjI2I7BHLaJxOsHOF+qyFOhajKha8bumoQUWoiTjiwi6ZF2khOBv834iXtl6ADKp
         OmC7lsD1L32zfD8RLhlhv0jHGvtwuumkNqwKB4TNL0CjSqxOCNfHcrsBRYuGrbPs+p
         yJymnvCQHRo1rlWLCbZhJV4TVpIE2wpCeI7Qy6P25GnQK13VrwLW5gzxRYbSxOUThK
         RlkaJWCMdPVgw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        Xiubo.Lee@gmail.com, tiwai@suse.com, festevam@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1659495748-10876-1-git-send-email-shengjiu.wang@nxp.com>
References: <1659495748-10876-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: imx-rpmsg: Support configure sysclk for codec dai
Message-Id: <166058058210.769843.13008464133060260888.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 17:23:02 +0100
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

On Wed, 3 Aug 2022 11:02:28 +0800, Shengjiu Wang wrote:
> Some codecs need to configure the sysclk even with slave
> mode, otherwise it may not work properly with some case.
> 
> wm8960 is the one that need sysclk be configured, so add
> late_probe() to call the snd_soc_dai_set_sysclk() of codec
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-rpmsg: Support configure sysclk for codec dai
      commit: 088f115c6ff664c8afe003bd542e1e662a72aaed

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
