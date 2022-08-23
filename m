Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828B59E8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiHWRNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345183AbiHWRLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:11:40 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE914AED5;
        Tue, 23 Aug 2022 06:56:31 -0700 (PDT)
X-QQ-mid: bizesmtp79t1661262841tpfcwc0s
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:53:59 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: UMQM+3VOEYswySdPdmcuBIq8Lxprx4yh6Nu/SkjK0qCZp7D+keDzhUzeQJi8t
        C6IOyfPmERvsAYe90iCLT8IX3BuUMWCkJS2Xad2NJHVV9He0Ahf5bhGO5zPSHkb4THLzBjm
        VeABar7wRN5X8wgUxf6CA64O8WgomJX99Ske0v7bJT4JESqIxq+rP7eSrgP/n/zWVKw4S2s
        g3LkOKjzx7k8Y5KHQhu3jVuT6cODxytqoZj51m2XA8Ar1rMZXLrSNU+gOwDPi7+v1lV0dwe
        UlH9qE6rycrSyPGOOMJpFp5zPlCM5zChzqdm3Yf6aB7m/dx5PtBhoJw8BnzoCyy6HZeX36a
        tPDI7FMyT5Q5lmsVn80qY1fQZbbP1psPjCkAIsCIZt4hroGc4u0BoEnUXzGN/YndZBntgcK
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] marvell/octeontx: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:53:53 +0800
Message-Id: <20220823135353.63767-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'is'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
index b8bdb9f134f3..205eacac4a34 100644
--- a/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
+++ b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
@@ -403,7 +403,7 @@ union otx_cptx_pf_exe_bist_status {
  *	big-endian format in memory.
  *  iqb_ldwb:1 [7:7](R/W) Instruction load don't write back.
  *	0 = The hardware issues NCB transient load (LDT) towards the cache,
- *	which if the line hits and is is dirty will cause the line to be
+ *	which if the line hits and is dirty will cause the line to be
  *	written back before being replaced.
  *	1 = The hardware issues NCB LDWB read-and-invalidate command towards
  *	the cache when fetching the last word of instructions; as a result the
-- 
2.36.1

