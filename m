Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE251D36F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390152AbiEFIcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390146AbiEFIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:32:39 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44B27522D8
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651825736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6z7gc/drMhEeRJp39wQIA1kBqGj2H/sPubOogLgDhI=;
        b=XK4fmhaCuKmrpfvflKc0dDzeTCnPc91l9AXvFfrT8TkjvzArGGrjT2av4Zo8JVaiqv4cWP
        ftNKE8NLmttCqwisioebA9VZd90kWuX4EBBPkL9N32r8e3eB0Ptl4rTylugn6aR4D+qc2B
        51dwzEowxEaUSg/vQxBPWyTq6SxyHNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-YPUZiyGDMOWmGfUE-_G9qw-1; Fri, 06 May 2022 04:28:53 -0400
X-MC-Unique: YPUZiyGDMOWmGfUE-_G9qw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CEBB804199;
        Fri,  6 May 2022 08:28:52 +0000 (UTC)
Received: from rh (vpn2-54-181.bne.redhat.com [10.64.54.181])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C9F62166B2D;
        Fri,  6 May 2022 08:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1nmtKT-005kR5-Fc; Fri, 06 May 2022 18:28:49 +1000
Date:   Fri, 6 May 2022 18:28:47 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  83a21c1844: xfstests.xfs.533.fail
Message-ID: <YnTcP86M0NV6lkfB@rh>
References: <20220506080341.GF23061@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506080341.GF23061@xsang-OptiPlex-9020>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:03:41PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 83a21c18441f75aec64548692b52d34582b98a6a ("xfs: Directory's data fork extent counter can never overflow")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-46e1b83-1_20220414
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group-53
> 	ucode: 0x21
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> xfs/533	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/533.out.bad)
>     --- tests/xfs/533.out	2022-04-14 12:51:49.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/533.out.bad	2022-05-03 06:24:37.310381846 +0000
>     @@ -6,12 +6,4 @@
>      Inject bmap_alloc_minlen_extent error tag
>      * Create directory entries
>      Verify directory's extent count
>     -* Rename: Populate destination directory
>     -Populate $dstdir by moving new directory entries
>     -Verify $dstdir's extent count
>     -* Create multiple hard links to a single file
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/533.out /lkp/benchmarks/xfstests/results//xfs/533.out.bad'  to see the entire diff)

Not a regression. This is testing directory data fork extent count
overflow using error injection, but you might notice that the title
of the commit is "Directory's data fork extent counter can never
overflow".

IOWs, we changed fine grained directory extent count overflow
from a runtime check (on every dir op) to an inode verifier
check that is only run when the directory inode is read from or
written to disk.

The test probably should be removed. Chandan?

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

