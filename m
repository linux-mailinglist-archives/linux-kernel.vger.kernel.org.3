Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0A58F00C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiHJQEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiHJQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:04:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680C792F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6D8761199
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9004FC433D6;
        Wed, 10 Aug 2022 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660147460;
        bh=Ji77jQb/mPc8cT+aCiNaXW8eudUIuT0bN1cvWw8nyKQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R/LwNnziA2wEz2jyx27fiVxvdrlUtIn+frWrYj0cYcQoGTt/vKVMJ5zaq1cYLumCd
         lNCMQL9SW+gqg34+a92f+gkhuxTrez6bs8N/ppsc3C8qQPZpxHLaOrwjuY/Hp0vQKD
         CT6q2BmmX/3TdUZLkODJZ+mkYEbqoPD/nVRxN3lKZ23W8xkGgLICffPV+otViHPpDK
         cMpDSmGwjPKKaoXpOw00JrH8ygKmxPQ8qaCAdfbY+VX/Y43o7jDfJDy+jMfuPS9wPb
         KNUlqGIym13ZkNofLLzpfaoRU50TYTBtzro1G5BCJ68IFs2dEas7cNoq67MTRG8aRa
         eg7yKSGflL25Q==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20220809142738.1.I91625242f137c707bb345c51c80c5ecee02eeff3@changeid>
References: <20220809142738.1.I91625242f137c707bb345c51c80c5ecee02eeff3@changeid>
Subject: Re: [PATCH] regulator: core: Fix missing error return from regulator_bulk_get()
Message-Id: <166014745930.381561.14131467318227618078.b4-ty@kernel.org>
Date:   Wed, 10 Aug 2022 17:04:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 14:27:45 -0700, Douglas Anderson wrote:
> In commit 6eabfc018e8d ("regulator: core: Allow specifying an initial
> load w/ the bulk API") I changed the error handling but had a subtle
> that caused us to always return no error even if there was an
> error. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix missing error return from regulator_bulk_get()
      commit: d511e8a7e850db567cd7f633288aa96a19508e5b

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
