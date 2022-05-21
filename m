Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E8952F9C5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351486AbiEUHlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240940AbiEUHlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 03:41:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C621275E0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 00:41:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso13241046pjj.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nkC8R3wCXH68D4z7ykE31agm2/PPcd7YK33KMuJAW0=;
        b=vXFtD6fPc1gHThhUFXmomjEpkhfM6kTHUB5fWVUzUEoPnn5HuqTWlqPolavNlHZvy+
         0FKri/WoCMBQSGlELJV+KR7fTw4+8tGIsDjaX/RIWlzfbvhpUoz20d7rqP/yrcAHcfeL
         ZfVIdSuGefvHjanN0MmWEM4FHiFAuVFkzFl4uzRhPUKGC/+nvnmkkQaz1yXfxoo6lPm9
         sHPR8nmUyncXBVmtfZCWsW/6FfSErHLvfMCUIiEoN9BRY9I3bx+zTZ0aoCCp77b6hF0C
         ge/WsubSF6bojhzcxGrXkSoFZPulJ24QsQSzmgqx1Vjh3Pi6ntMmwA+hm47wxdfb2FuM
         t5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nkC8R3wCXH68D4z7ykE31agm2/PPcd7YK33KMuJAW0=;
        b=40LKDSFaqimMueqTgj7MZ9prE1ZvcUl+/YZXoOG+tgJi5iwPmO0z+NTpp9/Ttusiaw
         923UdJDCXY3stDI6mO3CW9ttaP4PyKWccNjKD6DC10mjFq0ukGGbuoBK6bCml7yy32Dl
         V2zLYOBziS1OxGfmPCC6ITVx46mQDO+AwzcVssBZi8BKBlUB9+vEBhiyaTaZEOvqSw3Y
         XvsndpjXUYoN3lMtZvtvAcr2kaF7catrLZQGHvbzPobY5P2BfcjxlorZyH61wfZyS16y
         KeORHXqonboNn9wSGXpuee3hQO1G6lm/l8mmMHRH7/hrAFzJojr9CeoqCdojo89pMXhj
         Aedw==
X-Gm-Message-State: AOAM531ohKyCzVDTvdomSLo6lCeYeHuwVyz0d3n/ZCYxmrgO5DSJYzRx
        nTkdlCGKFsNswHa9tzeg+kvBDw==
X-Google-Smtp-Source: ABdhPJyE2XaD09jR1f2y5cOWDtifOQaPbd0ax33DAYVfmiywF365Ow2gn8nIuH9JxKuaisEaM8BMEw==
X-Received: by 2002:a17:902:c752:b0:161:7cb4:78b1 with SMTP id q18-20020a170902c75200b001617cb478b1mr13142696plq.166.1653118895053;
        Sat, 21 May 2022 00:41:35 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id f64-20020a62db43000000b0050dc7628134sm3148755pfg.14.2022.05.21.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 00:41:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] MAINTAINERS: add Muchun as co-maintainer for HugeTLB
Date:   Sat, 21 May 2022 15:41:03 +0800
Message-Id: <20220521074103.79468-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been focusing on mm for the past two years. e.g. developing,
fixing bugs, reviewing related to HugeTLB system.  I would like to
help Mike and other people working on HugeTLB by reviewing their
work.

When I fist introduced the vmemmmap reduction, I forgot to update
MAINTAINERS file.  Let's update it as well.  And rename "HUGETLB
FILESYSTEM" to "HUGETLB SUBSYSTEM" since some files are not only
related to filesystem but also memory management (the name of
FILESYSTEM cannot cover this area).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6516f9c6d28e..904657ffdcd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9087,16 +9087,20 @@ S:	Orphan
 F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
 F:	drivers/net/ethernet/huawei/hinic/
 
-HUGETLB FILESYSTEM
+HUGETLB SUBSYSTEM
 M:	Mike Kravetz <mike.kravetz@oracle.com>
+M:	Muchun Song <songmuchun@bytedance.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
 F:	Documentation/admin-guide/mm/hugetlbpage.rst
 F:	Documentation/vm/hugetlbfs_reserv.rst
+F:	Documentation/vm/vmemmap_dedup.rst
 F:	fs/hugetlbfs/
 F:	include/linux/hugetlb.h
 F:	mm/hugetlb.c
+F:	mm/hugetlb_vmemmap.c
+F:	mm/hugetlb_vmemmap.h
 
 HVA ST MEDIA DRIVER
 M:	Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
-- 
2.11.0

