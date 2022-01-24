Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57E497778
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiAXChu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:37:50 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31114 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiAXCho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:37:44 -0500
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JhvDt076lz1FCm2;
        Mon, 24 Jan 2022 10:33:49 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:37:41 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:37:40 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        <corbet@lwn.net>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
        <linux-mm@kvack.org>, <liupeng256@huawei.com>
Subject: [PATCH RFC 0/3] Add a module parameter to adjust kfence objects
Date:   Mon, 24 Jan 2022 02:52:02 +0000
Message-ID: <20220124025205.329752-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series make KFENCE to be more convenient to adjust parameters in
not only debug process but also production situations. In different
production and development stage, the demands of memory and CPU
limitations for KFENCE is quite different. In order to satisfy these
demands with a uniform kernel release, dynamically adjust KFENCE
parameters is needed.

Signed-off-by: Peng Liu <liupeng256@huawei.com>

Peng Liu (3):
  kfence: Add a module parameter to adjust kfence objects
  kfence: Optimize branches prediction when sample interval is zero
  kfence: Make test case compatible with run time set sample interval

 Documentation/dev-tools/kfence.rst |  14 ++--
 include/linux/kfence.h             |  10 ++-
 mm/kfence/core.c                   | 113 ++++++++++++++++++++++++-----
 mm/kfence/kfence.h                 |   2 +-
 mm/kfence/kfence_test.c            |  10 +--
 5 files changed, 116 insertions(+), 33 deletions(-)

-- 
2.18.0.huawei.25

