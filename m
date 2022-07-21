Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469E557D4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiGUUGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiGUUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:06:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127473919;
        Thu, 21 Jul 2022 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n/9ErwRmiUikJNtsWaQxy5ZmJnxDCBmH6HSCcV1UBjA=; b=pfYlkewtF3Uijvi8H5wZ7tlML+
        1130pLyHkySuRGzsbveKwtHFvvi6MQkPAGJPHjcrPO9kNS/iAq3oCJj8OjltBgrZP/5vWPRRIElsB
        JC3Qq2NFwOyAfe6CfsfEkHSbHBMQuFNMJQqRqYvSGeRz0hdpmHL+dQUtEocOlvWZPlWxvUMmMsebT
        mBFGC5nVcKQ+Qv8P2HuWv9xo86vyzOR3IuR24iKtPQmfbYBrL4vorgjO8bdB560Nn5nmvOnMXB62w
        t9gf8RRxZSrTfvwoPw/FyRuPC7lurd203XJKTy8CQCgpum+24VXYIjW1iaon9zHflF/aKLVMW+VZu
        oSys+9YQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oEcQd-00EWlt-L7;
        Thu, 21 Jul 2022 20:05:47 +0000
Date:   Thu, 21 Jul 2022 21:05:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] s390/crash: support multi-segment iterators
Message-ID: <Ytmxm7UhejnRPkFU@ZenIV>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
 <YtdzwLXFMuv02JEA@ZenIV>
 <YtkSWBPpUe8CqNxV@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtkSWBPpUe8CqNxV@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:46:16AM +0200, Alexander Gordeev wrote:
> On Wed, Jul 20, 2022 at 04:17:20AM +0100, Al Viro wrote:
> > I can put your series into replacement of #fixes-s390, or pull it
> > from whatever static branch you put it into - up to you.
> > Preferences?
> 
> Hi Al,
> 
> Please find the changes since commit af2debd58bd769e38f538143f0d332e15d753396:
> 
>   s390/crash: make copy_oldmem_page() return number of bytes copied
> 
> up to ebbc9570169147740aa39aee1d61b4cc5a631644:
> 
>   s390/crash: support multi-segment iterators
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git	vmcore-iov_iter
> 
> Please, note three (rather trivial) prereq commits to pull along:
> 
>   f6749da17a34 s390/crash: fix incorrect number of bytes to copy to user space
>   86caa4b67895 s390/crash: remove redundant panic() on save area allocation failure
>   7190d84966b3 s390/mm: remove unused tprot() function

Pulled.
