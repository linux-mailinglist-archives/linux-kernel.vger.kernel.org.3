Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405504E6768
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352109AbiCXRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352081AbiCXRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF5860A88
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648141176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bScuBlTCR/SuoeRC/MEmbsQaF2jR6pySvoofKTbZ9I=;
        b=Z8rYfQPkxITCpWQhzmGulUBRQ1GJhm9u+qpv+G9vBK0Xkgll1gVrsfov5T+QIeZ7+N59Sk
        HfQeOkXbOqQ2Wj8eoL4S/EAl11cD3jBT75+ziJLGnPV6NjCOir9LlZhjbjrd98GPHl9c9h
        EpYtlEikHizxj2+k6GuVAAv5eyvjMdc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-QR4RPUjdPEunvOSwyOCvyQ-1; Thu, 24 Mar 2022 12:59:30 -0400
X-MC-Unique: QR4RPUjdPEunvOSwyOCvyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDCE61C0E343;
        Thu, 24 Mar 2022 16:59:29 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55416C15D7D;
        Thu, 24 Mar 2022 16:59:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Amit Kucheria <amitk@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Documentation/ABI: sysfs-class-thermal: Fix Sphinx warning
Date:   Thu, 24 Mar 2022 17:59:17 +0100
Message-Id: <20220324165918.22005-3-hdegoede@redhat.com>
In-Reply-To: <20220324165918.22005-1-hdegoede@redhat.com>
References: <20220324165918.22005-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning from "make htmldocs":

Documentation/ABI/testing/sysfs-class-thermal:201:
  WARNING: Bullet list ends without a blank line; unexpected unindent.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-class-thermal | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-thermal b/Documentation/ABI/testing/sysfs-class-thermal
index 2c52bb1f864c..8eee37982b2a 100644
--- a/Documentation/ABI/testing/sysfs-class-thermal
+++ b/Documentation/ABI/testing/sysfs-class-thermal
@@ -203,7 +203,7 @@ Description:
 
 		- for generic ACPI: should be "Fan", "Processor" or "LCD"
 		- for memory controller device on intel_menlow platform:
-		should be "Memory controller".
+		  should be "Memory controller".
 
 		RO, Required
 
-- 
2.35.1

