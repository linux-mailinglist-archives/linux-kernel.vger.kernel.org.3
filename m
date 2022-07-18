Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149125782B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiGRMtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiGRMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:49:37 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208960DC;
        Mon, 18 Jul 2022 05:49:31 -0700 (PDT)
X-QQ-mid: bizesmtp81t1658148567tcl5iv99
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:49:11 +0800 (CST)
X-QQ-SSF: 0100000000600020C000000A0000020
X-QQ-FEAT: w7IG6bg2XpkbdaEd/YpMJwtHqnOmLvCaC899yerFVCv9VtTdrojPT631bBG/F
        oCcmv9jjKSOK8EOhnjhb7n+TExGIfo+R5FsH85CPsbz44mp4TRlvyrPpTkY2RpgOVtlMNeA
        ZhRUKAUXvNSk0GzgGGejFGbdfSgkNzw10OH+NN7+3+HD1gmO9LdZcS5WVkLofMIzMFGpdcP
        K4A4z/oelZgA8ZTIxBZMsoxTdS64wtuZDOkxz74SUV4xxfVjzuvuKD7GAqmzMb90YyniosO
        bPRo21uKMs+cY7+2ugEoj0b6/gUz45dnAHZb4Ga8o7wfmAgIjN1e0/pLHGOEBbcRag5Ai76
        6kcY9qn6JTnBYUvMQD2AVVi51lUlEd5SYC/SblsCAEFlZrZAu4aUA5ASMiyvQ==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     srinivas.pandruvada@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] tools/power/x86/intel-speed-select:Unneeded semicolon
Date:   Mon, 18 Jul 2022 20:49:07 +0800
Message-Id: <20220718124907.7254-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unneeded semicolon

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/power/x86/intel-speed-select/hfi-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/hfi-events.c b/tools/power/x86/intel-speed-select/hfi-events.c
index 761375062505..f0ed69721308 100644
--- a/tools/power/x86/intel-speed-select/hfi-events.c
+++ b/tools/power/x86/intel-speed-select/hfi-events.c
@@ -144,7 +144,7 @@ static int family_handler(struct nl_msg *msg, void *arg)
 			continue;
 		res->id = nla_get_u32(tb2[CTRL_ATTR_MCAST_GRP_ID]);
 		break;
-	};
+	}
 
 	return 0;
 }
-- 
2.30.2

