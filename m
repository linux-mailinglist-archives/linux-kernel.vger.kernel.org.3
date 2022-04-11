Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F494FC4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349505AbiDKTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349419AbiDKTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:07:13 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87933A23;
        Mon, 11 Apr 2022 12:04:33 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 5c461fbcb3871e3f; Mon, 11 Apr 2022 21:04:32 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2622A66BDFD;
        Mon, 11 Apr 2022 21:04:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 09/20] ACPICA: Update copyright notices to the year 2022
Date:   Mon, 11 Apr 2022 20:54:22 +0200
Message-ID: <3681652.kQq0lBPeGt@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 738d7b0726e6c0458ef93c0a01c0377490888d1e

Affects all source modules and utility signons.

Link: https://github.com/acpica/acpica/commit/738d7b07
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acapps.h                             |    4 ++--
 drivers/acpi/acpica/accommon.h                           |    2 +-
 drivers/acpi/acpica/acconvert.h                          |    2 +-
 drivers/acpi/acpica/acdebug.h                            |    2 +-
 drivers/acpi/acpica/acdispat.h                           |    2 +-
 drivers/acpi/acpica/acevents.h                           |    2 +-
 drivers/acpi/acpica/acglobal.h                           |    2 +-
 drivers/acpi/acpica/achware.h                            |    2 +-
 drivers/acpi/acpica/acinterp.h                           |    2 +-
 drivers/acpi/acpica/aclocal.h                            |    2 +-
 drivers/acpi/acpica/acmacros.h                           |    2 +-
 drivers/acpi/acpica/acnamesp.h                           |    2 +-
 drivers/acpi/acpica/acobject.h                           |    2 +-
 drivers/acpi/acpica/acopcode.h                           |    2 +-
 drivers/acpi/acpica/acparser.h                           |    2 +-
 drivers/acpi/acpica/acpredef.h                           |    2 +-
 drivers/acpi/acpica/acresrc.h                            |    2 +-
 drivers/acpi/acpica/acstruct.h                           |    2 +-
 drivers/acpi/acpica/actables.h                           |    2 +-
 drivers/acpi/acpica/acutils.h                            |    2 +-
 drivers/acpi/acpica/amlcode.h                            |    2 +-
 drivers/acpi/acpica/amlresrc.h                           |    2 +-
 drivers/acpi/acpica/dbhistry.c                           |    2 +-
 drivers/acpi/acpica/dsargs.c                             |    2 +-
 drivers/acpi/acpica/dscontrol.c                          |    2 +-
 drivers/acpi/acpica/dsdebug.c                            |    2 +-
 drivers/acpi/acpica/dsfield.c                            |    2 +-
 drivers/acpi/acpica/dsinit.c                             |    2 +-
 drivers/acpi/acpica/dsmethod.c                           |    2 +-
 drivers/acpi/acpica/dsobject.c                           |    2 +-
 drivers/acpi/acpica/dsopcode.c                           |    2 +-
 drivers/acpi/acpica/dspkginit.c                          |    2 +-
 drivers/acpi/acpica/dswexec.c                            |    2 +-
 drivers/acpi/acpica/dswload.c                            |    2 +-
 drivers/acpi/acpica/dswload2.c                           |    2 +-
 drivers/acpi/acpica/dswscope.c                           |    2 +-
 drivers/acpi/acpica/dswstate.c                           |    2 +-
 drivers/acpi/acpica/evevent.c                            |    2 +-
 drivers/acpi/acpica/evglock.c                            |    2 +-
 drivers/acpi/acpica/evgpe.c                              |    2 +-
 drivers/acpi/acpica/evgpeblk.c                           |    2 +-
 drivers/acpi/acpica/evgpeinit.c                          |    2 +-
 drivers/acpi/acpica/evgpeutil.c                          |    2 +-
 drivers/acpi/acpica/evhandler.c                          |    2 +-
 drivers/acpi/acpica/evmisc.c                             |    2 +-
 drivers/acpi/acpica/evregion.c                           |    2 +-
 drivers/acpi/acpica/evrgnini.c                           |    2 +-
 drivers/acpi/acpica/evxface.c                            |    2 +-
 drivers/acpi/acpica/evxfevnt.c                           |    2 +-
 drivers/acpi/acpica/evxfgpe.c                            |    2 +-
 drivers/acpi/acpica/evxfregn.c                           |    2 +-
 drivers/acpi/acpica/exconcat.c                           |    2 +-
 drivers/acpi/acpica/exconfig.c                           |    2 +-
 drivers/acpi/acpica/exconvrt.c                           |    2 +-
 drivers/acpi/acpica/excreate.c                           |    2 +-
 drivers/acpi/acpica/exdebug.c                            |    2 +-
 drivers/acpi/acpica/exdump.c                             |    2 +-
 drivers/acpi/acpica/exfield.c                            |    2 +-
 drivers/acpi/acpica/exfldio.c                            |    2 +-
 drivers/acpi/acpica/exmisc.c                             |    2 +-
 drivers/acpi/acpica/exmutex.c                            |    2 +-
 drivers/acpi/acpica/exnames.c                            |    2 +-
 drivers/acpi/acpica/exoparg1.c                           |    2 +-
 drivers/acpi/acpica/exoparg2.c                           |    2 +-
 drivers/acpi/acpica/exoparg3.c                           |    2 +-
 drivers/acpi/acpica/exoparg6.c                           |    2 +-
 drivers/acpi/acpica/exprep.c                             |    2 +-
 drivers/acpi/acpica/exregion.c                           |    2 +-
 drivers/acpi/acpica/exresnte.c                           |    2 +-
 drivers/acpi/acpica/exresolv.c                           |    2 +-
 drivers/acpi/acpica/exresop.c                            |    2 +-
 drivers/acpi/acpica/exserial.c                           |    2 +-
 drivers/acpi/acpica/exstore.c                            |    2 +-
 drivers/acpi/acpica/exstoren.c                           |    2 +-
 drivers/acpi/acpica/exstorob.c                           |    2 +-
 drivers/acpi/acpica/exsystem.c                           |    2 +-
 drivers/acpi/acpica/extrace.c                            |    2 +-
 drivers/acpi/acpica/exutils.c                            |    2 +-
 drivers/acpi/acpica/hwacpi.c                             |    2 +-
 drivers/acpi/acpica/hwesleep.c                           |    2 +-
 drivers/acpi/acpica/hwgpe.c                              |    2 +-
 drivers/acpi/acpica/hwsleep.c                            |    2 +-
 drivers/acpi/acpica/hwtimer.c                            |    2 +-
 drivers/acpi/acpica/hwvalid.c                            |    2 +-
 drivers/acpi/acpica/hwxface.c                            |    2 +-
 drivers/acpi/acpica/hwxfsleep.c                          |    2 +-
 drivers/acpi/acpica/nsarguments.c                        |    2 +-
 drivers/acpi/acpica/nsconvert.c                          |    2 +-
 drivers/acpi/acpica/nsdump.c                             |    2 +-
 drivers/acpi/acpica/nsdumpdv.c                           |    2 +-
 drivers/acpi/acpica/nsinit.c                             |    2 +-
 drivers/acpi/acpica/nsload.c                             |    2 +-
 drivers/acpi/acpica/nsparse.c                            |    2 +-
 drivers/acpi/acpica/nspredef.c                           |    2 +-
 drivers/acpi/acpica/nsprepkg.c                           |    2 +-
 drivers/acpi/acpica/nsrepair.c                           |    2 +-
 drivers/acpi/acpica/nsrepair2.c                          |    2 +-
 drivers/acpi/acpica/nsutils.c                            |    2 +-
 drivers/acpi/acpica/nswalk.c                             |    2 +-
 drivers/acpi/acpica/nsxfname.c                           |    2 +-
 drivers/acpi/acpica/psargs.c                             |    2 +-
 drivers/acpi/acpica/psloop.c                             |    2 +-
 drivers/acpi/acpica/psobject.c                           |    2 +-
 drivers/acpi/acpica/psopcode.c                           |    2 +-
 drivers/acpi/acpica/psopinfo.c                           |    2 +-
 drivers/acpi/acpica/psparse.c                            |    2 +-
 drivers/acpi/acpica/psscope.c                            |    2 +-
 drivers/acpi/acpica/pstree.c                             |    2 +-
 drivers/acpi/acpica/psutils.c                            |    2 +-
 drivers/acpi/acpica/pswalk.c                             |    2 +-
 drivers/acpi/acpica/psxface.c                            |    2 +-
 drivers/acpi/acpica/tbdata.c                             |    2 +-
 drivers/acpi/acpica/tbfadt.c                             |    2 +-
 drivers/acpi/acpica/tbfind.c                             |    2 +-
 drivers/acpi/acpica/tbinstal.c                           |    2 +-
 drivers/acpi/acpica/tbprint.c                            |    2 +-
 drivers/acpi/acpica/tbutils.c                            |    2 +-
 drivers/acpi/acpica/tbxface.c                            |    2 +-
 drivers/acpi/acpica/tbxfload.c                           |    2 +-
 drivers/acpi/acpica/tbxfroot.c                           |    2 +-
 drivers/acpi/acpica/utaddress.c                          |    2 +-
 drivers/acpi/acpica/utalloc.c                            |    2 +-
 drivers/acpi/acpica/utascii.c                            |    2 +-
 drivers/acpi/acpica/utbuffer.c                           |    2 +-
 drivers/acpi/acpica/utcache.c                            |    2 +-
 drivers/acpi/acpica/utcopy.c                             |    2 +-
 drivers/acpi/acpica/utdebug.c                            |    2 +-
 drivers/acpi/acpica/utdecode.c                           |    2 +-
 drivers/acpi/acpica/uteval.c                             |    2 +-
 drivers/acpi/acpica/utglobal.c                           |    2 +-
 drivers/acpi/acpica/uthex.c                              |    2 +-
 drivers/acpi/acpica/utids.c                              |    2 +-
 drivers/acpi/acpica/utinit.c                             |    2 +-
 drivers/acpi/acpica/utlock.c                             |    2 +-
 drivers/acpi/acpica/utobject.c                           |    2 +-
 drivers/acpi/acpica/utosi.c                              |    2 +-
 drivers/acpi/acpica/utpredef.c                           |    2 +-
 drivers/acpi/acpica/utprint.c                            |    2 +-
 drivers/acpi/acpica/uttrack.c                            |    2 +-
 drivers/acpi/acpica/utuuid.c                             |    2 +-
 drivers/acpi/acpica/utxface.c                            |    2 +-
 drivers/acpi/acpica/utxfinit.c                           |    2 +-
 include/acpi/acbuffer.h                                  |    2 +-
 include/acpi/acconfig.h                                  |    2 +-
 include/acpi/acexcep.h                                   |    2 +-
 include/acpi/acnames.h                                   |    2 +-
 include/acpi/acoutput.h                                  |    2 +-
 include/acpi/acpi.h                                      |    2 +-
 include/acpi/acpiosxf.h                                  |    2 +-
 include/acpi/acpixf.h                                    |    2 +-
 include/acpi/acrestyp.h                                  |    2 +-
 include/acpi/actbl.h                                     |    2 +-
 include/acpi/actbl1.h                                    |    2 +-
 include/acpi/actbl2.h                                    |    2 +-
 include/acpi/actbl3.h                                    |    2 +-
 include/acpi/actypes.h                                   |    2 +-
 include/acpi/acuuid.h                                    |    2 +-
 include/acpi/platform/acenv.h                            |    2 +-
 include/acpi/platform/acenvex.h                          |    2 +-
 include/acpi/platform/acgcc.h                            |    2 +-
 include/acpi/platform/acgccex.h                          |    2 +-
 include/acpi/platform/acintel.h                          |    2 +-
 include/acpi/platform/aclinux.h                          |    2 +-
 include/acpi/platform/aclinuxex.h                        |    2 +-
 tools/power/acpi/common/cmfsize.c                        |    2 +-
 tools/power/acpi/common/getopt.c                         |    2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c |    2 +-
 tools/power/acpi/os_specific/service_layers/osunixdir.c  |    2 +-
 tools/power/acpi/os_specific/service_layers/osunixmap.c  |    2 +-
 tools/power/acpi/os_specific/service_layers/osunixxf.c   |    2 +-
 tools/power/acpi/tools/acpidump/acpidump.h               |    2 +-
 tools/power/acpi/tools/acpidump/apdump.c                 |    2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                |    2 +-
 tools/power/acpi/tools/acpidump/apmain.c                 |    2 +-
 174 files changed, 175 insertions(+), 175 deletions(-)

Index: linux-pm/drivers/acpi/acpica/acapps.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acapps.h
+++ linux-pm/drivers/acpi/acpica/acapps.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
@@ -17,7 +17,7 @@
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
-#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2021 Intel Corporation"
+#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2022 Intel Corporation"
 
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_WIDTH          " (64-bit version)"
Index: linux-pm/drivers/acpi/acpica/accommon.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/accommon.h
+++ linux-pm/drivers/acpi/acpica/accommon.h
@@ -3,7 +3,7 @@
  *
  * Name: accommon.h - Common include files for generation of ACPICA source
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acconvert.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acconvert.h
+++ linux-pm/drivers/acpi/acpica/acconvert.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acdebug.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acdebug.h
+++ linux-pm/drivers/acpi/acpica/acdebug.h
@@ -3,7 +3,7 @@
  *
  * Name: acdebug.h - ACPI/AML debugger
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acdispat.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acdispat.h
+++ linux-pm/drivers/acpi/acpica/acdispat.h
@@ -3,7 +3,7 @@
  *
  * Name: acdispat.h - dispatcher (parser to interpreter interface)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acevents.h
+++ linux-pm/drivers/acpi/acpica/acevents.h
@@ -3,7 +3,7 @@
  *
  * Name: acevents.h - Event subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acglobal.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acglobal.h
+++ linux-pm/drivers/acpi/acpica/acglobal.h
@@ -3,7 +3,7 @@
  *
  * Name: acglobal.h - Declarations for global variables
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/achware.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/achware.h
+++ linux-pm/drivers/acpi/acpica/achware.h
@@ -3,7 +3,7 @@
  *
  * Name: achware.h -- hardware specific interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acinterp.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acinterp.h
+++ linux-pm/drivers/acpi/acpica/acinterp.h
@@ -3,7 +3,7 @@
  *
  * Name: acinterp.h - Interpreter subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/aclocal.h
+++ linux-pm/drivers/acpi/acpica/aclocal.h
@@ -3,7 +3,7 @@
  *
  * Name: aclocal.h - Internal data types used across the ACPI subsystem
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acmacros.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acmacros.h
+++ linux-pm/drivers/acpi/acpica/acmacros.h
@@ -3,7 +3,7 @@
  *
  * Name: acmacros.h - C macros for the entire subsystem.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acnamesp.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acnamesp.h
+++ linux-pm/drivers/acpi/acpica/acnamesp.h
@@ -3,7 +3,7 @@
  *
  * Name: acnamesp.h - Namespace subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acobject.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acobject.h
+++ linux-pm/drivers/acpi/acpica/acobject.h
@@ -3,7 +3,7 @@
  *
  * Name: acobject.h - Definition of union acpi_operand_object  (Internal object only)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acopcode.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acopcode.h
+++ linux-pm/drivers/acpi/acpica/acopcode.h
@@ -3,7 +3,7 @@
  *
  * Name: acopcode.h - AML opcode information for the AML parser and interpreter
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acparser.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acparser.h
+++ linux-pm/drivers/acpi/acpica/acparser.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acparser.h - AML Parser subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acpredef.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acpredef.h
+++ linux-pm/drivers/acpi/acpica/acpredef.h
@@ -3,7 +3,7 @@
  *
  * Name: acpredef - Information table for ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acresrc.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acresrc.h
+++ linux-pm/drivers/acpi/acpica/acresrc.h
@@ -3,7 +3,7 @@
  *
  * Name: acresrc.h - Resource Manager function prototypes
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acstruct.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acstruct.h
+++ linux-pm/drivers/acpi/acpica/acstruct.h
@@ -3,7 +3,7 @@
  *
  * Name: acstruct.h - Internal structs
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/actables.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/actables.h
+++ linux-pm/drivers/acpi/acpica/actables.h
@@ -3,7 +3,7 @@
  *
  * Name: actables.h - ACPI table management
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/acutils.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acutils.h
+++ linux-pm/drivers/acpi/acpica/acutils.h
@@ -3,7 +3,7 @@
  *
  * Name: acutils.h -- prototypes for the common (subsystem-wide) procedures
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/amlcode.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/amlcode.h
+++ linux-pm/drivers/acpi/acpica/amlcode.h
@@ -5,7 +5,7 @@
  *                   Declarations and definitions contained herein are derived
  *                   directly from the ACPI specification.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/amlresrc.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/amlresrc.h
+++ linux-pm/drivers/acpi/acpica/amlresrc.h
@@ -3,7 +3,7 @@
  *
  * Module Name: amlresrc.h - AML resource descriptors
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dbhistry.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dbhistry.c
+++ linux-pm/drivers/acpi/acpica/dbhistry.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dbhistry - debugger HISTORY command
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dsargs.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dsargs.c
+++ linux-pm/drivers/acpi/acpica/dsargs.c
@@ -4,7 +4,7 @@
  * Module Name: dsargs - Support for execution of dynamic arguments for static
  *                       objects (regions, fields, buffer fields, etc.)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dscontrol.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dscontrol.c
+++ linux-pm/drivers/acpi/acpica/dscontrol.c
@@ -4,7 +4,7 @@
  * Module Name: dscontrol - Support for execution control opcodes -
  *                          if/else/while/return
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dsdebug.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dsdebug.c
+++ linux-pm/drivers/acpi/acpica/dsdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsdebug - Parser/Interpreter interface - debugging
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dsfield.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dsfield.c
+++ linux-pm/drivers/acpi/acpica/dsfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsfield - Dispatcher field routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dsinit.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dsinit.c
+++ linux-pm/drivers/acpi/acpica/dsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsinit - Object initialization namespace walk
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dsmethod.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dsmethod.c
+++ linux-pm/drivers/acpi/acpica/dsmethod.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsmethod - Parser/Interpreter interface - control method parsing
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dsobject.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dsobject.c
+++ linux-pm/drivers/acpi/acpica/dsobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsobject - Dispatcher object management routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dsopcode.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dsopcode.c
+++ linux-pm/drivers/acpi/acpica/dsopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsopcode - Dispatcher support for regions and fields
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dspkginit.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dspkginit.c
+++ linux-pm/drivers/acpi/acpica/dspkginit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dspkginit - Completion of deferred package initialization
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dswexec.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dswexec.c
+++ linux-pm/drivers/acpi/acpica/dswexec.c
@@ -4,7 +4,7 @@
  * Module Name: dswexec - Dispatcher method execution callbacks;
  *                        dispatch to interpreter.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dswload2.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dswload2.c
+++ linux-pm/drivers/acpi/acpica/dswload2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload2 - Dispatcher second pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dswload.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dswload.c
+++ linux-pm/drivers/acpi/acpica/dswload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload - Dispatcher first pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dswscope.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dswscope.c
+++ linux-pm/drivers/acpi/acpica/dswscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswscope - Scope stack manipulation
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/dswstate.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/dswstate.c
+++ linux-pm/drivers/acpi/acpica/dswstate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswstate - Dispatcher parse tree walk management routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evevent.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evevent.c
+++ linux-pm/drivers/acpi/acpica/evevent.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evevent - Fixed Event handling and dispatch
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evglock.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evglock.c
+++ linux-pm/drivers/acpi/acpica/evglock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evglock - Global Lock support
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-pm/drivers/acpi/acpica/evgpeblk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeblk - GPE block creation and initialization.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpe.c
+++ linux-pm/drivers/acpi/acpica/evgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpe - General Purpose Event handling and dispatch
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evgpeinit.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpeinit.c
+++ linux-pm/drivers/acpi/acpica/evgpeinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeinit - System GPE initialization and update
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evgpeutil.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpeutil.c
+++ linux-pm/drivers/acpi/acpica/evgpeutil.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeutil - GPE utilities
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evhandler.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evhandler.c
+++ linux-pm/drivers/acpi/acpica/evhandler.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evhandler - Support for Address Space handlers
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evmisc.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evmisc.c
+++ linux-pm/drivers/acpi/acpica/evmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evmisc - Miscellaneous event manager support functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evregion.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evregion.c
+++ linux-pm/drivers/acpi/acpica/evregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evregion - Operation Region support
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evrgnini.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evrgnini.c
+++ linux-pm/drivers/acpi/acpica/evrgnini.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evrgnini- ACPI address_space (op_region) init
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxface.c
+++ linux-pm/drivers/acpi/acpica/evxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxface - External interfaces for ACPI events
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-pm/drivers/acpi/acpica/evxfevnt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfevnt - External Interfaces, ACPI event disable/enable
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfgpe - External Interfaces for General Purpose Events (GPEs)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/evxfregn.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
+++ linux-pm/drivers/acpi/acpica/evxfregn.c
@@ -4,7 +4,7 @@
  * Module Name: evxfregn - External Interfaces, ACPI Operation Regions and
  *                         Address Spaces.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exconcat.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exconcat.c
+++ linux-pm/drivers/acpi/acpica/exconcat.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconcat - Concatenate-type AML operators
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exconfig.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exconfig.c
+++ linux-pm/drivers/acpi/acpica/exconfig.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconfig - Namespace reconfiguration (Load/Unload opcodes)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exconvrt.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exconvrt.c
+++ linux-pm/drivers/acpi/acpica/exconvrt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconvrt - Object conversion routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/excreate.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/excreate.c
+++ linux-pm/drivers/acpi/acpica/excreate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: excreate - Named object creation
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exdebug.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exdebug.c
+++ linux-pm/drivers/acpi/acpica/exdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdebug - Support for stores to the AML Debug Object
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exdump.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exdump.c
+++ linux-pm/drivers/acpi/acpica/exdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdump - Interpreter debug output routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exfield.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exfield.c
+++ linux-pm/drivers/acpi/acpica/exfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfield - AML execution - field_unit read/write
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exfldio.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exfldio.c
+++ linux-pm/drivers/acpi/acpica/exfldio.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfldio - Aml Field I/O
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exmisc.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exmisc.c
+++ linux-pm/drivers/acpi/acpica/exmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmisc - ACPI AML (p-code) execution - specific opcodes
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exmutex.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exmutex.c
+++ linux-pm/drivers/acpi/acpica/exmutex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmutex - ASL Mutex Acquire/Release functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exnames.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exnames.c
+++ linux-pm/drivers/acpi/acpica/exnames.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exnames - interpreter/scanner name load/execute
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exoparg1.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exoparg1.c
+++ linux-pm/drivers/acpi/acpica/exoparg1.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg1 - AML execution - opcodes with 1 argument
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exoparg2.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exoparg2.c
+++ linux-pm/drivers/acpi/acpica/exoparg2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg2 - AML execution - opcodes with 2 arguments
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exoparg3.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exoparg3.c
+++ linux-pm/drivers/acpi/acpica/exoparg3.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg3 - AML execution - opcodes with 3 arguments
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exoparg6.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exoparg6.c
+++ linux-pm/drivers/acpi/acpica/exoparg6.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg6 - AML execution - opcodes with 6 arguments
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exprep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exprep.c
+++ linux-pm/drivers/acpi/acpica/exprep.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exprep - ACPI AML field prep utilities
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exregion.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exregion.c
+++ linux-pm/drivers/acpi/acpica/exregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exregion - ACPI default op_region (address space) handlers
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exresnte.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exresnte.c
+++ linux-pm/drivers/acpi/acpica/exresnte.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresnte - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exresolv.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exresolv.c
+++ linux-pm/drivers/acpi/acpica/exresolv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresolv - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exresop.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exresop.c
+++ linux-pm/drivers/acpi/acpica/exresop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresop - AML Interpreter operand/object resolution
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exserial.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exserial.c
+++ linux-pm/drivers/acpi/acpica/exserial.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exserial - field_unit support for serial address spaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exstore.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exstore.c
+++ linux-pm/drivers/acpi/acpica/exstore.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstore - AML Interpreter object store support
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exstoren.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exstoren.c
+++ linux-pm/drivers/acpi/acpica/exstoren.c
@@ -4,7 +4,7 @@
  * Module Name: exstoren - AML Interpreter object store support,
  *                        Store to Node (namespace object)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exstorob.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exstorob.c
+++ linux-pm/drivers/acpi/acpica/exstorob.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstorob - AML object store support, store to object
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exsystem.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exsystem.c
+++ linux-pm/drivers/acpi/acpica/exsystem.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exsystem - Interface to OS services
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/extrace.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/extrace.c
+++ linux-pm/drivers/acpi/acpica/extrace.c
@@ -3,7 +3,7 @@
  *
  * Module Name: extrace - Support for interpreter execution tracing
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/exutils.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exutils.c
+++ linux-pm/drivers/acpi/acpica/exutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exutils - interpreter/scanner utilities
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwacpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwacpi.c
+++ linux-pm/drivers/acpi/acpica/hwacpi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwacpi - ACPI Hardware Initialization/Mode Interface
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwesleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwesleep.c
+++ linux-pm/drivers/acpi/acpica/hwesleep.c
@@ -4,7 +4,7 @@
  * Name: hwesleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                    extended FADT-V5 sleep registers.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-pm/drivers/acpi/acpica/hwgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwgpe - Low level GPE enable/disable/clear functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
+++ linux-pm/drivers/acpi/acpica/hwsleep.c
@@ -4,7 +4,7 @@
  * Name: hwsleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                   original/legacy sleep/PM registers.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwtimer.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwtimer.c
+++ linux-pm/drivers/acpi/acpica/hwtimer.c
@@ -3,7 +3,7 @@
  *
  * Name: hwtimer.c - ACPI Power Management Timer Interface
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwvalid.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwvalid.c
+++ linux-pm/drivers/acpi/acpica/hwvalid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwvalid - I/O request validation
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwxface.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwxface.c
+++ linux-pm/drivers/acpi/acpica/hwxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwxface - Public ACPICA hardware interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/hwxfsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwxfsleep.c
+++ linux-pm/drivers/acpi/acpica/hwxfsleep.c
@@ -3,7 +3,7 @@
  *
  * Name: hwxfsleep.c - ACPI Hardware Sleep/Wake External Interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsarguments.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsarguments.c
+++ linux-pm/drivers/acpi/acpica/nsarguments.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsarguments - Validation of args for ACPI predefined methods
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsconvert.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsconvert.c
+++ linux-pm/drivers/acpi/acpica/nsconvert.c
@@ -4,7 +4,7 @@
  * Module Name: nsconvert - Object conversions for objects returned by
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsdump.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsdump.c
+++ linux-pm/drivers/acpi/acpica/nsdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsdumpdv.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsdumpdv.c
+++ linux-pm/drivers/acpi/acpica/nsdumpdv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsinit.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsinit.c
+++ linux-pm/drivers/acpi/acpica/nsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsinit - namespace initialization
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsload.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsload.c
+++ linux-pm/drivers/acpi/acpica/nsload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsload - namespace loading/expanding/contracting procedures
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsparse.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsparse.c
+++ linux-pm/drivers/acpi/acpica/nsparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsparse - namespace interface to AML parser
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nspredef.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nspredef.c
+++ linux-pm/drivers/acpi/acpica/nspredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nspredef - Validation of ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsprepkg.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsprepkg.c
+++ linux-pm/drivers/acpi/acpica/nsprepkg.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsprepkg - Validation of package objects for predefined names
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsrepair2.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsrepair2.c
+++ linux-pm/drivers/acpi/acpica/nsrepair2.c
@@ -4,7 +4,7 @@
  * Module Name: nsrepair2 - Repair for objects returned by specific
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsrepair.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsrepair.c
+++ linux-pm/drivers/acpi/acpica/nsrepair.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsrepair - Repair for objects returned by predefined methods
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsutils.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsutils.c
+++ linux-pm/drivers/acpi/acpica/nsutils.c
@@ -4,7 +4,7 @@
  * Module Name: nsutils - Utilities for accessing ACPI namespace, accessing
  *                        parents and siblings and Scope manipulation
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nswalk.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nswalk.c
+++ linux-pm/drivers/acpi/acpica/nswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nswalk - Functions for walking the ACPI namespace
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/nsxfname.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsxfname.c
+++ linux-pm/drivers/acpi/acpica/nsxfname.c
@@ -4,7 +4,7 @@
  * Module Name: nsxfname - Public interfaces to the ACPI subsystem
  *                         ACPI Namespace oriented interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psargs.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psargs.c
+++ linux-pm/drivers/acpi/acpica/psargs.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psargs - Parse AML opcode arguments
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psloop.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psloop.c
+++ linux-pm/drivers/acpi/acpica/psloop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psloop - Main AML parse loop
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psobject.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psobject.c
+++ linux-pm/drivers/acpi/acpica/psobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psobject - Support for parse objects
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psopcode.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psopcode.c
+++ linux-pm/drivers/acpi/acpica/psopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopcode - Parser/Interpreter opcode information table
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psopinfo.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psopinfo.c
+++ linux-pm/drivers/acpi/acpica/psopinfo.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopinfo - AML opcode information functions and dispatch tables
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psparse.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psparse.c
+++ linux-pm/drivers/acpi/acpica/psparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psparse - Parser top level AML parse routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psscope.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psscope.c
+++ linux-pm/drivers/acpi/acpica/psscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psscope - Parser scope stack management routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/pstree.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/pstree.c
+++ linux-pm/drivers/acpi/acpica/pstree.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pstree - Parser op tree manipulation/traversal/search
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psutils.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psutils.c
+++ linux-pm/drivers/acpi/acpica/psutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psutils - Parser miscellaneous utilities (Parser only)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/pswalk.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/pswalk.c
+++ linux-pm/drivers/acpi/acpica/pswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pswalk - Parser routines to walk parsed op tree(s)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/psxface.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psxface.c
+++ linux-pm/drivers/acpi/acpica/psxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psxface - Parser external interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbdata.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbdata.c
+++ linux-pm/drivers/acpi/acpica/tbdata.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbdata - Table manager data structure functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbfadt.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbfadt.c
+++ linux-pm/drivers/acpi/acpica/tbfadt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfadt   - FADT table utilities
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbfind.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbfind.c
+++ linux-pm/drivers/acpi/acpica/tbfind.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfind   - find table
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbinstal.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbinstal.c
+++ linux-pm/drivers/acpi/acpica/tbinstal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbinstal - ACPI table installation and removal
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbprint.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbprint.c
+++ linux-pm/drivers/acpi/acpica/tbprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbprint - Table output utilities
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbutils.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbutils.c
+++ linux-pm/drivers/acpi/acpica/tbutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbutils - ACPI Table utilities
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbxface.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbxface.c
+++ linux-pm/drivers/acpi/acpica/tbxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxface - ACPI table-oriented external interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbxfload.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbxfload.c
+++ linux-pm/drivers/acpi/acpica/tbxfload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfload - Table load/unload external interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/tbxfroot.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbxfroot.c
+++ linux-pm/drivers/acpi/acpica/tbxfroot.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfroot - Find the root ACPI table (RSDT)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utaddress.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utaddress.c
+++ linux-pm/drivers/acpi/acpica/utaddress.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utaddress - op_region address range check
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utalloc.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utalloc.c
+++ linux-pm/drivers/acpi/acpica/utalloc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utalloc - local memory allocation routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utascii.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utascii.c
+++ linux-pm/drivers/acpi/acpica/utascii.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utascii - Utility ascii functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utbuffer.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utbuffer.c
+++ linux-pm/drivers/acpi/acpica/utbuffer.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utbuffer - Buffer dump routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utcache.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utcache.c
+++ linux-pm/drivers/acpi/acpica/utcache.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcache - local cache allocation routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utcopy.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utcopy.c
+++ linux-pm/drivers/acpi/acpica/utcopy.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcopy - Internal to external object translation utilities
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utdebug.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utdebug.c
+++ linux-pm/drivers/acpi/acpica/utdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdebug - Debug print/trace routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utdecode.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utdecode.c
+++ linux-pm/drivers/acpi/acpica/utdecode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdecode - Utility decoding routines (value-to-string)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/uteval.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/uteval.c
+++ linux-pm/drivers/acpi/acpica/uteval.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uteval - Object evaluation
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utglobal.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utglobal.c
+++ linux-pm/drivers/acpi/acpica/utglobal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utglobal - Global variables for the ACPI subsystem
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/uthex.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/uthex.c
+++ linux-pm/drivers/acpi/acpica/uthex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uthex -- Hex/ASCII support functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utids.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utids.c
+++ linux-pm/drivers/acpi/acpica/utids.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utids - support for device Ids - HID, UID, CID, SUB, CLS
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utinit.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utinit.c
+++ linux-pm/drivers/acpi/acpica/utinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utinit - Common ACPI subsystem initialization
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utlock.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utlock.c
+++ linux-pm/drivers/acpi/acpica/utlock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utlock - Reader/Writer lock interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utobject.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utobject.c
+++ linux-pm/drivers/acpi/acpica/utobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utobject - ACPI object create/delete/size/cache routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utosi.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utosi.c
+++ linux-pm/drivers/acpi/acpica/utosi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utosi - Support for the _OSI predefined control method
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utpredef.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utpredef.c
+++ linux-pm/drivers/acpi/acpica/utpredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utpredef - support functions for predefined names
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utprint.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utprint.c
+++ linux-pm/drivers/acpi/acpica/utprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utprint - Formatted printing routines
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/uttrack.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/uttrack.c
+++ linux-pm/drivers/acpi/acpica/uttrack.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uttrack - Memory allocation tracking routines (debug only)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utuuid.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utuuid.c
+++ linux-pm/drivers/acpi/acpica/utuuid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utuuid -- UUID support functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utxface.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utxface.c
+++ linux-pm/drivers/acpi/acpica/utxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxface - External interfaces, miscellaneous utility functions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/drivers/acpi/acpica/utxfinit.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utxfinit.c
+++ linux-pm/drivers/acpi/acpica/utxfinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxfinit - External interfaces for ACPICA initialization
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acbuffer.h
===================================================================
--- linux-pm.orig/include/acpi/acbuffer.h
+++ linux-pm/include/acpi/acbuffer.h
@@ -3,7 +3,7 @@
  *
  * Name: acbuffer.h - Support for buffers returned by ACPI predefined names
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acconfig.h
===================================================================
--- linux-pm.orig/include/acpi/acconfig.h
+++ linux-pm/include/acpi/acconfig.h
@@ -3,7 +3,7 @@
  *
  * Name: acconfig.h - Global configuration constants
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acexcep.h
===================================================================
--- linux-pm.orig/include/acpi/acexcep.h
+++ linux-pm/include/acpi/acexcep.h
@@ -3,7 +3,7 @@
  *
  * Name: acexcep.h - Exception codes returned by the ACPI subsystem
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acnames.h
===================================================================
--- linux-pm.orig/include/acpi/acnames.h
+++ linux-pm/include/acpi/acnames.h
@@ -3,7 +3,7 @@
  *
  * Name: acnames.h - Global names and strings
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acoutput.h
===================================================================
--- linux-pm.orig/include/acpi/acoutput.h
+++ linux-pm/include/acpi/acoutput.h
@@ -3,7 +3,7 @@
  *
  * Name: acoutput.h -- debug output
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acpi.h
===================================================================
--- linux-pm.orig/include/acpi/acpi.h
+++ linux-pm/include/acpi/acpi.h
@@ -3,7 +3,7 @@
  *
  * Name: acpi.h - Master public include file used to interface to ACPICA
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acpiosxf.h
===================================================================
--- linux-pm.orig/include/acpi/acpiosxf.h
+++ linux-pm/include/acpi/acpiosxf.h
@@ -5,7 +5,7 @@
  *                    interfaces must be implemented by OSL to interface the
  *                    ACPI components to the host operating system.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -3,7 +3,7 @@
  *
  * Name: acpixf.h - External interfaces to the ACPI subsystem
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acrestyp.h
===================================================================
--- linux-pm.orig/include/acpi/acrestyp.h
+++ linux-pm/include/acpi/acrestyp.h
@@ -3,7 +3,7 @@
  *
  * Name: acrestyp.h - Defines, types, and structures for resource descriptors
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/actbl1.h
===================================================================
--- linux-pm.orig/include/acpi/actbl1.h
+++ linux-pm/include/acpi/actbl1.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl1.h - Additional ACPI table definitions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/actbl2.h
===================================================================
--- linux-pm.orig/include/acpi/actbl2.h
+++ linux-pm/include/acpi/actbl2.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl2.h - ACPI Table Definitions (tables not in ACPI spec)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/actbl3.h
===================================================================
--- linux-pm.orig/include/acpi/actbl3.h
+++ linux-pm/include/acpi/actbl3.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl3.h - ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/actbl.h
===================================================================
--- linux-pm.orig/include/acpi/actbl.h
+++ linux-pm/include/acpi/actbl.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl.h - Basic ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -3,7 +3,7 @@
  *
  * Name: actypes.h - Common data types for the entire ACPI subsystem
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/acuuid.h
===================================================================
--- linux-pm.orig/include/acpi/acuuid.h
+++ linux-pm/include/acpi/acuuid.h
@@ -3,7 +3,7 @@
  *
  * Name: acuuid.h - ACPI-related UUID/GUID definitions
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/platform/acenvex.h
===================================================================
--- linux-pm.orig/include/acpi/platform/acenvex.h
+++ linux-pm/include/acpi/platform/acenvex.h
@@ -3,7 +3,7 @@
  *
  * Name: acenvex.h - Extra host and compiler configuration
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/platform/acenv.h
===================================================================
--- linux-pm.orig/include/acpi/platform/acenv.h
+++ linux-pm/include/acpi/platform/acenv.h
@@ -3,7 +3,7 @@
  *
  * Name: acenv.h - Host and compiler configuration
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/platform/acgccex.h
===================================================================
--- linux-pm.orig/include/acpi/platform/acgccex.h
+++ linux-pm/include/acpi/platform/acgccex.h
@@ -3,7 +3,7 @@
  *
  * Name: acgccex.h - Extra GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/platform/acgcc.h
===================================================================
--- linux-pm.orig/include/acpi/platform/acgcc.h
+++ linux-pm/include/acpi/platform/acgcc.h
@@ -3,7 +3,7 @@
  *
  * Name: acgcc.h - GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/platform/acintel.h
===================================================================
--- linux-pm.orig/include/acpi/platform/acintel.h
+++ linux-pm/include/acpi/platform/acintel.h
@@ -3,7 +3,7 @@
  *
  * Name: acintel.h - VC specific defines, etc.
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/platform/aclinuxex.h
===================================================================
--- linux-pm.orig/include/acpi/platform/aclinuxex.h
+++ linux-pm/include/acpi/platform/aclinuxex.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinuxex.h - Extra OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/include/acpi/platform/aclinux.h
===================================================================
--- linux-pm.orig/include/acpi/platform/aclinux.h
+++ linux-pm/include/acpi/platform/aclinux.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinux.h - OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/common/cmfsize.c
===================================================================
--- linux-pm.orig/tools/power/acpi/common/cmfsize.c
+++ linux-pm/tools/power/acpi/common/cmfsize.c
@@ -3,7 +3,7 @@
  *
  * Module Name: cmfsize - Common get file size function
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/common/getopt.c
===================================================================
--- linux-pm.orig/tools/power/acpi/common/getopt.c
+++ linux-pm/tools/power/acpi/common/getopt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: getopt
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
===================================================================
--- linux-pm.orig/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ linux-pm/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -3,7 +3,7 @@
  *
  * Module Name: oslinuxtbl - Linux OSL for obtaining ACPI tables
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/os_specific/service_layers/osunixdir.c
===================================================================
--- linux-pm.orig/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ linux-pm/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixdir - Unix directory access interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/os_specific/service_layers/osunixmap.c
===================================================================
--- linux-pm.orig/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ linux-pm/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixmap - Unix OSL for file mappings
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/os_specific/service_layers/osunixxf.c
===================================================================
--- linux-pm.orig/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ linux-pm/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixxf - UNIX OSL interfaces
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/tools/acpidump/acpidump.h
===================================================================
--- linux-pm.orig/tools/power/acpi/tools/acpidump/acpidump.h
+++ linux-pm/tools/power/acpi/tools/acpidump/acpidump.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acpidump.h - Include file for acpi_dump utility
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/tools/acpidump/apdump.c
===================================================================
--- linux-pm.orig/tools/power/acpi/tools/acpidump/apdump.c
+++ linux-pm/tools/power/acpi/tools/acpidump/apdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apdump - Dump routines for ACPI tables (acpidump)
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/tools/acpidump/apfiles.c
===================================================================
--- linux-pm.orig/tools/power/acpi/tools/acpidump/apfiles.c
+++ linux-pm/tools/power/acpi/tools/acpidump/apfiles.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apfiles - File-related functions for acpidump utility
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 
Index: linux-pm/tools/power/acpi/tools/acpidump/apmain.c
===================================================================
--- linux-pm.orig/tools/power/acpi/tools/acpidump/apmain.c
+++ linux-pm/tools/power/acpi/tools/acpidump/apmain.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apmain - Main module for the acpidump utility
  *
- * Copyright (C) 2000 - 2021, Intel Corp.
+ * Copyright (C) 2000 - 2022, Intel Corp.
  *
  *****************************************************************************/
 



