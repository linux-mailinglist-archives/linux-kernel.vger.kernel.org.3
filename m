Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3838B4BAC3F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbiBQWGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:06:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiBQWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:06:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1B403FC;
        Thu, 17 Feb 2022 14:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5351616A4;
        Thu, 17 Feb 2022 22:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C8EC340E8;
        Thu, 17 Feb 2022 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645135555;
        bh=96/Fw31UcvkUe9mnofnlh/ChlXauDqzgFy7oaLF3aZM=;
        h=From:To:Cc:Subject:Date:From;
        b=FWiCDvfwmcMallUZHDFhnKbka8asV/PDmVT8C/6oy4iIpyTX2N+R8ofwj9Tuu3zv3
         1p9JkopDnunU/KKbkCOlHMnTRiobnc3r3xEFMAXuQkHFrfEyITCSqhGrzF8L66oHLj
         a1CDSb4LqsOpVumLocSD5f0uXAW8VuxYFWYC6pDWF9KbnSFZlUnEiP6ZnzpGiQAwcH
         iU9kaL2vmIfZAHKEkrGaDmJ7KbmLdspEPtM1jPbHIDouTgWOVaO7GNhMbC1OIsZfeA
         QD678pIw21r8HafArs48f9v9wU3J2uhPjyMM3WBuYTVbjqS+gUSAqmGmbgubodi3F3
         DS6mPTWfyx4dA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/2] clk: Mark a couple things const
Date:   Thu, 17 Feb 2022 14:05:52 -0800
Message-Id: <20220217220554.2711696-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some spring cleaning.

Stephen Boyd (2):
  clk: Mark 'all_lists' as const
  clk: Mark clk_core_evict_parent_cache_subtree() 'target' const

 drivers/clk/clk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: fa62806ece26d6a7e40e785e5297ecccfffd29a3
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

