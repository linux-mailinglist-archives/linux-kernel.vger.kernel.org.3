Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29AC4FE758
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358541AbiDLRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356075AbiDLRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2576212D;
        Tue, 12 Apr 2022 10:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E26619D7;
        Tue, 12 Apr 2022 17:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAA5C385A1;
        Tue, 12 Apr 2022 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649785103;
        bh=3LtPJpBag3FhKWTyd+lv8UDX78WC5GQyaw42g+nIqes=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=UjIJzPKAWvTCCDrcA4R3ttd9UxR9RuVChvAK6SmbrP2BngxvpQeiEzvpyAXU58NqG
         XOlE43X2n9QAo9TjXzXSgYj0JQxPVK0K9z1zB6rsKNtIS2I9ES9N6kk7pq1cp828Zu
         KH2lfWe1NyJH4hyJCaqaZ1GnX22l3pmDQOszT03WhZN1JsWR0mWVirK+6YbkRzggwC
         sKCzNpu+ZQWUoLOLKEPyTVIXIokdKMsHrHknLu7TOwa1YTAaaUNWg4x6yx41q6Yjkx
         0jL3QVaJSxe0yIysga/YEFhNPsKDwlNprAm0952JWNro561CN1LZXK19fA7AXB7YYD
         XG4oAXW9TgLbw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linmq006@gmail.com, vigneshr@ti.com
In-Reply-To: <20220411111034.24447-1-linmq006@gmail.com>
References: <20220411111034.24447-1-linmq006@gmail.com>
Subject: Re: [PATCH] spi: spi-ti-qspi: Fix return value handling of wait_for_completion_timeout
Message-Id: <164978510277.404853.11478015977958567610.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 18:38:22 +0100
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

On Mon, 11 Apr 2022 11:10:33 +0000, Miaoqian Lin wrote:
> wait_for_completion_timeout() returns unsigned long not int.
> It returns 0 if timed out, and positive if completed.
> The check for <= 0 is ambiguous and should be == 0 here
> indicating timeout which is the only error case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: Fix return value handling of wait_for_completion_timeout
      commit: 8b1ea69a63eb62f97cef63e6d816b64ed84e8760

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
