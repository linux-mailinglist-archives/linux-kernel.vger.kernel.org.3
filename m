Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6648D4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiAMJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiAMJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:24:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BA3C06173F;
        Thu, 13 Jan 2022 01:24:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r28so8940062wrc.3;
        Thu, 13 Jan 2022 01:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCkVJzyBm9DkekZ2srPt2opWmyZGjkyE6LY+JDVYLMc=;
        b=MsEIc3Ul3dQHDwDf72c+U1apAqZ/UZChA40f5xPrGXMuNIeszzQ2ga75db/EC5nwQZ
         Bj7kDO6oTSLkU3aesgaL9ILia2lxZysY9XmPUiUFEa8uCtUXRUoFmggNsTxKFX1lBf6N
         APpNAwShwQesTa6CXS4Z+VfDm6EmUwgiKeiXHHkyE1Aw7byNdHxIbTEBLsQdEnfmQzs9
         8Z8FYMxNwg0BciquMWt5UO8ev8l9bFqKUHTqGNuuuAWDZA7x+XTQ8W/VaAFuA1Or0i3L
         V0v9YzUqttEkBvQMwNPTC4DLInyXdV+w8mF/EWLxZip7N8xUxvroftV6POWJi6W6DXbb
         tflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCkVJzyBm9DkekZ2srPt2opWmyZGjkyE6LY+JDVYLMc=;
        b=Y15xZd87oIj9TT5I1Hkvb4xlOOqBxbj2imZxLyXmdeA+yLBgUzVz14IrVhzkrA+SO2
         JOO/IgTgx7pasTOH1QnHqdGUJNgttQymQ4hrKKm51QWKT6Nv09xzqGHWehXqwNytVOn/
         yxvrATUnXLLBQn4lgj4num0d342TJRV2rvcmqJUGpUQ/fwcyj+CsGl+qrZP9cXwor0Bl
         jNVe8ufCajiE0ZkZrwtLX8VlLjhZN/2h/rBITVjzSa+Q+s+IKQGswvZtXXdbwSBMGYGf
         7cRtf5VX2o/PBSX55XVgSLgH6cksM/ZBg/Uxp8KwezVwqSLerkM+ZquMMEHw4Os4UtDg
         lDKQ==
X-Gm-Message-State: AOAM5316bv98PLVxWpmvwRRyKCNmqvpidQC/1r5NKt7uYsBl5TUQYFcn
        tCDDLVfZRRm2kACPDKtRaYDSjT7wlB0EfOHE
X-Google-Smtp-Source: ABdhPJyS3TMFMdJLERgMpQrmKP5ReJTdSxtyerLoyjHay7GNS9ARuJkSbPijRSZNowPJ4AcmuFrs2A==
X-Received: by 2002:adf:d23b:: with SMTP id k27mr3368042wrh.517.1642065858592;
        Thu, 13 Jan 2022 01:24:18 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r13sm1938459wrn.101.2022.01.13.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:24:18 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kernel: Fix spelling mistake "compresser" -> "compressor"
Date:   Thu, 13 Jan 2022 09:24:17 +0000
Message-Id: <20220113092417.1354537-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a pr_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/module_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module_decompress.c b/kernel/module_decompress.c
index aeefd95a3337..b01c69c2ff99 100644
--- a/kernel/module_decompress.c
+++ b/kernel/module_decompress.c
@@ -106,7 +106,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 
 	rc = zlib_inflateInit2(&s, -MAX_WBITS);
 	if (rc != Z_OK) {
-		pr_err("failed to initialize decompresser: %d\n", rc);
+		pr_err("failed to initialize decompressor: %d\n", rc);
 		retval = -EINVAL;
 		goto out;
 	}
-- 
2.33.1

