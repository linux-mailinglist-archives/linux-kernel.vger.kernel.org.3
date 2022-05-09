Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8076B52016B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiEIPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiEIPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:49:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C0EAB87;
        Mon,  9 May 2022 08:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28A4CB8172F;
        Mon,  9 May 2022 15:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72BBC385B1;
        Mon,  9 May 2022 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111151;
        bh=g20W+7CygqgPEo++WiNMlzpLIcKmzLF46O4/qXIfbeE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PXTH2xOmwnr8cyQfqMEkeiAKskYwcZvW+kQVPF7iVwN7rovAaa6Uj6CtNTOinXz1n
         Fugmy0ob0HHRMcWBfGBhEWnqNbeOXs8YGTPysL7VVHB+XZR6Hq4Kup1rex96Lt5Pv3
         o246cwOl3lWlZ6IBrD1P/JZ0lekB9E4QFkoHR0GBObDqN/AaDAMZxeGh9kdFYU6Ksy
         6XpqRo1B1yZIvT+5ArLYYWJiH6ZN3W1YtnQ9J5TcgVj4BC30zCx0WQZp4MHEPXjyEr
         38U9lpEWlcWO/lio3Je8MGdpxWGGjD80qswC7btwvcZVuahdDSfMbqnDdo1qaszUx8
         YzZYwDABJ/7Ow==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, yangyingliang@huawei.com,
        linux-kernel@vger.kernel.org
Cc:     han.xu@nxp.com, Ashish.Kumar@nxp.com
In-Reply-To: <20220505093954.1285615-1-yangyingliang@huawei.com>
References: <20220505093954.1285615-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] spi: spi-fsl-qspi: check return value after calling platform_get_resource_byname()
Message-Id: <165211115053.774621.2081571560850333629.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 16:45:50 +0100
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

On Thu, 5 May 2022 17:39:54 +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource_byname() returns NULL,
> we need check the return value.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-qspi: check return value after calling platform_get_resource_byname()
      commit: a2b331ac11e1cac56f5b7d367e9f3c5796deaaed

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
