Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0511555976C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiFXKMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiFXKL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:11:57 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A27A6DA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:11:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHGmj7v_1656065510;
Received: from 30.97.49.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHGmj7v_1656065510)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 18:11:51 +0800
Message-ID: <3134549d-f17e-5dba-72f7-ed591ce4d1c8@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 18:11:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/7] migrate_pages(): fix several bugs in error path
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220624025309.1033400-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 6/24/2022 10:53 AM, Huang Ying 写道:
> From: "Huang, Ying" <ying.huang@intel.com>
> 
> During review the code of migrate_pages() and build a test program for
> it.  Several bugs in error path are identified and fixed in this
> series.
> 
> Most patches are tested via
> 
> - Apply error-inject.patch in Linux kernel
> - Compile test-migrate.c (with -lnuma)
> - Test with test-migrate.sh
> 
> error-inject.patch, test-migrate.c, and test-migrate.sh are as below.
> It turns out that error injection is an important tool to fix bugs in
> error path.
> 

Hi Ying,

The subject prefix shows there are 7 patches in your patch set, however 
I only received 5 patches in my mail box, and I checked the link [1], it 
also shows there are 5 patches. Seems you missed 2 patches?

https://lore.kernel.org/all/20220624025309.1033400-1-ying.huang@intel.com/
