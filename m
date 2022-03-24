Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDDF4E6744
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbiCXQt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351794AbiCXQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07A0BADD6E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648140467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7qgwlx16gMa4fPk1wjLgWS5qaxNfrIcUO2G1rbGKjE=;
        b=Vhzabb7AOaRCM93b0qNDfYT83WgbZGJLiuSZtOu+no/Njs972NAxQkeUUyI/Sy3rbwnJ9x
        8jWK56XRSSAfyOXoJfyz5xkQ5lGeSHzj2wnT8r2HAEekDoGA+gneHDipLaX5biwf+xAdQG
        gXvulSF6H+dpMd6wvCbHpeupr++N4DA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-Y7GCWqX5PPqiln_NcQ1DwA-1; Thu, 24 Mar 2022 12:47:43 -0400
X-MC-Unique: Y7GCWqX5PPqiln_NcQ1DwA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F541811E7A;
        Thu, 24 Mar 2022 16:47:43 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2F5440146E;
        Thu, 24 Mar 2022 16:47:41 +0000 (UTC)
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
Subject: [PATCH 2/4] Documentation/ABI: sysfs-class-firmware-attributes: Fix Sphinx errors
Date:   Thu, 24 Mar 2022 17:47:35 +0100
Message-Id: <20220324164737.21765-3-hdegoede@redhat.com>
In-Reply-To: <20220324164737.21765-1-hdegoede@redhat.com>
References: <20220324164737.21765-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings from "make htmldocs":

Documentation/ABI/testing/sysfs-class-firmware-attributes:130:
  ERROR: Unexpected indentation.
  ERROR: Unexpected indentation.
  ERROR: Unexpected indentation.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../testing/sysfs-class-firmware-attributes   | 42 ++++++++++---------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 05820365f1ec..5356ff2ed6c8 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -246,9 +246,7 @@ Description:
 					that is being referenced (e.g hdd0, hdd1 etc)
 					This attribute defaults to device 0.
 
-		certificate:
-		signature:
-		save_signature:
+		certificate, signature, save_signature:
 					These attributes are used for certificate based authentication. This is
 					used in conjunction with a signing server as an alternative to password
 					based authentication.
@@ -257,22 +255,27 @@ Description:
 					The attributes can be displayed to check the stored value.
 
 					Some usage examples:
-					Installing a certificate to enable feature:
-						echo <supervisor password > authentication/Admin/current_password
-						echo <signed certificate> > authentication/Admin/certificate
 
-					Updating the installed certificate:
-						echo <signature> > authentication/Admin/signature
-						echo <signed certificate> > authentication/Admin/certificate
+						Installing a certificate to enable feature::
 
-					Removing the installed certificate:
-						echo <signature> > authentication/Admin/signature
-						echo '' > authentication/Admin/certificate
+							echo "supervisor password" > authentication/Admin/current_password
+							echo "signed certificate" > authentication/Admin/certificate
 
-					Changing a BIOS setting:
-						echo <signature> > authentication/Admin/signature
-						echo <save signature> > authentication/Admin/save_signature
-						echo Enable > attribute/PasswordBeep/current_value
+						Updating the installed certificate::
+
+							echo "signature" > authentication/Admin/signature
+							echo "signed certificate" > authentication/Admin/certificate
+
+						Removing the installed certificate::
+
+							echo "signature" > authentication/Admin/signature
+							echo "" > authentication/Admin/certificate
+
+						Changing a BIOS setting::
+
+							echo "signature" > authentication/Admin/signature
+							echo "save signature" > authentication/Admin/save_signature
+							echo Enable > attribute/PasswordBeep/current_value
 
 					You cannot enable certificate authentication if a supervisor password
 					has not been set.
@@ -288,9 +291,10 @@ Description:
 		certificate_to_password:
 					Write only attribute used to switch from certificate based authentication
 					back to password based.
-					Usage:
-						echo <signature> > authentication/Admin/signature
-						echo <password> > authentication/Admin/certificate_to_password
+					Usage::
+
+						echo "signature" > authentication/Admin/signature
+						echo "password" > authentication/Admin/certificate_to_password
 
 
 What:		/sys/class/firmware-attributes/*/attributes/pending_reboot
-- 
2.35.1

