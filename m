Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37FD4B31F6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354393AbiBLA1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:27:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiBLA1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:27:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68882C55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0413E61CD8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 00:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1D5C340E9;
        Sat, 12 Feb 2022 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644625655;
        bh=4ozYgfzq2TPcUtEMk5+7s7otN44W5zlazOXgs4tFmMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVNVQSd0tWk4T0M8Kk67yRsW11uh1fnQCPgIY3xVkPbUdmUidV7UBXUkotrGTIcB/
         ZLT/GoCMJgWbqrQmAOG7xTwVzlSuvjvHWmuO+sMiBGiHsD/YGqW5hhT3pYcheyoeRG
         lZSRbI69UJI5wweJfsTLgihhjsXK+ECBcmhpEFI8=
Date:   Fri, 11 Feb 2022 16:27:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v5 0/5] mm/gup: some cleanups
Message-Id: <20220211162734.bfd21e10ff9bb231274e39f8@linux-foundation.org>
In-Reply-To: <6712a07b-d1ac-520d-8bbb-7539476ec679@nvidia.com>
References: <20220207062213.235127-1-jhubbard@nvidia.com>
        <6712a07b-d1ac-520d-8bbb-7539476ec679@nvidia.com>
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

On Fri, 11 Feb 2022 16:24:15 -0800 John Hubbard <jhubbard@nvidia.com> wrote:

> On 2/6/22 22:22, John Hubbard wrote:
> > Hi,
> > 
> > Here's an update, mainly just collecting reviewed-by tags:
> > 
> > Changes since v4:
> > 
> >      * Patch 1: reflowed the commit description to 72 columns.
> > 
> >      * Added reviewed-by's from Christoph and Jan for remaining patches.
> > 
> >      * Rebased onto 5.17-rc3.
> > 
> 
> Hi Andrew,
> 
> Is this OK to put in mmotm yet? All the patches here have been reviewed.
> And this small series also does not conflict with Willy's "[PATCH 00/75]
> MM folio patches for 5.18" series.

The v4 series is is -mm.  Shall update to v5 soon...
