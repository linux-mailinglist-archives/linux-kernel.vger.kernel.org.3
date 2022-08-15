Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9464659288D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiHOEQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiHOEQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:16:31 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D926140A5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:16:29 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F3wF6p016367;
        Mon, 15 Aug 2022 04:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=0ukIsswr7jv4Q0zqB8Tov8ZNl+GRYQNfvf7V28HUxG8=;
 b=GnoDOIE5YM8Xjy574xRYo/HSJQ8Ua+uWcfBOLIrRD3hObGleeqE+j7MKofpJ/aybMwrs
 oDx1FxhdZ06llq8Qr/bIKPN8EM3VJv+R5Zl/1Flo/wHGvLVlcV5W9BjhJ1mF/YtcFCNZ
 C9/DNGw5jFjOI0LcLMbJNwDDHj0jM65GYeihhi+AnzhPdjncnwfAn2b+tAYHCPNlYVQS
 fZpcuNn27ADfPAWKT3hjVrhXmoEbABcxbWLJOOv/MJYNy8hQkKuI/pz/CFogNg/8PtTP
 L2bUm3nJCIfZdKL7Io+QjTH4LF3CzjlIU67jBM96SMS4Bw5hG06p5S0djgyoCEwhldZP Gg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hyeq2r9hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 04:16:24 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9009FD2F8;
        Mon, 15 Aug 2022 04:16:22 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 407A58048EE;
        Mon, 15 Aug 2022 04:16:22 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 1/3] checkpatch: improve Kconfig help text patch parsing
Date:   Sun, 14 Aug 2022 23:15:46 -0500
Message-Id: <20220815041548.43744-2-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815041548.43744-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Og3yy0Z5LYdfpZ53DvAkYzWey1qvH7OA
X-Proofpoint-ORIG-GUID: Og3yy0Z5LYdfpZ53DvAkYzWey1qvH7OA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_03,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

While parsing Kconfig help text, allow the strings that affect
parsing (e.g., help, bool, tristate, and prompt) to be in existing
text, not just added text (i.e., allow both + and a space character
at the beginning of the line).

This improves parsing of a patch like:

+config CRYPTO_SHA512_S390
+       tristate "SHA384 and SHA512 (s390)"
+       depends on S390
        select CRYPTO_HASH
        help
-         SHA512 secure hash standard (DFIPS 180-2).
+         SHA-384 and SHA-512 secure hash algorithms (FIPS 180)

-         This version of SHA implements a 512 bit hash with 256 bits of
-         security against collision attacks.
+         Architecture: s390

-         This code also includes SHA-384, a 384 bit hash with 192 bits
-         of security against collision attacks.
+         It is available as of z10.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 503e8abbb2c1..b0cda2f6414d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3489,11 +3489,11 @@ sub process {
 				next if ($f =~ /^-/);
 				last if ($f !~ /^[\+ ]/);	# !patch context
 
-				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+				if ($f =~ /^[\+ ]\s*(?:bool|tristate|prompt)\s*["']/) {
 					$needs_help = 1;
 					next;
 				}
-				if ($f =~ /^\+\s*help\s*$/) {
+				if ($f =~ /^[\+ ]\s*help\s*$/) {
 					$has_help = 1;
 					next;
 				}
@@ -3518,7 +3518,8 @@ sub process {
 			    $help_length < $min_conf_desc_length) {
 				my $stat_real = get_stat_real($linenr, $ln - 1);
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a help paragraph that fully describes the config symbol\n" . "$here\n$stat_real\n");
+				     "please write $min_conf_desc_length lines of help text that fully describes the config symbol (detected $help_length lines)\n" .
+				     "$here\n$stat_real\n");
 			}
 		}
 
-- 
2.37.1

