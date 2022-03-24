Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099694E6763
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352030AbiCXRBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbiCXRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 209955EBEE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648141169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HoU1CnOuyhMAlEaaC12/xCNXrJPRzI+Ntu0MYgwKlIE=;
        b=LxRT0VW2xgDERZgxoj9jyfzpb/VnzeAE/5clxBIzah6/c71dgsk/1zGB7tqUvW9exYIXDh
        f7woNuiPM4+xvPd6yqBmTT+P3EKrRGQqM6aa6QNh7QssxPXRc5LnI5iGWhwn8KaPStlzKJ
        j4IJg4RIcF9exoa5QhnVTC153wbGdxw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-0PnzShTtP7eZ3Lw5u9qB_Q-1; Thu, 24 Mar 2022 12:59:27 -0400
X-MC-Unique: 0PnzShTtP7eZ3Lw5u9qB_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2CE51044566;
        Thu, 24 Mar 2022 16:59:26 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB747C26EA0;
        Thu, 24 Mar 2022 16:59:23 +0000 (UTC)
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
Subject: [PATCH 1/3] Documentation/ABI: sysfs-driver-aspeed-uart-routing: Fix sphinx warning
Date:   Thu, 24 Mar 2022 17:59:16 +0100
Message-Id: <20220324165918.22005-2-hdegoede@redhat.com>
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

Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing:2:
  WARNING: Inline emphasis start-string without end-string.

This is caused by the used of '*' in the example cat command,
mark the command as code to fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
index b363827da437..1e25cd2cacc1 100644
--- a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
+++ b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
@@ -8,9 +8,10 @@ Description:	Selects the RX source of the UARTx device.
 		selected option marked by brackets "[]". The list of available options
 		depends on the selected file.
 
-		e.g.
-		cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
-		[io1] io2 io3 io4 uart2 uart3 uart4 io6
+		e.g.::
+
+			# cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
+			[io1] io2 io3 io4 uart2 uart3 uart4 io6
 
 		In this case, UART1 gets its input from IO1 (physical serial port 1).
 
-- 
2.35.1

