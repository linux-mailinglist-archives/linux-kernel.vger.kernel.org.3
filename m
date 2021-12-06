Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6E46A390
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbhLFSEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52438 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhLFSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:03:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B81F8B811DC;
        Mon,  6 Dec 2021 18:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AEBC341C1;
        Mon,  6 Dec 2021 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813628;
        bh=zHUTDXXfzWnxTHaFvSpW2L0XNbOVdHY/sxh/MV0nomI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tnx+LyrFNU/9Vvi5FBG2FmEFVQZunIyrA7BceY33+nYpWIxa+o6MqazpOp3xQY6ut
         +4LDzpPx2FXoJG3xN8c3svkItB7ogm2e/JvrN4IIs4dIm8/O+t856zmk4xGYS2Ajl5
         inhSKEjGfld+8p01/pQ9Zpk9nLonB3CwuVresSTw5WocLmlEJchvnNxAJyYtCF2KN1
         xYC5BOiJ3fFSKHKgC8ywjQzOf3vszFM+MfbIQPTf8ADLiwkDhdp8dqotCDNn33B6OZ
         Zfg/nfW9If9WjmVnGwlrLHTxk9W5CcI6Iy8qYl8g5PfWEGIosqozSWo6HUTRlRFDju
         xpLjmq68/rEiA==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, matthias.bgg@gmail.com, tiwai@suse.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        yc.hung@mediatek.com, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20211129141057.12422-1-trevor.wu@mediatek.com>
References: <20211129141057.12422-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v2 0/4] ASoC: mediatek: Update MT8195 machine driver
Message-Id: <163881362422.2769299.13576953689584169746.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 22:10:53 +0800, Trevor Wu wrote:
> This series of patches adds support for RT5682s headset codec in mt8195
> machine drivers, and SOF support on card mt8195-mt6359-rt1019-rt5682 is
> also included.
> Patches are based on broonie tree "for-next" branch.
> 
> Changes since v1:
>   - remove patch3 and patch4 in v1
>   - add SOF support on card mt8195-mt6359-rt1012-rt5682
>   - add new propertes to dt-bindings for mt8195-mt6359-rt1019-rt5682
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: mediatek: mt8195: add headset codec rt5682s support
      commit: c9d57a25de53800e54969f4bf2b672b3a58cdaf5
[2/4] dt-bindings: mediatek: mt8195: add model property
      commit: 629e442761bae0c62b2fb14061d66bbd08b4155e
[3/4] ASoC: mediatek: mt8195: add sof support on mt8195-mt6359-rt1019-rt5682
      commit: 3d00d2c07f04f47aa4228700b440ac47abf13853
[4/4] dt-bindings: mediatek: mt8195: add adsp and dai-link property
      commit: 6182ec4616d6ffc046bea798c683a0dee11ded67

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
