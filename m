Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53004834F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiACQlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiACQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:41:40 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jan 2022 08:41:40 PST
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F46C061761;
        Mon,  3 Jan 2022 08:41:40 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4JSLv925YmzQlLQ;
        Mon,  3 Jan 2022 17:35:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1641227700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVaFMeMetbF2chCKkaAP7mGT+Mpn+9qurXFgcY31yEw=;
        b=Ft18cB8WzNQOXw5b2wYqIlYweCebjU2JnRNNYrh6cxhIfQ9krzjXMF779dY3PqaYcV0KMl
        OpcPwPa/lm1rNc9sL1CIL7IqeHx5mj0AlfKmkssr52RyOyw6Nmy2JSxb6H57pPjQoQmyW1
        qBTUFjf1yHyOk9kBZb5fT97rz+F6W1buTm8qF6/5HgLou3IDMhFrCI4+XJjStRNOyHiFBQ
        bMb/rV8c66vCxJmBVMmxPc0OseF7YNoLPA9rklTaNBVV/9q2w46IdQbhA48hVp/Rp09bNq
        WnN17Xx9nWdyuMrDYAGUncIFOuSiGuBrTbyiHNPFMkIZ765C/MNV7HfhQIRAKw==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] hwmon: (max6639) Update Datasheet URL
Date:   Mon,  3 Jan 2022 17:33:51 +0100
Message-Id: <9de5b23396e4031158a68bfbd47d370b50080e43.1641224715.git.sylv@sylv.io>
In-Reply-To: <cover.1641224715.git.sylv@sylv.io>
References: <cover.1641224715.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old Datasheet does not exist anymore.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 Documentation/hwmon/max6639.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max6639.rst b/Documentation/hwmon/max6639.rst
index 3da54225f83c..c85d285a3489 100644
--- a/Documentation/hwmon/max6639.rst
+++ b/Documentation/hwmon/max6639.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c, 0x2e, 0x2f
 
-    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6639.pdf
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
 
 Authors:
     - He Changqing <hechangqing@semptian.com>
-- 
2.33.1

