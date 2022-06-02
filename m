Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADCF53C06F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiFBVkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbiFBVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:40:42 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E4AA23BFD;
        Thu,  2 Jun 2022 14:40:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C1BF55EC4E7;
        Fri,  3 Jun 2022 07:40:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwsYX-001whT-IF; Fri, 03 Jun 2022 07:40:37 +1000
Date:   Fri, 3 Jun 2022 07:40:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  5349b2afc1: xfstests.xfs.299.fail
Message-ID: <20220602214037.GE1098723@dread.disaster.area>
References: <20220602085053.GC27190@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602085053.GC27190@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62992e58
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
        a=7-415B0cAAAA:8 a=-A5qU4moq-8n6FO1PKwA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:50:53PM +0800, kernel test robot wrote:
> 
> (please be noted we reported
> "[xfs]  5349b2afc1: xfstests.xfs.050.fail"
> on
> https://lore.kernel.org/all/20220518094120.GB15472@xsang-OptiPlex-9020/
> when this commit was on linux-next/master
> now we found there are still xfstests failure including xfs.050 on mainline.
> report again FYI)
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 5349b2afc117d87d35502f2fe1930692d6bfc68b ("xfs: don't set quota warning values")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-46e1b83-1_20220414
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group-29
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
> 2022-05-17 15:49:39 export TEST_DIR=/fs/sdb1
> 2022-05-17 15:49:39 export TEST_DEV=/dev/sdb1
> 2022-05-17 15:49:39 export FSTYP=xfs
> 2022-05-17 15:49:39 export SCRATCH_MNT=/fs/scratch
> 2022-05-17 15:49:39 mkdir /fs/scratch -p
> 2022-05-17 15:49:39 export SCRATCH_DEV=/dev/sdb4
> 2022-05-17 15:49:39 export SCRATCH_LOGDEV=/dev/sdb2
> 2022-05-17 15:49:39 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
> 2022-05-17 15:49:39 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
> 2022-05-17 15:49:39 sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group-29
> 2022-05-17 15:49:39 ./check xfs/290 xfs/291 xfs/292 xfs/293 xfs/294 xfs/295 xfs/296 xfs/297 xfs/298 xfs/299
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 lkp-ivb-d05 5.18.0-rc2-00103-g5349b2afc117 #1 SMP Sun May 15 12:16:43 CST 2022
> MKFS_OPTIONS  -- -f /dev/sdb4
> MOUNT_OPTIONS -- /dev/sdb4 /fs/scratch
> 
> xfs/290	 2s
> xfs/291	 130s
> xfs/292	 3s
> xfs/293	 1s
> xfs/294	 63s
> xfs/295	 30s
> xfs/296	 14s
> xfs/297	 209s
> xfs/298	 14s
> xfs/299	- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/299.out.bad)
>     --- tests/xfs/299.out	2022-05-16 16:42:32.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/299.out.bad	2022-05-17 15:57:43.078827071 +0000
>     @@ -6,6 +6,7 @@
>      log      =LDEV bsize=XXX blocks=XXX
>      realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
>      *** user, group, and project
>     +xfs_quota: cannot set warnings: Invalid argument

Not a kernel issue - this is fixed in the latest fstests release.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
