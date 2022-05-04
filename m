Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C23519FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349996AbiEDMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349759AbiEDMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:52:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C635240
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651668540; x=1683204540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zbPWkrkZR01gJjb6qqiV16gda+b6yWtyTRLOiX97Dks=;
  b=DXDgpOsZGKxmXUpPzK7Rfq6H7Je5AQ5EsZP+1B9kIfAw//RWh2Vdgl75
   y0EXGKbML6PqVKD25FVTn52rT6DV+JjxFOfSZPUEFPqpK/GwGMOlQZtzw
   J87+nxnT1fvo6eKvVWIocXDi7O+4FiImyyqrJtnQOMyoq9cn0Gt680Bxn
   Ue+Hz8fXOtto5cZ3KkZOxQzUjSjZYLr11QN4nsAkWOBsjnOEk/tzl5NgA
   EKufe/iTbtLcggTy17+1TgQ9zY9eLyk1cr+7TUrTkmtnRsrGFZEI4JzMR
   5BbPo/Jm5kOL/3Pz0Oht9bWwPw6twgrvsGuVo3Lf/l2n8dANj9HEA8nJj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266599306"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="266599306"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="693941257"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2022 05:48:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmER8-000BOp-7k;
        Wed, 04 May 2022 12:48:58 +0000
Date:   Wed, 4 May 2022 20:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chanwoo:devfreq-testing 5/5] include/linux/list.h:638:9: warning:
 this 'for' clause does not guard...
Message-ID: <202205042019.gOXJsH4f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   40eaf97ddb3a7e661942296ccf192af0edd3d77d
commit: 40eaf97ddb3a7e661942296ccf192af0edd3d77d [5/5] PM / devfreq: Use cpufreq_policy instead of NR_CPU
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220504/202205042019.gOXJsH4f-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=40eaf97ddb3a7e661942296ccf192af0edd3d77d
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout 40eaf97ddb3a7e661942296ccf192af0edd3d77d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/devfreq/governor_passive.c: In function 'get_parent_cpu_data':
   drivers/devfreq/governor_passive.c:31:17: error: expected expression before 'int'
      31 |                 int first_cpu = parent_cpu_data->first_cpu;
         |                 ^~~
   In file included from include/linux/module.h:12,
                    from drivers/devfreq/governor_passive.c:10:
>> include/linux/list.h:638:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     638 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |         ^~~
   drivers/devfreq/governor_passive.c:30:9: note: in expansion of macro 'list_for_each_entry'
      30 |         list_for_each_entry(parent_cpu_data, &p_data->cpu_data_list, node)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/devfreq/governor_passive.c:32:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
      32 |                 if (first_cpu == cpumask_first(policy->related_cpus);)
         |                 ^~
   drivers/devfreq/governor_passive.c:32:21: error: 'first_cpu' undeclared (first use in this function)
      32 |                 if (first_cpu == cpumask_first(policy->related_cpus);)
         |                     ^~~~~~~~~
   drivers/devfreq/governor_passive.c:32:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers/devfreq/governor_passive.c:32:69: error: expected ')' before ';' token
      32 |                 if (first_cpu == cpumask_first(policy->related_cpus);)
         |                    ~                                                ^
         |                                                                     )
   In file included from include/linux/module.h:12,
                    from drivers/devfreq/governor_passive.c:10:
   drivers/devfreq/governor_passive.c: In function 'cpufreq_passive_register_notifier':
   include/linux/list.h:23:30: error: expected expression before '{' token
      23 | #define LIST_HEAD_INIT(name) { &(name), &(name) }
         |                              ^
   drivers/devfreq/governor_passive.c:256:33: note: in expansion of macro 'LIST_HEAD_INIT'
     256 |         p_data->cpu_data_list = LIST_HEAD_INIT(p_data->cpu_data_list);
         |                                 ^~~~~~~~~~~~~~


vim +/for +638 include/linux/list.h

6d7581e62f8be4 Jiri Pirko      2013-05-29  557  
008208c6b26f21 Oleg Nesterov   2013-11-12  558  /**
008208c6b26f21 Oleg Nesterov   2013-11-12  559   * list_next_entry - get the next element in list
008208c6b26f21 Oleg Nesterov   2013-11-12  560   * @pos:	the type * to cursor
3943f42c11896c Andrey Utkin    2014-11-14  561   * @member:	the name of the list_head within the struct.
008208c6b26f21 Oleg Nesterov   2013-11-12  562   */
008208c6b26f21 Oleg Nesterov   2013-11-12  563  #define list_next_entry(pos, member) \
008208c6b26f21 Oleg Nesterov   2013-11-12  564  	list_entry((pos)->member.next, typeof(*(pos)), member)
008208c6b26f21 Oleg Nesterov   2013-11-12  565  
008208c6b26f21 Oleg Nesterov   2013-11-12  566  /**
008208c6b26f21 Oleg Nesterov   2013-11-12  567   * list_prev_entry - get the prev element in list
008208c6b26f21 Oleg Nesterov   2013-11-12  568   * @pos:	the type * to cursor
3943f42c11896c Andrey Utkin    2014-11-14  569   * @member:	the name of the list_head within the struct.
008208c6b26f21 Oleg Nesterov   2013-11-12  570   */
008208c6b26f21 Oleg Nesterov   2013-11-12  571  #define list_prev_entry(pos, member) \
008208c6b26f21 Oleg Nesterov   2013-11-12  572  	list_entry((pos)->member.prev, typeof(*(pos)), member)
008208c6b26f21 Oleg Nesterov   2013-11-12  573  
^1da177e4c3f41 Linus Torvalds  2005-04-16  574  /**
^1da177e4c3f41 Linus Torvalds  2005-04-16  575   * list_for_each	-	iterate over a list
8e3a67a99231f9 Randy Dunlap    2006-06-25  576   * @pos:	the &struct list_head to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds  2005-04-16  577   * @head:	the head for your list.
^1da177e4c3f41 Linus Torvalds  2005-04-16  578   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  579  #define list_for_each(pos, head) \
0425473037db40 Andy Shevchenko 2022-01-19  580  	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
^1da177e4c3f41 Linus Torvalds  2005-04-16  581  
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  582  /**
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  583   * list_for_each_continue - continue iteration over a list
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  584   * @pos:	the &struct list_head to use as a loop cursor.
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  585   * @head:	the head for your list.
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  586   *
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  587   * Continue to iterate over a list, continuing after the current position.
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  588   */
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  589  #define list_for_each_continue(pos, head) \
0425473037db40 Andy Shevchenko 2022-01-19  590  	for (pos = pos->next; !list_is_head(pos, (head)); pos = pos->next)
28ca0d6d39ab1d Pavel Begunkov  2019-11-29  591  
^1da177e4c3f41 Linus Torvalds  2005-04-16  592  /**
^1da177e4c3f41 Linus Torvalds  2005-04-16  593   * list_for_each_prev	-	iterate over a list backwards
8e3a67a99231f9 Randy Dunlap    2006-06-25  594   * @pos:	the &struct list_head to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds  2005-04-16  595   * @head:	the head for your list.
^1da177e4c3f41 Linus Torvalds  2005-04-16  596   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  597  #define list_for_each_prev(pos, head) \
0425473037db40 Andy Shevchenko 2022-01-19  598  	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
^1da177e4c3f41 Linus Torvalds  2005-04-16  599  
^1da177e4c3f41 Linus Torvalds  2005-04-16  600  /**
^1da177e4c3f41 Linus Torvalds  2005-04-16  601   * list_for_each_safe - iterate over a list safe against removal of list entry
8e3a67a99231f9 Randy Dunlap    2006-06-25  602   * @pos:	the &struct list_head to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds  2005-04-16  603   * @n:		another &struct list_head to use as temporary storage
^1da177e4c3f41 Linus Torvalds  2005-04-16  604   * @head:	the head for your list.
^1da177e4c3f41 Linus Torvalds  2005-04-16  605   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  606  #define list_for_each_safe(pos, n, head) \
0425473037db40 Andy Shevchenko 2022-01-19  607  	for (pos = (head)->next, n = pos->next; \
0425473037db40 Andy Shevchenko 2022-01-19  608  	     !list_is_head(pos, (head)); \
^1da177e4c3f41 Linus Torvalds  2005-04-16  609  	     pos = n, n = pos->next)
^1da177e4c3f41 Linus Torvalds  2005-04-16  610  
37c42524d60906 Denis V. Lunev  2007-10-16  611  /**
8f731f7d83d6c6 Randy Dunlap    2007-10-18  612   * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
37c42524d60906 Denis V. Lunev  2007-10-16  613   * @pos:	the &struct list_head to use as a loop cursor.
37c42524d60906 Denis V. Lunev  2007-10-16  614   * @n:		another &struct list_head to use as temporary storage
37c42524d60906 Denis V. Lunev  2007-10-16  615   * @head:	the head for your list.
37c42524d60906 Denis V. Lunev  2007-10-16  616   */
37c42524d60906 Denis V. Lunev  2007-10-16  617  #define list_for_each_prev_safe(pos, n, head) \
37c42524d60906 Denis V. Lunev  2007-10-16  618  	for (pos = (head)->prev, n = pos->prev; \
0425473037db40 Andy Shevchenko 2022-01-19  619  	     !list_is_head(pos, (head)); \
37c42524d60906 Denis V. Lunev  2007-10-16  620  	     pos = n, n = pos->prev)
37c42524d60906 Denis V. Lunev  2007-10-16  621  
e130816164e244 Andy Shevchenko 2020-10-15  622  /**
e130816164e244 Andy Shevchenko 2020-10-15  623   * list_entry_is_head - test if the entry points to the head of the list
e130816164e244 Andy Shevchenko 2020-10-15  624   * @pos:	the type * to cursor
e130816164e244 Andy Shevchenko 2020-10-15  625   * @head:	the head for your list.
e130816164e244 Andy Shevchenko 2020-10-15  626   * @member:	the name of the list_head within the struct.
e130816164e244 Andy Shevchenko 2020-10-15  627   */
e130816164e244 Andy Shevchenko 2020-10-15  628  #define list_entry_is_head(pos, head, member)				\
e130816164e244 Andy Shevchenko 2020-10-15  629  	(&pos->member == (head))
e130816164e244 Andy Shevchenko 2020-10-15  630  
^1da177e4c3f41 Linus Torvalds  2005-04-16  631  /**
^1da177e4c3f41 Linus Torvalds  2005-04-16  632   * list_for_each_entry	-	iterate over list of given type
8e3a67a99231f9 Randy Dunlap    2006-06-25  633   * @pos:	the type * to use as a loop cursor.
^1da177e4c3f41 Linus Torvalds  2005-04-16  634   * @head:	the head for your list.
3943f42c11896c Andrey Utkin    2014-11-14  635   * @member:	the name of the list_head within the struct.
^1da177e4c3f41 Linus Torvalds  2005-04-16  636   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  637  #define list_for_each_entry(pos, head, member)				\
93be3c2eb3371f Oleg Nesterov   2013-11-12 @638  	for (pos = list_first_entry(head, typeof(*pos), member);	\
e130816164e244 Andy Shevchenko 2020-10-15  639  	     !list_entry_is_head(pos, head, member);			\
8120e2e5141a42 Oleg Nesterov   2013-11-12  640  	     pos = list_next_entry(pos, member))
^1da177e4c3f41 Linus Torvalds  2005-04-16  641  

:::::: The code at line 638 was first introduced by commit
:::::: 93be3c2eb3371f022ad88acf1ab6bee8e3c38378 list: introduce list_last_entry(), use list_{first,last}_entry()

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
