Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84559BF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiHVMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiHVMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:15:37 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B221E2F009;
        Mon, 22 Aug 2022 05:15:34 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661170507t880wh30
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:15:05 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: /rrU+puPB7Q5buPq1+M8oaz3Bq6YwZZRDTWvvdwm6oGCfZP5AXY7eTvHBMQIR
        J/rXVNBkRjy39pjT5d4PDcjzXZY3NKFk9gFWOA3x2IkJvuc1mOrFd2sE9aa6j+PJnmYmDFI
        tU1oYxwzpMvpFSMNzcam2vnnP15Cox5MeE90qcEZ3GCf1cqFd3RS7DVmG8WVh0Lu/zKblPl
        sKuqQJMmVWF3Lz4szgxF8ImQqEawq2tT0EviPRRMBX01ffnsfxcCcm+qUcJpNoZM63OHfXT
        CaaPTOjbpXWA+G8eLlFPWcUgAatV7zKoyAfsG/nRY04+40B7CEoDgPN4DaznM31ka3AJKnN
        1DhqnDlmQP7eJDUgTqlp5QYex1axvDK6OmnGs4I2INshdNziUmJ68xxVs61H7rYaiKLvWnM
        tpVR1th89IE=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        colin.king@intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] serial/jsm: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:14:57 +0800
Message-Id: <20220822121457.21004-1-yuanjilin@cdjrlc.com>
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
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
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

 Delete the redundant word 'way'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/tty/serial/jsm/jsm_cls.c | 2 +-
 drivers/tty/serial/jsm/jsm_neo.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 3fd57ac3ad81..8c2f0038db53 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -403,7 +403,7 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		/*
 		 * If our queue is full, we have no choice but to drop some
 		 * data. The assumption is that HWFLOW or SWFLOW should have
-		 * stopped things way way before we got to this point.
+		 * stopped things way before we got to this point.
 		 *
 		 * I decided that I wanted to ditch the oldest data first,
 		 * I hope thats okay with everyone? Yes? Good.
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 0c78f66276cd..e12dcb5f03ec 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -433,7 +433,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		/*
 		 * If our queue is full, we have no choice but to drop some data.
 		 * The assumption is that HWFLOW or SWFLOW should have stopped
-		 * things way way before we got to this point.
+		 * things way before we got to this point.
 		 *
 		 * I decided that I wanted to ditch the oldest data first,
 		 * I hope thats okay with everyone? Yes? Good.
-- 
2.36.1

