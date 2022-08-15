Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8987A59325E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiHOPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiHOPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE37167F7;
        Mon, 15 Aug 2022 08:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70FE86111B;
        Mon, 15 Aug 2022 15:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47547C433D7;
        Mon, 15 Aug 2022 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578308;
        bh=kHq6yMy6gK9MQCNPVme+VzjQOm4ty0ndfUWa4Uog7s8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LkKFN1OCoKVjRoYpbWqnGar9UrZh+cY1rFi4MVyVhL7X29cZNaU4A+8wAB4b8Cet5
         +FqB1BP0zhgD7v0tmuIwFn324PItCDP9MFUJhDAHeJK2MSgqASN1Bba4HygH4UZJUm
         2egYexUIxdNeG5w7B55ZJl90DAXVIjyY2tGpvqCN3J2KcwabVIkj2j+pdmRxd/sxq7
         yd8JfVGtiH1K2kAcrBjUhR7Wpbl/BEw42bia41NQPeQ+i/wPf/wsf2NQVlXq4YcML1
         c/u+7ba13K7bQj5pRs8ReFDdmlp7nniFr5vAGZ+E2NR/yOj0FWf5FWn8gxauqr003n
         pTGQ5UPGSXVFA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>, xiaoning.wang@nxp.com
In-Reply-To: <20220812073452.45763-1-peng.fan@oss.nxp.com>
References: <20220812073452.45763-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: lpspi: add dmas property
Message-Id: <166057830692.697678.5825676350299676949.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:45:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 15:34:51 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The LPSPI has dma capability, so add dma property.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: lpspi: add dmas property
      commit: fba933c2d975463d6a19898cbe30f7399de9f32e
[2/2] dt-bindings: lpspi: add i.MX93 compatible
      commit: d9c6a706f37c32480ab287aafcc781192996d584

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
