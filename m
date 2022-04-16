Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB150354B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiDPIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiDPIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:44:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A649D0E6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:41:33 -0700 (PDT)
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KgRVX024wzfYlv;
        Sat, 16 Apr 2022 16:40:51 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 16:41:31 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 16:41:31 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <Jonathan_Lucas@mentor.com>
Subject: [PATCH v5 0/2] Add support for UltraSoc System Memory Buffer
Date:   Sat, 16 Apr 2022 16:39:51 +0800
Message-ID: <20220416083953.52610-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for UltraSoc System Memory Buffer.

Change since v4:
- Add a simple document of SMB driver according to Suzuki's comment.
- Address the comments from Suzuki.
- https://lore.kernel.org/linux-arm-kernel/20220128061755.31909-1-liuqi115@huawei.com/

Change since v3:
- Modify the file header according to community specifications.
- Address the comments from Mathieu.
- Link:https://lore.kernel.org/linux-arm-kernel/20211118110016.40398-1-liuqi115@huawei.com/
Change since v2:
- Move ultrasoc driver to drivers/hwtracing/coresight.
- Link:https://lists.linaro.org/pipermail/coresight/2021-November/007310.html

Change since v1:
- Drop the document of UltraSoc according to Mathieu's comment.
- Add comments to explain some private hardware settings.
- Address the comments from Mathieu.
- Link: https://lists.linaro.org/pipermail/coresight/2021-August/006842.html

Change since RFC:
- Move driver to drivers/hwtracing/coresight/ultrasoc.
- Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
  basic tracing function.
- Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
- Address the comments from Mathieu and Suzuki.
- Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html

Qi Liu (2):
  drivers/coresight: Add UltraSoc System Memory Buffer driver
  Documentation: Add document for UltraSoc SMB drivers

 .../trace/coresight/ultrasoc-smb.rst          |  79 +++
 drivers/hwtracing/coresight/Kconfig           |  10 +
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/ultrasoc-smb.c    | 643 ++++++++++++++++++
 drivers/hwtracing/coresight/ultrasoc-smb.h    | 106 +++
 5 files changed, 839 insertions(+)
 create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h

-- 
2.24.0

