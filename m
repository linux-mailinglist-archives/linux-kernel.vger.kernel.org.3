Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC5465C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355089AbhLBDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:05:42 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27332 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355055AbhLBDDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:03:54 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J4LKz6QVzzbgf0;
        Thu,  2 Dec 2021 11:00:23 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 11:00:31 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 2 Dec
 2021 11:00:31 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <gregkh@linuxfoundation.org>, <paskripkin@gmail.com>,
        <dan.carpenter@oracle.com>
Subject: [PATCH -next v4 0/3] some fix and cleanup for rtl8192e
Date:   Thu, 2 Dec 2021 11:07:01 +0800
Message-ID: <20211202030704.2425621-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: Fix crypt_info leak. Add fix tags for patch #1 and #2.
v3: Fix more leaks.  Break it up into multple patches.
v2: Make rtllib_softmac_init() return error codes.

patch #1, #2:
  fix error handle case in alloc_rtllib()

patch #3:
  remove unnecessary assignment

Yang Yingliang (3):
  staging: rtl8192e: return error code from rtllib_softmac_init()
  staging: rtl8192e: rtllib_module: fix error handle case in
    alloc_rtllib()
  staging: rtl8192e: rtllib_module: remove unnecessary assignment

 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_module.c  | 17 ++++++++++++-----
 drivers/staging/rtl8192e/rtllib_softmac.c |  6 ++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.25.1

