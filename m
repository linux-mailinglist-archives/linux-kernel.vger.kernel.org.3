Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995215A39C1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 21:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiH0TjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiH0TjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 15:39:02 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE14AD65;
        Sat, 27 Aug 2022 12:39:01 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27RJVwxt002296;
        Sat, 27 Aug 2022 19:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=FNSOarG3m3NOFX/OEoKlVy1pfEGSdzdls18eAWThtAc=;
 b=jBWYRHxlsySUr+7fUnV/p4mLnKtbP9dkm3xz8kZb7J1KWxNoKJXjbpWP7xvEZuz5P6Fo
 Sj22ZuydqHHrejuRROiB/4cvcr7aa7NYZyzzb+kUhmrT5mk7VMu+DNL0Z+9r58b3k9V+
 PCB7MbWXST+unrgtGuC0gwxO4H2BF3iHoRX6wdKljMbRwuO0FESLA9zBxNz1kOjdDHaM
 CSlSIdTrXVuuHrWSF0/L+T7yR/XfQWDQUmibo6w8zHpzUE7ITz9Y7GGtow+ZFfdDW7I+
 v+InspiZz7+pJYKPdeRIWzZdw3CWaRj1qxx/ckBxsK2uJ3PLPqdOqaHcKt71guBoPNmm +Q== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j78n648m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 19:38:42 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id B40B2D2EE;
        Sat, 27 Aug 2022 19:38:41 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D2791802CFD;
        Sat, 27 Aug 2022 19:38:39 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     mpe@ellerman.id.au, nanya@linux.vnet.ibm.com,
        keescook@chromium.org, asahiroy@kernel.org,
        michal.lkml@markovi.net, corbet@lwn.net
Cc:     ndesaulniers@google.com, linux-hardening@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH] docs/core-api: expand Fedora instructions for GCC plugins
Date:   Sat, 27 Aug 2022 14:38:36 -0500
Message-Id: <20220827193836.2582079-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
X-Proofpoint-ORIG-GUID: KIr6ioxv73pUUBLLNYDlkb2JbTavYLny
X-Proofpoint-GUID: KIr6ioxv73pUUBLLNYDlkb2JbTavYLny
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=666
 clxscore=1011 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208270073
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Fedora 36, cross-compiling an allmodconfig configuration
for other architectures on x86 fails with this problem:

In file included from ../scripts/gcc-plugins/gcc-common.h:95,
                 from ../scripts/gcc-plugins/latent_entropy_plugin.c:78:
/usr/lib/gcc/aarch64-linux-gnu/12/plugin/include/builtins.h:23:10: fatal
error: mpc.h: No such file or directory
   23 | #include <mpc.h>
      |          ^~~~~~~
compilation terminated.

In that distro, that header file is available in the separate
libmpc-devel package.

Although future versions of Fedora might correctly mark
that dependency, mention this additional package.

To help detect such problems ahead of time, describe the
    gcc -print-file-name=plugin
command that is used by scripts/gcc-plugins/Kconfig to detect
plugins [1].

[1] https://lore.kernel.org/lkml/CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@xxxxxxxxxxxxxx/

Fixes: 43e96ef8b70c50f ("docs/core-api: Add Fedora instructions for GCC plugins");
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 Documentation/kbuild/gcc-plugins.rst | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/kbuild/gcc-plugins.rst b/Documentation/kbuild/gcc-plugins.rst
index 0ba76719f1b9..c578c6ba3eb6 100644
--- a/Documentation/kbuild/gcc-plugins.rst
+++ b/Documentation/kbuild/gcc-plugins.rst
@@ -90,7 +90,11 @@ e.g., on Ubuntu for gcc-10::
 
 Or on Fedora::
 
-	dnf install gcc-plugin-devel
+	dnf install gcc-plugin-devel libmpc-devel
+
+Or on Fedora when using cross-compilers that include plugins::
+
+	dnf install libmpc-devel
 
 Enable the GCC plugin infrastructure and some plugin(s) you want to use
 in the kernel config::
@@ -99,6 +103,19 @@ in the kernel config::
 	CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
 	...
 
+Run gcc (native or cross-compiler) to ensure plugin headers are detected::
+
+	gcc -print-file-name=plugin
+	CROSS_COMPILE=arm-linux-gnu- ${CROSS_COMPILE}gcc -print-file-name=plugin
+
+The word "plugin" means they are not detected::
+
+	plugin
+
+A full path means they are detected::
+
+       /usr/lib/gcc/x86_64-redhat-linux/12/plugin
+
 To compile the minimum tool set including the plugin(s)::
 
 	make scripts
-- 
2.37.1

