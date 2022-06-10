Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D5545F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347926AbiFJIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346744AbiFJIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:38:07 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1293527DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:35:43 -0700 (PDT)
X-QQ-mid: bizesmtp68t1654850070tsk9ifn1
Received: from localhost.localdomain ( [182.148.15.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 10 Jun 2022 16:34:27 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: F3yR32iATbgOB8wqhUV9BP/WtpcdVhsEfUxADbPpeAa1mrfAo0aemA8czVNVN
        +82aspKj6Y/HwxXonqJYZtcnewc+iOWKcASMeVoEG06sLCjxYoOFllLG4r/1uYKnX04jmHj
        D08f53306nE3Ili9cMG9SA3le0+wL5r1ZsmCnDzrl6I0PmGXq0HA0YGiMlMvgk6bVVy9Znl
        kgv1lwS/0eE1ytBQhIEbV2cIXc2tlKn2ZjBNkg9AHpQJd+8M9LVOorGLc8NcZhCt84yjSsQ
        w8LYoQ5QFSPXuny37Nb0eH8YtWnR8B7QzqZs0GrO78qONOTj7BdCnAG/pO+TZRFtyC+0K1I
        Lltim1yGex1F04g9AXu2769nbnrag==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     geert@linux-m68k.org
Cc:     funaho@jurai.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v2] m68k: Fix syntax errors in comments
Date:   Fri, 10 Jun 2022 16:34:20 +0800
Message-Id: <20220610083420.30214-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

comments "the the" should be replaced by "of the" instead.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
Changes since v1
*Change comments "the the" to "of the"

 arch/m68k/coldfire/intc-2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/intc-2.c b/arch/m68k/coldfire/intc-2.c
index 995093357c59..f74f0e473119 100644
--- a/arch/m68k/coldfire/intc-2.c
+++ b/arch/m68k/coldfire/intc-2.c
@@ -7,7 +7,7 @@
  * family, the 5270, 5271, 5274, 5275, and the 528x family which have two such
  * controllers, and the 547x and 548x families which have only one of them.
  *
- * The external 7 fixed interrupts are part the the Edge Port unit of these
+ * The external 7 fixed interrupts are part of the Edge Port unit of these
  * ColdFire parts. They can be configured as level or edge triggered.
  *
  * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>
-- 
2.36.1

