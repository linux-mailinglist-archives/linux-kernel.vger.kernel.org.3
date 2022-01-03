Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E7483505
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiACQm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:42:59 -0500
Received: from mout-y-209.mailbox.org ([91.198.250.237]:13554 "EHLO
        mout-y-209.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiACQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:42:54 -0500
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 11:42:54 EST
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4JSLv342gWzQl13;
        Mon,  3 Jan 2022 17:34:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1641227691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVaFMeMetbF2chCKkaAP7mGT+Mpn+9qurXFgcY31yEw=;
        b=RELAq90Z9vHK6rkuZ9Ko8eYCR/XT4rUj1XVatTCXJqLGU/4D80DcXLRJjMkrPm+ZYIP0Pc
        4kkEsZmydu18ideLPYCbFl1HHuvSGENl2UNlHaoHZI3AVxNrsHp2fTxzVbDcg3m3j5b1n3
        BMuerl5u61AhnAauFenAJC2ptVaTsBn4CYROOHyOit2nMFyuCX9LTJAZPTKej/Y9qz1mlj
        X8OVOpXBCJG8K8GneLhhCFQmOY/++15bfxKhvVJnJSo7Z7aecZqwyLUq6JD0/17x4F8qt5
        +U8STaWb0lY4FzwJNpf9rPfiBq8AdNLHJmNnESGa5wp9uf2NQ68669TwPLoFgg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] hwmon: (max6639) Update Datasheet URL
Date:   Mon,  3 Jan 2022 17:33:46 +0100
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

