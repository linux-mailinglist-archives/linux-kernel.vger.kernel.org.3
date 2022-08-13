Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9244E591B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiHMPRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiHMPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:16:59 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127B13F93;
        Sat, 13 Aug 2022 08:16:53 -0700 (PDT)
X-QQ-mid: bizesmtp74t1660403795twerpap8
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:16:28 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: DRnj/z+Sqac7eaaRnRxjohl0DEvoOesJDpkPKa5FAiUeCIb4HB4wRQobyKARc
        2u+3PVZtiijWZKitdsaVoddTICob6JL/nXE4UWivOeUdM7x8N4dpy7bz7LH9RKmBLCJBW6K
        RREVCUsjGcsmpzf54Ur9zgspPaB8cgvxCEtbjJUdA+IvMCFeOj1VdCSrfJ8tRQ/HJZLXJRL
        bmoZTZYSRxZReH0vbmnl1tHXZ+r2nQJ2NObg92HN+G+NhbR6n7ysmYA6q0DMz7VNZN//p+L
        A9zKhfcPkMGYP4duw4yLuEFtH32np6SoL5RUnRdfRpCNiYrf4M/T45q9AmJzIXvRMNOF7Ay
        21zLIE84pSggkGo3SrGIu/Fhf1mfUk16ICswMPbkYhRpq4hE6EmjWmdIoji8A==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        srinivas.pandruvada@linux.intel.com
Cc:     dan.carpenter@oracle.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] drm/i915/gt: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:16:16 +0800
Message-Id: <20220813151616.4193-1-tangmin@cdjrlc.com>
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

There is no semicolon after '}' in line 648.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/i915/gt/intel_migrate.c         | 2 +-
 tools/power/x86/intel-speed-select/hfi-events.c | 2 +-
 tools/testing/selftests/timers/nanosleep.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_migrate.c b/drivers/gpu/drm/i915/gt/intel_migrate.c
index 2c35324b5f68..a69b244f14d0 100644
--- a/drivers/gpu/drm/i915/gt/intel_migrate.c
+++ b/drivers/gpu/drm/i915/gt/intel_migrate.c
@@ -645,7 +645,7 @@ static int scatter_list_length(struct scatterlist *sg)
 	while (sg && sg_dma_len(sg)) {
 		len += sg_dma_len(sg);
 		sg = sg_next(sg);
-	};
+	}
 
 	return len;
 }
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
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 71b5441c2fd9..433a09676aeb 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.17.1

