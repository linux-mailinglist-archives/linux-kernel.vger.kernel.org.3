Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C942567C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiGFDHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGFDHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:07:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B461AF15
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076832; x=1688612832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V1OYQd01MbSEp9wHG1vov7SEBMz7Hedc8PvBrDU4mKI=;
  b=G4qI5aIDp02jUtrT2ofinypxK2WMASuzFSYm9sUMtCTVyDNiVjouHPvO
   3lwXLIjH4B2dZQoVl9TiZJOhuuOZ/6YM5wh29VHuPcksKDwoHmNQZpCGV
   M8jNSo8SLpVlOvIY29lJgRFbdVPxGVq5jV0U03kkHEzWGa/xejVD1hVrT
   /yHIGM2xxXi7Ouwy3MP95JLyHaRaUQM4BKvPN+ENt2o59185+gdOZ89og
   IpsP/15mUQUbfi/IbMF7/8uqelLrIA1aPJdTaCPxpw1WpbvJwHc7Ow/n5
   5MNaYvIXUzY4dsTuC/jOxtPgIc3jMhGL4UZSURb0doceU0rr0xb6pg/ce
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="369946236"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="369946236"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="682742803"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2022 20:07:10 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8vNe-000Ju3-7U;
        Wed, 06 Jul 2022 03:07:10 +0000
Date:   Wed, 6 Jul 2022 11:06:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 21/21] kernel/bpf/trampoline.c:941:11:
 warning: variable 'id_multi' is uninitialized when used here
Message-ID: <202207061003.NznoJ2YS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_22
head:   1d891c46bb689a24985cea58f4eddb053d6b1331
commit: 1d891c46bb689a24985cea58f4eddb053d6b1331 [21/21] bpf: Add support to attach multi trampolines
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220706/202207061003.NznoJ2YS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 142aca7741d5b06207e87bf4880fbe308c8d6823)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1d891c46bb689a24985cea58f4eddb053d6b1331
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout 1d891c46bb689a24985cea58f4eddb053d6b1331
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:941:11: warning: variable 'id_multi' is uninitialized when used here [-Wuninitialized]
                           id_add(id_multi, id->id[i]);
                                  ^~~~~~~~
   kernel/bpf/trampoline.c:924:31: note: initialize the variable 'id_multi' to silence this warning
           struct bpf_tramp_id *id_multi, *id_singles;
                                        ^
                                         = NULL
>> kernel/bpf/trampoline.c:950:10: warning: variable 'id_singles' is uninitialized when used here [-Wuninitialized]
                   id_add(id_singles, id->id[i]);
                          ^~~~~~~~~~
   kernel/bpf/trampoline.c:924:44: note: initialize the variable 'id_singles' to silence this warning
           struct bpf_tramp_id *id_multi, *id_singles;
                                                     ^
                                                      = NULL
   2 warnings generated.


vim +/id_multi +941 kernel/bpf/trampoline.c

   921	
   922	int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp, struct bpf_tramp_id *id)
   923	{
   924		struct bpf_tramp_id *id_multi, *id_singles;
   925		struct bpf_trampoline *tr;
   926		LIST_HEAD(upd);
   927		int i, err = -EINVAL;
   928		u64 key;
   929	
   930		mutex_lock(&trampoline_mutex);
   931		list_for_each_entry(tr, &multi_trampolines, multi.list) {
   932			if (id_and(id, tr->multi.id_multi))
   933				goto out_unlock;
   934		}
   935	
   936		for (i = 0; i < id->cnt; i++) {
   937			key = bpf_trampoline_compute_key(tp->prog, tp->prog->aux->attach_btf,
   938							 id->id[i]);
   939			tr = __bpf_trampoline_lookup(key);
   940			if (!tr) {
 > 941				id_add(id_multi, id->id[i]);
   942				continue;
   943			}
   944			mutex_lock(&tr->mutex);
   945			err = __bpf_trampoline_link_prog(tp, tr, &upd);
   946			if (err) {
   947				mutex_unlock(&tr->mutex);
   948				goto out_rollback;
   949			}
 > 950			id_add(id_singles, id->id[i]);
   951		}
   952	
   953		tr = bpf_trampoline_alloc();
   954		if (!tr)
   955			goto out_rollback;
   956	
   957		err = __bpf_trampoline_link_prog(tp, tr, &upd);
   958		if (err)
   959			goto out_rollback;
   960	
   961		err = bpf_tramp_update_set(&upd);
   962		if (err)
   963			goto out_rollback;
   964	
   965		tr->multi.id_multi = id_multi;
   966		tr->multi.id_singles = id_singles;
   967		list_add_tail(&tr->multi.list, &multi_trampolines);
   968	
   969		list_for_each_entry(tr, &upd, update.list) {
   970			bpf_trampoline_commit(tr);
   971			mutex_unlock(&tr->mutex);
   972		}
   973	
   974	out_unlock:
   975		mutex_unlock(&trampoline_mutex);
   976		return 0;
   977	out_rollback:
   978		list_for_each_entry(tr, &upd, update.list) {
   979			bpf_trampoline_rollback(tr);
   980			mutex_unlock(&tr->mutex);
   981			bpf_trampoline_put(tr);
   982		}
   983		mutex_unlock(&trampoline_mutex);
   984		return err;
   985	}
   986	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
