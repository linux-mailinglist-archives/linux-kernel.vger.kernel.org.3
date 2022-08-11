Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89167590365
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbiHKQWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiHKQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:20:38 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FBAFADB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:02:37 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660233677t7kazeqf
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 12 Aug 2022 00:01:12 +0800 (CST)
X-QQ-SSF: 0100000000000080H000000A0000020
X-QQ-FEAT: ILHsT53NKPgyimJccMYtRICob5h5v4gBQ1pwz09xH1r8vp6AzRaN7xxiRXs3V
        HEqsS4oVFnTccMV9E48O1NHXafi6/CPdPa8zhywonBGhS+vNZzH4cCOHLgx7ZlQuZ8kdvOg
        OQjSZ1LSOITlj2UVTrUox6FprR70VCs7gYcvzsna8EMWWRCErQF3dEygakf2klPoXcTca7Q
        vYJsI80hW1tgktE+00RTOSf7hhdFqUTsep6tny/bJJcKq2ObskAbpFD6r4NtpcBoxV07b1i
        pPovhB1Hq59u1XYJOLOjyZ+5JhjCOz1G64mJG0y+ve/BBN9gBcpSCdWhew67HEgP2YCQt4j
        tbVpaEnvQphGiXMn/I=
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] drm/ttm: Fix comment typo
Date:   Fri, 12 Aug 2022 00:01:00 +0800
Message-Id: <20220811160100.13798-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `sure' is duplicated in line 454, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 7bc99b1279f7..2e9349e01e8e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -450,7 +450,7 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 	}
 
 	/*
-	 * If we don't track dirty using the MKWRITE method, make sure
+	 * If we don't track dirty using the MKWRITE method, make
 	 * sure the page protection is write-enabled so we don't get
 	 * a lot of unnecessary write faults.
 	 */
-- 
2.17.1

