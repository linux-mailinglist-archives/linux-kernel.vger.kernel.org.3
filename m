Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8F53ECDB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiFFRRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiFFRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:16:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7232152BB4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72276B819FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48760C34115;
        Mon,  6 Jun 2022 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654535425;
        bh=1jBe4uELOqppK1KztJgJ6/8nhny/As1YHF1KtCMJW+Y=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=AjPRaQltb8X1eQx/xfQe+YKO7qyDjqedBtfbuYpf3+UWYNmCmy9pC3XVB2zW2s07M
         Z9ZUzg77Wi1GoBkuSFHymLPxQce4EW7DfU0YT1o7cgTorFfOwGC60cpnY5F0SE4YuC
         ivyD8681sy9w5rSXII4Sj8PpPLqmATGhxKCVmP5WhGVVRDrGobo7Psvs4qQ3zERkzJ
         4PVmTB3zDhafa9A7CF6NBmCtp6x5nisrpyn5C+GtcRygot9iG1wHTegW6RmwECQoss
         /1h6dmW3weIgDQJhbU+zY9qVVWQtxWHr/MEwBJzbaoOTQWY23kgSD+gB484Zkoh2vP
         ZNmYZ/2hc/KuA==
From:   Mark Brown <broonie@kernel.org>
To:     wangxiang@cdjrlc.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220604041603.9697-1-wangxiang@cdjrlc.com>
References: <20220604041603.9697-1-wangxiang@cdjrlc.com>
Subject: Re: [PATCH] regmap: cache: Fix syntax errors in comments
Message-Id: <165453542401.2437928.12545939803420105222.b4-ty@kernel.org>
Date:   Mon, 06 Jun 2022 18:10:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022 12:16:03 +0800, Xiang wangx wrote:
> Delete the redundant word 'the'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: cache: Fix syntax errors in comments
      commit: 72607f372c9c27af458e4fa1411fbd3a2a448386

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
