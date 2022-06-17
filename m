Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0454F8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382533AbiFQN6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381558AbiFQN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:58:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC636300
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:58:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m4so1097911pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3PCuIcYAcZyb+k4ENIbfzjTIn3XM8zfk9TCfHX0dmA=;
        b=EWCtootqlRe6RzPmBcX/GvZIDoYDBFHPKC5RtYBkHp4WG27bDvGfe8Vb3qaWqpOIxu
         X9cpHH/lpp6xBmJoXDKQp+QTVXQ83H5faWsQksdRKoyIu24ml5tBs6fYuUyoeBYGJx1B
         bzyrTklsyt/4hngqwLTTfcNQinZlBWyAl9GHG1Ya0r0X7fNcwboZs91b32JcVi/GDfJa
         f/20BsC0euG+39EZLQgh+t0kViZC14EUAtd63YPMhQkpOuY7DOHHOJ3bqsX6a75lG9bT
         R8mJFQc6/EUiX8ZL2S+F45kcOEpLZBPhembrWLM/edIQ3fijtGT4Zv8Ote0Ky2ShrPtn
         Nlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3PCuIcYAcZyb+k4ENIbfzjTIn3XM8zfk9TCfHX0dmA=;
        b=bM27HxqYVzja6XoozL4vO/L509CWngsMfuGH1//3clh95G3HdiJ01p0GeNnKwlZcAk
         s86WNhZGSqU68PigPh0pC+YDjPmNKP9ujW4loCYrH0S1uT4auz7PtMSNFGxTQ0VhL7xw
         toUAkfjMD3VURCXKw0WNEOjkPV+M/DTwe7cP3bClr6QnygWgDSFIItIUB4dHC7oIdLYR
         /NOdkMvK7OvQRvDpgo5z/0luSL5vAqEiF8fMMZDv3vixs8HiO7tbcWeX5zviIDzQ8Bam
         rVkOSjrLnd5hWLB+JPHNOLsHS2q2dJ9K2Q7wjZGJqytJYIfCNIxKoTfOBz/4znWLuL9M
         QNwg==
X-Gm-Message-State: AJIora+lpbJNYi6VLfqil5H8+tGYK3R0YGQvKAwYNNYPylqq1JRV6epF
        PpVlurIDZ8UyjTBqFn2FWDRH0nekYS09pYAvsvU=
X-Google-Smtp-Source: AGRyM1u0E5+TFznm/6+22gBGLbXXne5g4/D4eqNgUB31mGswQgCMIRkIrFAmMJdL0nA2QSXkuN7Ynw==
X-Received: by 2002:a17:90b:4b49:b0:1e6:8827:aaf1 with SMTP id mi9-20020a17090b4b4900b001e68827aaf1mr10740999pjb.154.1655474286821;
        Fri, 17 Jun 2022 06:58:06 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015e8d4eb277sm3605869plo.193.2022.06.17.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:58:05 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, osalvador@suse.de, paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/2] make hugetlb_optimize_vmemmap compatible with memmap_on_memory
Date:   Fri, 17 Jun 2022 21:56:48 +0800
Message-Id: <20220617135650.74901-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes hugetlb_optimize_vmemmap compatible with memmap_on_memory
and is based on mm-stable.  The reason refers to the patch 2's commit log.

v3:
 - Switch complicated enumeration magic (David).
 - Introduce PageVmemmapSelfHosted to make both parameters compatible (David and Oscar).

v2:
 - Fix compile error when !CONFIG_ZONE_DEVICE reported by kernel test robot.

Muchun Song (2):
  mm: memory_hotplug: enumerate all supported section flags
  mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with
    memmap_on_memory

 Documentation/admin-guide/kernel-parameters.txt | 22 ++++++------
 Documentation/admin-guide/sysctl/vm.rst         |  5 ++-
 include/linux/memory_hotplug.h                  |  9 -----
 include/linux/mmzone.h                          | 44 ++++++++++++++++++-----
 include/linux/page-flags.h                      | 11 ++++++
 mm/hugetlb_vmemmap.c                            | 47 ++++++++++++++++++++-----
 mm/memory_hotplug.c                             | 33 ++++++++---------
 mm/sparse.c                                     |  2 +-
 8 files changed, 116 insertions(+), 57 deletions(-)


base-commit: 6edda04ccc7cfb281d139e352dbd5dd933bd2751
-- 
2.11.0

