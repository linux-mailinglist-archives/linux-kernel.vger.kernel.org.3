Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689C44E4D12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiCWHKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiCWHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:10:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E99BF72;
        Wed, 23 Mar 2022 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648019320; x=1679555320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nFfcLS/n1UgIu6ykqsZWlNP54RWJ3rWzqT7racZ7/Kc=;
  b=AVDnTdysSU1/9Akzf+mllDdslzpUflXS8OPUpV4Y069Y34ljtrNvJY+C
   MMiEe3vQ8L+EpoJrMx9FtVccUQdEfYOaaEbZY7xbZ76AzacDKfz3kRCNl
   x/j3z8PqeLb8Wd7Bzi5Apq3ARWQ41VwIsiiPUtttP4LjZH+msrXFJi8hI
   TIbN9kRZjZ19aO89kD/Wcztpb4WZZsE20vb1LjSnoce6nl2tafE08Ekb1
   2SVg9JbQ1yReOy+vh7vun+dUkwHw3FuPKosnz0P4XB5WkbUhqepFpYZMj
   cRqb7YFYQLZS/GDjJuFqTwuuFpfpeN9DGTCOQfp9DAWc8Px0DKljt0j9t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258230534"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="xz'?bad'?full'?scan'208";a="258230534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:08:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="xz'?bad'?full'?scan'208";a="519246097"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:08:37 -0700
Date:   Wed, 23 Mar 2022 15:08:34 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [xfs]  1fc3f2c3c9: xfstests.xfs.529.fail
Message-ID: <20220323070834.GB16885@xsang-OptiPlex-9020>
References: <20220322135402.GB32582@xsang-OptiPlex-9020>
 <20220322162733.GP8241@magnolia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20220322162733.GP8241@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi, Darrick,

On Tue, Mar 22, 2022 at 09:27:33AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 22, 2022 at 09:54:02PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 1fc3f2c3c928c88654d4716af5cc4dee07b3a1c4 ("xfs: only free posteof blocks on first close")
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
> > 
> > in testcase: xfstests
> > version: xfstests-x86_64-1de1db8-1_20220217
> > with following parameters:
> > 
> > 	disk: 4HDD
> > 	fs: xfs
> > 	test: xfs-group-52
> > 	ucode: 0x21
> > 
> > test-description: xfstests is a regression test suite for xfs and other files ystems.
> > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > 
> > on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> 
> Could you export DIFF_LENGTH=0 in the test environment so that we get
> the full diff here, please?

the full diff is as below (also attached dmesg, full log, log for 529 in case
helpful):

xfs/529 [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/529.out.bad)
    --- tests/xfs/529.out       2022-02-17 11:55:00.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//xfs/529.out.bad       2022-03-23 06:18:39.815036267 +0000
    @@ -4,21 +4,4 @@
     Inject reduce_max_iextents error tag
     Create fragmented file
     Verify $testfile's extent count
    -Disable reduce_max_iextents error tag
    -* Fallocate unwritten extents
    -Inject reduce_max_iextents error tag
    -Fallocate fragmented file
    -Verify $testfile's extent count
    -Disable reduce_max_iextents error tag
    -* Directio write
    -Inject reduce_max_iextents error tag
    -Create fragmented file via directio writes
    -Verify $testfile's extent count
    -Disable reduce_max_iextents error tag
    -* Extend quota inodes
    -Consume free space
    -Create fragmented filesystem
    -Inject reduce_max_iextents error tag
    -Inject bmap_alloc_minlen_extent error tag
    -Extend uquota file
    -Verify uquota inode's extent count
    +Extent count overflow check failed: nextents = 15


> 
> --D
> 

--A6N2fC+uXW/VQSAv
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
eOMKOAABgTDutgIADX3dcrHEZ/sCAAAAAARZWg==

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xfstests

2022-03-23 06:18:24 export TEST_DIR=/fs/sdb1
2022-03-23 06:18:24 export TEST_DEV=/dev/sdb1
2022-03-23 06:18:24 export FSTYP=xfs
2022-03-23 06:18:24 export SCRATCH_MNT=/fs/scratch
2022-03-23 06:18:24 mkdir /fs/scratch -p
2022-03-23 06:18:24 export SCRATCH_DEV=/dev/sdb4
2022-03-23 06:18:24 export SCRATCH_LOGDEV=/dev/sdb2
2022-03-23 06:18:24 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
2022-03-23 06:18:24 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
DIFF_LENGTH=
0
END
2022-03-23 06:18:24 sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group-52
2022-03-23 06:18:24 ./check xfs/520 xfs/522 xfs/523 xfs/524 xfs/525 xfs/526 xfs/527 xfs/529
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 lkp-ivb-d05 5.17.0-rc8-00340-g1fc3f2c3c928 #1 SMP Mon Mar 21 07:17:57 CST 2022
MKFS_OPTIONS  -- -f /dev/sdb4
MOUNT_OPTIONS -- /dev/sdb4 /fs/scratch

xfs/520	 3s
xfs/522	[not run] need configuration file support in mkfs.xfs
xfs/523	[not run] need configuration file support in mkfs.xfs
xfs/524	[not run] need configuration file support in mkfs.xfs
xfs/525	[not run] need configuration file support in mkfs.xfs
xfs/526	[not run] need configuration file support in mkfs.xfs
xfs/527	 2s
xfs/529	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/529.out.bad)
    --- tests/xfs/529.out	2022-02-17 11:55:00.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//xfs/529.out.bad	2022-03-23 06:18:39.815036267 +0000
    @@ -4,21 +4,4 @@
     Inject reduce_max_iextents error tag
     Create fragmented file
     Verify $testfile's extent count
    -Disable reduce_max_iextents error tag
    -* Fallocate unwritten extents
    -Inject reduce_max_iextents error tag
    -Fallocate fragmented file
    -Verify $testfile's extent count
    -Disable reduce_max_iextents error tag
    -* Directio write
    -Inject reduce_max_iextents error tag
    -Create fragmented file via directio writes
    -Verify $testfile's extent count
    -Disable reduce_max_iextents error tag
    -* Extend quota inodes
    -Consume free space
    -Create fragmented filesystem
    -Inject reduce_max_iextents error tag
    -Inject bmap_alloc_minlen_extent error tag
    -Extend uquota file
    -Verify uquota inode's extent count
    +Extent count overflow check failed: nextents = 15
Ran: xfs/520 xfs/522 xfs/523 xfs/524 xfs/525 xfs/526 xfs/527 xfs/529
Not run: xfs/522 xfs/523 xfs/524 xfs/525 xfs/526
Failures: xfs/529
Failed 1 of 8 tests


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="529.full"

meta-data=/dev/sdb4              isize=512    agcount=4, agsize=32768 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=0
data     =                       bsize=4096   blocks=131072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=1605, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0185 sec (216.099 KiB/sec and 54.0249 ops/sec)
wrote 4096/4096 bytes at offset 8192
4 KiB, 1 ops; 0.0157 sec (253.888 KiB/sec and 63.4719 ops/sec)
wrote 4096/4096 bytes at offset 16384
4 KiB, 1 ops; 0.0158 sec (251.620 KiB/sec and 62.9050 ops/sec)
wrote 4096/4096 bytes at offset 24576
4 KiB, 1 ops; 0.0160 sec (248.648 KiB/sec and 62.1620 ops/sec)
wrote 4096/4096 bytes at offset 32768
4 KiB, 1 ops; 0.0160 sec (249.423 KiB/sec and 62.3558 ops/sec)
wrote 4096/4096 bytes at offset 40960
4 KiB, 1 ops; 0.0158 sec (251.604 KiB/sec and 62.9010 ops/sec)
wrote 4096/4096 bytes at offset 49152
4 KiB, 1 ops; 0.0161 sec (247.755 KiB/sec and 61.9387 ops/sec)
wrote 4096/4096 bytes at offset 57344
4 KiB, 1 ops; 0.0159 sec (250.878 KiB/sec and 62.7195 ops/sec)
pwrite: File too large
pwrite: File too large
pwrite: File too large
pwrite: File too large
pwrite: File too large
pwrite: File too large
pwrite: File too large

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="529.out.bad"

QA output created by 529
Format and mount fs
* Delalloc to written extent conversion
Inject reduce_max_iextents error tag
Create fragmented file
Verify $testfile's extent count
Extent count overflow check failed: nextents = 15

--A6N2fC+uXW/VQSAv--
