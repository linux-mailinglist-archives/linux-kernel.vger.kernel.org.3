Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A524753D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhLOHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:41:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:10762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhLOHlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639554113; x=1671090113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nmB0XX/nlHr0hYrA4MT77yOECUswRd/uG0DSr9vtZeE=;
  b=TbCkwH5xI2uUA46dIwYaQpQAPAP1pCGO316xEI/GNeyPjHYW9fFfSJYC
   G8zkyL1fyN4++S9yGUT/Bj+TA+jj749MhUvJ91kGa241qqHZiZDM2Fdbw
   DnHGcDrbq5Bfyx0x01Yd3pYLlsM0uiFJ7J7zhDAaHSI90g8VsnohAMIoD
   lVZpDHNN+9Mqtzf3Z1SaLCbwSRFeMcuN4kkTS6otwsjeCRjPLkco3CtR4
   oHJcAaiEfd8TnlMDeMI9zBYhigt9eb0PX1UB8LF4+i6HZ10BPoT9sWd7t
   EUIEvn0eY9vemGQOC1h/ubygKzujs+uUdIA2bqzP0grjGYjjeYXStZtLV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="325449575"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="325449575"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 23:41:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="545489962"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2021 23:41:49 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxOv6-0001Re-W9; Wed, 15 Dec 2021 07:41:48 +0000
Date:   Wed, 15 Dec 2021 15:41:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amitay Isaacs <amitay@ozlabs.org>, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com
Cc:     kbuild-all@lists.01.org, Amitay Isaacs <amitay@ozlabs.org>
Subject: Re: [PATCH 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT
 ioctl
Message-ID: <202112151543.C2qA1wIs-lkp@intel.com>
References: <20211215005833.222841-2-amitay@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215005833.222841-2-amitay@ozlabs.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amitay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.16-rc5 next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Amitay-Isaacs/fsi-sbefifo-Use-specified-value-of-start-of-response-timeout/20211215-090038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: h8300-randconfig-s032-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151543.C2qA1wIs-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/abe81bc06079f76e9a9f4ebe6cc0a963ee5b6985
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Amitay-Isaacs/fsi-sbefifo-Use-specified-value-of-start-of-response-timeout/20211215-090038
        git checkout abe81bc06079f76e9a9f4ebe6cc0a963ee5b6985
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/fsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/fsi/fsi-sbefifo.c:956:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user **argp @@     got void [noderef] __user * @@
   drivers/fsi/fsi-sbefifo.c:956:31: sparse:     expected void [noderef] __user **argp
   drivers/fsi/fsi-sbefifo.c:956:31: sparse:     got void [noderef] __user *

vim +956 drivers/fsi/fsi-sbefifo.c

   952	
   953	static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
   954	{
   955		struct sbefifo_user *user = file->private_data;
 > 956		void __user **argp = (void __user *)arg;
   957		int rc = -ENOTTY;
   958	
   959		if (!user)
   960			return -EINVAL;
   961	
   962		mutex_lock(&user->file_lock);
   963		switch (cmd) {
   964		case FSI_SBEFIFO_READ_TIMEOUT:
   965			rc = sbefifo_read_timeout(user, argp);
   966			break;
   967		}
   968		mutex_unlock(&user->file_lock);
   969		return rc;
   970	}
   971	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
