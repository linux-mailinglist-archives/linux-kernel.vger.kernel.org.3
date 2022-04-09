Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC194FA5BA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiDIILk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiDIILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087DDDE;
        Sat,  9 Apr 2022 01:09:11 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb76b0dw3z1HBW1;
        Sat,  9 Apr 2022 16:08:39 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:09:09 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 9 Apr
 2022 16:09:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 00/11] add regitser checking and last word dumping for ACC
Date:   Sat, 9 Apr 2022 16:03:17 +0800
Message-ID: <20220409080328.15783-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register detection function to accelerator. Add last word dumping
function during acc engines controller reset. It can help to improve
debugging capability.

Kai Ye (11):
  crypto: hisilicon/qm - add register checking for ACC
  crypto: hisilicon/hpre - support register checking
  crypto: hisilicon/sec - support register checking
  crypto: hisilicon/zip - support register checking
  Documentation: update debugfs doc for Hisilicon HPRE
  Documentation: update debugfs doc for Hisilicon SEC
  Documentation: update debugfs doc for Hisilicon ZIP
  crypto: hisilicon/qm - add last word dumping for ACC
  crypto: hisilicon/sec - support last word dumping
  crypto: hisilicon/hpre - support last word dumping
  crypto: hisilicon/zip - support last word dumping

 Documentation/ABI/testing/debugfs-hisi-hpre |  14 ++
 Documentation/ABI/testing/debugfs-hisi-sec  |  14 ++
 Documentation/ABI/testing/debugfs-hisi-zip  |  14 ++
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 222 ++++++++++++++----
 drivers/crypto/hisilicon/qm.c               | 239 +++++++++++++++++++-
 drivers/crypto/hisilicon/sec2/sec_main.c    | 108 ++++++++-
 drivers/crypto/hisilicon/zip/zip_main.c     | 185 ++++++++++++++-
 include/linux/hisi_acc_qm.h                 |  18 ++
 8 files changed, 765 insertions(+), 49 deletions(-)

-- 
2.33.0

