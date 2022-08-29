Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1398F5A5056
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiH2Pjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH2Pj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CCB915DC;
        Mon, 29 Aug 2022 08:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 111D9611A5;
        Mon, 29 Aug 2022 15:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D38C433B5;
        Mon, 29 Aug 2022 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661787561;
        bh=tDx2vf/E5986u3hCddTmtMxyX6w8Hn5pq5J64HWUT8Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MTNyTD1KetefBMcnCPRg17sVFv1r3r4ALBkwsFMAULSnhf8mf5dOexjuCWo8zPatm
         o5vGnDRAoLqQXTXXkKZGI1GrsbgHOaNosUyuHNOL5kZWjcfp4et0K1H7oqsfA6uWTt
         iYMR/c7+XjDLcij6ZWuQp13SIn/ot5VbHwtevwoBo02TpIZRPzrQj4SWlkrVzDdtIt
         QlqCdU7RIF6tIN/kkael6NMtkmMJSduMO93rdQJfU6TRXg463KCEj0Tk6nwA3XNZYj
         hW8MS/wu7wXzNqUiIziA33nDJh5L05c8onA/zZLBPHO4kvnBGjcnLRTmacRgAmn0h4
         uFxB1zfTPMC6g==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     jneanne@baylibre.com
In-Reply-To: <20220826061941.1814723-1-yangyingliang@huawei.com>
References: <20220826061941.1814723-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] regulator: tps65219: change tps65219_regulator_irq_types to static
Message-Id: <166178756042.812665.11210670721222958758.b4-ty@kernel.org>
Date:   Mon, 29 Aug 2022 16:39:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 14:19:41 +0800, Yang Yingliang wrote:
> tps65219_regulator_irq_types is only used in tps65219-regulator.c now,
> change it to static.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65219: change tps65219_regulator_irq_types to static
      commit: b662748ff2e8ff99daabdfbd928270f25f29a9fd

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
