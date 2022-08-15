Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED18593152
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiHOPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHOPKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2B62CA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE97D60FF6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CF8C433C1;
        Mon, 15 Aug 2022 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660576219;
        bh=EeOLEYWrkj5+ibYmr3Cp7OFxCnJPsqiDgEVrLkweeqs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FyIUSsp6+xxBjFRRlp31ZnIb7pfvA6/Tlyvc32a4w+igDZBQ9tMY4/GA+QongBuKt
         wPuWXgNzzaeqB2bAyi5OV0kvkYTuHNr6E3rLo/h77n3pfviGzeWjiYjJAefFvbqtoI
         JnwlBl9zJ2W5zXws89dKcC99daB1ID95lTKYDajx9luOUCRKW6fcj4aDLCaGGL4Kfp
         9+3SbzTFK8dcEb1aoh8ccuNdwBtutjtGFcH/rUqyH1lTGcI8Ry36WWLMR+20h2Iyfk
         mmknk62ivUqyx9TT9U3EgPSHo+MS5jqFk/An4e12MSUET1zNJSFAasunQMuKXOFJgx
         f0FXnNT8FTuaA==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20220726151213.71712-1-andriy.shevchenko@linux.intel.com>
References: <20220726151213.71712-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap: Make use of get_unaligned_be24(), put_unaligned_be24()
Message-Id: <166057621785.624931.15173366927907651824.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:10:17 +0100
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

On Tue, 26 Jul 2022 18:12:13 +0300, Andy Shevchenko wrote:
> Since we have a proper endianness converters for BE 24-bit data use
> them. While at it, format the code using switch-cases as it's done
> for the rest of the endianness handlers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Make use of get_unaligned_be24(), put_unaligned_be24()
      commit: 060004431df4958a326d6a45107b2fe3406d10f2

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
