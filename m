Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43A50B365
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445712AbiDVJDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiDVJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:02:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73A63B0;
        Fri, 22 Apr 2022 02:00:05 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kl7d01gVvzfZSR;
        Fri, 22 Apr 2022 16:59:16 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:00:03 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 17:00:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC:     <linux@roeck-us.net>, <jdelvare@suse.com>
Subject: [PATCH 00/20] hwmon: check return value after calling platform_get_resource()
Date:   Fri, 22 Apr 2022 17:11:47 +0800
Message-ID: <20220422091207.4034406-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patcheset add check after calling platform_get_resource to avoid null-ptr-deref
in drivers/hwmon/.

Yang Yingliang (20):
  hwmon: (abituguru) check return value after calling
    platform_get_resource()
  hwmon: (abituguru3) check return value after calling
    platform_get_resource()
  hwmon: (dme1737) check return value after calling
    platform_get_resource()
  hwmon: (f71805f) check return value after calling
    platform_get_resource()
  hwmon: (f71882fg) check return value after calling
    platform_get_resource()
  hwmon: (it87) check return value after calling platform_get_resource()
  hwmon: (lm78) check return value after calling platform_get_resource()
  hwmon: (nct6683) check return value after calling
    platform_get_resource()
  hwmon: (nct6775) check return value after calling
    platform_get_resource()
  hwmon: (sch5627) check return value after calling
    platform_get_resource()
  hwmon: (sch5636) check return value after calling
    platform_get_resource()
  hwmon: (sis5595) check return value after calling
    platform_get_resource()
  hwmon: (smsc47b397) check return value after calling
    platform_get_resource()
  hwmon: (smsc47m1) check return value after calling
    platform_get_resource()
  hwmon: (via686a) check return value after calling
    platform_get_resource()
  hwmon: (vt1211) check return value after calling
    platform_get_resource()
  hwmon: (vt8231) check return value after calling
    platform_get_resource()
  hwmon: (w83627ehf) check return value after calling
    platform_get_resource()
  hwmon: (w83627hf) check return value after calling
    platform_get_resource()
  hwmon: (w83781d) check return value after calling
    platform_get_resource()

 drivers/hwmon/abituguru.c  | 6 +++++-
 drivers/hwmon/abituguru3.c | 6 +++++-
 drivers/hwmon/dme1737.c    | 2 ++
 drivers/hwmon/f71805f.c    | 2 ++
 drivers/hwmon/f71882fg.c   | 6 +++++-
 drivers/hwmon/it87.c       | 2 ++
 drivers/hwmon/lm78.c       | 2 ++
 drivers/hwmon/nct6683.c    | 2 ++
 drivers/hwmon/nct6775.c    | 2 ++
 drivers/hwmon/sch5627.c    | 6 +++++-
 drivers/hwmon/sch5636.c    | 6 +++++-
 drivers/hwmon/sis5595.c    | 2 ++
 drivers/hwmon/smsc47b397.c | 2 ++
 drivers/hwmon/smsc47m1.c   | 2 ++
 drivers/hwmon/via686a.c    | 2 ++
 drivers/hwmon/vt1211.c     | 2 ++
 drivers/hwmon/vt8231.c     | 2 ++
 drivers/hwmon/w83627ehf.c  | 2 ++
 drivers/hwmon/w83627hf.c   | 2 ++
 drivers/hwmon/w83781d.c    | 2 ++
 20 files changed, 55 insertions(+), 5 deletions(-)

-- 
2.25.1

