Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1118B4D789E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 23:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiCMWqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 18:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCMWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 18:46:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910573079
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647211534; x=1678747534;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6/PmBlsNMqYSzZY3dIK0TjfWjBpSYq6IwPvIuaEWwtc=;
  b=XLBL/ii5GdOgWerM0qnZMqKIcCiyaBqDLVsQilPEehiTegx7mo3FpaIp
   7RbUGxKE5wtRwbuEoAANoM4/++g0hPomqDtpBpCZ+3MHuoFBaDaNSVRxo
   qoy6z30UXKebP9iwiF0pMjK0gwDCKhVqpSdi0Z6oipNuhpaFdkKWIDBc4
   ZMdccAnqkx7XkYZrQfmVJSayuOk75hKrc6PceIWcx30u+b1QPX2b/b/0C
   uaU1cfP4doophGUlVASwq9RQ45qkaap5iqdMYYOuQatJEBpImU7b64ja7
   AYo3adAlFUZaXriClTjDNXkfKWUkMG0jZaMbExXtdfoh2KK9heKyqTiBH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="254732977"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="254732977"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 15:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="713504214"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 15:45:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTWxv-0009LS-V4; Sun, 13 Mar 2022 22:45:31 +0000
Date:   Mon, 14 Mar 2022 06:44:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 7/9] net/core/filter.c:9720:14: warning:
 assignment to 'struct btf *' from 'int' makes pointer from integer without a
 cast
Message-ID: <202203140612.pwI8TzBG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   3e7f25d58b1bfd5ad623678bf9e11f27c98a8094
commit: 28d9ca982b9ae96bcad2bee81647ba18ae049a69 [7/9] bpf: Enable direct packet access for dequeue packets
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220314/202203140612.pwI8TzBG-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=28d9ca982b9ae96bcad2bee81647ba18ae049a69
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 28d9ca982b9ae96bcad2bee81647ba18ae049a69
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/skmsg.h:7,
                    from net/core/filter.c:38:
   include/linux/bpf.h:2062:15: error: return type defaults to 'int' [-Werror=return-type]
    2062 | static inline bpf_get_btf_vmlinux(void)
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h: In function 'bpf_get_btf_vmlinux':
   include/linux/bpf.h:2064:9: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    2064 |  return ERR_PTR(-EINVAL);
         |         ^~~~~~~~~~~~~~~~
   net/core/filter.c: In function 'dequeue_btf_struct_access':
>> net/core/filter.c:9720:14: warning: assignment to 'struct btf *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    9720 |  btf_vmlinux = bpf_get_btf_vmlinux();
         |              ^
   net/core/filter.c: In function 'dequeue_get_convert_ctx_access':
   net/core/filter.c:9848:14: warning: assignment to 'struct btf *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    9848 |  btf_vmlinux = bpf_get_btf_vmlinux();
         |              ^
   cc1: some warnings being treated as errors


vim +9720 net/core/filter.c

  9709	
  9710	static int dequeue_btf_struct_access(struct bpf_verifier_log *log,
  9711					     const struct btf *btf,
  9712					     const struct btf_type *t, int off, int size,
  9713					     enum bpf_access_type atype,
  9714					     u32 *next_btf_id, enum bpf_type_flag *flag)
  9715	{
  9716		const struct btf_type *pkt_type;
  9717		enum bpf_reg_type reg_type;
  9718		struct btf *btf_vmlinux;
  9719	
> 9720		btf_vmlinux = bpf_get_btf_vmlinux();
  9721		if (IS_ERR(btf_vmlinux) || btf != btf_vmlinux)
  9722			return -EINVAL;
  9723	
  9724		if (atype != BPF_READ) {
  9725			bpf_log(log, "only read is supported\n");
  9726			return -EACCES;
  9727		}
  9728	
  9729		pkt_type = btf_type_by_id(btf_vmlinux, xdp_md_btf_ids[0]);
  9730		if (!pkt_type)
  9731			return -EINVAL;
  9732		if (t != pkt_type)
  9733			return btf_struct_access(log, btf, t, off, size, atype,
  9734						 next_btf_id, flag);
  9735	
  9736		switch (off) {
  9737		case offsetof(struct xdp_md, data):
  9738			reg_type = PTR_TO_PACKET;
  9739			break;
  9740		case offsetof(struct xdp_md, data_meta):
  9741			reg_type = PTR_TO_PACKET_META;
  9742			break;
  9743		case offsetof(struct xdp_md, data_end):
  9744			reg_type = PTR_TO_PACKET_END;
  9745			break;
  9746		default:
  9747			bpf_log(log, "only access to data, data_meta, and data_end allowed for xdp_md\n");
  9748			return -EACCES;
  9749		}
  9750	
  9751		if (!__is_valid_xdp_access(off, size)) {
  9752			bpf_log(log, "invalid xdp_md access off=%d size=%d\n", off, size);
  9753			return -EINVAL;
  9754		}
  9755		return reg_type;
  9756	}
  9757	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
