Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2034F44FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381741AbiDEPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346606AbiDEJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA42FB;
        Tue,  5 Apr 2022 02:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 876C0B81CB5;
        Tue,  5 Apr 2022 09:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81404C385A2;
        Tue,  5 Apr 2022 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151066;
        bh=YypSHEp1rOHcihtmVFUWRUSVBqn1rhBtj2pQDDhyoOI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OQgUIMa2+Jl5ZN/tEN/rPzkKmhEaurR5d+v0K2yZR31kmlkdJkgvJ1UiBhBzt5RSM
         ydqLwdVnexufAh7HFSeU/S0f2WHs6PYKrJOB1GpykjS42ntFc3btzZzVpLYEU8V481
         5xnHiBquaMN7puc//Amlvcf2iRbUseZUCom+xKF66Nm87x/vy11Phosp0dENqtVdkG
         WkgGsQd1vJpfhYNB0H0g8IcYzxPeMSwSGV1XxmNF3AtxqaHR9nCMjA6iQ+TduCEobD
         z/Dt03CLIwASXP+0esQU+i1N9gdzwE5cTKsr/P7p7sOhaxmLVUNB7FtbmJC7ECnRTw
         yeHets5eAbOyw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, trevor.wu@mediatek.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     aaronyu@google.com, tzungbi@google.com,
        linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, miles.chen@mediatek.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220324053851.27350-1-trevor.wu@mediatek.com>
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v4 0/6] ASoC: mediatek: Add support for MT8195 sound card with max98390 and rt5682
Message-Id: <164915106325.276574.14625118005435337786.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 13:38:45 +0800, Trevor Wu wrote:
> This series of patches adds support for mt8195 board with mt6359, max98390
> and rt5682.
> 
> To prevent from copy-paste components, mt8195 machine drivers and
> dt-bindings are merged in the patch.
> 
> Patches are based on broonie tree "for-next" branch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: mediatek: mt8195: revise mt8195-mt6359-rt1019-rt5682.c
      commit: 4dbc714fe07641e7a07731f82152448ef09f3002
[2/6] ASoC: mediatek: mt8195: merge machine driver
      commit: 094e30efa444a118a535cb67ec000bbee9f8d150
[3/6] ASoC: dt-bindings: mediatek: mt8195: merge mt8195 machine yaml
      commit: dc16399078aea4c98f17aa99f0cdea9d5ac9c4a9
[4/6] ASoC: mediatek: mt8195: rename card controls
      commit: 3a0323c26c6720447fd5eff6495c1aea514b77d5
[5/6] ASoC: mediatek: mt8195: add machine support for max98390 and rt5682
      commit: 86a6b9c9dffff1bd653d582cfc5138da75e5f7b0
[6/6] ASoC: dt-bindings: mediatek: mt8195: support mt8195-mt6359-max98390-rt5682
      commit: cae34da5323b6ce4d0dc365d1b971f838dcff318

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
