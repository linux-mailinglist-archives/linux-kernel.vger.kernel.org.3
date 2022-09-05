Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD25AD166
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiIELKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiIELKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:10:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB97354C8E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:10:43 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oV9zw-0005hc-FZ; Mon, 05 Sep 2022 13:10:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     guoren@kernel.org, apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 0/5] Some style cleanups for recent extension additions
Date:   Mon,  5 Sep 2022 13:10:22 +0200
Message-Id: <20220905111027.2463297-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by some people, some parts of the recently added extensions
(svpbmt, zicbom) + t-head errata could use some styling upgrades.

So this series provides these.

changes in v2:
- add patch also converting cpufeature probe to BIT()
- update commit message in patch1 (Conor)

Heiko Stuebner (5):
  riscv: cleanup svpbmt cpufeature probing
  riscv: drop some idefs from CMO initialization
  riscv: use BIT() macros in t-head errata init
  riscv: use BIT() marco for cpufeature probing
  riscv: check for kernel config option in t-head memory types errata

 arch/riscv/errata/thead/errata.c    | 14 ++++++-----
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 39 ++++++++++++-----------------
 3 files changed, 26 insertions(+), 29 deletions(-)

-- 
2.35.1

