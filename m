Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B6B4F4412
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389671AbiDEPVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbiDEJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B5FDCAB5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EBEC616DF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93376C385A0;
        Tue,  5 Apr 2022 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151134;
        bh=5SNgnebEuo88t5BuI0Mgek4UqhCz6ONUb192n7FiN0Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Oo9fl/fH8xae4F4cmyDJZ2ie5I3demQAztu68AbOvXXC8uTrXxnalQaGqRqj0CkZ5
         Bdsa9ewLXh9I7lYTMd7hv5wCN4v4Ip6wPgneKw+6ljf9fJ91Ehn3q6YmJuEv1JL0ls
         VvUtUMeocgK/Rmxms+BcfXG7ag/gT/IPxsa9ENx7MTsCrtulr0X901gWO1fDlt/3uM
         oZhJQtRYyg1h5KWzTS7eaqLCgxiNHzocI9y4HDkq/Q13SgD4Eg6H4m2+TaFupUSxFE
         kXBpVwd9p1G1BreVp93TUtiKWAbyWak4ozrAa4nxAUlELnK4TC3crwN5ro+mhoL4n1
         bu5BiCtvQWTCw==
From:   Mark Brown <broonie@kernel.org>
To:     axel.lin@ingics.com
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20220403132235.123727-1-axel.lin@ingics.com>
References: <20220403132235.123727-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: atc260x: Fix missing active_discharge_on setting
Message-Id: <164915113333.276837.13963154631042010035.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:13 +0100
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

On Sun, 3 Apr 2022 21:22:35 +0800, Axel Lin wrote:
> Without active_discharge_on setting, the SWITCH1 discharge enable control
> is always disabled. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: atc260x: Fix missing active_discharge_on setting
      commit: 2316f0fc0ad2aa87a568ceaf3d76be983ee555c3

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
