Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4B59288E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbiHOEQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiHOEQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:16:31 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843E60C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:16:29 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F40EWP022788;
        Mon, 15 Aug 2022 04:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=LK46XCs0ItzQBrOI0CsZJ19pC1VKt8R0VzwjqMnqb0c=;
 b=QFlIl0mxNoRNMFkl7fdQ/e6VZ5KvagfSmumRfIOUIqWplLTElqMUVIPU/BJ4HFaSGJqu
 n39amsnzLxSD399td0kEOPzhGB1Q08tebEQqawiClQcnLjBbbBfFvlhfsCtPm2qnYnTY
 HYPL+R2aRKXv/3qml0qVdMvjiIWGZ375MVxY+q0woms62hI2J+6i5WnzrOFwc9MfX4fN
 cjlDrCnWlRQRXeWCxrVlm8GNuDnytnElz7bqH/Z7nEhOweo9iHe5C3aOOSeq/7tSNxwJ
 HYDUBonu5c53ORWpXW3lo+cqGSB5ETMAdTi+7dh3kBVaD4/F5a3w5Gw23mimNMJsVDmq Cg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hyeqtr8a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 04:16:25 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E85A7800E8D;
        Mon, 15 Aug 2022 04:16:24 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 7A97380560D;
        Mon, 15 Aug 2022 04:16:24 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 2/3] checkpatch: don't sanitise quotes in Kconfig files
Date:   Sun, 14 Aug 2022 23:15:47 -0500
Message-Id: <20220815041548.43744-3-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815041548.43744-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VOSiHDwBFUTS1qBX9r5-wNe24WBW98bp
X-Proofpoint-GUID: VOSiHDwBFUTS1qBX9r5-wNe24WBW98bp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_02,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=671
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150015
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Kconfig help text contains a single quote (e.g., can't),
checkpatch replaces all characters with X until another quote
appears in some later help text. This interferes with processing
keywords.

Don't sanitise lines if the file is a Kconfig file.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b0cda2f6414d..4d09a324a586 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2714,9 +2714,15 @@ sub process {
 			sanitise_line_reset($in_comment);
 
 		} elsif ($realcnt && $rawline =~ /^(?:\+| |$)/) {
-			# Standardise the strings and chars within the input to
-			# simplify matching -- only bother with positive lines.
-			$line = sanitise_line($rawline);
+			if (($realfile =~ /Kconfig/) ||
+			    (!$is_patch && $filename =~ /Kconfig/)) {
+				# Kconfig help text is free to use unmatched quotes
+				$line = $rawline;
+			} else {
+				# Standardise the strings and chars within the input to
+				# simplify matching -- only bother with positive lines.
+				$line = sanitise_line($rawline);
+			}
 		}
 		push(@lines, $line);
 
-- 
2.37.1

