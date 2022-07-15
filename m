Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A75782C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiGRMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGRMvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:51:40 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861276339;
        Mon, 18 Jul 2022 05:51:35 -0700 (PDT)
X-QQ-mid: bizesmtp62t1658148675t65hmxy8
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:51:13 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000000
X-QQ-FEAT: DoD8xN2rKow5rkGmDF4e6qEv2N+kzmuS/CsbsKnen9LCGciXeKXBAkEkjGXzn
        kLIYQmQEnHHPaGU7lj1gBwclHD7Cq11CkjySJ+hp/klM3TW0kWFvxBtQhVbb/B6CV4bm+Gj
        P3Xi6Gw9HjE/MD5J9deOcf5oM+5Qq9qCcsj/nugyuCH47r/FhppPiMC73CS8Vu7aXTv6102
        C32DTGvI637He9Ooy//8X1qXQr30Os1cMHrPg5/Ecs+6zYcjtnTVvFxOun4mEn+Y5G9xcov
        oMBfIt9AIRp3ostERXGArsQtU8kqEaCbZFjifwiY0JiovGPQu+8pM+e3H765VKBY2x1+NxI
        /g/qpWMN9JaGCPDrcUaXmPk+ShPtkEUCIo6L9e2EF5eTmwwGwnKh9HBNywP6bNfhlCnW0nm
        iaEQXGot0/k=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     deller@gmx.de
Cc:     James.Bottomley@HansenPartnership.com, dave.anglin@bell.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au,
        rmk+kernel@armlinux.org.uk, peterx@redhat.com,
        zhengqi.arch@bytedance.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] mm: Fix comment typo
Date:   Fri, 15 Jul 2022 12:49:15 +0800
Message-Id: <20220715044915.21077-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in line 41, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/parisc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 9ad80d4d3389..869204e97ec9 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -38,7 +38,7 @@ int show_unhandled_signals = 1;
 /*
  * parisc_acctyp(unsigned int inst) --
  *    Given a PA-RISC memory access instruction, determine if the
- *    the instruction would perform a memory read or memory write
+ *    instruction would perform a memory read or memory write
  *    operation.
  *
  *    This function assumes that the given instruction is a memory access
-- 
2.35.1

