Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC253A90E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355275AbiFAOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356210AbiFAOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:20:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A62A1A2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654092576; x=1685628576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OIASPbT4ErywrxAuYrz/ZgaqSnR5UCcNc+ztvYy5GUs=;
  b=a/sYWc8AnFSaqo9KZTUfBhMThbdr9ycV/vIS9hJU2LYxekvrLGxu7v/r
   XsmcET8BSbKU8P+HLpep0yGvLctTSN0t7xVgKbxJO8C5kiDe6miyae+Nf
   2KP6VzJDyJdWNlbPjfvh/F4srQdXLi35ORRxoL3Wf5nxe6oiFTGhVG5r0
   TlxhG1qIPr77AwtFlyvnNhIzF6kGuMKSCQuxVAKJ0oQaVZ/NTw/104RIk
   reYdeXRF7ZG1pj9roVRO/w0W8JE1k4xX7IU/j8bqth6Jfs/dv6mopfONR
   gZD1PRZMDgg/bRBvqPl3QHcqZzCXSnsJIEuK2PusmhTOmYIp7yQNfISI0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257668795"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="257668795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 07:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="680113133"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2022 07:09:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwP20-00043U-0h;
        Wed, 01 Jun 2022 14:09:04 +0000
Date:   Wed, 1 Jun 2022 22:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Haowen Bai <baihaowen@meizu.com>, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coda: remove unused variable
Message-ID: <202206012159.9WhO0iYq-lkp@intel.com>
References: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Haowen-Bai/coda-remove-unused-variable/20220601-160014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 700170bf6b4d773e328fa54ebb70ba444007c702
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220601/202206012159.9WhO0iYq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/627c05172e8d819cb8dca41dfa795baae03ea6f9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Haowen-Bai/coda-remove-unused-variable/20220601-160014
        git checkout 627c05172e8d819cb8dca41dfa795baae03ea6f9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/coda/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/coda/upcall.c:115:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   fs/coda/upcall.c:164:20: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   fs/coda/upcall.c:238:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   fs/coda/upcall.c:306:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   fs/coda/upcall.c:329:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   fs/coda/upcall.c:383:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   fs/coda/upcall.c:410:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   fs/coda/upcall.c:443:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp; 
                             ^
   fs/coda/upcall.c:459:27: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp; 
                             ^
>> fs/coda/upcall.c:483:2: error: use of undeclared identifier 'insize'
           UPARG(CODA_IOCTL);
           ^
   fs/coda/upcall.c:63:44: note: expanded from macro 'UPARG'
           inp = (union inputArgs *)alloc_upcall(op, insize); \
                                                     ^
>> fs/coda/upcall.c:483:2: error: use of undeclared identifier 'insize'
   fs/coda/upcall.c:66:19: note: expanded from macro 'UPARG'
           outsize = insize; \
                     ^
   fs/coda/upcall.c:576:20: warning: variable 'outp' set but not used [-Wunused-but-set-variable]
           union outputArgs *outp;
                             ^
   10 warnings and 2 errors generated.


vim +/insize +483 fs/coda/upcall.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  473  
^1da177e4c3f41 Linus Torvalds   2005-04-16  474  
^1da177e4c3f41 Linus Torvalds   2005-04-16  475  int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
^1da177e4c3f41 Linus Torvalds   2005-04-16  476  		 unsigned int cmd, struct PioctlData *data)
^1da177e4c3f41 Linus Torvalds   2005-04-16  477  {
^1da177e4c3f41 Linus Torvalds   2005-04-16  478          union inputArgs *inp;
^1da177e4c3f41 Linus Torvalds   2005-04-16  479          union outputArgs *outp;  
627c05172e8d81 Haowen Bai       2022-06-01  480  	int outsize, error;
^1da177e4c3f41 Linus Torvalds   2005-04-16  481  	int iocsize;
^1da177e4c3f41 Linus Torvalds   2005-04-16  482  
^1da177e4c3f41 Linus Torvalds   2005-04-16 @483  	UPARG(CODA_IOCTL);
^1da177e4c3f41 Linus Torvalds   2005-04-16  484  
^1da177e4c3f41 Linus Torvalds   2005-04-16  485          /* build packet for Venus */
^1da177e4c3f41 Linus Torvalds   2005-04-16  486          if (data->vi.in_size > VC_MAXDATASIZE) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  487  		error = -EINVAL;
^1da177e4c3f41 Linus Torvalds   2005-04-16  488  		goto exit;
^1da177e4c3f41 Linus Torvalds   2005-04-16  489          }
^1da177e4c3f41 Linus Torvalds   2005-04-16  490  
^1da177e4c3f41 Linus Torvalds   2005-04-16  491          if (data->vi.out_size > VC_MAXDATASIZE) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  492  		error = -EINVAL;
^1da177e4c3f41 Linus Torvalds   2005-04-16  493  		goto exit;
^1da177e4c3f41 Linus Torvalds   2005-04-16  494  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  495  
^1da177e4c3f41 Linus Torvalds   2005-04-16  496          inp->coda_ioctl.VFid = *fid;
^1da177e4c3f41 Linus Torvalds   2005-04-16  497      
^1da177e4c3f41 Linus Torvalds   2005-04-16  498          /* the cmd field was mutated by increasing its size field to
^1da177e4c3f41 Linus Torvalds   2005-04-16  499           * reflect the path and follow args. We need to subtract that
^1da177e4c3f41 Linus Torvalds   2005-04-16  500           * out before sending the command to Venus.  */
^1da177e4c3f41 Linus Torvalds   2005-04-16  501          inp->coda_ioctl.cmd = (cmd & ~(PIOCPARM_MASK << 16));	
^1da177e4c3f41 Linus Torvalds   2005-04-16  502          iocsize = ((cmd >> 16) & PIOCPARM_MASK) - sizeof(char *) - sizeof(int);
^1da177e4c3f41 Linus Torvalds   2005-04-16  503          inp->coda_ioctl.cmd |= (iocsize & PIOCPARM_MASK) <<	16;	
^1da177e4c3f41 Linus Torvalds   2005-04-16  504      
^1da177e4c3f41 Linus Torvalds   2005-04-16  505          /* in->coda_ioctl.rwflag = flag; */
^1da177e4c3f41 Linus Torvalds   2005-04-16  506          inp->coda_ioctl.len = data->vi.in_size;
^1da177e4c3f41 Linus Torvalds   2005-04-16  507          inp->coda_ioctl.data = (char *)(INSIZE(ioctl));
^1da177e4c3f41 Linus Torvalds   2005-04-16  508       
^1da177e4c3f41 Linus Torvalds   2005-04-16  509          /* get the data out of user space */
^1da177e4c3f41 Linus Torvalds   2005-04-16  510  	if (copy_from_user((char *)inp + (long)inp->coda_ioctl.data,
^1da177e4c3f41 Linus Torvalds   2005-04-16  511  			   data->vi.in, data->vi.in_size)) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  512  		error = -EINVAL;
^1da177e4c3f41 Linus Torvalds   2005-04-16  513  	        goto exit;
^1da177e4c3f41 Linus Torvalds   2005-04-16  514  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  515  
a1b0aa87647493 Jan Harkes       2007-07-19  516  	error = coda_upcall(coda_vcp(sb), SIZE(ioctl) + data->vi.in_size,
^1da177e4c3f41 Linus Torvalds   2005-04-16  517  			    &outsize, inp);
^1da177e4c3f41 Linus Torvalds   2005-04-16  518  
^1da177e4c3f41 Linus Torvalds   2005-04-16  519          if (error) {
6d6bd94f4d83d7 Fabian Frederick 2014-06-06  520  		pr_warn("%s: Venus returns: %d for %s\n",
6d6bd94f4d83d7 Fabian Frederick 2014-06-06  521  			__func__, error, coda_f2s(fid));
^1da177e4c3f41 Linus Torvalds   2005-04-16  522  		goto exit; 
^1da177e4c3f41 Linus Torvalds   2005-04-16  523  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  524  
^1da177e4c3f41 Linus Torvalds   2005-04-16  525  	if (outsize < (long)outp->coda_ioctl.data + outp->coda_ioctl.len) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  526  		error = -EINVAL;
^1da177e4c3f41 Linus Torvalds   2005-04-16  527  		goto exit;
^1da177e4c3f41 Linus Torvalds   2005-04-16  528  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  529          
^1da177e4c3f41 Linus Torvalds   2005-04-16  530  	/* Copy out the OUT buffer. */
^1da177e4c3f41 Linus Torvalds   2005-04-16  531          if (outp->coda_ioctl.len > data->vi.out_size) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  532  		error = -EINVAL;
^1da177e4c3f41 Linus Torvalds   2005-04-16  533  		goto exit;
^1da177e4c3f41 Linus Torvalds   2005-04-16  534          }
^1da177e4c3f41 Linus Torvalds   2005-04-16  535  
^1da177e4c3f41 Linus Torvalds   2005-04-16  536  	/* Copy out the OUT buffer. */
^1da177e4c3f41 Linus Torvalds   2005-04-16  537  	if (copy_to_user(data->vi.out,
^1da177e4c3f41 Linus Torvalds   2005-04-16  538  			 (char *)outp + (long)outp->coda_ioctl.data,
^1da177e4c3f41 Linus Torvalds   2005-04-16  539  			 outp->coda_ioctl.len)) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  540  		error = -EFAULT;
^1da177e4c3f41 Linus Torvalds   2005-04-16  541  		goto exit;
^1da177e4c3f41 Linus Torvalds   2005-04-16  542  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  543  
^1da177e4c3f41 Linus Torvalds   2005-04-16  544   exit:
936dae4525322f Dan Carpenter    2019-07-16  545  	kvfree(inp);
^1da177e4c3f41 Linus Torvalds   2005-04-16  546  	return error;
^1da177e4c3f41 Linus Torvalds   2005-04-16  547  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  548  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
