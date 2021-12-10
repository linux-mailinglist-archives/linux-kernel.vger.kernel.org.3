Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BEA46FCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhLJIY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:24:56 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29114 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhLJIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:24:53 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J9P1D53QNz1DKVV;
        Fri, 10 Dec 2021 16:18:24 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:21:17 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:21:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/3] amba: cleanup part2
Date:   Fri, 10 Dec 2021 16:31:27 +0800
Message-ID: <20211210083130.141784-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is anonther cleanup about amba, which is found when try to fix
no IRQ domain issue in amba, kill some unused functions and change
position of EXPORT_SYMBOL().

part1: which has sent to ARM patch system.
https://lore.kernel.org/linux-arm-kernel/20211115135148.171786-3-wangkefeng.wang@huawei.com/

Kefeng Wang (3):
  amba: Cleanup amba pclk operation
  amba: kill amba_find_match()
  amba: Move EXPORT_SYMBOL() closer to definition

 drivers/amba/bus.c       | 73 +++-------------------------------------
 drivers/dma/pl330.c      |  4 +--
 include/linux/amba/bus.h | 21 ------------
 3 files changed, 7 insertions(+), 91 deletions(-)

-- 
2.26.2

