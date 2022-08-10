Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48958E4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiHJCCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiHJCC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:02:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86780F43
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E09ACE1B01
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BB2C433D6;
        Wed, 10 Aug 2022 02:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660096943;
        bh=2TpLLn+zpAcyKpF5m5oz6ek8zPf7qV+AjNIajAPpIe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mlzx4Wc1t5T0asGq5ID2rQHvumbAFlIkU5MGbKsVzNeveMHI+bEBjOaoj+calGlsY
         +XwRiD+IKYDhtFjIGZnCXy9qoxGWzZIIBZ9miBQolpq7B/G7e1rAXGQyizxPNB4nBE
         yDcVO5FffiskfG3RlJkxZddNqe0XDeqCGpQI8k5Q=
Date:   Tue, 9 Aug 2022 19:02:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
Subject: Re: [PATCH v2] mm: add warning if __vm_enough_memory fails
Message-Id: <20220809190222.7da71d851e1ca7035165e42a@linux-foundation.org>
In-Reply-To: <abe62159-c218-2fb5-e096-3c71c10c28e1@huawei.com>
References: <20220726145428.8030-1-wangkefeng.wang@huawei.com>
        <abe62159-c218-2fb5-e096-3c71c10c28e1@huawei.com>
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

On Tue, 9 Aug 2022 16:32:46 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Hi maintainer, any comments, thanks

Looks great to me - I have it saved away.

I prefer not to add new material during the merge window prior to MM
being fully merged up.  In fact, I think this might be against
Stephen's rules-for-linux-next.  Even during the merge window,
linux-next remains the testing ground for Linus's "next" release,
so adding next+1 material will weaken that testing.
