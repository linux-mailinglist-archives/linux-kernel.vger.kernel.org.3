Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044EB57E0DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiGVLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiGVLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:31:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C82584EEB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658489504; x=1690025504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7Mgh2v51fvKrprdWwzR0ZLKsjdW5A4VF7OUsVpraGz0=;
  b=NgGHUSRGj0g9uv+dDFPorIekJhAGPkTrnHTau4cg3GdicgG18fK9IHNN
   EQ0v8WXCN6EwQgN64ZWzTQSmTs3bVWNgIJk0tOMESbi2nzg16M832zwnu
   CvpOAWjz1yk2EYbNr4asXJFHU2B3jrS/ZII4N7wHeRwxpah6UbhoRzXHp
   shfJyoZc1KCWyGmANkLvwNh7mOs17cMfFwavaVVa+IBPKUgV6fZIWI1YW
   pJk1LV+6RlDsHIBjwrvzfpTttzZ5OyiIIzhFsWy8KYWlHbzfUupTJPZYh
   NtPjHeXXEdcoVKLGKfI7FjjlZ5VjS0EIpZ5z5r1njRHn0OJDkaW0bcMqH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="270328670"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="270328670"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 04:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="626531603"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2022 04:31:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEqsf-0001P6-2Q;
        Fri, 22 Jul 2022 11:31:41 +0000
Date:   Fri, 22 Jul 2022 19:31:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: [bpf-next:master 3/14] net/bpf/test_run.c:699:40: error: macro
 "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
Message-ID: <202207221911.qGsLSox7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
head:   ac7ac432a67eb5410be32a3bef0fb393058af537
commit: a4703e3184320d6e15e2bc81d2ccf1c8c883f9d1 [3/14] bpf: Switch to new kfunc flags infrastructure
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220722/202207221911.qGsLSox7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=a4703e3184320d6e15e2bc81d2ccf1c8c883f9d1
        git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
        git fetch --no-tags bpf-next master
        git checkout a4703e3184320d6e15e2bc81d2ccf1c8c883f9d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/bpf/test_run.c:699:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     699 | BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
         |                                        ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:700:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     700 | BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
         |                                        ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/bpf/test_run.c:699:1: error: unknown type name 'BTF_ID_FLAGS'
     699 | BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
         | ^~~~~~~~~~~~
   net/bpf/test_run.c:701:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     701 | BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
         |                                        ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/bpf/test_run.c:701:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BTF_ID_FLAGS'
     701 | BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
         | ^~~~~~~~~~~~
   net/bpf/test_run.c:708:48: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     708 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
         |                                                ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:701:1: error: unknown type name 'BTF_ID_FLAGS'
     701 | BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
         | ^~~~~~~~~~~~
   net/bpf/test_run.c:709:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     709 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
         |                                             ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:710:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     710 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
         |                                             ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:711:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     711 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
         |                                             ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:712:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     712 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
         |                                             ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:713:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     713 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
         |                                             ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:714:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     714 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
         |                                                     ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:715:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     715 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
         |                                                     ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/bpf/test_run.c:716:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     716 | BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
         |                                                     ^
   In file included from net/bpf/test_run.c:6:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
--
>> net/ipv4/tcp_cubic.c:491:33: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     491 | BTF_ID_FLAGS(func, cubictcp_init)
         |                                 ^
   In file included from net/ipv4/tcp_cubic.c:29:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_cubic.c:492:44: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     492 | BTF_ID_FLAGS(func, cubictcp_recalc_ssthresh)
         |                                            ^
   In file included from net/ipv4/tcp_cubic.c:29:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/tcp_cubic.c:491:1: error: unknown type name 'BTF_ID_FLAGS'
     491 | BTF_ID_FLAGS(func, cubictcp_init)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_cubic.c:493:39: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     493 | BTF_ID_FLAGS(func, cubictcp_cong_avoid)
         |                                       ^
   In file included from net/ipv4/tcp_cubic.c:29:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/tcp_cubic.c:493:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BTF_ID_FLAGS'
     493 | BTF_ID_FLAGS(func, cubictcp_cong_avoid)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_cubic.c:494:34: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     494 | BTF_ID_FLAGS(func, cubictcp_state)
         |                                  ^
   In file included from net/ipv4/tcp_cubic.c:29:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_cubic.c:493:1: error: unknown type name 'BTF_ID_FLAGS'
     493 | BTF_ID_FLAGS(func, cubictcp_cong_avoid)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_cubic.c:495:39: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     495 | BTF_ID_FLAGS(func, cubictcp_cwnd_event)
         |                                       ^
   In file included from net/ipv4/tcp_cubic.c:29:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_cubic.c:496:34: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     496 | BTF_ID_FLAGS(func, cubictcp_acked)
         |                                  ^
   In file included from net/ipv4/tcp_cubic.c:29:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
--
>> net/ipv4/bpf_tcp_ca.c:201:37: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     201 | BTF_ID_FLAGS(func, tcp_reno_ssthresh)
         |                                     ^
   In file included from net/ipv4/bpf_tcp_ca.c:9:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/bpf_tcp_ca.c:202:39: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     202 | BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
         |                                       ^
   In file included from net/ipv4/bpf_tcp_ca.c:9:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/bpf_tcp_ca.c:201:1: error: unknown type name 'BTF_ID_FLAGS'
     201 | BTF_ID_FLAGS(func, tcp_reno_ssthresh)
         | ^~~~~~~~~~~~
   net/ipv4/bpf_tcp_ca.c:203:38: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     203 | BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
         |                                      ^
   In file included from net/ipv4/bpf_tcp_ca.c:9:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/bpf_tcp_ca.c:203:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BTF_ID_FLAGS'
     203 | BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
         | ^~~~~~~~~~~~
   net/ipv4/bpf_tcp_ca.c:204:34: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     204 | BTF_ID_FLAGS(func, tcp_slow_start)
         |                                  ^
   In file included from net/ipv4/bpf_tcp_ca.c:9:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/bpf_tcp_ca.c:203:1: error: unknown type name 'BTF_ID_FLAGS'
     203 | BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
         | ^~~~~~~~~~~~
   net/ipv4/bpf_tcp_ca.c:205:37: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     205 | BTF_ID_FLAGS(func, tcp_cong_avoid_ai)
         |                                     ^
   In file included from net/ipv4/bpf_tcp_ca.c:9:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
--
>> net/ipv4/tcp_bbr.c:1160:28: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1160 | BTF_ID_FLAGS(func, bbr_init)
         |                            ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_bbr.c:1161:28: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1161 | BTF_ID_FLAGS(func, bbr_main)
         |                            ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/tcp_bbr.c:1160:1: error: unknown type name 'BTF_ID_FLAGS'
    1160 | BTF_ID_FLAGS(func, bbr_init)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_bbr.c:1162:37: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1162 | BTF_ID_FLAGS(func, bbr_sndbuf_expand)
         |                                     ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/tcp_bbr.c:1162:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BTF_ID_FLAGS'
    1162 | BTF_ID_FLAGS(func, bbr_sndbuf_expand)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_bbr.c:1163:33: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1163 | BTF_ID_FLAGS(func, bbr_undo_cwnd)
         |                                 ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_bbr.c:1162:1: error: unknown type name 'BTF_ID_FLAGS'
    1162 | BTF_ID_FLAGS(func, bbr_sndbuf_expand)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_bbr.c:1164:34: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1164 | BTF_ID_FLAGS(func, bbr_cwnd_event)
         |                                  ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_bbr.c:1165:32: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1165 | BTF_ID_FLAGS(func, bbr_ssthresh)
         |                                ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_bbr.c:1166:36: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1166 | BTF_ID_FLAGS(func, bbr_min_tso_segs)
         |                                    ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_bbr.c:1167:33: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
    1167 | BTF_ID_FLAGS(func, bbr_set_state)
         |                                 ^
   In file included from net/ipv4/tcp_bbr.c:60:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
--
>> net/ipv4/tcp_dctcp.c:245:30: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     245 | BTF_ID_FLAGS(func, dctcp_init)
         |                              ^
   In file included from net/ipv4/tcp_dctcp.c:40:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_dctcp.c:246:38: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     246 | BTF_ID_FLAGS(func, dctcp_update_alpha)
         |                                      ^
   In file included from net/ipv4/tcp_dctcp.c:40:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/tcp_dctcp.c:245:1: error: unknown type name 'BTF_ID_FLAGS'
     245 | BTF_ID_FLAGS(func, dctcp_init)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_dctcp.c:247:36: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     247 | BTF_ID_FLAGS(func, dctcp_cwnd_event)
         |                                    ^
   In file included from net/ipv4/tcp_dctcp.c:40:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
>> net/ipv4/tcp_dctcp.c:247:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BTF_ID_FLAGS'
     247 | BTF_ID_FLAGS(func, dctcp_cwnd_event)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_dctcp.c:248:34: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     248 | BTF_ID_FLAGS(func, dctcp_ssthresh)
         |                                  ^
   In file included from net/ipv4/tcp_dctcp.c:40:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_dctcp.c:247:1: error: unknown type name 'BTF_ID_FLAGS'
     247 | BTF_ID_FLAGS(func, dctcp_cwnd_event)
         | ^~~~~~~~~~~~
   net/ipv4/tcp_dctcp.c:249:35: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     249 | BTF_ID_FLAGS(func, dctcp_cwnd_undo)
         |                                   ^
   In file included from net/ipv4/tcp_dctcp.c:40:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 
   net/ipv4/tcp_dctcp.c:250:31: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
     250 | BTF_ID_FLAGS(func, dctcp_state)
         |                               ^
   In file included from net/ipv4/tcp_dctcp.c:40:
   include/linux/btf_ids.h:209: note: macro "BTF_ID_FLAGS" defined here
     209 | #define BTF_ID_FLAGS(prefix, name, flags)
         | 


vim +/BTF_ID_FLAGS +699 net/bpf/test_run.c

   697	
   698	BTF_SET8_START(test_sk_check_kfunc_ids)
 > 699	BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
   700	BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 > 701	BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
   702	BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
   703	BTF_ID_FLAGS(func, bpf_kfunc_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL)
   704	BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
   705	BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
   706	BTF_ID_FLAGS(func, bpf_kfunc_call_memb1_release, KF_RELEASE)
   707	BTF_ID_FLAGS(func, bpf_kfunc_call_test_kptr_get, KF_ACQUIRE | KF_RET_NULL | KF_KPTR_GET)
   708	BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
   709	BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
   710	BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
   711	BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
   712	BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
   713	BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
   714	BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
   715	BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
   716	BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
   717	BTF_SET8_END(test_sk_check_kfunc_ids)
   718	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
