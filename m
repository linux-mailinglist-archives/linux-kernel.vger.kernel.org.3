Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFAA5B1CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiIHMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiIHMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:21:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C6F5C76
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E556CE1F29
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E690C433D6;
        Thu,  8 Sep 2022 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662639660;
        bh=R8UfrDpDouHJ1MsY5QXY59Z1WV4i3w4cWc+dtHbs1MY=;
        h=From:To:Cc:Subject:Date:From;
        b=lz/ajbyjGBkp2jzECnPQ4kEtZ7GUL/P+H+rks2S8FiXpOj3mQXKMu2mTrTvLfGnNh
         NTVHSiJIV+8ZKm4cR/bwVQLXBxFb6ngxI7DT7If6FDnwCC5U8jwcaMgAlicnV2tYBH
         wsJGdSpOmdNoBAKqiJ5158QObMcTMHRvKZ+2XNJKkpBbu/Hv1APF+lwMXbX1TOr7tA
         b5CUErdO7Jf9rN/YZakwPDwKi03dZCDXktYRMESMAwKk78Fwt8saCTpJCRenSFhw9C
         m3aB9LTp2SP160Trd6xxxad44nwi/M0QdxF+3+cEwdMKdnLwT90kOlaOQ88xt6iusD
         9xpK2aWkYazrg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.0-rc4
Date:   Thu, 08 Sep 2022 13:20:50 +0100
Message-Id: <20220908122100.1E690C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.0-rc4

for you to fetch changes up to f5723cfc01932c7a8d5c78dbf7e067e537c91439:

  regmap: spi: Reserve space for register address/padding (2022-08-18 15:02:05 +0100)

----------------------------------------------------------------
regmap: Fix for v6.0

A fix for how we handle controller constraints on SPI message sizes,
only impacting systems with SPI controllers with very low limits like
the AMD controller used in the Steam Deck.

----------------------------------------------------------------
Cristian Ciocaltea (1):
      regmap: spi: Reserve space for register address/padding

 drivers/base/regmap/regmap-spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)
