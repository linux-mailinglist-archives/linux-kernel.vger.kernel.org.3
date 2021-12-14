Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDD473B83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhLND0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:26:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:59776 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhLND0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639452367; x=1670988367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=71zIv+Njok8Xe+yhfXw+gCZCCrc8tzE51c0znQCgWKQ=;
  b=d1PxBjg1/9sV6d6h6q7OiKReFtFTOT2uitiqLc7/BmnnB98OKRSYAxFD
   CvNna4TqK9jhpFFUJmp/YIT5qq28Y/THPB16TZY0QjbWIWQIwiIDSxQjK
   c/bQL77TQt/x2poLd4FrQ51fTAo729V6Rn34TR14cB/0AGct+AGTgrMaQ
   fPZMhSrumZ3paGQ8lz4YpTVOEAHCv74DU2utvMcKNCsTKDvvkxF6kfk7E
   /B9vQyzItPvVD8ruTsw7oO0i6iPT2ewnfiXodORknrPJ1bGS3FhOYycAx
   qmtXm2xfYKQGiSBfz+M/Vs9oFrfn74mcbDIt6o4WVmCiZnBfMEgEQqdIR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225747884"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="225747884"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 19:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="481753039"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2021 19:26:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwyS2-0007NX-Qh; Tue, 14 Dec 2021 03:26:02 +0000
Date:   Tue, 14 Dec 2021 11:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Brazdil <dbrazdil@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <202112141128.lBBmmIuE-lkp@intel.com>
References: <20211213195833.772892-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213195833.772892-3-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on char-misc/char-misc-testing soc/for-next v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Brazdil/Driver-for-Open-Profile-for-DICE/20211214-040051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211214/202112141128.lBBmmIuE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6fb8e9472d98abcc2dfabd43e95fc4ec5819ecd0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Brazdil/Driver-for-Open-Profile-for-DICE/20211214-040051
        git checkout 6fb8e9472d98abcc2dfabd43e95fc4ec5819ecd0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/open-dice.c:74: warning: Function parameter or member 'filp' not described in 'open_dice_read'
   drivers/misc/open-dice.c:74: warning: Function parameter or member 'ptr' not described in 'open_dice_read'
   drivers/misc/open-dice.c:74: warning: Function parameter or member 'len' not described in 'open_dice_read'
   drivers/misc/open-dice.c:74: warning: Function parameter or member 'off' not described in 'open_dice_read'
>> drivers/misc/open-dice.c:74: warning: expecting prototype for Returns the size of the reserved memory region. The user(). Prototype was for open_dice_read() instead
   drivers/misc/open-dice.c:84: warning: Function parameter or member 'filp' not described in 'open_dice_write'
   drivers/misc/open-dice.c:84: warning: Function parameter or member 'ptr' not described in 'open_dice_write'
   drivers/misc/open-dice.c:84: warning: Function parameter or member 'len' not described in 'open_dice_write'
   drivers/misc/open-dice.c:84: warning: Function parameter or member 'off' not described in 'open_dice_write'
>> drivers/misc/open-dice.c:84: warning: expecting prototype for Triggers a wipe of the reserved memory region. The user(). Prototype was for open_dice_write() instead
>> drivers/misc/open-dice.c:89: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Creates a mapping of the reserved memory region in a user address space.


vim +74 drivers/misc/open-dice.c

    67	
    68	/**
    69	 * Returns the size of the reserved memory region. The user-provided pointer is
    70	 * never dereferenced.
    71	 */
    72	static ssize_t open_dice_read(struct file *filp, char __user *ptr, size_t len,
    73				      loff_t *off)
  > 74	{
    75		return open_dice_size(to_open_dice_drvdata(filp));
    76	}
    77	
    78	/**
    79	 * Triggers a wipe of the reserved memory region. The user-provided pointer is
    80	 * never dereferenced.
    81	 */
    82	static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
    83				       size_t len, loff_t *off)
  > 84	{
    85		return open_dice_wipe(to_open_dice_drvdata(filp));
    86	}
    87	
    88	/**
  > 89	 * Creates a mapping of the reserved memory region in a user address space.
    90	 */
    91	static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
    92	{
    93		struct open_dice_drvdata *drvdata = to_open_dice_drvdata(filp);
    94	
    95		/* Do not allow userspace to modify the underlying data. */
    96		if ((vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED))
    97			return -EPERM;
    98	
    99		/* Create write-combine mapping so all clients observe a wipe. */
   100		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
   101		vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
   102		return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->size);
   103	}
   104	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
