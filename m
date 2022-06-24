Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9C55A0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiFXS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiFXS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:29:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0951680A4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kz+63EY5xlLyapBTGkOL84KmexADuFELrbRNwZ+rNZQ=; b=cwjRjyeHPwpwXCqL+t0J2K6f9P
        KtI4Zmj24hElq5XjLhwrvsGkibQTOi9wR7qjizWk3R7bSLkAu33O7Bjh2NrxELK7fDnLuTmrEWMnv
        CxmgFB1GrLs9cYFHOXA9tDYX77+NLfYHY0hmj7k3LLzlmkWqX4CryKHImzIAXMtmxx4fSMSLnxpff
        oVv9/D7NVl2HKQNaEmZ/DnYa9sLQoE1J1QIhFSD7qlnVl3Bh45oldoxbt3ZEmkVZYWoE/KUiYW2Sd
        djGs2xDiV/JTkBM7kdvARFJlUv8g3aiJA8N+5anImRktjl7Cy0yPbayoDexFHS/uESHnu2WMi2Th2
        9Gb1YoHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4o3N-0098gv-Qx; Fri, 24 Jun 2022 18:29:14 +0000
Date:   Fri, 24 Jun 2022 19:29:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <YrYCeYy0rjfGhT/W@casper.infradead.org>
References: <20220624173656.2033256-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:36:30PM +0000, James Houghton wrote:
> [1] This used to be called HugeTLB double mapping, a bad and confusing
>     name. "High-granularity mapping" is not a great name either. I am open
>     to better names.

Oh good, I was grinding my teeth every time I read it ;-)

How does "Fine granularity" work for you?
"sub-page mapping" might work too.
