Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63650D242
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiDXOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbiDXOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:33:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C123BC1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650810645; x=1682346645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1o4u4tcHj8GJHvMb2O8TmdCKH7Vu63K+AlpEAuoV8Qo=;
  b=dX3ZPrMddvjlyxtRIn4RL1TnhgmocOI76Bowe0ur8d4hmlQnu41F+Cqi
   6h3APTyuWnvaTrDOUYG0CPuEsUR9uAiGUP2Qt6MxHvcOvvjP6CsD64sgm
   hjpHRvIFJLbYUpAB9jz32KqH7xZtT74erat1hAGOaxPoV32XFFwp4sCtX
   LUSteJKp0hCd2PEqwbNe9kQx2cdmHhkK6I1fRpO6MCJIYCvshiB5FWc/D
   /V6OzY76acURheW1rWc6G2f2uhyVo3MGom6GK0wRIND4uOIi1BH7HU+Rc
   k3btTmG7wSXzKi0dedxn0DuK3anskffbgIKRKfVv50uh8Ouu6w3B3obWQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="265217241"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="265217241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 07:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="594855437"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2022 07:30:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nidG6-0001WV-0m;
        Sun, 24 Apr 2022 14:30:42 +0000
Date:   Sun, 24 Apr 2022 22:30:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: make filesystem exportable
Message-ID: <202204242236.0aTl5THK-lkp@intel.com>
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongnan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongnan-Li/erofs-make-filesystem-exportable/20220424-211653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
config: hexagon-buildonly-randconfig-r005-20220424 (https://download.01.org/0day-ci/archive/20220424/202204242236.0aTl5THK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0fc15c5ccc4a5090cc32744ba63bde8ea558ac7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hongnan-Li/erofs-make-filesystem-exportable/20220424-211653
        git checkout c0fc15c5ccc4a5090cc32744ba63bde8ea558ac7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/super.c:601:16: warning: no previous prototype for function 'erofs_get_parent' [-Wmissing-prototypes]
   struct dentry *erofs_get_parent(struct dentry *child)
                  ^
   fs/erofs/super.c:601:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *erofs_get_parent(struct dentry *child)
   ^
   static 
   1 warning generated.


vim +/erofs_get_parent +601 fs/erofs/super.c

   600	
 > 601	struct dentry *erofs_get_parent(struct dentry *child)
   602	{
   603		erofs_nid_t nid;
   604		unsigned int d_type;
   605		int err;
   606	
   607		err = erofs_namei(d_inode(child), &dotdot_name, &nid, &d_type);
   608		if (err)
   609			return ERR_PTR(err);
   610		return d_obtain_alias(erofs_iget(child->d_sb, nid, d_type == FT_DIR));
   611	}
   612	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
