Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93758605B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiGaS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiGaS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:28:07 -0400
Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBCBE21
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=697; q=dns/txt; s=iport;
  t=1659292086; x=1660501686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g07U4jFOazJDMyLsG0XmP2+i7PqqWD46ZFjDm4FCS34=;
  b=fifV5D/DJvCw6H1DrwpUEFX82vHlpYsuBDeKIK6EOTd2BrT0w9ANRkeI
   yjG3K+hOC4WHl4dS7aBhoT2L+j1ezVBrO0r2tSiVrMXlIcepHjE9wzhxx
   h4XxlmSMvuTPZT2jzEtk2uQ5YYKiIxGka7B03vjzQcCbhAXLnKZ8tZAKw
   A=;
X-IPAS-Result: =?us-ascii?q?A0C2AADAyOZilxbLJq1aHgEBCxIMggQLg3ssEkWNTIgQn?=
 =?us-ascii?q?HmBfAsBAQEPQgQBAYUGAoR1JjQJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEHBBQBAQEBAQEBAQkbBgwFEDWFdYZDAwMyAUYQIDFXGYJ9gxsDpm2CK4EBi?=
 =?us-ascii?q?gGBPYl5hSc9BoFJRIR9hAuBBoVuBJgFAwkEBwVKRAMLLA8WBQgJFxIQEAIEE?=
 =?us-ascii?q?RoLBgMWPwkCBA4DQAgNAxEEAw8YCRIIEAQGAzEMJQsDFAwBBgMGBQMBAxsDF?=
 =?us-ascii?q?AMFJAcDHA8jDQ0EHx0DAwUlAwICGwcCAgMCBhUGAgI2GDkIBAgEKyMPBQIHL?=
 =?us-ascii?q?wUELwIeBAUGEQgCFgIGBAQEBBYCEAgCCCcXBxMzGQEFWRAJIRwOGhAFBhMDI?=
 =?us-ascii?q?G8FBz4PKDM1PCsfGwqBEiorFQMEBAMCBhgDAyICEC4xAxUGKRMSLQkqdQkCA?=
 =?us-ascii?q?yJtAwMEKi4DCSEfBwkwHZhQgQ6VEK8wg1uffhoxqGeWfKMEhFCBYYIVTSMVg?=
 =?us-ascii?q?yNRGQ+OLA0JjjBCMTsCBgsBAQMJjD6CSAEB?=
IronPort-Data: A9a23:ZQ8vEa6dllKadeyMHVfsPwxRtDbHchMFZxGqfqrLsTDasY5as4F+v
 mcXWDiGOquIMWKjL41xPd6wo0gHsceEyNZrGQE5+38yZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyOa/lH3WlTYhSEUOZugHtIQM8aZfHEqLeNYYH1500g7xLVg2tcAbeWRWmthh
 /uj+6UzB3f9s9JEGjp8B3Wr8U4HUFza4Vv0j3RmDRx5lAa2e0o9UPrzEZqMw07QGeG4KAIVq
 9Hrl9lV9kuBl/sk50jMfrzTKiXmSZaKVeSCZ+Y/t6WK2nB/SiIOPqkTMsIZZE1Z1xuwh9lx7
 P5SmrPsewIwIfiZ8Agde0Ew/yBWNKBcvbTAO3X66IqYzlbNdD3nxPAG4EMeZNJDvL0nRzsWr
 rpCcljhbTjb7w6y6LK2RfVyi8g/BMLqJ4gY/HpnyFk1CN59GsmcH/2UjTNe9A4VvuwNJM/nX
 voIVyd0ME3rQQEWKm5CXfrSm8/x1iWgLFW0smm9p6kw+GnVxSRqzaPgdtHHEvSURN9YhUbep
 X/D9n7RBhAcPcaYjz2f/RqEifXCkiD7cIYTEqCo+Pl3hlGa2m0UDlsRT1TTif24jFOuHtFSM
 UoZ/gIwoqUosk+mVN/wW1u/unHsg/IHc9NdCag78AaX1u/S6hrfDWkfRTkHY9sj3CMredA0/
 lmxmt7jC2BBiaWcSVa26Zi78QG3IDdAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJszHlJd3j6
 2vV83Vm1t3/meZOhvrrpwmW6965jsGRFlZd2+nBYo6yAupEiG+Zi26AtAGzARVoddjxory9U
 J8swZL20Qz2JcvR/BFhuc1UdF1T296LMSfHnXlkFIQ7+jKm9haLJN4NsWsmeRc1ap9aIlcFh
 XM/XysPvPe/21P3PcdKj36ZUKzGMIC5T42+D6CIBjawSsEpK1XvEN5Sib64hjCxzxdEfVAXM
 paAesHkFmcBFali11KLqxQ1j9cWKtQF7TqLH/jTlk3/uZLHPS79YepVYTOmM7FihIvZ8Vq9z
 jqqH5bTo/mpeLalOXe/HE96BQ1iEEXX8ris85IMLb7fe1Y3cIzjYteIqY4cl0Vet/w9vo/1E
 ruVAye0FHKXaaX7FDi3
IronPort-HdrOrdr: A9a23:1Vx39aPei2KqycBcTsSjsMiBIKoaSvp037Dk7SxMoHtuA6ilfq
 +V8sjzuSWftN9VYgBCpTniAtjkfZqjz/9ICOAqVN/IYOClghrLEGgI1+TfKlPbdhEWjtQ86U
 +lGJIObuEZyjNB/KHH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,206,1654560000"; 
   d="scan'208";a="3317406"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Jul 2022 18:26:58 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 26VIQpXw008219;
        Sun, 31 Jul 2022 18:26:58 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [v4.9 PATCH 2/6] init/main: Fix double "the" in comment
Date:   Sun, 31 Jul 2022 20:26:32 +0200
Message-Id: <20220731182635.1910069-3-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220731182635.1910069-1-hegtvedt@cisco.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

s/the\ the/the

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
(cherry picked from commit 6623f1c6150c09ce946c8e27a4c814d64919495b)
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 30226a836c8..a6ecdd492ed 100644
--- a/init/main.c
+++ b/init/main.c
@@ -488,7 +488,7 @@ asmlinkage __visible void __init start_kernel(void)
 	debug_objects_early_init();
 
 	/*
-	 * Set up the the initial canary ASAP:
+	 * Set up the initial canary ASAP:
 	 */
 	add_latent_entropy();
 	boot_init_stack_canary();
-- 
2.34.1

