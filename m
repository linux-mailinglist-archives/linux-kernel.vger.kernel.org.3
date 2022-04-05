Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8D4F5265
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850161AbiDFCr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585288AbiDEX7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:59:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E642128DE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2CD3B81FF0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C925FC385A0;
        Tue,  5 Apr 2022 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649196978;
        bh=8LM8oYesOnkFwWaxBlNnPegAUYU1pEClxEtyin3U9X4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xhSnE3/EqIsFBG1SJ9QvyIlXgsBBF10o2ufCqKuVO6VnuoC/MBQk1LXh6QsK+K48u
         ISBzQ3C3lETGXI8Tym4xIRgrj/eIbFLSafSiKWwN4Lr+ddk/Hzp3qy07MVn40I/HyF
         B91NVya62FH+qrHH3H5ePWiv79lbB34m/t4HKDm4=
Date:   Tue, 5 Apr 2022 15:16:16 -0700
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
Message-Id: <20220405151616.bf25fa4aad55536cd031e1ab@linux-foundation.org>
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
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

On Mon,  4 Apr 2022 21:46:23 -0400 Peter Xu <peterx@redhat.com> wrote:

> This is v8 of the series to add shmem+hugetlbfs support for userfaultfd
> write protection. 

Various compilation catastrophes with x86_64 allnoconfig.  I poked at
the include ordering for a while but other things quickly became more
attractive ;)
