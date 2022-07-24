Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5C57F38E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 08:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiGXG7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 02:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXG7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 02:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17913CC9;
        Sat, 23 Jul 2022 23:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3045B60F06;
        Sun, 24 Jul 2022 06:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF70C3411E;
        Sun, 24 Jul 2022 06:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658645950;
        bh=0bzSie0qzgwC5yG2upCpzGwq7ZL0AMvfjZJyIDgHWsU=;
        h=From:To:Cc:Subject:Date:From;
        b=cyU6aFBUnqQKr5JmNQAjfof3PL05+k7V51ZduPJoPXTm+X8sFhXxpTOx7d5Ria/v8
         s9OXDmfyp6DDXEuQkxpF/v7lFoGO+rqhpT/kud3qwuZ8mSFBq0BGxdT9SpqpNU3ykA
         hkaMecAW6b4yI6UQlYe68Aq4f/M7wwiQ+ZIQ1ZZ3tL31hd1vPnWZhH9HNdtZg2ETTl
         K5IfIMvV5tjpgIfivkcyBsZVV2C3l+PBa11MI4voCnVUhM/CrACuS2raIRyHhaY/Ap
         +zwKnBQ5ebF+iek3XajfnO3MQct9+musKgcb2+Zwyv+9zGlmPip+DxynD1cmZaTyqv
         DBqAq/wJgFw1A==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.19-rc7
Date:   Sat, 23 Jul 2022 23:59:09 -0700
Message-Id: <20220724065909.1484190-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a79e69c8714f416bd324952d06d1dd7bce3f35bf:

  MAINTAINERS: add include/dt-bindings/clock to COMMON CLK FRAMEWORK (2022-06-15 17:19:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 25c2a075eb6a3031813b6051bd10dfc22c36a2a4:

  clk: lan966x: Fix the lan966x clock gate register address (2022-07-19 00:04:10 -0700)

----------------------------------------------------------------
One more fix to set the correct IO mapping for a clk gate in the lan966x
driver.

----------------------------------------------------------------
Herve Codina (1):
      clk: lan966x: Fix the lan966x clock gate register address

 drivers/clk/clk-lan966x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
