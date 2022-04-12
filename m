Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1CD4FE756
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358490AbiDLRlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356774AbiDLRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C12A62BCC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB71619D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F5EC385A1;
        Tue, 12 Apr 2022 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649785099;
        bh=VsiW3CuUG+R7QVT9cZrUKPYiW2B49SVijz2OAHaLQF4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BveF8bkvE+lr22QTXpRwLJ6STY4ghFnr6cz1scbsP+oqFS4cxL0HVhKTwKEgvFY9Y
         iwU5I9ZrxspDXCMdZpGGzcCpTRXa8FJgYMoYJLPvvQ9kjCw6hcjn7Um00F6YMz50RE
         JzQzdRX6OHI6MKNS8yMhk2BdYvCcB+BsnxBGCh4lTE3TTJMnc2tv5keysKjTkD4xLS
         L1vbHdDFnxpfs46Hx6v6DWkf5Lv/CHEBcknYuOxXfUPGhmLh5kfSoKDK/km7KRNbCV
         D9tWF3Y7P5ySdMo+Rj9CbKUFWGnfdFLfwr5JkqcwKzBHLKMYhu6fmecLxNoO7h0mfG
         h/0m56u9a37Ig==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220411165929.1302333-1-rf@opensource.cirrus.com>
References: <20220411165929.1302333-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l45: Make exports namespaced
Message-Id: <164978509825.404572.4732190389821838906.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 18:38:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 17:59:29 +0100, Richard Fitzgerald wrote:
> Use the new EXPORT_SYMBOL_NS_GPL() for exports from the set of
> drivers for cs35l45.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l45: Make exports namespaced
      commit: 31c90dd56ae2945ce46ffa9728d1e1502f5a0c2e

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
