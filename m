Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC46753C074
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiFBVol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbiFBVok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:44:40 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1772D2DAA4;
        Thu,  2 Jun 2022 14:44:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0FB4410E6D63;
        Fri,  3 Jun 2022 07:44:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwscO-001wk0-OV; Fri, 03 Jun 2022 07:44:36 +1000
Date:   Fri, 3 Jun 2022 07:44:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  1eb70f54c4: xfstests.xfs.348.fail
Message-ID: <20220602214436.GF1098723@dread.disaster.area>
References: <20220602090409.GD27190@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602090409.GD27190@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62992f46
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
        a=7-415B0cAAAA:8 a=-aPHgg1e-4_rmetnlIoA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 05:04:09PM +0800, kernel test robot wrote:
> 
> (please be noted we reported
> "[xfs]  1eb70f54c4: xfstests.xfs.348.fail"
> on
> https://lore.kernel.org/all/20220518144504.GB22659@xsang-OptiPlex-9020/
> while this commit was on linux-next/master
> now we noticed the issue is still existing on mainline.
> report again FYI)
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 1eb70f54c445fcbb25817841e774adb3d912f3e8 ("xfs: validate inode fork size against fork format")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-46e1b83-1_20220414
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group-34
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
> 2022-05-18 11:47:42 export TEST_DIR=/fs/sdb1
> 2022-05-18 11:47:42 export TEST_DEV=/dev/sdb1
> 2022-05-18 11:47:42 export FSTYP=xfs
> 2022-05-18 11:47:42 export SCRATCH_MNT=/fs/scratch
> 2022-05-18 11:47:42 mkdir /fs/scratch -p
> 2022-05-18 11:47:42 export SCRATCH_DEV=/dev/sdb4
> 2022-05-18 11:47:42 export SCRATCH_LOGDEV=/dev/sdb2
> 2022-05-18 11:47:42 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
> 2022-05-18 11:47:42 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
> 2022-05-18 11:47:42 sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group-34
> 2022-05-18 11:47:42 ./check xfs/348 xfs/349
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 lkp-ivb-d05 5.18.0-rc2-00067-g1eb70f54c445 #1 SMP Thu May 12 04:39:22 CST 2022
> MKFS_OPTIONS  -- -f /dev/sdb4
> MOUNT_OPTIONS -- /dev/sdb4 /fs/scratch
> 
> xfs/348	- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/348.out.bad)
>     --- tests/xfs/348.out	2022-05-16 16:42:32.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/348.out.bad	2022-05-18 11:47:58.897287914 +0000
>     @@ -108,7 +108,7 @@
>      would have junked entry "EMPTY" in directory PARENT_INO
>      would have junked entry "FIFO" in directory PARENT_INO
>      stat: 'SCRATCH_MNT/test/DIR' is a directory
>     -stat: 'SCRATCH_MNT/test/DATA' is a directory
>     +stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
>      stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
>      stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning

Not a kernel issue - this is fixed in the latest fstests.

>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/348.out /lkp/benchmarks/xfstests/results//xfs/348.out.bad'  to see the entire diff)
> xfs/349	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/349.out.bad)
>     --- tests/xfs/349.out	2022-05-16 16:42:32.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/349.out.bad	2022-05-18 11:53:51.101272360 +0000
>     @@ -1,3 +1,2 @@
>      QA output created by 349
>      Format and populate
>     -Scrub
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/349.out /lkp/benchmarks/xfstests/results//xfs/349.out.bad'  to see the entire diff)

You are running a test in the "dangerous_fuzzers" group that isn't
in the auto group. This is a test for developers to find error
detection issues and, as such, failure is kinda expected. It is not
regression test that can be used for pass/fail testing....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
