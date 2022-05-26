Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591C653553C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbiEZU47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbiEZU44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:56:56 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC446A066
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:56:53 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nuKXJ-0006ZH-B6; Thu, 26 May 2022 22:56:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 0/5] riscv: some svpbmt fixes
Date:   Thu, 26 May 2022 22:56:41 +0200
Message-Id: <20220526205646.258337-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some additionals comments and notes from autobuilders received
after the series got applied, warranted some changes.

So this is a small collection of cleanups for the svpbmt v10 series.

changes in v2:
- add Guo's Review
- add patch dropping the use of function pointers in code
  that can run before relocation

Heiko Stuebner (5):
  riscv: drop cpufeature_apply_feature tracking variable
  riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol
  riscv: make patch-function pointer more generic in
    cpu_manufacturer_info struct
  riscv: fix dependency for t-head errata
  riscv: remove usage of function-pointers from cpufeatures and t-head
    errata

 arch/riscv/Kconfig               |  9 ++++++--
 arch/riscv/Kconfig.erratas       |  1 +
 arch/riscv/errata/thead/errata.c | 38 ++++++++++----------------------
 arch/riscv/kernel/alternative.c  | 18 +++++++--------
 arch/riscv/kernel/cpufeature.c   | 37 +++++++++----------------------
 5 files changed, 40 insertions(+), 63 deletions(-)

-- 
2.35.1

