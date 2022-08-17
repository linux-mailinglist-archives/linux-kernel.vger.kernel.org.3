Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D54596A90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiHQHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiHQHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:45:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A230379EE6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:29 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M70My28GHzkWNK;
        Wed, 17 Aug 2022 15:42:06 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 15:45:26 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4 -next] fault-injection: make stacktrace filter works with others
Date:   Wed, 17 Aug 2022 08:03:28 +0000
Message-ID: <20220817080332.1052710-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset allow fault injection run on x86_64, and make stacktrace
filter works as expected. With this, we can test device driver module by
fault injecting more easy.

*** BLURB HERE ***

Wei Yongjun (4):
  fault-injection: allow stacktrace filter for x86-64
  fault-injection: skip stacktrace filtering by default
  fault-injection: make some stack filter attrs more readable
  fault-injection: make stacktrace filter works as expected

 lib/Kconfig.debug  |  1 -
 lib/fault-inject.c | 30 ++++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.34.1

