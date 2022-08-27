Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A015A339E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbiH0BwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiH0BwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:52:14 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D93ED018
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:52:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661565132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1V9s4L1obo2NhvUrQmYwsK+i//IRNQIHNCUI73LRpQ=;
        b=tTeBHvuNKwTbQoG/yv0fh4Ergt3uMVDMEB7VZovzeAiTz2xwp1wLqw4Gktfn4vj9opBksA
        3MqDCDQiBaY0vyNWPezFUrdAlyxIbH4rgPeVqJwI65JbQMYck4iJ3DlS8frPMrTMQQau12
        yJsO0nxnqRVQv5KQaivS7vXWNXgBd2s=
MIME-Version: 1.0
Subject: Re: [PATCH 07/10] hugetlb: kill hugetlbfs_pagecache_page()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220826092422.39591-8-linmiaohe@huawei.com>
Date:   Sat, 27 Aug 2022 09:52:09 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F992616D-2410-43BB-A7FF-78B69A05BED4@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-8-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> Fold hugetlbfs_pagecache_page() into its sole caller to remove some
> duplicated code. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

