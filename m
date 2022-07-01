Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EBE5628CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiGACOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiGACOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22A5725D;
        Thu, 30 Jun 2022 19:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264E96202D;
        Fri,  1 Jul 2022 02:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60767C34115;
        Fri,  1 Jul 2022 02:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656641654;
        bh=hCL50FeUhLI4fWeZpWTEjBv/SYSkzqVnH30jItVr29s=;
        h=From:To:Cc:Subject:Date:From;
        b=R0RVEzRI6uqSZpnOzuG8sTo/i8/1/kgxhZZ/OpvdT7UvyUF3BxpGssuqHVE684Tg2
         jeKI5OqhdQjFj+scAKy5QIjLfSuRl+LXMAt4CVFRrOlG6c4rdthu9S9/tyEM3fEIbp
         8HCU7KlTLKp5q7kt1Dkou0k46k+cP/mwvjKXjDNQupYCg2xH9qmxMrbf41ETrZQBmp
         E5IjWVSFgpZw+HGJCiTxuKV4EA7GMe1CDLYVo2KsdTOhj2TzpFPU+mVtDR7gPMhpId
         AZ+05UGiVqbFLYfAm+xQM54nnyA2mlLrkTbSm0zI4MANFhnIZlwnlQFWVCfh9F4jG2
         YDzZYFCKvrMiw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.19-rc5
Date:   Thu, 30 Jun 2022 19:14:13 -0700
Message-Id: <20220701021413.276395-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
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

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to a79e69c8714f416bd324952d06d1dd7bce3f35bf:

  MAINTAINERS: add include/dt-bindings/clock to COMMON CLK FRAMEWORK (2022-06-15 17:19:02 -0700)

----------------------------------------------------------------
Two small fixes

 - Initialize a spinlock in the stm32 reset code
 - Add dt bindings to the clk maintainer filepattern

----------------------------------------------------------------
Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/clock to COMMON CLK FRAMEWORK

Wei Yongjun (1):
      clk: stm32: rcc_reset: Fix missing spin_lock_init()

 MAINTAINERS                     | 1 +
 drivers/clk/stm32/reset-stm32.c | 1 +
 2 files changed, 2 insertions(+)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
