Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C765A4F9884
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbiDHOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiDHOtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:49:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1438D84;
        Fri,  8 Apr 2022 07:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9537B61E83;
        Fri,  8 Apr 2022 14:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37655C385A8;
        Fri,  8 Apr 2022 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649429233;
        bh=6UAy6vwa9qNgF6GIFreKzgcGTOebGNa25UsFFF9iOHw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GNsF6pDXrgnU84AB89bG6z8gC2Cqfueje8sDfg6VZIHVELT3aZpBrW83/h+TzNRU1
         +HOib9Djh1UWy1FXxcf5vlKMCBr0Y984nAVX2Zid9VcnGjvf9jXakgXlFBjP/HbUPC
         6rbsYHQj+Qg1I9ZpcSMPbhB4o7+GFfUqAQxFwof0Yn++oNdsESMKYhEPsCpEiIRaOs
         Nf4VcYQBlrYkKneakat1KYW2nRSLACsX5fR6i7Ll6PcQlQAcJEQg4XHcDvUntKAp4Y
         TmIJd349vXbssjDOJfkK6OVy05oRsf9kfkafxCi9CDcY/aaj7Dv30U4B/PSjlVSP7G
         rsGHas/pYKhKA==
From:   Mark Brown <broonie@kernel.org>
To:     tzungbi@google.com, robh+dt@kernel.org, jiaxin.yu@mediatek.com,
        nfraprado@collabora.com
Cc:     trevor.wu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aaronyu@google.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linmq006@gmail.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com
In-Reply-To: <20220408060552.26607-1-jiaxin.yu@mediatek.com>
References: <20220408060552.26607-1-jiaxin.yu@mediatek.com>
Subject: Re: [v10 0/4] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Message-Id: <164942922994.1424253.17635473999849755848.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 15:47:09 +0100
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

On Fri, 8 Apr 2022 14:05:48 +0800, Jiaxin Yu wrote:
> The series reuses mt8192-mt6359-rt1015-rt5682.c for supporting machine
> driver with rt1015p speaker amplifier and rt5682s headset codec.
> 
> Changes from v9:
>   - Modify the commit messages to make them more clear.
> 
> Changes from v8:
>   - fix typos.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible and new properties
      commit: 1efe7eca170d344c5101c69ac51df6982de764e4
[2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of speaker
      commit: e1e408e60e856b99782b26308a9dc3937b1ba8bf
[3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI links of headset
      commit: f8910fb4985a00c0a1e6932dc5bda6181c549b76
[4/4] ASoC: mediatek: mt8192: support rt1015p_rt5682s
      commit: 7a80167b08f52e7b5eaa18a9d515efdcff9085fc

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
