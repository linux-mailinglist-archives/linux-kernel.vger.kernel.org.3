Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04227478CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhLQNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:49:40 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42137 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234468AbhLQNtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:49:39 -0500
Received: from localhost.localdomain (ip5f5aed08.dynamic.kabel-deutschland.de [95.90.237.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2E19661EA1924;
        Fri, 17 Dec 2021 14:49:37 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?iommu/amd:=20Fix=20typo=20in=20*glues=20?= =?UTF-8?q?=E2=80=A6=20together*=20in=20comment?=
Date:   Fri, 17 Dec 2021 14:49:16 +0100
Message-Id: <20211217134916.43698-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1eacd43cb436..29d55a99c39f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1523,7 +1523,7 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
 }
 
 /*
- * This function clues the initialization function for one IOMMU
+ * This function glues the initialization function for one IOMMU
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
  */
-- 
2.34.1

