Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6C59E83D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiHWRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbiHWQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:58:58 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939919E0E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:15:00 -0700 (PDT)
X-QQ-mid: bizesmtp71t1661264077t2rkxezi
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:14:36 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: ILHsT53NKPjxA3QUZ9443L6fJYtCysqDGp9BXbgtj0Cl63dZj5uG64ljGVgft
        RZfQip6bWFR2Gfo+tVqZEOs5H0zRPwdaJHYD5qzETmgwU9/jS5RVikRPKhqQbeEvmgDZJUd
        Y4+otmSNh8zyccLJl2ACciZrnj+x0HfwgevgVe5r9BQu0PU8xbJZA21gfeg7Uhs1fvrOk2x
        WXhpF9bpaq3dfFWkEmj2lI+01KvbDA3XDBkF86b/+gpN+FLavewBSmoNc+yfIBeH/e6/Q3P
        rPagfR1D4AAu3I0hjeBr1uI9bsFu1KPVEtH2tjCpz+wJjrcC7oRVeYOgJzwELcTRLyvJ3RZ
        YxeQPsqbmnuMkULJp6FV51kolBHeAZGMze1D3k+g+PfH4At/AVwNEOKJEvzZw==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] i915/display: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:14:29 +0800
Message-Id: <20220823141429.11598-1-wangjianli@cdjrlc.com>
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

 Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/i915/display/intel_crt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
index 6a3893c8ff22..fead011c87b5 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.c
+++ b/drivers/gpu/drm/i915/display/intel_crt.c
@@ -1102,7 +1102,7 @@ void intel_crt_init(struct drm_i915_private *dev_priv)
 	drm_connector_helper_add(connector, &intel_crt_connector_helper_funcs);
 
 	/*
-	 * TODO: find a proper way to discover whether we need to set the the
+	 * TODO: find a proper way to discover whether we need to set the
 	 * polarity and link reversal bits or not, instead of relying on the
 	 * BIOS.
 	 */
-- 
2.36.1

