Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5B55467E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbiFVI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiFVI0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:26:08 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB94A381BC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:26:06 -0700 (PDT)
Received: from cap.home.8bytes.org (p5b006cf2.dip0.t-ipconnect.de [91.0.108.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 45A3D7F;
        Wed, 22 Jun 2022 10:26:04 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] MAINTAINERS: Add new IOMMU development mailing list
Date:   Wed, 22 Jun 2022 10:26:01 +0200
Message-Id: <20220622082601.31678-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The IOMMU mailing list will move from lists.linux-foundation.org to
lists.linux.dev. The hard switch of the archive will happen on July
5th, but add the new list now already so that people start using the
list when sending patches.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..b5bac297d63d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10354,6 +10354,7 @@ IOMMU DRIVERS
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	Documentation/devicetree/bindings/iommu/
-- 
2.36.1

