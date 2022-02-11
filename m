Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBD64B2FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353865AbiBKWAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:00:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242801AbiBKWAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:00:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B702C71;
        Fri, 11 Feb 2022 14:00:16 -0800 (PST)
Date:   Fri, 11 Feb 2022 22:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644616813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTTOhOarOmDlJS+IVo/bHvNsI94k1ve05Ip04NujUUQ=;
        b=PV2dZQL+D5cWZXJPETFHOYwCpkDc11XNEvtYxJvafTw8f54n1E1xpMU7qIY17xd78isj4g
        ao03a6rbamDByElBbewIkMyU2UXDcz7hKoLr8lqMWELhpK9BjnrNXgul3UWHvI3LHmr8Cv
        kg0nR4zTsHORLhttDNmh+AMm1ULcVkqE0hEzvmwM0MYL8FmkQM1Dor5yGhrQd5UIMnCK+L
        VoBkaYxCd2kyMG1o+w9g8hdMoTKLh/+Vzfzr93CRNG4M2cYSN0X+pFPryGnR0kZcoXnPsP
        WNJ5HVWRtcMKkgKhjyfYjtzvSoRjcaFDjM6jf7lS9YvU1iBH/fIeCbUwuz8KMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644616813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTTOhOarOmDlJS+IVo/bHvNsI94k1ve05Ip04NujUUQ=;
        b=MJSZ0FRcoeN45aAnRaLoKqeaKv4B7D57YUtko2cvUc02EWmgWPbYmx+OivAIG/zjmyPp7E
        klzCOGPa2861ZNAw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Remove extra newlines in test output
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6fd171ba622aed172a7c5b129d34d50bd0482f24=2E16443?=
 =?utf-8?q?55600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C6fd171ba622aed172a7c5b129d34d50bd0482f24=2E164435?=
 =?utf-8?q?5600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <164461681246.16921.10735507033791339273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     5626de65f97ae152e6dafdc528a36c1cbb7146ee
Gitweb:        https://git.kernel.org/tip/5626de65f97ae152e6dafdc528a36c1cbb7146ee
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 08 Feb 2022 13:48:42 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Feb 2022 13:52:48 -08:00

selftests/sgx: Remove extra newlines in test output

The TH_LOG() macro is an optional debug logging function made
available by kselftest itself. When TH_LOG_ENABLED is set it
prints the provided message with additional information and
formatting that already includes a newline.

Providing a newline to the message printed by TH_LOG() results
in a double newline that produces irregular test output.

Remove the unnecessary newlines from the text provided to
TH_LOG().

Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lkml.kernel.org/r/6fd171ba622aed172a7c5b129d34d50bd0482f24.1644355600.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index b0bd95a..dd74fa4 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -146,7 +146,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 
 	if (!encl_load("test_encl.elf", encl, heap_size)) {
 		encl_delete(encl);
-		TH_LOG("Failed to load the test enclave.\n");
+		TH_LOG("Failed to load the test enclave.");
 		return false;
 	}
 
@@ -204,7 +204,7 @@ err:
 		fclose(maps_file);
 	}
 
-	TH_LOG("Failed to initialize the test enclave.\n");
+	TH_LOG("Failed to initialize the test enclave.");
 
 	encl_delete(encl);
 
