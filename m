Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9745B1C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiIHMTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIHMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:19:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718FEE72D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:19:12 -0700 (PDT)
X-QQ-mid: bizesmtp68t1662639548tz9rdjfz
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:19:08 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: bYR630AeiPi9DCPyOQiyNnr2fpcz0pvLDYrXOJwgx6fCXQnF8UiNsnSA62kAF
        /0Z+SoXcpPJ50MGvXZawNl0+P8DCNE3lxFvsrmInlWnzwfr54xdxpYCrsutiZzQa+iUvEtV
        oN1az1jNbw+iBtGTIh9+MIEDl4Bh4vhPbjG+0nWgSKoGStlf3u92NTA8m99onPNzRhgk8Uu
        hDVjtczAhgAFfdgXLupQ+2YAGnrHS719HybtMhsKn/qMSWZCoJfHWEFxAF0FfOUk7PnZn3P
        DJxVLvSA9cUM0PqtIXYBtc9LZLWJbvacZzXVlrN23hmE8NqVVy/WfO65n30vc/3zL4VWzU1
        WG0AxHgFhvsFkCDEtjwUv0KOT+j3X86vdCZ9741mu2ru7C+r78=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] fs/romfs: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:18:56 +0800
Message-Id: <20220908121856.8589-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 fs/romfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b4..4794d65c995d 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -41,7 +41,7 @@
  *					  dentries in lookup
  *					clean up page flags setting
  *					  (error, uptodate, locking) in
- *					  in read_folio
+ *					  read_folio
  *					use init_special_inode for
  *					  fifos/sockets (and streamline) in
  *					  read_inode, fix _ops table order
-- 
2.36.1

