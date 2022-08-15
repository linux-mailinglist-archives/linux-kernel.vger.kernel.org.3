Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D04059288C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbiHOEQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiHOEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:16:32 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B398D14D28
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:16:30 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F43qGl027861;
        Mon, 15 Aug 2022 04:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=aSHXFdAQ03T2SGv1NgPTxGKHIy2TzHOP7Y3b0nXA+UU=;
 b=RpVqPwqz/n6PaVG2Pr0/AMqGF98xmCcE+af1K92RBPmpIHJ5cKQLo38b7K/FNA2Kal8b
 GHQDrMxsaXFtVfSDLqGH0sBWcUiRCU+snFmEiEnyOgYNwKJjonfAnyJdM90HqCc0vEDP
 Xaesxh4Z3h2hiY1BvEycPqOWwe8H4qPHD/WDAOjtfLxYRBahPWvdPkrRGVcEJUJjH//Q
 mjEtov0FgHoOnre+F6r4py5GzA7cEZA9xzHCqsDQqsB5V52j94Hv3mPblgHTmDFyzJ9e
 yBeEOZ+6y3hMQheU3iWzNIT/v9LozpuRGOORClWLju9opM+L0vDXnxbR/9WsmYdjm0rW Cw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hydktgsb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 04:16:26 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 171DA8000B7;
        Mon, 15 Aug 2022 04:16:26 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id BB12D80560D;
        Mon, 15 Aug 2022 04:16:25 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 3/3] checkpatch: check line length in Kconfig help text
Date:   Sun, 14 Aug 2022 23:15:48 -0500
Message-Id: <20220815041548.43744-4-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815041548.43744-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jfcEAwiQtfWhDpxpOu-MkFc9T72ktjAm
X-Proofpoint-ORIG-GUID: jfcEAwiQtfWhDpxpOu-MkFc9T72ktjAm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_03,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150016
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply the normal --max-line-length=nn line length checks to
Kconfig help text.

The default of 100 is only triggered by one existing line in
a file named Kconfig. Running with --max-line-length=80 reports
only a few long lines:
- 11 between 90 and 99 characters
- 25 betwen 81 and 89 characters
9 of which are due to long URLs.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4d09a324a586..f8e48af40b81 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3495,7 +3495,7 @@ sub process {
 				next if ($f =~ /^-/);
 				last if ($f !~ /^[\+ ]/);	# !patch context
 
-				if ($f =~ /^[\+ ]\s*(?:bool|tristate|prompt)\s*["']/) {
+				if ($f =~ /^[\+ ]\s*(?:bool|tristate|string|hex|int|prompt)\s*["']/) {
 					$needs_help = 1;
 					next;
 				}
@@ -3514,12 +3514,27 @@ sub process {
 				# and so hopefully shouldn't trigger false
 				# positives, even though some of these are
 				# common words in help texts
-				if ($f =~ /^(?:config|menuconfig|choice|endchoice|
-					       if|endif|menu|endmenu|source)\b/x) {
+				if ($f =~ /^(?:config|menuconfig|
+					       choice|endchoice|
+					       comment|if|endif|
+					       menu|endmenu|source)\b/x) {
 					last;
 				}
+
+				# no further checking for lines with these keywords
+				if ($f =~ /^(?:default|def_bool|depends|select|imply)\b/x) {
+					next;
+				}
+
+				my ($length, $indent) = line_stats($f);
+				if ($length > $max_line_length) {
+					WARN("CONFIG_DESCRIPTION",
+					     "Kconfig help text line length ($length) too long: $f\n");
+				}
+
 				$help_length++ if ($has_help);
 			}
+
 			if ($needs_help &&
 			    $help_length < $min_conf_desc_length) {
 				my $stat_real = get_stat_real($linenr, $ln - 1);
-- 
2.37.1

