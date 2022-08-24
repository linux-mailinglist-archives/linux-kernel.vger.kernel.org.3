Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2C59FF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiHXQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiHXQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77F4BA68;
        Wed, 24 Aug 2022 09:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B7E619E8;
        Wed, 24 Aug 2022 16:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F32C433B5;
        Wed, 24 Aug 2022 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661358265;
        bh=LgDF5Ox+bjDfNVdxCe2AZEmz1pOP9XOBZQajiIKH80Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aBUQ4qDHduZc4vcujUzSoPALU4+PnF25liHSk1hoRpSAu1fml/xeiNq2hI0a93jxg
         RZ2FBRYHoqtFm4suW9AiRWqLfWw6mI+qayWHO9kxFChRTWE7oRgzTq+p5qUwUchpCi
         C46zTJKfBaZLo4XoVKStoGslG/DrUH3gCpFlMIkPBUtkyNyJi9IF0ZVRNSmZd4KvIX
         DMi4aEqL6Xj3fKsWv0BTdQVz9YlPGzstmI6ylCnm3ckV4XMsNePQYB0tYvbifQUi7/
         kVNmt2f7r5APrb+hUFy6dAis4mMcC8XyPn8zwzPRucJcf/2RlGL5IN1jju1PBp02DC
         DChkiA7I+sTLw==
From:   Mark Brown <broonie@kernel.org>
To:     nfraprado@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Chunxu Li <chunxu.li@mediatek.com>
Cc:     project_global_chrome_upstream_group@mediatek.com,
        jiaxin.yu@mediatek.com, lgirdwood@gmail.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20220824122319.23918-1-chunxu.li@mediatek.com>
References: <20220824122319.23918-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: dt-bindings: modify machine
Message-Id: <166135826315.480875.12895204417307260753.b4-ty@kernel.org>
Date:   Wed, 24 Aug 2022 17:24:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 20:23:17 +0800, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> Changes since V1:
>   - remove unnecessary quotes
> 
> Add SOF related field.
> 1. Add a property "mediatek,adsp", Only when adsp phandle could be retrieved,
>  from DTS, the SOF related part of machine driver is executed.
> 2. Add a property "mediatek,dai-link" to support dai-links could be specified
>  from DTS
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: dt-bindings: modify machine bindings for SOF
      commit: 1173107d7c129ff87224814fd38fce5db023aaa0
[2/2] ASoC: mediatek: dt-bindings: modify machine bindings for SOF
      commit: 1173107d7c129ff87224814fd38fce5db023aaa0

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
