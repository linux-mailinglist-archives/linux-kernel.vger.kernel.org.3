Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6259B4D9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiHUPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiHUPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:09:54 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8AF2253C;
        Sun, 21 Aug 2022 08:09:52 -0700 (PDT)
X-QQ-mid: bizesmtp87t1661094585tylogl59
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:09:44 +0800 (CST)
X-QQ-SSF: 0100000000200010B000B00A0000000
X-QQ-FEAT: zT6n3Y95oi2SlWqB1OW3bb89aDWY8dXwiD8N+oi6EAvlVRDdAR5lcPNu6Nsyn
        owKWQGbga7pWiMBW9l6JYMt+gBVHwEZS86UXKTYl+rcOlSBoX5u+PTxKJDtU2PREnW9v7WT
        tCMIrREkp2D5eTn9d/qCKfYXoJkja1dcEwbWjzdaD6hL1HvqaG0Wi/8Qs54TbNgAMurNW6V
        dhp0mFqcTZphNF4CVHTiPINTbXxrLOcHHv2odGIlah6G59IQi9Zw1Ov0Y6EgpZNsTJqrA6+
        i8l6xYMz0ppJi5D7iQ1ELxVR+TP5r/DdgJBz4nYTQVbklHkzImUzMV8j4M4I7hz2BtFuOcn
        5O8PxF34YsrFntMmTe4ZCsouqctPAShXA18FcDVm7Q2nNYocTA=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] atomisp/pci: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:09:37 +0800
Message-Id: <20220821150937.53934-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/staging/media/atomisp/pci/isp2400_input_system_public.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h b/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h
index 85cb61e34192..19a00d569398 100644
--- a/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h
+++ b/drivers/staging/media/atomisp/pci/isp2400_input_system_public.h
@@ -200,7 +200,7 @@ STORAGE_CLASS_INPUT_SYSTEM_H void receiver_port_reg_store(
     const hrt_address			reg,
     const hrt_data				value);
 
-/*! Read from a control register PORT[port_ID] of of RECEIVER[ID]
+/*! Read from a control register PORT[port_ID] of RECEIVER[ID]
 
  \param	ID[in]				RECEIVER identifier
  \param	port_ID[in]			mipi PORT identifier
-- 
2.36.1

