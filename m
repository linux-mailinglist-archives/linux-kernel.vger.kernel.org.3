Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC84DE30B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiCRU7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiCRU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E732419299
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92593B82584
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812BEC340E8;
        Fri, 18 Mar 2022 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647637075;
        bh=lFMVIvLaULoi1F69g0FLY20JIygenMjKfO49F35rW64=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ja9Nd4UIqCaIhxFSwosQ3tCzCLUsj+ecIrR//a2BYZhc6dYTquOF+a3NEyQl5A11I
         fqNZu7Ez5Robq81DOTmj9qpZdJ+Z71wYeISw+8VLmIhPKQ2EransePekcEJPmgVKvz
         mhdmKXvG6f133K7yJTMVN1fEirGeYKggwyKx3v66ig/Je06yZn5uoowO0Jvg1eua5G
         itaoWoa+2Q+OsB3tgnRA+WU73Tc4YKkBi1xZNelwO4E2tVGJHX1OTI+ih7uWAmMMjb
         8ickGblNxkSgFSMeG18FY66an/0rNonPxk6KaW33qoCp8mJ1m+Pb0yYOJgmEzjZa3F
         ikLUrhv8YM2Rg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20220313224524.399947-1-colin.foster@in-advantage.com>
References: <20220313224524.399947-1-colin.foster@in-advantage.com>
Subject: Re: [RFC v1 0/2] Add more detailed regmap formatting capabilities
Message-Id: <164763707425.2336513.17062085835683897138.b4-ty@kernel.org>
Date:   Fri, 18 Mar 2022 20:57:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 15:45:22 -0700, Colin Foster wrote:
> The Ocelot chips (specifically the VSC7512 I'm using) have a method of
> accessing their registers internally via MMIO, or externally via SPI.
> When accessing these registers externally, a 24-bit address is used and
> downshifted by two. The manual references it as:
> 
> SI_ADDR = (REG_ADDR & 0x00FFFFFF) >> 2;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: add configurable downshift for addresses
      commit: 86fc59ef818beb0e1945d17f8e734898baba7e4e
[2/2] regmap: allow a defined reg_base to be added to every address
      commit: 0074f3f2b1e43d3cedd97e47fb6980db6d2ba79e

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
