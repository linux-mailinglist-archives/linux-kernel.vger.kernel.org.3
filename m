Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD059BF7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiHVM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHVM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:29:40 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD1193F7;
        Mon, 22 Aug 2022 05:29:37 -0700 (PDT)
X-QQ-mid: bizesmtp65t1661171371tgy84c75
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:29:30 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: zT6n3Y95oi325WtJj3R+SAq78BhD123Pjf1olfHwihXH6EieLG7XutwC4Ci5J
        2OBvRBswhvzmkAEba6PpN9tOLc+a3E+w35NJejze5Sze8Lh6XG2tcvmH2G94rS9s0PWlOR9
        HKT8inG0zOdcjRT5pg0CN38qpu5OmChzNCY43kxFllDaHikLkutrx+hJ2qJ7br9nVaYpy2l
        pfEg8z3hwnHewUBFhDDRNzTBtAENawIQWRcdi1L4OSSJivmK4ozodpfWMHIYBCih09HCQ8W
        1D0xaKB6vTFBk345ucPrdzqxGJhPpfYaOh+w14zfrDZnshtW6rZXIKO+9hiVi7BIZO2qhmT
        DLUMitEW9aa5tQV4wFK9b2/KeT1LEOhi6bmIJ6wmvB9pIpeX5I7On0csUWXukMhMgll7qrB
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/thunderbolt: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:29:21 +0800
Message-Id: <20220822122921.26437-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?43.154.54.12>]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/thunderbolt/ctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/ctl.h b/drivers/thunderbolt/ctl.h
index e8c64898dfce..7c7d80f96c0c 100644
--- a/drivers/thunderbolt/ctl.h
+++ b/drivers/thunderbolt/ctl.h
@@ -35,7 +35,7 @@ struct tb_cfg_result {
 			    * If err = 1 then this is the port that send the
 			    * error.
 			    * If err = 0 and if this was a cfg_read/write then
-			    * this is the the upstream port of the responding
+			    * this is the upstream port of the responding
 			    * switch.
 			    * Otherwise the field is set to zero.
 			    */
-- 
2.36.1

