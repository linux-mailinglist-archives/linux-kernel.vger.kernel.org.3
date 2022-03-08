Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EBE4D223F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbiCHUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350148AbiCHUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:10:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2DB3BFA7;
        Tue,  8 Mar 2022 12:09:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD0D617A8;
        Tue,  8 Mar 2022 20:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3733FC340EE;
        Tue,  8 Mar 2022 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646770165;
        bh=++fWBsYk4c3iUR/v1BXYa036CwhGMZdNx6dNVi06Y64=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HYKDu1403fUCfuD7Uv0tP6pcf0QBp3qC9H534nFYwV1eBLF60W0cLB01WH/0oDu9+
         Yc7uludKu36kgfBFkI888o3vnX2vtgZpH1jqYl3IeexuvPm3U4nJfHR6bDWoKrtAfE
         i4hwopg1CtxxgH87pC3m91IfcrRydQVY0hkap7FKhLhTQZLhrsa3d1BQ96kprBkhBi
         1dLLXPfBupYslWGAq26wngnd0wHc8pHLA+veWDgVUMmRIjooH9aDTqtNF3M/nkfIeQ
         PSVea8CoIqv2ijUTaalZfWIgd1xAZxv7AHh/TRXr/5I5eIgN2ZDXPFdp6/PJtFJcL+
         EhvbZG3HDBZnA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsd@tesla.com, Adithya K V <adithya.kv@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, andi@etezian.org, pankaj.dubey@samsung.com,
        linus.walleij@linaro.org, krzysztof.kozlowski@canonical.com,
        linux-spi@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20220308121640.27344-1-alim.akhtar@samsung.com>
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com> <20220308121640.27344-1-alim.akhtar@samsung.com>
Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi compatible
Message-Id: <164677016294.3181837.16909400248004317746.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 20:09:22 +0000
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

On Tue, 8 Mar 2022 17:46:39 +0530, Alim Akhtar wrote:
> Adds spi controller dt-binding compatible information for
> Tesla Full Self-Driving (FSD) SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: samsung: Add fsd spi compatible
      commit: 363d3c51bc5b3243b5b035a1f50d6d994a1b203f
[2/2] spi: s3c64xx: Add spi port configuration for Tesla FSD SoC
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
