Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E05A1E12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbiHZBWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiHZBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4DC6E81
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 126DF61DB3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7830C433D7;
        Fri, 26 Aug 2022 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661476921;
        bh=X6uBm8cdAjf6BlnhxWoaPZYGrX0WKZp7pDNUM4Gdhmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4vo9QQ22v4AnKV7wJfEg4Wppen690nS3tVz+UOjV+9fLfH9+eufqd38FqP5oQyZa
         kNpXZA9nLu8ZNz7dMvEwMlJ1Vn6SCXRLxZZ9ekwlW91CIIF/m55zHufOHJIn+5KGoY
         dIdk4vKzB1w4NoI17Gh2iQ8yAYO2CHswczXrai7I=
Date:   Thu, 25 Aug 2022 18:21:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Houghton <jthoughton@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Mina Almasry <almasrymina@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [next] x86: fs/hugetlbfs/inode.c:673:16: error: variable
 'm_index' is uninitialized when used here [-Werror,-Wuninitialized]
Message-Id: <20220825182159.5caf669b4564dd694a1373ce@linux-foundation.org>
In-Reply-To: <Ywepr7C2X20ZvLdn@monkey>
References: <CA+G9fYsHVdu0toduQqk6vsR8Z8mOVzZ9-_p3O5fjQ5mOpSxsDA@mail.gmail.com>
        <Ywepr7C2X20ZvLdn@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 09:56:15 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Andrew, how would you like to address in your tree?  The following patch
> can be applied on top of the original (next commit fcc0d3d00d74 "hugetlb:
> handle truncate racing with page faults").  Or, I could squash and
> resend the original, or resend the entire series.

This little fixlet is great, thanks.
