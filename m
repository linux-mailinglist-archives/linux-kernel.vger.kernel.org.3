Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B514984FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiAXQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:40:23 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:55678 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243785AbiAXQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:40:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4JjG1d4vhCz9xhTg
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yoAwxsAGPphS for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:40:21 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4JjG1d2vCLz9xhTk
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:40:21 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4JjG1d2vCLz9xhTk
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4JjG1d2vCLz9xhTk
Received: by mail-pj1-f69.google.com with SMTP id q1-20020a17090a064100b001b4d85cbaf7so14028207pje.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxLL3kilti4ewVR3w7E45Znhv6mVTGnaO20o6vv+LVM=;
        b=JpaXbkVPCCzYwDK587ZtC73AffzMALrsKE+nNt2D0mgffg8Gs2TwFtlI7d00fAe2TL
         6MHNAA6ISqfAxx/VhnWjRSueDDXe5Gbh0N7mbYX6mqKu88a4cxeOjlP4tgXucRKW0uFY
         3hF5zPCbgkNMGFj6RUEHp8zFFkOWKXFLma2CFIuwLfpM32YmO2K5oZapIAkzA3dkjaBK
         tNQj7q/UoNKZcXKl/Jf0qCYnUuwnjkWkJ8AlGYl6iN5+hj53K0dh8LdU7rpw4+sLl1X0
         a3yKSjCSpKM+u7mPfQkurNP/Sdh7aIcMMptvxGPzzxvwrEFqr7NW72lczyMlPWTOdM7h
         guCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxLL3kilti4ewVR3w7E45Znhv6mVTGnaO20o6vv+LVM=;
        b=M0Gvp+6nWqaQNEZuQQWovIM/Ytzdj6U0OKlj6Nt0n3f380G2U4BgqvuyxUyve/lyz/
         HXzsO1NZkdobFQqINPuMJJ8bKJXeA0++PKXrtOJRLXHk5TKfTujj53wL5oAF88GyLYLO
         EXKAFwiIY8uogieepe7JBUuEqBdvuwoFgTJPs86UPZityPSROAzalC5eJ2OTtgawzHrl
         YGpLVhs0YMYyqO6Lb/MjmUNx2S94oaMSnNcpN4ZtBhyt6EsY/JacUZ6LYu8J+ctoFZNX
         yKGLKLcGf7Jm7V93pRvItZTjlPoD/6QjY0ubKz/bLwCnCqWNDrIy2D5DuS7wgt2gD3r+
         1ADw==
X-Gm-Message-State: AOAM530uVkk6b9Ir6PUEJ3DNZWyBIEYnzkYPvOUS1xaalQHHZg6v/SBo
        kqxhjacNWvyANwREvFXlPeKuyGtLJA0oD7gE0Dt+mkngW7l3x25ZhvrPZPgTPVHJWeWEvPdMjkY
        GXctNarNblG3VfFpKdjKMD2nG2SbA
X-Received: by 2002:a17:90b:33cb:: with SMTP id lk11mr641662pjb.163.1643042420643;
        Mon, 24 Jan 2022 08:40:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKOpecXgH6OOu7Zh1Mdt8qsroSNZreBYhHQlXtTouXfATIb4NWFFgnxqg5cED3i6NAq7waBw==
X-Received: by 2002:a17:90b:33cb:: with SMTP id lk11mr641645pjb.163.1643042420395;
        Mon, 24 Jan 2022 08:40:20 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id bf23sm13770284pjb.52.2022.01.24.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:40:20 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: Linuxize: Fix a NULL pointer dereference in acpi_db_convert_to_package()
Date:   Tue, 25 Jan 2022 00:40:14 +0800
Message-Id: <20220124164014.51658-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acpi_db_convert_to_package(), the variable elements is assigned by
ACPI_ALLOCATE_ZEROED() and passes its address to 
acpi_db_convert_to_object(). In that function we may have a dereference
of elements without checks. ACPI_ALLOCATE_ZEROED() would return NULL on
failure, which may lead to NULL pointer dereference.

Fix this bug by adding a NULL check of elements.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..8dbab6932049 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.25.1

