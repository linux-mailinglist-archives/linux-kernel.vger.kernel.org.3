Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393115517C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiFTLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiFTLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964817063;
        Mon, 20 Jun 2022 04:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 749F86131A;
        Mon, 20 Jun 2022 11:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF210C3411B;
        Mon, 20 Jun 2022 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655725886;
        bh=0KLViu9Kc9KUYkxz5DPYN5S3+LCrgMJEn2pVpTajy9Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MHksJSUevDqRB/n8D2pKo7QVww/HGP0V0ReHcduV+fMXCm+PADfQwyBPNmbAg9MiW
         ne+zGCQ8/VHVEYcjGHngpvldOW3nU/Fym5AepJ9Jwc1oYmF96qPDrBvGDbHmz9JIPO
         3VXKmddXySqk0LGnaoPWFIVUFu/p6g68wJSHe6xbGi1OCE/37TwDhiEGdyRT4mVdzq
         4WsIvsX6qKT6HSKxfhswKhibvA1U6Mol8W4bVZhPTokT9YWdtrNQ4FRcOle7HIMJue
         9BIa0Wa5CnmB8P6L/R/TaN/vQFVwflQJV99ImFQZNyOLysSvaE1iuyVBS8PsuMb7LJ
         zMwtsjvR1KEkA==
From:   Mark Brown <broonie@kernel.org>
To:     jon.lin@rock-chips.com
Cc:     heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org
In-Reply-To: <20220617124251.5051-1-jon.lin@rock-chips.com>
References: <20220617124251.5051-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip: Unmask IRQ at the final to avoid preemption
Message-Id: <165572588544.132271.5675732326732041001.b4-ty@kernel.org>
Date:   Mon, 20 Jun 2022 12:51:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 20:42:51 +0800, Jon Lin wrote:
> Avoid pio_write process is preempted, resulting in abnormal state.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: Unmask IRQ at the final to avoid preemption
      commit: 419bc8f681a0dc63588cee693b6d45e7caa6006c

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
