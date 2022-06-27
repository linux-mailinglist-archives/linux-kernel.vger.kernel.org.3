Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC555D7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiF0UdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiF0UdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:33:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796FEC32
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 228B9B81ACC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C282CC34115;
        Mon, 27 Jun 2022 20:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361985;
        bh=PY/nZ97gXUdkVSEME+yaG6Lr8S9wimkxQCUX4cM3vs8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p0P+UFgBnlDvFhJX3IXZYR52W+RerSE/9J6ySZSj+SIGXhMhXPSePtZjrGTB7KGQi
         XcluaLW746KG4WBBk1rG6O4TqIH8WiqhBF084jqcJniHtlStLStoGD3QcVwY02CNiT
         CAx5FuVhSKys35T2tSutczSt9PQi4fVk03WjecA3sO9xCuVBYJRA64k81FyIdfGrA+
         t4DqRannvOIFK70Ou2tGUOAXlnYaqZyBet5wQGxLDRejX3B7gbUxOSYU/dLSMA9dKw
         Lwoo4p1moUGCQPE3ZjrVjRC0/c4OcHVVmM2LvQVNS9H3KZ4V1mwaw+hmqRfu/uq+cF
         SaAAoRQgpHNgA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, broonie@kernel.org
Cc:     dongas86@gmail.com
In-Reply-To: <20220622171723.1235749-1-broonie@kernel.org>
References: <20220622171723.1235749-1-broonie@kernel.org>
Subject: Re: [PATCH] regmap: Don't warn about cache only mode for devices with no cache
Message-Id: <165636198441.4094714.10382838559554694205.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:33:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 18:17:23 +0100, Mark Brown wrote:
> For devices with no cache it can make sense to use cache only mode as a
> mechanism for trapping writes to hardware which is inaccessible but since
> no cache is equivalent to cache bypass we force such devices into bypass
> mode. This means that our check that bypass and cache only mode aren't both
> enabled simultanously is less sensible for devices without a cache so relax
> it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Don't warn about cache only mode for devices with no cache
      commit: 3d0afe9cf1ef871a71596f990d7d2e60cc0b8669

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
