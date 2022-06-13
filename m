Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2884549DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiFMTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245565AbiFMTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46F1117F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:03:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E182361192
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAED1C341C4;
        Mon, 13 Jun 2022 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655143380;
        bh=0nCqIev+TzjLtB3pTABL/JjV/UBryXSplYSxvst+YE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rZCKCG4sw4Ei+r/spci/prFohB6UEYP7KI5MWc74R38RiyoM4H4yoBFILn+OqcdQX
         vcMCsDtXFFbWBMiWAAUy/Xr+wBXLR8hYKYoXMO/CBfATOBhhP7KNZtJP8FzKC6zChb
         PNQzdTT86h4/Yr767PMYDk0rHr+aAFeogOC/23Dc=
Date:   Mon, 13 Jun 2022 11:02:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <aarcange@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <neilb@suse.de>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mm/khugepaged: remove unneeded shmem_huge_enabled()
 check
Message-Id: <20220613110259.80507ec6a6472342a951dad4@linux-foundation.org>
In-Reply-To: <ac9e17d1-18f8-aa63-6c52-1822c752b63f@huawei.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
        <20220611084731.55155-2-linmiaohe@huawei.com>
        <20220611133336.b582edd4c2c2df15f5561d2b@linux-foundation.org>
        <ac9e17d1-18f8-aa63-6c52-1822c752b63f@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 09:48:27 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> > I updated this to
> > 
> > If we reach here, hugepage_vma_check() has already made sure that hugepage
> > is enabled for shmem, via its call to hugepage_vma_check().  Remove this
> > duplicated check.
> 
> Do you mean "khugepaged_scan_mm_slot() has already made sure that hugepage is
> enabled for shmem, via its call to hugepage_vma_check()"?

yup, thanks.
