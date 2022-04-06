Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650214F5B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiDFKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiDFKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:10:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5821CC66;
        Tue,  5 Apr 2022 23:38:38 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYFD46RK1zgY80;
        Wed,  6 Apr 2022 14:36:52 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 6 Apr
 2022 14:38:36 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <roberto.sassu@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] ima: fix boot command line issue
Date:   Wed, 6 Apr 2022 14:37:26 +0800
Message-ID: <20220406063727.178522-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 patch: https://patchwork.kernel.org/project/linux-integrity/patch/20220321074737.138002-1-guozihua@huawei.com/

Change log:
  v2:
    update commit message and subject following Mimi's advice. Remove
    references for CONFIG_IMA_TEMPLATE as well.

GUO Zihua (1):
  ima: remove the IMA_TEMPLATE Kconfig option

 security/integrity/ima/Kconfig | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

-- 
2.17.1

