Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943257E19A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiGVMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiGVMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E6A9B1BA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A8EE61F32
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49D4C341C6;
        Fri, 22 Jul 2022 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658494101;
        bh=A3PD/iBpdUVc6XMGatL8EReF7qKXiMvSVxBYCt3N/IQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WNXXEhny9JV3eScg/Pmy2l/tXCbGqDYAPW1nz2h14NzN7eMlNrw2Og7z7oqwKtcUb
         RIksLa2sljIzaD/RqBbd8wuDvt1ogo+UYJEy9ImtFInc0TsNH838fcennlfrMZ5HhR
         tLIPltZIqyvGWrZN0z27s13vtg+7GKzLOX99E8FLISiZ8jaDareXDZ/uzwqdJUOBVX
         VmsJvTmz5uc/UnqJnu2WNQx0L6OhemJGcoWY0ga4gxfadicqDN//IAtSpB4uN9QCcy
         ueZLUDqEipKBnytIxnaUF8OEnDR2Gol6vxjPiFxrFq5rRD7rorrBoT+Zh57lnUIgak
         dx2LsBuhy56EQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        syed sabakareem <Syed.SabaKareem@amd.com>
Cc:     Sunil-kumar.Dommati@amd.com, Alexander.Deucher@amd.com,
        vijendar.mukunda@amd.com, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH 1/5] ASoC: amd: add RPL Platform acp header file
Message-Id: <165849409858.139149.7568411438322284849.b4-ty@kernel.org>
Date:   Fri, 22 Jul 2022 13:48:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d952f
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 11:39:58 +0530, syed sabakareem wrote:
> From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> 
> Add ACP register header file for RPL platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: amd: add RPL Platform acp header file
      commit: d6a2cc9a80c2fdc10f7fde3f5f57c72e99f3bd5e
[2/5] ASoC: amd: add ACP PCI driver for RPL platform
      commit: 003b9a96f27635e534452b174733c5f1ceec0b56
[3/5] ASoC: amd: add RPL Platform init/de-init functions
      commit: 10599205417ee3b1d29093c85bc210c9040a6bd4
[4/5] ASoC: amd: add RPL Platform pci driver pm-ops
      commit: bc1100f29d1d0bfcd36ba3690a945235ffe149c8
[5/5] ASoC: amd: enable RPL Platform acp drivers build
      commit: 4fb35936a374758d5065b0a015c565436685c378

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
