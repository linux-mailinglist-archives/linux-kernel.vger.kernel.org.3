Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977194C7891
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiB1TQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiB1TQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:16:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05936E4481;
        Mon, 28 Feb 2022 11:15:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9066157E;
        Mon, 28 Feb 2022 19:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61FAC340F4;
        Mon, 28 Feb 2022 19:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646075750;
        bh=4ffxVFmIhfSz2RtkuWHLovxc6YbAAP8sRv97sOREYfc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=owGY+crFVM3JpKfDcYPQnUzKuoDo1rTOE31vlN/spxk8l2WCA7mVrq1kAMb5fRTIW
         8g2XhjsJ35xlVBOUCrQBsCGGIedCKaXq991oEoAxr3d1nj16SpptakxkYcIG3CIAbZ
         ZSs8J6oRO+jcMax2xMYxVMZ6QCzlzyEsZ10UcZrjqIJ84BXsdxSK8cuTSF7BZuDkST
         oIEw66ubt95eP7K118GgZEnKcHsQ2HaddQWZkMsGQa/LQ8w29/EQ0YQjktMz0uRlA2
         1qr6YfaVnZFCfZrRB9ffjE6ju9IyWMM998IB+Kxbl/caFh/JkQaEGyPS/Ymukh50vs
         pQ9EjwytV+xsQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
In-Reply-To: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
Message-Id: <164607574758.3538791.1940020429283173746.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 19:15:47 +0000
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

On Sun, 27 Feb 2022 22:56:32 +0000, Lad Prabhakar wrote:
> Document RZ/V2L SSI bindings. RZ/V2L SSI is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-ssi" will be used as a fallback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
      commit: 032959d880fd99a790607cf59cf6c00b77a32cef

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
