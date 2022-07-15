Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0FC5765E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiGORW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiGORWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45885D48
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C488A6225E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DD5C34115;
        Fri, 15 Jul 2022 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657905731;
        bh=Gd5+Z4wtxEhn7tEPYjzScgvwIhw26WiYATVwYYadh2U=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bgw4ceIOM4Cip7gRCGQAnHHLbhL0OeLbny31yMz0Hx7VBBDQQ5q8A36NY+2Sv7o3r
         wRgpYlLiHbmkAjyiRHISTm/4lKb8yhMGVH++hycbddVU6k3TkdRZZm31I7h5iJHKms
         DNARggEXBv9Wonu8Fia9liC8BwK2RZWybGPJUgQKqNXOtE3ExYSygpcS31QCnJD5QQ
         EQ4ABXaQ4sXEO+Xhg1ntnDgKe04mF1z00Oaqm4cnPGhIedrVeABucCyF2/SXbqiLvL
         zi0od+YvKJ+2ykIk7GuMqsWE970SKPCxPbSjuRc8mEgGsE+6XYLqyh3599hB/brlWH
         AQ3ljMqnT3laQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, windhl@126.com
In-Reply-To: <20220715111027.391032-1-windhl@126.com>
References: <20220715111027.391032-1-windhl@126.com>
Subject: Re: [PATCH] regulator: of: Fix refcount leak bug in of_get_regulation_constraints()
Message-Id: <165790573026.3961462.13205737184979102580.b4-ty@kernel.org>
Date:   Fri, 15 Jul 2022 18:22:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 19:10:27 +0800, Liang He wrote:
> We should call the of_node_put() for the reference returned by
> of_get_child_by_name() which has increased the refcount.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: of: Fix refcount leak bug in of_get_regulation_constraints()
      commit: 66efb665cd5ad69b27dca8571bf89fc6b9c628a4

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
