Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF804D6289
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbiCKNoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCKNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:44:12 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD5145E37
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647006189; x=1678542189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UY0ZKgcIqKBWofNbC62E37i4G3ggbAr8G9oOPJzKjrk=;
  b=Yi10p71cQj35JuOWykf0ZbLG+lSvudpJdEB3xZWaBnXZW7IoLtvueo43
   +8QTxbt4m7Y8YrtdvQ1D/VbllYSlcicJRe6SD0IWa6GX1rW7Jhgjc5ovG
   z86qjy/hIxg69dK/MKJo2Vtcdzmb54SeLr+sR2+Etlg4ED5WXF2RsHBRI
   OfXNb9PQOVvaKnkGjE0slPfmv9J7WI+HAvvOgRV4kJ5B728s9WM8HCriv
   3BIPjnv2hP3DKUuX7Odbz2gMymBWDOZHwlE3GeKc3DSBsWU2sEzebFOs1
   uKgL3lW6GLKCfsXdsJJcK2hPojjTI3Cjms4rbQMlyt0J0bbq0jsxWiO20
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316294457"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="316294457"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 05:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="597111135"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2022 05:43:07 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSfXu-0006UY-AE; Fri, 11 Mar 2022 13:43:06 +0000
Date:   Fri, 11 Mar 2022 21:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 7/9] net/core/filter.c:9736:14: error:
 implicit declaration of function 'bpf_get_btf_vmlinux'
Message-ID: <202203112129.UHn4ulpB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   91c92d46077f70b03fd162128dd3373663d529d4
commit: 9bae1dad48ccbee1a035d242a407ea54a29ae2c9 [7/9] bpf: Enable direct packet access for dequeue packets
config: arc-buildonly-randconfig-r002-20220310 (https://download.01.org/0day-ci/archive/20220311/202203112129.UHn4ulpB-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=9bae1dad48ccbee1a035d242a407ea54a29ae2c9
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 9bae1dad48ccbee1a035d242a407ea54a29ae2c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/core/filter.c:9727:5: warning: no previous prototype for 'dequeue_btf_struct_access' [-Wmissing-prototypes]
    9727 | int dequeue_btf_struct_access(struct bpf_verifier_log *log,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c: In function 'dequeue_btf_struct_access':
>> net/core/filter.c:9736:14: error: implicit declaration of function 'bpf_get_btf_vmlinux' [-Werror=implicit-function-declaration]
    9736 |         if (!bpf_get_btf_vmlinux() || btf != bpf_get_btf_vmlinux())
         |              ^~~~~~~~~~~~~~~~~~~
   net/core/filter.c:9736:43: warning: comparison between pointer and integer
    9736 |         if (!bpf_get_btf_vmlinux() || btf != bpf_get_btf_vmlinux())
         |                                           ^~
   net/core/filter.c:9744:35: warning: passing argument 1 of 'btf_type_by_id' makes pointer from integer without a cast [-Wint-conversion]
    9744 |         pkt_type = btf_type_by_id(bpf_get_btf_vmlinux(), xdp_md_btf_ids[0]);
         |                                   ^~~~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   int
   In file included from net/core/filter.c:50:
   include/linux/btf.h:348:71: note: expected 'const struct btf *' but argument is of type 'int'
     348 | static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
         |                                                     ~~~~~~~~~~~~~~~~~~^~~
>> net/core/filter.c:9748:24: error: implicit declaration of function 'btf_struct_access'; did you mean 'dequeue_btf_struct_access'? [-Werror=implicit-function-declaration]
    9748 |                 return btf_struct_access(log, btf, t, off, size, atype,
         |                        ^~~~~~~~~~~~~~~~~
         |                        dequeue_btf_struct_access
   net/core/filter.c: In function 'dequeue_get_convert_ctx_access':
   net/core/filter.c:9861:43: warning: comparison between pointer and integer
    9861 |         if (!bpf_get_btf_vmlinux() || btf != bpf_get_btf_vmlinux())
         |                                           ^~
   cc1: some warnings being treated as errors


vim +/bpf_get_btf_vmlinux +9736 net/core/filter.c

  9726	
  9727	int dequeue_btf_struct_access(struct bpf_verifier_log *log,
  9728				      const struct btf *btf,
  9729				      const struct btf_type *t, int off, int size,
  9730				      enum bpf_access_type atype,
  9731				      u32 *next_btf_id, enum bpf_type_flag *flag)
  9732	{
  9733		const struct btf_type *pkt_type;
  9734		enum bpf_reg_type reg_type;
  9735	
> 9736		if (!bpf_get_btf_vmlinux() || btf != bpf_get_btf_vmlinux())
  9737			return -EINVAL;
  9738	
  9739		if (atype != BPF_READ) {
  9740			bpf_log(log, "only read is supported\n");
  9741			return -EACCES;
  9742		}
  9743	
  9744		pkt_type = btf_type_by_id(bpf_get_btf_vmlinux(), xdp_md_btf_ids[0]);
  9745		if (!pkt_type)
  9746			return -EINVAL;
  9747		if (t != pkt_type)
> 9748			return btf_struct_access(log, btf, t, off, size, atype,
  9749						 next_btf_id, flag);
  9750	
  9751		switch (off) {
  9752		case offsetof(struct xdp_md, data):
  9753			reg_type = PTR_TO_PACKET;
  9754			break;
  9755		case offsetof(struct xdp_md, data_meta):
  9756			reg_type = PTR_TO_PACKET_META;
  9757			break;
  9758		case offsetof(struct xdp_md, data_end):
  9759			reg_type = PTR_TO_PACKET_END;
  9760			break;
  9761		default:
  9762			bpf_log(log, "only access to data, data_meta, and data_end allowed for xdp_md\n");
  9763			return -EACCES;
  9764		}
  9765	
  9766		if (!__is_valid_xdp_access(off, size)) {
  9767			bpf_log(log, "invalid xdp_md access off=%d size=%d\n", off, size);
  9768			return -EINVAL;
  9769		}
  9770		return reg_type;
  9771	}
  9772	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
