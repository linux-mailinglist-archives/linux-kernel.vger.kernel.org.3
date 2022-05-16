Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F32528B68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbiEPQ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbiEPQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:58:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B2F2A721;
        Mon, 16 May 2022 09:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5623CE1715;
        Mon, 16 May 2022 16:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488E4C385AA;
        Mon, 16 May 2022 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652720210;
        bh=7LDkU1QG3vKPlm+RwVOsAsHB0Xs2kYOwv5HCE8k9Ar0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gCnPCryUpGddOoqXzIOq4Kuvunuf9GDht5uqYOu345QySBHjYjj3GN6VJDeNDB4tc
         yF9RXK6nW1pjeUqMSmeLaaEBwUF3piJSStpYIjPIsL1T3PygwSgKqq7plW1IX/5uLV
         ItFDVY0ajXAkQdCNvY1Ip0bgJxPLevf9ra4W1SvzJWjy/E5DU5aLo2axtNWD4A2/87
         i9wOvURYCMBuJsqmIPGlArnfhZO5ntNgpYXMM8PXgyH90UBmAn5meJ1jtB3cdTU+D+
         zQy8ojiSXcGs8k5R4vyWl+h9NIbDumlj8Hn7Yqo4ys9GurSW8M3NXKQU6lTmB0OkN4
         BIhUbnuSifp3Q==
From:   Mark Brown <broonie@kernel.org>
To:     guozhengkui@vivo.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhengkui_guo@outlook.com
In-Reply-To: <20220513130333.58379-1-guozhengkui@vivo.com>
References: <20220513130333.58379-1-guozhengkui@vivo.com>
Subject: Re: [PATCH] drivers: spi: spi-au1550: replace ternary operator with min()
Message-Id: <165272020902.601738.18027494295826342656.b4-ty@kernel.org>
Date:   Mon, 16 May 2022 17:56:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 21:03:33 +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warnings:
> 
> drivers/spi/spi-au1550.c:408:21-22: WARNING opportunity for min()
> drivers/spi/spi-au1550.c:542:21-22: WARNING opportunity for min()
> 
> min() macro is defined in include/linux/minmax.h. It avoids multiple
> evaluations of the arguments when non-constant and performs strict
> type-checking.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers: spi: spi-au1550: replace ternary operator with min()
      commit: dcc6394db3c8cf6c1d4077a288e6967c4f0a4e43

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
