Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909F950821D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356866AbiDTHa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359714AbiDTHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E83B295
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E888361898
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994ECC385A1;
        Wed, 20 Apr 2022 07:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650439658;
        bh=SOilJc5Vxvp6JDI/sAy8cOGRwLrY6YXHjo9rcXuykR0=;
        h=From:To:Cc:Subject:Date:From;
        b=AAoiVkRoimlgphII5KT74LccxQywDwBG6zlj3n/nXZMKq0h/3hKTni+wRFYiLNliH
         2wdA6wHLs+hRq1qPEVquhcFlO4hcz5SITkyceaZsdjsApJlKgHZjbSgxVaLFVFdykw
         u6z5sIfBytOwXvr0D0EYU5yNCJUjmjU+mE7lR6PDFCK4USuNy4j/zm1tqGXBV4TB7q
         gjPdo0F1ZOq+sLDuVP1+wpxehnvgwVEkcsvXHaK5n2/LxpF6zxFOxH136VUFCiIYEl
         PIZKaXKJJCPecI+kugX5fY6fOQd5fLCU9p9q5WD9DLwHixBKU2D3Y8ECtq8ALV7s9V
         5dG7FlOpE15ig==
From:   SeongJae Park <sj@kernel.org>
To:     jgross@suse.com
Cc:     roger.pau@citrix.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2] xen-blk{back,front}: Update contact points for buffer_squeeze_duration_ms and feature_persistent
Date:   Wed, 20 Apr 2022 07:27:34 +0000
Message-Id: <20220420072734.1692-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae is currently listed as a contact point for some blk{back,front}
features, but he will not work for XEN for a while.  This commit
therefore updates the contact point to his colleague, Maximilian, who is
understanding the context and actively working with the features now.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---

Changes from v1
(https://lore.kernel.org/xen-devel/20220301144628.2858-1-sj@kernel.org/)
- Add Acked-by from Roger

 Documentation/ABI/testing/sysfs-driver-xen-blkback  | 4 ++--
 Documentation/ABI/testing/sysfs-driver-xen-blkfront | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index a74dfe52dd76..7faf719af165 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -29,7 +29,7 @@ Description:
 What:           /sys/module/xen_blkback/parameters/buffer_squeeze_duration_ms
 Date:           December 2019
 KernelVersion:  5.6
-Contact:        SeongJae Park <sj@kernel.org>
+Contact:        Maximilian Heyne <mheyne@amazon.de>
 Description:
                 When memory pressure is reported to blkback this option
                 controls the duration in milliseconds that blkback will not
@@ -39,7 +39,7 @@ Description:
 What:           /sys/module/xen_blkback/parameters/feature_persistent
 Date:           September 2020
 KernelVersion:  5.10
-Contact:        SeongJae Park <sj@kernel.org>
+Contact:        Maximilian Heyne <mheyne@amazon.de>
 Description:
                 Whether to enable the persistent grants feature or not.  Note
                 that this option only takes effect on newly created backends.
diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
index 61fd173fabfe..7f646c58832e 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
@@ -12,7 +12,7 @@ Description:
 What:           /sys/module/xen_blkfront/parameters/feature_persistent
 Date:           September 2020
 KernelVersion:  5.10
-Contact:        SeongJae Park <sj@kernel.org>
+Contact:        Maximilian Heyne <mheyne@amazon.de>
 Description:
                 Whether to enable the persistent grants feature or not.  Note
                 that this option only takes effect on newly created frontends.
-- 
2.25.1

