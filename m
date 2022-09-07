Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273A5B05A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIGNs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:48:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439AB48C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662558499; x=1694094499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G6HlQVdMdBhCXUF/CrQKealiVh2uZtP+3MVwZrFwfdU=;
  b=gWXjzXBDv1FQjMob6EuNhltTW2er6LtiA969BRDqBKsTCvIV1E/bQo7X
   38AtFaUKbRlLFRZLFPZ5ziNfEieZj38T/NWHeC3kp2/crS6smx71SIcIp
   JW0WWTt7mwqHSmaxDK3ao9s7O3B/0aR/xqOJmWImbi3QJEhGCLPhwJ/Zi
   dwfMnpaYsFmWI9QcG6OncxxZN1ZiZ6G1WqkcFdw49mwDetKhzCEFJ+Vi2
   VUh4ThyHaFC6S3e5+xMeSp+FgwALKK9KvgB3z/9EdinfN8Q8nAnzc3k8S
   nLEUdhGO0LvJZOPFtyMGEf7OHg8yUf7cSKmFyng8KQolDKuRKykaWGlQR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296873371"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="296873371"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 06:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="647636746"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2022 06:48:17 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVvPc-0006cZ-2k;
        Wed, 07 Sep 2022 13:48:16 +0000
Date:   Wed, 7 Sep 2022 21:47:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: net/bpf/test_run.c:249:1: warning: no previous declaration for
 'bpf_kfunc_call_test_acquire'
Message-ID: <202209072132.nwoItdQm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0066f1b0e27556381402db3ff31f85d2a2265858
commit: c1ff181ffabc292abcd1832a1c83aac2bc499e71 selftests/bpf: Extend kfunc selftests
date:   8 months ago
config: x86_64-randconfig-a003-20220829 (https://download.01.org/0day-ci/archive/20220907/202209072132.nwoItdQm-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1ff181ffabc292abcd1832a1c83aac2bc499e71
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c1ff181ffabc292abcd1832a1c83aac2bc499e71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/bpf/test_run.c:171:14: warning: no previous declaration for 'bpf_fentry_test1' [-Wmissing-declarations]
    int noinline bpf_fentry_test1(int a)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:176:14: warning: no previous declaration for 'bpf_fentry_test2' [-Wmissing-declarations]
    int noinline bpf_fentry_test2(int a, u64 b)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:181:14: warning: no previous declaration for 'bpf_fentry_test3' [-Wmissing-declarations]
    int noinline bpf_fentry_test3(char a, int b, u64 c)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:186:14: warning: no previous declaration for 'bpf_fentry_test4' [-Wmissing-declarations]
    int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:191:14: warning: no previous declaration for 'bpf_fentry_test5' [-Wmissing-declarations]
    int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:196:14: warning: no previous declaration for 'bpf_fentry_test6' [-Wmissing-declarations]
    int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:205:14: warning: no previous declaration for 'bpf_fentry_test7' [-Wmissing-declarations]
    int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:210:14: warning: no previous declaration for 'bpf_fentry_test8' [-Wmissing-declarations]
    int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:215:14: warning: no previous declaration for 'bpf_modify_return_test' [-Wmissing-declarations]
    int noinline bpf_modify_return_test(int a, int *b)
                 ^~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:221:14: warning: no previous declaration for 'bpf_kfunc_call_test1' [-Wmissing-declarations]
    u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
                 ^~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:226:14: warning: no previous declaration for 'bpf_kfunc_call_test2' [-Wmissing-declarations]
    int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
                 ^~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:231:24: warning: no previous declaration for 'bpf_kfunc_call_test3' [-Wmissing-declarations]
    struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
                           ^~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:249:1: warning: no previous declaration for 'bpf_kfunc_call_test_acquire' [-Wmissing-declarations]
    bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:257:15: warning: no previous declaration for 'bpf_kfunc_call_test_release' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:299:15: warning: no previous declaration for 'bpf_kfunc_call_test_pass_ctx' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:303:15: warning: no previous declaration for 'bpf_kfunc_call_test_pass1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:307:15: warning: no previous declaration for 'bpf_kfunc_call_test_pass2' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:311:15: warning: no previous declaration for 'bpf_kfunc_call_test_fail1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:315:15: warning: no previous declaration for 'bpf_kfunc_call_test_fail2' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:319:15: warning: no previous declaration for 'bpf_kfunc_call_test_fail3' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:323:15: warning: no previous declaration for 'bpf_kfunc_call_test_mem_len_pass1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:327:15: warning: no previous declaration for 'bpf_kfunc_call_test_mem_len_fail1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:331:15: warning: no previous declaration for 'bpf_kfunc_call_test_mem_len_fail2' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_kfunc_call_test_acquire +249 net/bpf/test_run.c

   247	
   248	noinline struct prog_test_ref_kfunc *
 > 249	bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
   250	{
   251		/* randomly return NULL */
   252		if (get_jiffies_64() % 2)
   253			return NULL;
   254		return &prog_test_struct;
   255	}
   256	
 > 257	noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
   258	{
   259	}
   260	
   261	struct prog_test_pass1 {
   262		int x0;
   263		struct {
   264			int x1;
   265			struct {
   266				int x2;
   267				struct {
   268					int x3;
   269				};
   270			};
   271		};
   272	};
   273	
   274	struct prog_test_pass2 {
   275		int len;
   276		short arr1[4];
   277		struct {
   278			char arr2[4];
   279			unsigned long arr3[8];
   280		} x;
   281	};
   282	
   283	struct prog_test_fail1 {
   284		void *p;
   285		int x;
   286	};
   287	
   288	struct prog_test_fail2 {
   289		int x8;
   290		struct prog_test_pass1 x;
   291	};
   292	
   293	struct prog_test_fail3 {
   294		int len;
   295		char arr1[2];
   296		char arr2[0];
   297	};
   298	
 > 299	noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
   300	{
   301	}
   302	
 > 303	noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
   304	{
   305	}
   306	
 > 307	noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
   308	{
   309	}
   310	
 > 311	noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
   312	{
   313	}
   314	
 > 315	noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
   316	{
   317	}
   318	
 > 319	noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
   320	{
   321	}
   322	
 > 323	noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
   324	{
   325	}
   326	
 > 327	noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
   328	{
   329	}
   330	
 > 331	noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
   332	{
   333	}
   334	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
