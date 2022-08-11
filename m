Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238045902BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbiHKQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiHKQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:12:01 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565A760DD
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:56:56 -0700 (PDT)
X-QQ-mid: bizesmtp82t1660233403tyl386yp
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:56:35 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: ntUToVEOiWoVPRpveSlZH+C/roA2UqPB/y8XhP4iN2dSWbOjCT0FeQqVlLK8A
        HZ3ArrUUBx0AGwShvtWE4XkltAfd6RtAJVwuXZjkPdrYmzJMT53W8Tp2flCe/vAQNtLtv1B
        g28u0I78SSe7vTJFyHEr1TLkhe2lsCsE8UTgMyyY+DP5+x1zdopURsF1h6e+hsDMtROJ024
        HkoZNwuhkjP8XaAfMqVfeZ0oXYjOZc/d6x5RrlcgBJAHNrYVBfVnrrvUz8yUJIVN48g/roZ
        aor7wL8N862bQNzi5ljMuoyiw/lpIxRETahGJSnKsJAwIObGGWe7sdNBr3x/weIN+ZQCVku
        /iX/0Me1XZzVyrvW0TNaLGsN8T5XS30D9Oqjc8NYE2LUADxR2XO1CRpCOIssB0hLewCc6z2
        m0H1pXQRdMg=
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] drm/vmwgfx: Fix comment typo
Date:   Thu, 11 Aug 2022 23:56:23 +0800
Message-Id: <20220811155623.13661-1-tangmin@cdjrlc.com>
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

The double `should' is duplicated in line 72, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 1d1c8b82c898..7c04e8150fe2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -69,7 +69,7 @@ struct vmw_du_update_plane {
 	 *
 	 * Some surface resource or buffer object need some extra cmd submission
 	 * like update GB image for proxy surface and define a GMRFB for screen
-	 * object. That should should be done here as this callback will be
+	 * object. That should be done here as this callback will be
 	 * called after FIFO allocation with the address of command buufer.
 	 *
 	 * This callback is optional.
-- 
2.17.1


