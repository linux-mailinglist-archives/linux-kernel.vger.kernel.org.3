Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9F959E882
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbiHWRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiHWRBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:01:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B658C002
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:10:52 -0700 (PDT)
X-QQ-mid: bizesmtp80t1661263838ta9jzgkz
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:10:37 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: znfcQSa1hKb69ljbhEMCIyJVqJcyVDLGX2/wMAZJUY1itMbUtF3rvuqdmNYTv
        dH2/ZQcgOvUGUQ7+ffjWegXeRgahSEt5NOMaSUu/aYxKiH86qIeHHEKCMHSara3mHa3VWo1
        AmclRh24J4xbRqdasWerfW4sPvDCnvjBT+5v8qYmJTbgmS3UQ86EnDPFs6SamykoJU0Scfh
        SDiRAOEsN/np2wJqk1C3cFL51HfQPUU5FdHf8H1fszzHuoTn6b23Q3347h/lvEvKcSqoYOO
        yrFMclAcPxF0n+Kshj6NDeixVHmC/wjwYyQst7DhKCimsf25tA0yjnYGYdTr3D2e8WT6ZQn
        Pp4y4jLFcRHCiGTpBMOt3ftcvmEz2Zkz/hw0sUzkMJpZH6Qu8dZgnPxHUepCQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/vmwgfx: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:10:30 +0800
Message-Id: <20220823141030.9078-1-wangjianli@cdjrlc.com>
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

 Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index d49de4905efa..23e773222019 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -381,7 +381,7 @@ static int vmw_execbuf_res_noctx_val_add(struct vmw_sw_context *sw_context,
 }
 
 /**
- * vmw_view_res_val_add - Add a view and the surface it's pointing to to the
+ * vmw_view_res_val_add - Add a view and the surface it's pointing to the
  * validation list
  *
  * @sw_context: The software context holding the validation list.
-- 
2.36.1

