Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D0490625
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiAQKlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiAQKlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:41:03 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2803C061574;
        Mon, 17 Jan 2022 02:41:02 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4JcpND5TTTzQkFW;
        Mon, 17 Jan 2022 11:41:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642416058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVaFMeMetbF2chCKkaAP7mGT+Mpn+9qurXFgcY31yEw=;
        b=jUy2gcE9V1KUXbBFmiotlqLp/bItR2PqcNqtJ4ZeErZYCKsJI/kPOWzCi9/nCFm9rz+ycN
        e8OzWBE+fq1/2p1o2adZP6LnrVAXnZPhAKwaOhelN+tOrHg6Xu3D1ZRhbYsiukBWREE/Ok
        vyiOJPKpz+xJFi9XzlsAgod1BCzz1hqAFySG7wiDtwjh/T3iRItredPxyw28dkego0JXyC
        KSILaQ9Q9XA75ffCAejp/1IS88TU5XcWMhNhW3dafSezAYWl4+381SvfBBBu4VH8B55wir
        zWClWvPju7XuYPwrW0QZw/4MlOkatILSkrskvkNp5gbHJ6jlJArCv6X7isFtCg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2 1/4] hwmon: (max6639) Update Datasheet URL
Date:   Mon, 17 Jan 2022 11:40:23 +0100
Message-Id: <76025f40d2684dc0d3ec02c8899b726b07a0e7da.1642413668.git.sylv@sylv.io>
In-Reply-To: <cover.1642413668.git.sylv@sylv.io>
References: <cover.1642413668.git.sylv@sylv.io>
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

