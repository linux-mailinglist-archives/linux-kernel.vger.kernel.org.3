Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546314F529F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850737AbiDFC4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446670AbiDFBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 21:16:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA213D23
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:08:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32619B81BC0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650EEC385A1;
        Tue,  5 Apr 2022 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649200135;
        bh=9HquPKfIot7ZwEkDf5EVIUrebSG3+HWItti341gUn2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xYyzWEBeIX/UgL0Axj8U7ahOIEzsPN7ri7jR9emA9aEzZtaYrhlnmYudbo2TYhXp9
         pZ1Mj31x8xs31Gp16i2je3HT/Qm6xVdVMZZSLYYBJgpcVKMkTm1Im1avGTnl9SPXr1
         lXZV+08A/WSFeqnR1M+/IY8kI8C7E3Pm1xCgvUsU=
Date:   Tue, 5 Apr 2022 16:08:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-Id: <20220405160854.0126484e17fafbb5a4754110@linux-foundation.org>
In-Reply-To: <YkzKiM8tI4+qOfXF@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
        <20220405151616.bf25fa4aad55536cd031e1ab@linux-foundation.org>
        <YkzF4/e86qwcuXiA@xz-m1.local>
        <20220405154912.4cda03c2cc5d801d25d5c2dd@linux-foundation.org>
        <YkzKiM8tI4+qOfXF@xz-m1.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 19:02:32 -0400 Peter Xu <peterx@redhat.com> wrote:

> For the allnoconfig, could you try with the attached quick fixup (upon
> patch "mm/uffd: PTE_MARKER_UFFD_WP")?

Works for me, thanks.
