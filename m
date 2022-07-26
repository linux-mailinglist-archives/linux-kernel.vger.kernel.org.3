Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BAB5818AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiGZRjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbiGZRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69202F021;
        Tue, 26 Jul 2022 10:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 718EEB812A8;
        Tue, 26 Jul 2022 17:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF9AC433C1;
        Tue, 26 Jul 2022 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658857157;
        bh=Y4fZ1s7g2f+dXxEvYEvMIpJ1WjqOBE65eE15TKQHCnY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dfsSNjyOYCn4HCPJlldUQXUiDm4gYAoKVzTjM2AyFT00SjYADkdD5KozVnsmGik13
         Z9Bo2DcByA5O7yqNz3hIQdKljswAMIvDBI83vkgrFJnoyJEP0RoQLqH0nJaK12fZyg
         k8Cf1Ts+e3gLBzeIIYWTTHdtXLgj0I4h1cgD2UnacIRrRHu/1B3+cuooquZ2E726Lj
         tip/2xh8q2vdwbXQlxaFRB8dPDR21MiJd9U7ko/E76cH3ZraV19fZWF3ubpoUjXZGj
         9Dai/1BIlgpm5N0JUyAoMqNeOS9tMAvn4MVBuGYVheINEGE7YXlvUkVS/3n+AfPSHL
         Fnt5DsaEfl2Lw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Elad Nachman <enachman@marvell.com>, Noam <lnoam@marvell.com>
In-Reply-To: <20220726130038.20995-1-vadym.kochan@plvision.eu>
References: <20220726130038.20995-1-vadym.kochan@plvision.eu>
Subject: Re: [PATCH v2] spi: a3700: support BE for AC5 SPI driver
Message-Id: <165885715584.796037.16726328668582175932.b4-ty@kernel.org>
Date:   Tue, 26 Jul 2022 18:39:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 16:00:37 +0300, Vadym Kochan wrote:
> From: Noam <lnoam@marvell.com>
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: a3700: support BE for AC5 SPI driver
      commit: 66bbf1441d218316948877f7ec6b477c9a49d554

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
