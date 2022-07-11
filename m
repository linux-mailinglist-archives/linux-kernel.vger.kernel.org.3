Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0B570341
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiGKMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiGKMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:47:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF5655A5;
        Mon, 11 Jul 2022 05:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 389B8B80D8C;
        Mon, 11 Jul 2022 12:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BC9C341C0;
        Mon, 11 Jul 2022 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657543615;
        bh=c1+9aQf54IZr+6ZP+dSHvWes82iHCwbJIRzUwO6op1s=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=C5bP6y/p9Y7SaHV/lNTGMWTBMa0wDEr/qah/Y+jrvQ0r/9QwFmGep8nK2U/Ofc3fB
         a5RImRqjYrs+oG1vzUnqlcAhNuV5I3aQaAJLXUqFIHwUUnrZJp/rZbDXMXWiip7EMm
         a64WanArsK3Qmqf2n8BhUwtuqs1sW14M8UvsA/uzMcJDVAILlhCB7F/VnRf0Px9R3n
         5aJpiO9DuLGP9ZReMXVjyo9BBoKFuH3wMJtHzWrznfwrCM5TFjLtXHCyiCqL/6Zqvq
         HYOtwkHpQLhZBxm6Z94JAu+ggB40riuBnu/0gwSbIUx9hzYwUZf5zSDdIGfSFR5GEL
         i8MicLG8P0OAQ==
From:   Mark Brown <broonie@kernel.org>
To:     andriy.shevchenko@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220709212956.25530-1-andriy.shevchenko@linux.intel.com>
References: <20220709212956.25530-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Return deferred probe error when controller isn't yet available
Message-Id: <165754361495.221560.4080129847008018481.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 13:46:54 +0100
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

On Sun, 10 Jul 2022 00:29:56 +0300, Andy Shevchenko wrote:
> If the controller is not available, it might be in the future and
> we would like to re-probe the peripheral again. For that purpose
> return deferred probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Return deferred probe error when controller isn't yet available
      commit: 9c22ec4ac27bcc5a54dd406da168f403327a5b55

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
