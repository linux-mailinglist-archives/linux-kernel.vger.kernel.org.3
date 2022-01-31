Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28954A483C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349051AbiAaNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:33:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235633AbiAaNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643636024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VfFqvSMV9Otew6WwuduSbrALdReBxJUaJj+oMXEGVOY=;
        b=jENr9/180kLfwkhAPpOiL/D0c4pP4Q9sVwAXpM2veNjCxeUwnlPaDL2r2WElVkJlTKDRnG
        tIGVDDBupnkUkH4BAmWtm/yVlgHEizW26sQ3vizHHy4m4I2/ieEEAeZCHI0IsqE8oguSUN
        WgspDEF4YbEPrqIGSQ8PVx8oV2KeRFY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-KPdmslGGNqWItuQwAUZLOA-1; Mon, 31 Jan 2022 08:33:43 -0500
X-MC-Unique: KPdmslGGNqWItuQwAUZLOA-1
Received: by mail-qv1-f70.google.com with SMTP id gg10-20020a056214252a00b0041eeb1c2684so12598345qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfFqvSMV9Otew6WwuduSbrALdReBxJUaJj+oMXEGVOY=;
        b=yoBzZXhRZFHOFh/FPfKKjCyRrdbpoMLbqGrUxXgLkxh+ySPdQ2o+/3Vd3Q29yaKLsW
         YRvsgWXgE9QGLye9nLm7/VH3QhGKL/aGx4CO1BheP+C1/h6iB8nj+ODyyHMHSkh2/q0Q
         2PewjUfaVBUZIXmyYGWLZXpMtVd0yQcdUSNKGHErULpdPNY5qzjdkzhxwIDo7rBDpijO
         twQ4MrCIkHJKrJObTQQa82KbYXbDcMUVTWdHE4zgZm8WcYFnwZjYwXaOwT8DEiygHB70
         Ev0E+EaRE6pQ8yJdLW1vUO+UEjbJDZMfzXAT0oqoEByzFJKf1L2AQC0xMy3IbFKisoES
         nBww==
X-Gm-Message-State: AOAM530lU583lxjL41zf5MJgK/fqEu5d7B/aZBI5oTBhpfCG3wBP0QOt
        9h7bDIN6a2kQlDvcPmYmF6sWjCnaO9jbmRENC+7Z3uzcxufxzFaiwEO+Gv3goHybIO6Y9ra/Gwb
        Vy9sRNTgDY1P+SEomQD+7Q5wW
X-Received: by 2002:a05:620a:1792:: with SMTP id ay18mr13373133qkb.12.1643636022755;
        Mon, 31 Jan 2022 05:33:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0RwA9z2nQfn12ZGFBT5t9iGfjKQ2Az19u0I4r0E5BKCJkPncDYJOi+4lmU54lStlau3WU/A==
X-Received: by 2002:a05:620a:1792:: with SMTP id ay18mr13373119qkb.12.1643636022563;
        Mon, 31 Jan 2022 05:33:42 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id u16sm2047274qtx.46.2022.01.31.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:33:42 -0800 (PST)
From:   trix@redhat.com
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ACPICA: cleanup double word in comment
Date:   Mon, 31 Jan 2022 05:33:37 -0800
Message-Id: <20220131133337.1556355-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'know'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/acpica/exfldio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index bdc7a30d1217c..b92605df3872c 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -104,7 +104,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 #ifdef ACPI_UNDER_DEVELOPMENT
 	/*
 	 * If the Field access is any_acc, we can now compute the optimal
-	 * access (because we know know the length of the parent region)
+	 * access (because we know the length of the parent region)
 	 */
 	if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
 		if (ACPI_FAILURE(status)) {
-- 
2.26.3

