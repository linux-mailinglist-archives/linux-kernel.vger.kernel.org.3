Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF34E6741
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351801AbiCXQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351791AbiCXQtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CE53ADD67
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648140465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xvphswbIShpn8BqHGvoNZfriq6MGSK7x/m0+DsGWrM=;
        b=PXQAqzGRgc12KO4auEzX6nvHZX3KaJTD6N/p/LdplpB8jdDKevEqNVGS0tyZNQlm4Fvzyz
        M2cEqWhCibIZfmkoUyt7dkPJCQ/AhJYW+5dEETfrENK2XvasGRgmIaupJN4dhTeDNjpo1j
        dqkIz7FVygQ/5HTUtsN7Vyn3D1ZL0VQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-zL0gSrFBMVOuuZvpg8Dp1w-1; Thu, 24 Mar 2022 12:47:42 -0400
X-MC-Unique: zL0gSrFBMVOuuZvpg8Dp1w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E25818E5340;
        Thu, 24 Mar 2022 16:47:41 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A61D40146E;
        Thu, 24 Mar 2022 16:47:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/4] Documentation/ABI: sysfs-driver-intel_sdsi: Fix sphinx warnings
Date:   Thu, 24 Mar 2022 17:47:34 +0100
Message-Id: <20220324164737.21765-2-hdegoede@redhat.com>
In-Reply-To: <20220324164737.21765-1-hdegoede@redhat.com>
References: <20220324164737.21765-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings from "make htmldocs":

Documentation/ABI/testing/sysfs-driver-intel_sdsi:2:
  WARNING: Unexpected indentation.
  WARNING: Block quote ends without a blank line; unexpected unindent.
  WARNING: Definition list ends without a blank line; unexpected unindent.

By turning the error-code table into a proper ReST table. While at it
also fix the error-code table mixing tab and spaces for indentation
(switch to all tabs).

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../ABI/testing/sysfs-driver-intel_sdsi        | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
index ab122125ff9a..96b92c105ec4 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel_sdsi
+++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
@@ -13,17 +13,19 @@ Description:
 		Should the operation fail, one of the following error codes
 		may be returned:
 
+		==========	=====
 		Error Code	Cause
-	        ----------	-----
-	        EIO		General mailbox failure. Log may indicate cause.
-	        EBUSY		Mailbox is owned by another agent.
-	        EPERM		SDSI capability is not enabled in hardware.
-	        EPROTO		Failure in mailbox protocol detected by driver.
+		==========	=====
+		EIO		General mailbox failure. Log may indicate cause.
+		EBUSY		Mailbox is owned by another agent.
+		EPERM		SDSI capability is not enabled in hardware.
+		EPROTO		Failure in mailbox protocol detected by driver.
 				See log for details.
-	        EOVERFLOW	For provision commands, the size of the data
+		EOVERFLOW	For provision commands, the size of the data
 				exceeds what may be written.
-	        ESPIPE		Seeking is not allowed.
-	        ETIMEDOUT	Failure to complete mailbox transaction in time.
+		ESPIPE		Seeking is not allowed.
+		ETIMEDOUT	Failure to complete mailbox transaction in time.
+		==========	=====
 
 What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/guid
 Date:		Feb 2022
-- 
2.35.1

