Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DBC47F269
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhLYGcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 01:32:20 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30105 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhLYGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 01:32:15 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JLYt41xssz1DJxx;
        Sat, 25 Dec 2021 14:29:00 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 14:32:12 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 25 Dec
 2021 14:32:12 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH 0/3] Documentation: update debugfs doc for Hisilicon Accelerator
Date:   Sat, 25 Dec 2021 14:27:15 +0800
Message-ID: <20211225062718.41155-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation describing DebugFS for function's QoS limiting.
Add the note that described how to use the function's QoS limiting.

Kai Ye (3):
  Documentation: update debugfs doc for Hisilicon SEC
  Documentation: update debugfs doc for Hisilicon ZIP
  Documentation: update debugfs doc for Hisilicon HPRE

 Documentation/ABI/testing/debugfs-hisi-hpre | 10 ++++++++++
 Documentation/ABI/testing/debugfs-hisi-sec  | 10 ++++++++++
 Documentation/ABI/testing/debugfs-hisi-zip  | 10 ++++++++++
 3 files changed, 30 insertions(+)

-- 
2.33.0

