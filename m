Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B11578522
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiGROQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiGROQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF3111E;
        Mon, 18 Jul 2022 07:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D14DB81610;
        Mon, 18 Jul 2022 14:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D609C341CB;
        Mon, 18 Jul 2022 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658153768;
        bh=AY2yPHdIUQw+cDf3vWADEhbIuHq7MP631FZmux7hbBI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DtrH+5y/m+j0b1b7xN+Y61SGG/Ma8aga9iUtYCL+Mva9TsyaetogQmkGLVkKF6NcX
         nn27yo74LswIZM+gpJm6pWnTfxoqtY2XMUayoyi+3spHiRoMLIzOrgscKngom9EvAb
         C14tPwI6Mv8vMyjjmQOVWLhUBV3Sky7HU23A8EKMonOVocqDHvLZQarDVj1N1Iys/A
         Zbf0lPnu18yY/KlyUxJZpkrMKflwPO5PDbPTorzKAo+CxiXUvYnbkKpZ6KvKyCNGhO
         ZD0Fqpq/B6ChG2L3MBi5us21bO7cB/oV3gc5zdJvP57P65b3CHxj52jtXQnBszph27
         O1OfIQWvUZZGQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, allen-kh.cheng@mediatek.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wenst@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220715115443.4154-1-allen-kh.cheng@mediatek.com>
References: <20220715115443.4154-1-allen-kh.cheng@mediatek.com>
Subject: Re: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Update bindings for nor flash
Message-Id: <165815376583.235243.5538314790515297993.b4-ty@kernel.org>
Date:   Mon, 18 Jul 2022 15:16:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 19:54:43 +0800, Allen-KH Cheng wrote:
> The spi-mtk-nor controller of mt8173, mt8186 and mt8192 have their
> DT data. They don't use mt8173 as fallback.
> 
> Using the fallback of mt8186 to enables the controllers to support
> mt8188.
> 
> Not all of spi-mtk-nor controller need interrupt property, so we
> don't mark interrupt as required.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: mediatek,spi-mtk-nor: Update bindings for nor flash
      commit: 82cef0af296d3de95c8c7005f640449d45bcef62

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
