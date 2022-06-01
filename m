Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA7539F02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbiFAIH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiFAIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD511A828;
        Wed,  1 Jun 2022 01:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC47D61454;
        Wed,  1 Jun 2022 08:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1672C385A5;
        Wed,  1 Jun 2022 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654070870;
        bh=2KmGbkpwU3u5Yd1FSJSVbte6vIGfMkEX7rpJCofVneM=;
        h=From:To:Cc:Subject:Date:From;
        b=fnDR70aiXoQ5qgtzgp4j9JcKZxyXSYfB1gNgDX9kISfkIeh/TDhSgSv3SgwqrhMrV
         cVGBCqs4jrOCwoq05urtLv4UfSXBHwyxBCEcOgKdzRXSM+aGm74cJDmnlKDgefFPTl
         M0gtXkbNUQY/paL6p/w8EatWA49MHhhnm4sOw2A127TSlXrQ7uPWAajL5e2SOVlStS
         Cj6WsXKa2BD7fVZBknc/Xx5WaGsoDkdb01w89T8sxtHT4U+nm8/8HLd+JntnULP/kA
         XaW3VWTXG7DQYe2lrf7ZkQvcacr6HhlhnfHe/AHBrHTr9f60FDNoHZ3sx9x6hdskhp
         URNHbIHOdb6Eg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.19-rc0
Date:   Wed, 01 Jun 2022 10:07:46 +0200
Message-Id: <20220601080749.B1672C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9c63b846e6df43e5b3d31263f7db545f32deeda3:

  spi: spi-mem: Convert Aspeed SMC driver to spi-mem (2022-05-16 19:38:40 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc0

for you to fetch changes up to ebf2a3521738520e12849b221fea24928b3f61ff:

  spi: core: Display return code when failing to transfer message (2022-05-26 14:43:29 +0100)

----------------------------------------------------------------
spi: Fixes for v5.19

A couple of fixes that came in during the merge window, a driver
fix for spurious timeouts in the fsi driver and an improvement to
make the core display error messages for transfer_one_message()
to help people debug things.

----------------------------------------------------------------
Eddie James (2):
      spi: fsi: Fix spurious timeout
      spi: core: Display return code when failing to transfer message

 drivers/spi/spi-fsi.c | 12 ++++++------
 drivers/spi/spi.c     |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)
