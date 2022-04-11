Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1ED4FC49D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349384AbiDKTHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349376AbiDKTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:06:55 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFACE2F388;
        Mon, 11 Apr 2022 12:04:29 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 2d7cc22c75eb7076; Mon, 11 Apr 2022 21:04:27 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B40E266BDFE;
        Mon, 11 Apr 2022 21:04:26 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 12/20] ACPICA: executer/exsystem: Add units to time variable names
Date:   Mon, 11 Apr 2022 20:57:02 +0200
Message-ID: <8110555.NyiUUSuA9g@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Menzel <pmenzel@molgen.mpg.de>

ACPICA commit b69cbef7a83eadb102a1ff6c6f6fc5abce34805a

`how_long` refers to different units in both functions, so make it more
clear, what unit they expect. That also makes one comment superfluous.

Link: https://github.com/acpica/acpica/commit/b69cbef7
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 exsystem.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff -Nurp linux.before_name/drivers/acpi/acpica/exsystem.c linux.after_name/drivers/acpi/acpica/exsystem.c
--- linux.before_name/drivers/acpi/acpica/exsystem.c	2022-04-01 18:26:24.556426955 +0200
+++ linux.after_name/drivers/acpi/acpica/exsystem.c	2022-04-01 18:26:20.646475824 +0200
@@ -107,7 +107,7 @@ acpi_status acpi_ex_system_wait_mutex(ac
  *
  * FUNCTION:    acpi_ex_system_do_stall
  *
- * PARAMETERS:  how_long        - The amount of time to stall,
+ * PARAMETERS:  how_long_us     - The amount of time to stall,
  *                                in microseconds
  *
  * RETURN:      Status
@@ -120,24 +120,24 @@ acpi_status acpi_ex_system_wait_mutex(ac
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_do_stall(u32 how_long)
+acpi_status acpi_ex_system_do_stall(u32 how_long_us)
 {
 	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_ENTRY();
 
-	if (how_long > 255) {	/* 255 microseconds */
+	if (how_long_us > 255) {
 		/*
-		 * Longer than 255 usec, this is an error
+		 * Longer than 255 microseconds, this is an error
 		 *
 		 * (ACPI specifies 100 usec as max, but this gives some slack in
 		 * order to support existing BIOSs)
 		 */
 		ACPI_ERROR((AE_INFO,
-			    "Time parameter is too large (%u)", how_long));
+			    "Time parameter is too large (%u)", how_long_us));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
-		acpi_os_stall(how_long);
+		acpi_os_stall(how_long_us);
 	}
 
 	return (status);
@@ -147,7 +147,7 @@ acpi_status acpi_ex_system_do_stall(u32
  *
  * FUNCTION:    acpi_ex_system_do_sleep
  *
- * PARAMETERS:  how_long        - The amount of time to sleep,
+ * PARAMETERS:  how_long_ms     - The amount of time to sleep,
  *                                in milliseconds
  *
  * RETURN:      None
@@ -156,7 +156,7 @@ acpi_status acpi_ex_system_do_stall(u32
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_do_sleep(u64 how_long)
+acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
 {
 	ACPI_FUNCTION_ENTRY();
 
@@ -168,11 +168,11 @@ acpi_status acpi_ex_system_do_sleep(u64
 	 * For compatibility with other ACPI implementations and to prevent
 	 * accidental deep sleeps, limit the sleep time to something reasonable.
 	 */
-	if (how_long > ACPI_MAX_SLEEP) {
-		how_long = ACPI_MAX_SLEEP;
+	if (how_long_ms > ACPI_MAX_SLEEP) {
+		how_long_ms = ACPI_MAX_SLEEP;
 	}
 
-	acpi_os_sleep(how_long);
+	acpi_os_sleep(how_long_ms);
 
 	/* And now we must get the interpreter again */
 



