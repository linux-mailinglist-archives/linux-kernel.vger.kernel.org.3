Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC1B4D2238
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350145AbiCHUKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350138AbiCHUKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C4419B2;
        Tue,  8 Mar 2022 12:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61B87B81D5A;
        Tue,  8 Mar 2022 20:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C195C340EB;
        Tue,  8 Mar 2022 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646770160;
        bh=KhuRevfaH9djHGc6N9bgsokQXeii825ORL4zHqAYP2Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VwiaPaLb6n3RlKd+FeNxd/LbP1sOxEs+W0abJjf/J+XHfODoDT/0JLH8YhTmRI2EY
         Mueiad0x1IVN23U9lijk8+1cLk4HA/UERtijnGJh2kQ9TdLAFQ5md2TlcHy9q2K/om
         aAn6Asb+rpHiFib2zdmquIt4TrQxqxn6E/Mtp5eQtDhrqGIlMfGQCEneWiEiplKi+s
         1vjjthORfIonTozkZGHvoVLQE6xS/Qb8FkgM36+ZXh1zmhVjkhBJhnEfC8oawaJ0z1
         uATNbSDE5vcuJT6CkK3ZDcwLNQb65sSTog4Nt7xMaGfgrPoDRvc6ky+t1X+ICJKmgS
         pMvYmQHhPcwqg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        andi@etezian.org, pankaj.dubey@samsung.com,
        linus.walleij@linaro.org, krzysztof.kozlowski@canonical.com,
        linux-spi@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20220120192438.25555-1-alim.akhtar@samsung.com>
References: <CGME20220120193608epcas5p466c73dfdcc7eb5cdcd52516a635fca79@epcas5p4.samsung.com> <20220120192438.25555-1-alim.akhtar@samsung.com>
Subject: Re: (subset) [PATCH v2 0/3] Add FSD SPI support
Message-Id: <164677015776.3181837.8136121419686603738.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 20:09:17 +0000
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

On Fri, 21 Jan 2022 00:54:35 +0530, Alim Akhtar wrote:
> Adds support for SPI controller found in Tesla FSD SoC
> 
> -Changes since v1
> * Splited SPI changes from a larger inital patch set
> * Rebased on Krzysztof's latest (v5) SPI schema changes
> * Added tag
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: samsung: Add fsd spi compatible
      commit: 363d3c51bc5b3243b5b035a1f50d6d994a1b203f
[2/3] spi: s3c64xx: Add spi port configuration for Tesla FSD SoC
      commit: 4ebb15a15799da4954f1d4926fcd3263ea46e417

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
