Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22860483E2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiADIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:34:21 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34874 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiADIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:34:21 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JSm9Q2q5hzcc3w;
        Tue,  4 Jan 2022 16:33:46 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:34:19 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 4 Jan
 2022 16:34:19 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v2 0/4] Documentation: update debugfs doc for Hisilicon Accelerator
Date:   Tue, 4 Jan 2022 16:29:15 +0800
Message-ID: <20220104082919.45742-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation describing DebugFS for function's QoS limiting.
Add the note that described how to use the function's QoS limiting.

changes v1->v2:
	fixup the documentation format.

Kai Ye (4):
  Documentation: use the tabs on all acc documentation
  Documentation: update debugfs doc for Hisilicon SEC
  Documentation: update debugfs doc for Hisilicon ZIP
  Documentation: update debugfs doc for Hisilicon HPRE

 Documentation/ABI/testing/debugfs-hisi-hpre | 178 +++++++++++---------
 Documentation/ABI/testing/debugfs-hisi-sec  | 146 ++++++++--------
 Documentation/ABI/testing/debugfs-hisi-zip  | 146 ++++++++--------
 3 files changed, 250 insertions(+), 220 deletions(-)

-- 
2.33.0

