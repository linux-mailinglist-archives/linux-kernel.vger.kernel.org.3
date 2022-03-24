Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F094E6745
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351812AbiCXQtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351795AbiCXQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF7A0ADD70
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648140468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlnvIl9jA2QQKrCnsdch9ZXCYegwpwfAzUxubyxp7TA=;
        b=gyjxs/EC6YV/52Qii3M0V5VlxTJd2Y7cSJr6JtLm7h7E7PdT+vzLZW1FYH+P3NU8jLBPlm
        I9Af/0PaCRVGqf61WJ02jTAG0LFN0C2eMFkTgYW5m49DiioYOpbjx19pN5wGs3xQzep7dM
        IeX+hj4m4Y6n8PgmbLCtZ8t7Kn2TW2E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-uTQaEyQQME-cXH23bm0lcQ-1; Thu, 24 Mar 2022 12:47:45 -0400
X-MC-Unique: uTQaEyQQME-cXH23bm0lcQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5D5E1C05AE6;
        Thu, 24 Mar 2022 16:47:44 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 641DF40146E;
        Thu, 24 Mar 2022 16:47:43 +0000 (UTC)
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
Subject: [PATCH 3/4] Documentation/ABI: sysfs-class-firmware-attributes: Misc. cleanups
Date:   Thu, 24 Mar 2022 17:47:36 +0100
Message-Id: <20220324164737.21765-4-hdegoede@redhat.com>
In-Reply-To: <20220324164737.21765-1-hdegoede@redhat.com>
References: <20220324164737.21765-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup / fix some minor issues.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-class-firmware-attributes | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 5356ff2ed6c8..4cdba3477176 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -116,7 +116,7 @@ Description:
 					    <value>[ForceIf:<attribute>=<value>]
 					    <value>[ForceIfNot:<attribute>=<value>]
 
-					For example:
+					For example::
 
 					    LegacyOrom/dell_value_modifier has value:
 						    Disabled[ForceIf:SecureBoot=Enabled]
@@ -212,7 +212,7 @@ Description:
 		the next boot.
 
 		Lenovo specific class extensions
-		------------------------------
+		--------------------------------
 
 		On Lenovo systems the following additional settings are available:
 
@@ -349,7 +349,7 @@ Description:
 
 		    # echo "factory" > /sys/class/firmware-attributes/*/device/attributes/reset_bios
 		    # cat /sys/class/firmware-attributes/*/device/attributes/reset_bios
-		    # builtinsafe lastknowngood [factory] custom
+		    builtinsafe lastknowngood [factory] custom
 
 		Note that any changes to this attribute requires a reboot
 		for changes to take effect.
-- 
2.35.1

