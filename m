Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487344C7C98
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiB1WBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiB1WBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:01:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3442EFE;
        Mon, 28 Feb 2022 14:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D87956126A;
        Mon, 28 Feb 2022 22:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7E9C340F1;
        Mon, 28 Feb 2022 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646085619;
        bh=ILU4k4S973vdYYdBOn+r/mutpeUjmBaupdBD+w+y3X8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YIVhXnYZKvFP98jw8SeIsqt8Rv0+yWL+dUNzcQA2g+HqsSDMe/yMHAkyDy/fQFBuU
         QBELhwB5OcEYMgVp9I/73hbKW15bK6hzx3mz87XZGT2HrXBeItwtNj10ncxEvmaXWq
         AWHX/rEHFnHDcYYQJs+XiRvB6IXP/aMVzjhEeHxg4Omtak0ZL7PyL/fbAydaN30GQi
         /TBGHd1kT5wS1IORRv8FtPclmGBjp1nf9tk+2LJS1sdxc5tVkfel7+zs1TgfQfLYit
         ml1FU/AWwnWl5M/qcMIkrWgew/NHXNwaeVMFdMFHhs++obJ0d2rQTCiHtGpDDEcRXS
         zfcdBkS1vzUpA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>, linux-spi@vger.kernel.org
In-Reply-To: <20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220227225956.29570-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/V2L SoC
Message-Id: <164608561623.2299679.12178967236581861002.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 22:00:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 22:59:56 +0000, Lad Prabhakar wrote:
> Add RSPI binding documentation for Renesas RZ/V2L SoC.
> 
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required. The fallback compatible string "renesas,rspi-rz" will be used
> on RZ/V2L.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: renesas,rspi: Document RZ/V2L SoC
      commit: f16ed63e53c79070283d3c264de5309794272ae9

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
