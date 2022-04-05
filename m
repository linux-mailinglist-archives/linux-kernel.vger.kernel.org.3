Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918B4F3E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388966AbiDEPUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbiDEJpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AB618379;
        Tue,  5 Apr 2022 02:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CACE3B81CC1;
        Tue,  5 Apr 2022 09:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E008C385C4;
        Tue,  5 Apr 2022 09:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151124;
        bh=GjmC2BEcN0KsKZ7ydEfVFphIGpjCxpDNSpkEEa64urQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nNsuW0ERMiz7rPDxZB8Z1DW5F1ZljqyZDRU3LuRnGbPOfIjyDWGqnYMItXQrFk3oQ
         SL7CUi6P1TQa/VNvIB+wYnsmV8bWHLOT382axLRhlgKaj7kAE7tUxO/34zp8/J7fnF
         IQEWaMWdTIzBMBA8Ttg03eIbBiuqeij0gayJgsogN8eqH8nXGDeEyPQax3fWtqec11
         RMK7Qx4jJ/hxsIqqJTC2EFIMx+QPHbQmoFBr54tLn0OZNBWoqwX0azrqZ/sYX4FgD5
         Zi1xC6asCUFRNOQq5ddKU66DrzQD3IIq8LA7UcbI3KF566PecFxrJyzcVuKfPq8dyh
         +NX9iwxMFKwZg==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, johnson.wang@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220317030402.24894-1-johnson.wang@mediatek.com>
References: <20220317030402.24894-1-johnson.wang@mediatek.com>
Subject: Re: [PATCH v2 0/2] Add support for MediaTek PMIC MT6366
Message-Id: <164915112290.276837.17651997512675348293.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:02 +0100
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

On Thu, 17 Mar 2022 11:04:00 +0800, Johnson Wang wrote:
> This patchset adds support for MediaTek PMIC MT6366.
> MT6366 is the primary PMIC for MT8186 and probably other SOCs.
> 
> Changes in v2:
> - rebase on Linux 5.17-rc8
> - change subject line
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: mt6366: Add support for MT6366 regulator
      commit: d077002c9d07dc6f64d07a362202a1e1081b2f6c
[2/2] dt-bindings: regulator: Add BUCK and LDO document for MT6358 and MT6366
      commit: 417dfad7e4f0501853e05a46742a4e47075f034c

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
