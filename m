Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947759676D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiHQC3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHQC26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:28:58 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FEA46221
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:28:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660703334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcckSVVduEY7rXQmH+e15p8lmhvgq1sdGuVhQBpEmWA=;
        b=vHjFI5vzngxaomZzpE/rnNCroJr+J5RfyCMx8r6HN4bzYZGPB+RHyQnFFS9noDGLxX0cNt
        xG8TfzHxh8Xy+nWg2hJzxwTxV+3hnfDRCW7ezXKdgnUECKYX1HE1cHqaGMMPAs5jLXdNyf
        pKTFfm5y1ou1kW3zoX70CWJnV4ueY8A=
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] mm/hugetlb: fix incorrect update of max_huge_pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220816130553.31406-2-linmiaohe@huawei.com>
Date:   Wed, 17 Aug 2022 10:28:46 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <117818F8-49AB-4E85-98EF-79E62BFCC7AB@linux.dev>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-2-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> There should be pages_per_huge_page(h) / pages_per_huge_page(target_hstate)
> pages incremented for target_hstate->max_huge_pages when page is demoted.
> Update max_huge_pages accordingly for consistency.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

