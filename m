Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C074E6767
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352086AbiCXRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352052AbiCXRBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF6566006E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648141174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IfREbj9fKQtRnAg2pDT/5pKTpdLNrvvzJnz4m1uJk0=;
        b=HZ3KlZj7BCU72xDTRb/kzDPDka3NuldZfIfrlgGm7CkApqjQyDTfbFfXvJqWU2NTg/WzXR
        ynLKEQGHZ4ojiQOlamM36Rl1w0TPHisd8XDTIXm0cLqPqAdF60eHDnsmMYP0CGEDkULPw+
        PYPGVvHFEXmP1nnXcd7PPTYI2HW9e2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-wCqIudkiPKuCtPvzD40K3w-1; Thu, 24 Mar 2022 12:59:33 -0400
X-MC-Unique: wCqIudkiPKuCtPvzD40K3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE0E9801585;
        Thu, 24 Mar 2022 16:59:32 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2759DC26EA0;
        Thu, 24 Mar 2022 16:59:30 +0000 (UTC)
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
Subject: [PATCH 3/3] Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors
Date:   Thu, 24 Mar 2022 17:59:18 +0100
Message-Id: <20220324165918.22005-4-hdegoede@redhat.com>
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

Fix the following warnings from "make htmldocs":

Documentation/ABI/testing/sysfs-fs-erofs:10:
  ERROR: Unexpected indentation.
  WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 05482374a741..bb4681a01811 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -9,8 +9,9 @@ Description:	Shows all enabled kernel features.
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
 Contact:	"Huang Jianan" <huangjianan@oppo.com>
-Description:	Control strategy of sync decompression
+Description:	Control strategy of sync decompression:
+
 		- 0 (default, auto): enable for readpage, and enable for
-				     readahead on atomic contexts only,
+		  readahead on atomic contexts only.
 		- 1 (force on): enable for readpage and readahead.
 		- 2 (force off): disable for all situations.
-- 
2.35.1

