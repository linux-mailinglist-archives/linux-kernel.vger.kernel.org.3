Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16934E6746
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351824AbiCXQth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351807AbiCXQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B474ADD60
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648140470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3yznAVa11IPBnnYwZf5Cua2JEMNbm4oYIGv6D2ELLY=;
        b=fxnsm17YIBhzyQhG5y1d1ZBG4aeraxGnhOItBOZO8h4eGY9qz/NHYfh630qanpemdd9mTF
        bQUMtzNtzNZL3kbJgQ1S9/OKlDUviQptGogP44mzfYPijCE7hmqv8c/PKSGSoMHSyeIgaz
        nOO0FhgXlGXH6vku8dr2eUvuBPBQx8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-IOys9a3oPNWp4-Zu6myxvg-1; Thu, 24 Mar 2022 12:47:47 -0400
X-MC-Unique: IOys9a3oPNWp4-Zu6myxvg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88142185A7A4;
        Thu, 24 Mar 2022 16:47:46 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 169F3417E32;
        Thu, 24 Mar 2022 16:47:44 +0000 (UTC)
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
Subject: [PATCH 4/4] Documentation/ABI: sysfs-class-power: Fix Sphinx error
Date:   Thu, 24 Mar 2022 17:47:37 +0100
Message-Id: <20220324164737.21765-5-hdegoede@redhat.com>
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

Fix the following error from "make htmldocs":

Documentation/ABI/testing/sysfs-class-power:459: ERROR:
No bottom table border found.

================ ====================================
auto:            Charge normally, respect thresholds
inhibit-charge:  Do not charge while AC is attached
force-discharge: Force discharge while AC is attached

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-class-power | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index fde21d900420..859501366777 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -468,6 +468,7 @@ Description:
 			auto:            Charge normally, respect thresholds
 			inhibit-charge:  Do not charge while AC is attached
 			force-discharge: Force discharge while AC is attached
+			================ ====================================
 
 What:		/sys/class/power_supply/<supply_name>/technology
 Date:		May 2007
-- 
2.35.1

