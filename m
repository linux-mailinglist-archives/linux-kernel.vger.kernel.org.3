Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC74753FCC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbiFGLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242337AbiFGK7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D410789B;
        Tue,  7 Jun 2022 03:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6492F61563;
        Tue,  7 Jun 2022 10:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224E2C385A5;
        Tue,  7 Jun 2022 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599321;
        bh=5JaZ8fuFAsCs3zwfgmDiaQbX9q96F/m3qVELfXvKhnE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qXg2Eg9uNjPunE55sZ+BYMJ5NTmO6e4w5ByJadfTdStS0+FZjNCqBowUi+6KqvBos
         JS6jGOP9QNpAodD2mbEStUZdH25C2vWJn0tzp+BTevWrJJp+r+/SjQz+tcPza6VckL
         B8416lH1ZvjJR5BuckGw7yqkpyq9FEIE095V1z+wU2PqVI1nQ1f9OWWcvKQ1PQ+2aP
         nIe6QJK0cTSo4R4wJIW/4OKlXCv2y9R/Ie6dxoslCxh8Bd7gioxNdB27ULvAehleCF
         /zgpb575z90pCyBNr2gD86eS3vvVKc7+2fHKBP38j7CH4pn6gaJoL8qns5iOjyaPj+
         R94JgD9oKxLzA==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        jiaxin.yu@mediatek.com
Cc:     linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, tzungbi@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        julianbraha@gmail.com, aaronyu@google.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20220523132858.22166-1-jiaxin.yu@mediatek.com>
References: <20220523132858.22166-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v5 00/20] ASoC: mediatek: Add support for MT8186 SoC
Message-Id: <165459931885.399031.2621579592368573898.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:55:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 21:28:38 +0800, Jiaxin Yu wrote:
> This series of patches adds support for Mediatek AFE of MT8186 Soc.
> Patches are based on broonie tree "for-next" branch.
> 
> Changes since v4:
>   - [v5 07/20]
>     - remove unsusd controls
>   - [v5 09/20]
>     - correct indent error
>   - [v5 10/20]
>   - [v5 13/20]
>   - [v5 14/20]
>     - fix the return value if the value is different from the previous
>       value in mixer controls
>   - [v5 17/20]
>   - [v5 19/20]
>     - correct the compatible name with '_' instead of '-'
>   - [v5 18/20]
>   - [v5 20/20]
>     - correct the yaml after 'pip3 install dtschema --upgrade'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/20] ASoC: mediatek: mt6366: support for mt6366 codec
        commit: 612c4695e312c753a8b06f6b052cea3d8338e3c3
[02/20] dt-bindings: mediatek: mt6358: add new compatible for using mt6366
        (no commit info)
[03/20] ASoC: mediatek: mt8186: support audsys clock control
        commit: 58949aa35c0f74a98b03864817354d85f452a51c
[04/20] ASoC: mediatek: mt8186: support adda in platform driver
        commit: b65c466220b336f5044c1be75ebc771d087ee7ca
[05/20] ASoC: mediatek: mt8186: support hostless in platform driver
        commit: 55cac93d271166a2aa431d453bf31fdcb19bd5e6
[06/20] ASoC: mediatek: mt8186: support hw gain in platform driver
        commit: 2567ccae9105cbc881828f2ea09954c1b5fd975d
[07/20] ASoC: mediatek: mt8186: support i2s in platform driver
        commit: 2907d261276e09bd84fdc8bad35930a046a99d4d
[08/20] ASoC: mediatek: mt8186: support pcm in platform driver
        commit: 920508f9fe2fc90f19916d74f4c23088030d32e0
[09/20] ASoC: mediatek: mt8186: support src in platform driver
        commit: e118015db7bd0dad1744221d0fe18333ebf9c622
[10/20] ASoC: mediatek: mt8186: support tdm in platform driver
        commit: ae92dcbee8b6a6f63198a2a6fea0fc9f6a0fe07b
[11/20] ASoC: mediatek: mt8186: support audio clock control in platform driver
        commit: 55b423d5623ccd6785429431c2cf5f3e073b73ba
[12/20] ASoC: mediatek: mt8186: support gpio control in platform driver
        commit: cfa9a966f12a91a269e50f1c3237c006ffe2ee9a
[13/20] ASoC: mediatek: mt8186: add misc driver and register definitions
        commit: 80d8cad2e9ce21517d50c7084c12a59d38a778f7
[14/20] ASoC: mediatek: mt8186: add platform driver
        (no commit info)
[15/20] ASoC: mediatek: mt8186: add mt8186-mt6366 common driver
        (no commit info)
[16/20] dt-bindings: mediatek: mt8186: add audio afe document
        (no commit info)
[17/20] ASoC: mediatek: mt8186: add machine driver with mt6366, da7219 and max98357
        (no commit info)
[18/20] dt-bindings: mediatek: mt8186: add mt8186-mt6366-da7219-max98357 document
        (no commit info)
[19/20] ASoC: mediatek: mt8186: add machine driver with mt6366, rt1019 and rt5682s
        (no commit info)
[20/20] dt-bindings: mediatek: mt8186: add mt8186-mt6366-rt1019-rt5682s document
        (no commit info)

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
