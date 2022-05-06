Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE051D3E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390325AbiEFJDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390319AbiEFJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C863519;
        Fri,  6 May 2022 01:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC8DE61E96;
        Fri,  6 May 2022 08:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13532C385A8;
        Fri,  6 May 2022 08:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651827568;
        bh=RSgyh1edbxv41R8KaczXs+zvimId815zdsaJMTtRlaA=;
        h=From:To:Cc:Subject:Date:From;
        b=OzELTSBQTZ3aGmsJSJVDrWBESih/7DYm7dMBHg5Xf/jpKvgV59xjVN/E3Jfk1z6xH
         TBzTinF274HkiV/4t+59Ww3M8kiWhF1HFfhyh7ZuGORhEJjHXsS7Qw/HEy44gPlKl3
         uq0n+H4O326SBNQC/xrh2IHGNKaR59D7rKq8b18tGCE4SL4zl6VEMmtSN9mc+w4xOM
         A2veNBayOMpTst55AicsS5jGTpc8hYF5uYe8M1s1+T+Oeyjy5Z34vNHObBf1V9ik+f
         RFJWtRN7I36C7HivyENbVYC4EQ44rA/pllB6r6PGR6YhhADzmZnVmqB8wRvHQniSiG
         FgZS5suwOJYdg==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fix for 5.18-rc
Date:   Fri,  6 May 2022 11:59:23 +0300
Message-Id: <20220506085923.23816-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains one more fix for the current cycle. The
details are in the signed tag. It has been in linux-next during the
last few days. Please pull into char-misc-linus when possible.

Thanks,
Georgi

The following changes since commit 2fb251c265608636fc961b7d38e1a03937e57371:

  interconnect: qcom: sdx55: Drop IP0 interconnects (2022-04-14 09:47:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.18-rc6

for you to fetch changes up to 20ce30fb4750f2ffc130cdcb26232b1dd87cd0a5:

  interconnect: Restore sync state by ignoring ipa-virt in provider count (2022-05-03 22:24:21 +0300)

----------------------------------------------------------------
interconnect fixes for v5.18-rc

This contains an additional fix for sc7180 and sdx55 platforms that helps
them to enter suspend even on devices that don't have the most recent DT
changes.

- interconnect: Restore sync state by ignoring ipa-virt in provider count

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Stephen Boyd (1):
      interconnect: Restore sync state by ignoring ipa-virt in provider count

 drivers/interconnect/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
