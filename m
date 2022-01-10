Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904AE48903D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiAJGgq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 01:36:46 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:48648 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235018AbiAJGgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:36:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-sUP3oVoqMk-bZGQowZhJow-1; Mon, 10 Jan 2022 01:36:44 -0500
X-MC-Unique: sUP3oVoqMk-bZGQowZhJow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4230A344AF;
        Mon, 10 Jan 2022 06:36:42 +0000 (UTC)
Received: from bzdocha.local (unknown [10.43.2.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E6B7B031;
        Mon, 10 Jan 2022 06:36:33 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] platform/x86: x86-android-tablets: Trivial typo fix for MODULE_AUTHOR
Date:   Mon, 10 Jan 2022 07:36:29 +0100
Message-Id: <20220110063629.273364-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lkundrak@v3.sk
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: v3.sk
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring balance to the quoting of Hans' e-mail address.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/x86/x86-android-tablets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index c5b1f25d849f..9333bbec33e9 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -1074,6 +1074,6 @@ static __init int x86_android_tablet_init(void)
 module_init(x86_android_tablet_init);
 module_exit(x86_android_tablet_cleanup);
 
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("X86 Android tablets DSDT fixups driver");
 MODULE_LICENSE("GPL");
-- 
2.33.1

