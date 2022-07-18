Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E719457840B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiGRNnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiGRNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B5AB2F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0733961620
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D37DC341C0;
        Mon, 18 Jul 2022 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658151827;
        bh=fvMrWGN2+Z3EMUKa7NqYc4Z5CPh6SQ2Vx2v8jNnb1mk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=r/GpiRrMEeBcPsr+e0cU4ZjAjKEVWXpiiKEmrWSelg+DxSWVFRiq0KfHQrjA2y8nf
         KI6DlZAKmHTubgr0cl1XZFKsehsfmRcLaM+zJZv5bd5ySUyhQeSlm/xbgbzZzXho1D
         +Ga7pcrAPE3IT4+1eV65JHNa3CIMVIC4kzjXh1AETvniw6eIr5WUUy+Jz7a1ZUJU5a
         KUPzhexrEOD18pqWqRlO7c7PelqaXm6ou0Imbha320sqXjEw0OALecysf7MUSIlos3
         EkuuLsSO+/O2E8OukEnwcIiuIOYxl/bc3Pcbpb0fwnrGQUb+s/jNRUxZqNZwm7CVpH
         KnNN0uJjnxMCQ==
From:   Mark Brown <broonie@kernel.org>
To:     ansuelsmth@gmail.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org
In-Reply-To: <20220715201032.19507-1-ansuelsmth@gmail.com>
References: <20220715201032.19507-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] regmap: permit to set reg_update_bits with bulk implementation
Message-Id: <165815182610.53791.17547202213321860152.b4-ty@kernel.org>
Date:   Mon, 18 Jul 2022 14:43:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 22:10:32 +0200, Christian Marangi wrote:
> A regmap may still require to set a custom reg_update_bits instead of
> relying to the regmap_bus_read/write general function.
> 
> Permit to set it in the map if provided by the regmap config.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: permit to set reg_update_bits with bulk implementation
      commit: 739f872e48d47c97fa17a86a7b3356771b75240c

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
