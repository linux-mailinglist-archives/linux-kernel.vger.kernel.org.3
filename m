Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EBD5550AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359798AbiFVQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376477AbiFVQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:03:36 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B591E3DF;
        Wed, 22 Jun 2022 09:03:28 -0700 (PDT)
X-QQ-mid: bizesmtp66t1655913748tr800lv5
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 00:02:23 +0800 (CST)
X-QQ-SSF: 01000000000000B0C000000A0000000
X-QQ-FEAT: YOSTkFbe9CSyz/zu6cMhmhprXNt8fTAqSnfj4q7NBl4jnkj+u1ffUymLkSXp5
        TJU+xp5mPxj90COzqGCwzVLk4mtVIpA879BffJjzzMd8l2iiZxDYGry8jHPW6sGOKnouPnn
        03Uvwj4RyYxjFFWlfPL7+EwSzdjmZugRRx4Owr2BoP/J5NqZeIVQar4iQV30ZZ/hpbdYjWI
        m/NtxfysgkCAyRCjSX3Wm3LUmOTmDed673wZuJuGs/iOPgHKDmSBs+Cev9Kw9I5tVw/qvZO
        7h7LU5n0/BvBP7qB/KjLHlLBSulcxHAgIVR1O61D3G4QWJ
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     gcherian@marvell.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] crypto: cavium - fix typos in comments
Date:   Thu, 23 Jun 2022 00:02:22 +0800
Message-Id: <20220622160222.10753-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'is' with 'it'

file: drivers/crypto/cavium/cpt/cpt_hw_types.h
line: 268

*	which if the line hits and is is dirty will cause the line to be

changed to:
*	which if the line hits and it is dirty will cause the line to be

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/crypto/cavium/cpt/cpt_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/cpt/cpt_hw_types.h b/drivers/crypto/cavium/cpt/cpt_hw_types.h
index 96bc963bb804..8ec6edc69f3f 100644
--- a/drivers/crypto/cavium/cpt/cpt_hw_types.h
+++ b/drivers/crypto/cavium/cpt/cpt_hw_types.h
@@ -265,7 +265,7 @@ union cptx_pf_exe_bist_status {
  *	big-endian format in memory.
  *  iqb_ldwb:1 [7:7](R/W) Instruction load don't write back.
  *	0 = The hardware issues NCB transient load (LDT) towards the cache,
- *	which if the line hits and is is dirty will cause the line to be
+ *	which if the line hits and it is dirty will cause the line to be
  *	written back before being replaced.
  *	1 = The hardware issues NCB LDWB read-and-invalidate command towards
  *	the cache when fetching the last word of instructions; as a result the
-- 
2.17.1

