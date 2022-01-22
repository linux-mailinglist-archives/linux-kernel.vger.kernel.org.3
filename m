Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11377496AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiAVISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:18:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16729 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiAVISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:18:24 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jgptw450TzZf68;
        Sat, 22 Jan 2022 16:14:32 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 16:18:21 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 22 Jan
 2022 16:18:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v3 0/5] crypto: hisilicon - some misc bugfix for SEC engine
Date:   Sat, 22 Jan 2022 16:13:07 +0800
Message-ID: <20220122081312.29121-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some misc bugfix for SEC engine.

changes v1->v2:
	add rate limited for printing messages.
changes v2->v3:
	modify the second patch.

Kai Ye (5):
  crypto: hisilicon/sec - fixup icv checking enabled on Kunpeng 930
  crypto: hisilicon/sec - add some comments for soft fallback
  crypto: hisilicon/sec - fix the max length of AAD for the CCM mode
  crypto: hisilicon/sec - fix the CTR mode BD configuration
  crypto: hisilicon/sec - use the correct print format

 drivers/crypto/hisilicon/sec2/sec_crypto.c | 27 +++++++++++++++-------
 drivers/crypto/hisilicon/sec2/sec_crypto.h |  6 +++--
 2 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.33.0

