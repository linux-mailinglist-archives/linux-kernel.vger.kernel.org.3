Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFC5A106E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiHYM24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbiHYM2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:28:41 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C2B2CDA;
        Thu, 25 Aug 2022 05:28:37 -0700 (PDT)
X-QQ-mid: bizesmtp65t1661430511t5hhop1q
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:28:30 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: zT6n3Y95oi3eGr0MMkYqB3kxaKnzlkS5GT+bOs+NBYTVns1qjQqzbDIQMbT1F
        63tMrJD2If/d5eI8IDoj5svIMbrJpJgaw7g3RTuFI+CwEBQZyWoNSKv+j79JH2/I2H+yCSz
        N+aud243pbTjiSYKZ9KTVlqrKtEX5umlf6ovNQO9GwtpLeDg1S9kseqGJqB4ORifAMTVXjB
        rQqDv+fPG5MY5ha+1CGNKcU6zzR2DAemmxM50cxrWl3emoDKlg07pbGvnkgXyJaCM0sgyjl
        4wUCSz1KN+PnINT+qaHL1PrcB69bmszbrw8k8W9EjQCnui89iE5AMJ9N54c1bD/H5CqNszE
        PSKhhkYIL/w4RgBAQKNA2eubaauUk4qwG77TIN1VrbuM8d5tGEj8LJfmptE04ACVtOEGXXn
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] atomisp/pci: fix repeated words in comments
Date:   Thu, 25 Aug 2022 20:28:23 +0800
Message-Id: <20220825122824.42425-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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

