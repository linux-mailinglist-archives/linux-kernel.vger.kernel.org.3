Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED55549D66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiFMTUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351353AbiFMTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E853B43;
        Mon, 13 Jun 2022 10:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A781B81178;
        Mon, 13 Jun 2022 17:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C642EC3411B;
        Mon, 13 Jun 2022 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655141074;
        bh=WhFcv1EH9geGyT4FKQyR7YpypEd1X5ddAYODqZhxQiU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bIt6/NjQpUm9hagE+jYFaN7jaGYRwZVtDciGgAfNK3Qb5tIyrMdV294tUdE/kyVHJ
         8OToqFezlHWN7qFpFkQakyQNvN/3Smhd2XmdBhb0cjaVOYDb0V/M5CWI/wvMfkcZMf
         FF65AnHsL/A028n3Jv80EalHs0tm5N7qDfZRr+YelvlkJgO2WBng7pVWENehJe81do
         IeNyWAiuaupY+7a/4CDMs5pp+45j2s9y58tZmd76r2MuwmSpV+Rm3iBCs35pW1ug1G
         EEFqd0tjWeeF5lKGD0zmuf03BWdsiY+LpHuYSVgTeJ43Ge3g+4MQGyn6j8mPpDClEj
         hIPO17I5vVapw==
From:   Mark Brown <broonie@kernel.org>
To:     conor.dooley@microchip.com, lewis.hanly@microchip.com,
        wupeng58@huawei.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com, linux-riscv@lists.infradead.org
In-Reply-To: <20220611021117.40494-1-wupeng58@huawei.com>
References: <20220611021117.40494-1-wupeng58@huawei.com>
Subject: Re: [PATCH] spi: micro: fix unreasonable clk_prepare_enable() on error in mchp_corespi_probe()
Message-Id: <165514107253.671611.10664601205751933959.b4-ty@kernel.org>
Date:   Mon, 13 Jun 2022 18:24:32 +0100
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

On Sat, 11 Jun 2022 02:11:17 +0000, Peng Wu wrote:
> Fix the unreasonable clk_prepare_enable() with clk_disable_unprepare()
> before return from mchp_corespi_probe() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: micro: fix unreasonable clk_prepare_enable() on error in mchp_corespi_probe()
      commit: 116679aef2f92d535ea8049ef2a610bc73f94660

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
