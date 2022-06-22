Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD555418A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356868AbiFVEVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356836AbiFVEVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:21:46 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6737654;
        Tue, 21 Jun 2022 21:21:41 -0700 (PDT)
X-QQ-mid: bizesmtp80t1655871674tzpd9dy0
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 12:21:10 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: ArfJXynxbT1uXABXlykhqfjVcC9+bIBOVONNwN3WyHigVLDsSmf88mOeQ2HT1
        U55QAVx5d9Z2B33tRC+0PR2qPSH9nikzCxBcWsJHHoXf1jR4uBnyiG28g0JdSEQxJbb5EDu
        2+LUTNM4XlzhUX9ydtDludZhC8ZEMnp5ra/D5R3WavQdqCnRKkCDagx2S3wKzZaz36EbHH2
        tZYKhyEvbQEP64tDhMbCG1hpOhGtvPgsC0yy8b64ZjpfslG42jEHE/hv1sid36qqp9P0+Lu
        6cNGu/YhUKyRFXmUeZ0CAJQ5Wnaq9qacqtkaOdzMiNIWPMUV7KHkZCenKx4ekjPM+3y3hD6
        Vat9mlK3sqFg3OpTzIqkB30xiXFBA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     artur.paszkiewicz@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: isci: Remove duplicate 'the'
Date:   Wed, 22 Jun 2022 12:21:07 +0800
Message-Id: <20220622042107.9069-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an obvious typing error, found by spellcheck(1).

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/isci/host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/host.h b/drivers/scsi/isci/host.h
index 6bc3f022630a..64e4759f25d7 100644
--- a/drivers/scsi/isci/host.h
+++ b/drivers/scsi/isci/host.h
@@ -244,7 +244,7 @@ enum sci_controller_states {
 	SCIC_INITIALIZED,
 
 	/**
-	 * This state indicates the the controller is in the process of becoming
+	 * This state indicates the controller is in the process of becoming
 	 * ready (i.e. starting).  In this state no new IO operations are permitted.
 	 * This state is entered from the INITIALIZED state.
 	 */
-- 
2.17.1

