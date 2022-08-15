Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713EA59333A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiHOQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiHOQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:25:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8459427170
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C465FCE1177
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDDC433D6;
        Mon, 15 Aug 2022 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660580592;
        bh=a1McajjZBLg4+o4Mngq4Nas6xSzpje4QIdi9DWARZwM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KTyTi2cNmB6+pC4+OPuS2mbjWu8IDcyxjABlJtbJOstVXP7Cnc/rs/LwzQTIoO7RJ
         EOpQIpktn4q5kOV4HL/haotJ1w1HQxRPEtmxsacZsny8fHkWpxr0kBlou3Cn/KH3Xa
         sZhrRfjWbENvpFu7tC61plXSlg2mCv5kpXXaJIkFZw+UMfAF4zZMLd55mKkkb6KPUs
         BPYSNEt1RYz70SnsiYjV+yV1ntMMM5NO7HNThK2AfSwfHPi63vYKuzxPvXvmN6KA+r
         xnJWtH9u6XXplZz7Q91K2iNcjP9QJvFRpG7FKBV6MzYqU5qGUcjrqo6jNeNVqrryXw
         f9/fQIj68dk8g==
From:   Mark Brown <broonie@kernel.org>
To:     Xin Gao <gaoxin@cdjrlc.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220808153910.59545-1-gaoxin@cdjrlc.com>
References: <20220808153910.59545-1-gaoxin@cdjrlc.com>
Subject: Re: [PATCH] ASoC: Variable type completion
Message-Id: <166058059129.769843.571852618081031336.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 17:23:11 +0100
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

On Mon, 8 Aug 2022 23:39:10 +0800, Xin Gao wrote:
> 'unsigned int' is better than 'unsigned'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Variable type completion
      commit: 1b5efeabf75a74043f1eb509ca3ac183b3ffaf89

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
