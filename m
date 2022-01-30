Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C94A3720
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355387AbiA3PAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355350AbiA3O72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643554765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xudE8SFyweDgi30gczcfI1OPOT6rRDCIESB6EBvxvdI=;
        b=VYjQlXhpjRa05IUArUKr4DzzoYY0h3KYQphHtUYSY7I0qEO1kPqBZAyEunVvsOJU04Mgxy
        Az2FltEPulUoQDKOJILZkIJ8KCjHZePiXTqwmYsLeoVfM7PJFA1TtyxAz9Aj8lLjmDsSDg
        HMGNk+ZCMuA8SftV7sCsM/FEitCXKAE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-CRtWt9zgNI2Oxq75J2iJ2A-1; Sun, 30 Jan 2022 09:59:24 -0500
X-MC-Unique: CRtWt9zgNI2Oxq75J2iJ2A-1
Received: by mail-qt1-f198.google.com with SMTP id y1-20020ac87041000000b002c3db9c25f8so8316658qtm.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 06:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xudE8SFyweDgi30gczcfI1OPOT6rRDCIESB6EBvxvdI=;
        b=HFHZvqYGfn1VuaugxdpB24+woc4s7DRFwcv0o71R3tx1rXnBxPtNRRm1j3g0aRXxMS
         QvBfp6MYRAZEeELSvIWBGg4GwzWZ8gi/W5qhX5M0K6D4KU763ngw4K5rlnIQeHHfM9NQ
         2kMBdBvBNJiLbhuUnmunLLc6E0te2/RVhIgoPX66IGvLPR+F/V6hZT86+xi8th9VOyZf
         +eojzxqdHTi5PiyAWrFHTydi2/770SeekDWhsO5tVOz78ofN5sOYRULaPcNvfIille5M
         GiyGu6vCjPKSv/2vepZF2H13YA0y8GfwPmrKga64JcoCMdIRBHKCbuBlK0NFdWJlo9tL
         JnfQ==
X-Gm-Message-State: AOAM531YNXL8GMquQyKOvzb0fR3QPqAdayvYCplhJHlz8JkAkYV+keCv
        PiEhn6ytnyUXgSVeA5qYhopSu3CrjkfPLgb+NgyrCoMsTGny72ZiGbo6G1VaT6poWYpPf8nXO7t
        G+Hjab2B60c/Hhj8TnvF54Vv3
X-Received: by 2002:a05:622a:38c:: with SMTP id j12mr11682790qtx.336.1643554764051;
        Sun, 30 Jan 2022 06:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZhw5EwnviYrqCBy0aif5dSsqa62U9luVFrPneT4ZfeEcZxFYRqIU2Vgthv4/kf4s0YPIZxQ==
X-Received: by 2002:a05:622a:38c:: with SMTP id j12mr11682777qtx.336.1643554763850;
        Sun, 30 Jan 2022 06:59:23 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bl1sm7251745qkb.16.2022.01.30.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 06:59:23 -0800 (PST)
From:   trix@redhat.com
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ACPICA: cleanup double word in comment
Date:   Sun, 30 Jan 2022 06:59:18 -0800
Message-Id: <20220130145918.1498203-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'than'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/acpica/hwregs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 69603ba52a3ac..f62d5d0242058 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -446,7 +446,7 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
  * RETURN:      Status
  *
  * DESCRIPTION: Write the PM1 A/B control registers. These registers are
- *              different than than the PM1 A/B status and enable registers
+ *              different than the PM1 A/B status and enable registers
  *              in that different values can be written to the A/B registers.
  *              Most notably, the SLP_TYP bits can be different, as per the
  *              values returned from the _Sx predefined methods.
-- 
2.26.3

