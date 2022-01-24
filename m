Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5A49850E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiAXQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:43:00 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48884 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbiAXQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:42:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4JjG4f2L5Lz9xgl4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A4hgbZ1LUX7S for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:42:58 -0600 (CST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4JjG4d75Hbz9xgl2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:42:57 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4JjG4d75Hbz9xgl2
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4JjG4d75Hbz9xgl2
Received: by mail-pf1-f198.google.com with SMTP id v10-20020a62ac0a000000b004c97d435156so1479188pfe.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkMHnLhdVlAFXL1f9xT6ZtHXh+qR3Ozk42TcA0ftXx4=;
        b=ZhdWKaWWfpclwFUb8NuXxOWd5VrMEBGzCGE7PFvSoQsXdoWIFrcS6HCyURolNWkbuf
         MbOj3l3r8fxXLQi33EYslAJJqn0CC3yaZbSH/yrKBVS2l44o5Z9+iR5pOLEOZtl6EgQt
         lCr1UhIzQO/k6K+Cw5uTyws2k+Na0rZIAl30PBPbph2ctGSc2pyoS7k8NfZGX6RdhKN/
         OpuY/UqEgv7fphtn95LpHupAwjbIEl/vTBywUB3kdg2C7EGX5nb2oUGb/3bDet+USh1w
         z8rM0HkqgbhCFYZrVyHcmWyCdeGq9MfzaXzHRO587j3bXbd7LEVcR9hDH5xmizmLB71o
         NtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkMHnLhdVlAFXL1f9xT6ZtHXh+qR3Ozk42TcA0ftXx4=;
        b=vwlet/Irwv0AteNkNYIzTHsV7RPKJw8vT/ozuNWOsd8XQdjXmQZJcZalTCp36RlxiX
         H1hSR8DtmAZUNT2TVE4YMLwOta5PuU6d770LcRoZfLhgQTD8BD5nUI+fuTp9iOEOAHXY
         Ng7m4Q5rGY0qvB6ggyHU+YbIHmSeFbp/ArolzjKF/FHbe0OEb0Z9VtQmwcV9opMYxLFj
         H+zOW4226Xm/jJNhscqQckrjJ0rFfe1axpNiYcuJ4OfZhJTT/V9g7SzBP6+cwUh2+lIF
         EVrWy3dhetmLz6j5kSHTmgV8pjEl5GuKqW42f8sZYXjeIA/dblReN/f7192jNQnY4wVt
         +PDg==
X-Gm-Message-State: AOAM533kDMH4e8GSTFja6bhZBI3LvZ6HvzsoI5Hv9t7dovaXvMH0xeyD
        9eGY2Y3ca846uRB8ukAqmwGmDOSAPdOYaVkSzmZZQwyDfxTQkTxI5VxtRaPpLsV0vSrziHmNUed
        YH2ErLssy3FA35zFbtmypBgBwS3Y/
X-Received: by 2002:a63:68c3:: with SMTP id d186mr12483297pgc.306.1643042577256;
        Mon, 24 Jan 2022 08:42:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI5QjCBYvNzKdspif2Q6QAqpXfTi6c38b6CKUse+xdHlcdxo3pGtKk1r+Pl3rp4yf7ug9MHA==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr12483281pgc.306.1643042576997;
        Mon, 24 Jan 2022 08:42:56 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id r4sm8201788pjj.56.2022.01.24.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:42:56 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / tables: Fix a NULL pointer dereference in acpi_table_initrd_override()
Date:   Tue, 25 Jan 2022 00:42:51 +0800
Message-Id: <20220124164251.52466-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acpi_table_initrd_override(), the return value of acpi_os_map_memory()
is assigned to table and there is a dereference of it after that.
acpi_os_map_memory() will return NULL on failure, which may lead to NULL
pointer dereference.

Fix this bug by adding a NULL check of table.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 5ae74f2cc2f1 ("ACPI / tables: Move table override mechanisms to tables.c")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/acpi/tables.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0741a4933f62..8b10c192ed32 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -696,6 +696,10 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
 	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
 		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
 					   ACPI_HEADER_SIZE);
+		if (!table) {
+			return AE_NO_MEMORY;
+		}
+
 		if (table_offset + table->length > all_tables_size) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			WARN_ON(1);
-- 
2.25.1

