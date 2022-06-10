Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048F4545DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347013AbiFJHwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244463AbiFJHwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:52:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D56D1C284F;
        Fri, 10 Jun 2022 00:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654847534; x=1686383534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vi/Cl0PyJOCXlWY+DAGC0EAW94aIzRv2dNjS6RisAUg=;
  b=h3LCxusJBB3qrT8698ODwct78Fxd67dNb+Eem3PEg3vXpxhqFly6szAd
   xNqbbuDCPticV4f5l4q3F7eSWbvPbJMc/yuksrNRaB+ISDl8rWT1K8GPD
   kfzi32TnqssY/G48BnFknXCtXFgr19YG/CZBbqLwIUQ+qw0iQ0kUVNiLq
   5aJio8YqsKdXnWSkMISD/O/las1Ip5m/aqGjiBHuVH+GS91t2JKsMxSGU
   ej3wM8qJQVX7G+sW+4c/N5Ntr8uDuPV/OHJzMWdtySd1WeswlBfFNeK06
   PxW58b9YkOUK891VYZG+dRaIlRMKb4i2JQre8CaPmXXIj+gybR5IjuOV4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363881095"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363881095"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 00:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="616379856"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2022 00:52:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzZR6-000GoA-Vi;
        Fri, 10 Jun 2022 07:52:04 +0000
Date:   Fri, 10 Jun 2022 15:51:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v36 04/33] LSM: provide lsm name and id slot mappings
Message-ID: <202206101543.IWAKe4Qx-lkp@intel.com>
References: <20220609230146.319210-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609230146.319210-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on pcmoore-selinux/next linus/master v5.19-rc1 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220610-080129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: sparc-randconfig-r014-20220609 (https://download.01.org/0day-ci/archive/20220610/202206101543.IWAKe4Qx-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/767517968014af3744e00ba2c0c956b290a56ecb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220610-080129
        git checkout 767517968014af3744e00ba2c0c956b290a56ecb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   security/security.c: In function 'lsm_name_to_slot':
>> security/security.c:496:40: warning: array subscript i is outside array bounds of 'struct lsm_id *[0]' [-Warray-bounds]
     496 |                 if (strcmp(lsm_slotlist[i]->lsm, name) == 0)
         |                            ~~~~~~~~~~~~^~~
   security/security.c:481:23: note: while referencing 'lsm_slotlist'
     481 | static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
         |                       ^~~~~~~~~~~~
   security/security.c: In function 'lsm_slot_to_name':
>> security/security.c:521:25: warning: array subscript 0 is outside array bounds of 'struct lsm_id *[0]' [-Warray-bounds]
     521 |         if (lsm_slotlist[slot] == NULL)
         |             ~~~~~~~~~~~~^~~~~~
   security/security.c:481:23: note: while referencing 'lsm_slotlist'
     481 | static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
         |                       ^~~~~~~~~~~~
   security/security.c: In function 'security_add_hooks':
>> security/security.c:546:29: warning: array subscript <unknown> is outside array bounds of 'struct lsm_id *[0]' [-Warray-bounds]
     546 |                 lsm_slotlist[lsm_slot] = lsmid;
         |                 ~~~~~~~~~~~~^~~~~~~~~~
   security/security.c:481:23: note: while referencing 'lsm_slotlist'
     481 | static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
         |                       ^~~~~~~~~~~~


vim +496 security/security.c

   482	
   483	/**
   484	 * lsm_name_to_slot - Report the slot number for a security module
   485	 * @name: name of the security module
   486	 *
   487	 * Look up the slot number for the named security module.
   488	 * Returns the slot number or LSMBLOB_INVALID if @name is not
   489	 * a registered security module name.
   490	 */
   491	int lsm_name_to_slot(char *name)
   492	{
   493		int i;
   494	
   495		for (i = 0; i < lsm_slot; i++)
 > 496			if (strcmp(lsm_slotlist[i]->lsm, name) == 0)
   497				return i;
   498	
   499		return LSMBLOB_INVALID;
   500	}
   501	
   502	/**
   503	 * lsm_slot_to_name - Get the name of the security module in a slot
   504	 * @slot: index into the interface LSM slot list.
   505	 *
   506	 * Provide the name of the security module associated with
   507	 * a interface LSM slot.
   508	 *
   509	 * If @slot is LSMBLOB_INVALID return the value
   510	 * for slot 0 if it has been set, otherwise NULL.
   511	 *
   512	 * Returns a pointer to the name string or NULL.
   513	 */
   514	const char *lsm_slot_to_name(int slot)
   515	{
   516		if (slot == LSMBLOB_INVALID)
   517			slot = 0;
   518		else if (slot >= LSMBLOB_ENTRIES || slot < 0)
   519			return NULL;
   520	
 > 521		if (lsm_slotlist[slot] == NULL)
   522			return NULL;
   523		return lsm_slotlist[slot]->lsm;
   524	}
   525	
   526	/**
   527	 * security_add_hooks - Add a modules hooks to the hook lists.
   528	 * @hooks: the hooks to add
   529	 * @count: the number of hooks to add
   530	 * @lsmid: the identification information for the security module
   531	 *
   532	 * Each LSM has to register its hooks with the infrastructure.
   533	 * If the LSM is using hooks that export secids allocate a slot
   534	 * for it in the lsmblob.
   535	 */
   536	void __init security_add_hooks(struct security_hook_list *hooks, int count,
   537				       struct lsm_id *lsmid)
   538	{
   539		int i;
   540	
   541		WARN_ON(!lsmid->slot || !lsmid->lsm);
   542	
   543		if (lsmid->slot == LSMBLOB_NEEDED) {
   544			if (lsm_slot >= LSMBLOB_ENTRIES)
   545				panic("%s Too many LSMs registered.\n", __func__);
 > 546			lsm_slotlist[lsm_slot] = lsmid;
   547			lsmid->slot = lsm_slot++;
   548			init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
   549				   lsmid->slot);
   550		}
   551	
   552		for (i = 0; i < count; i++) {
   553			hooks[i].lsmid = lsmid;
   554			hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
   555		}
   556	
   557		/*
   558		 * Don't try to append during early_security_init(), we'll come back
   559		 * and fix this up afterwards.
   560		 */
   561		if (slab_is_available()) {
   562			if (lsm_append(lsmid->lsm, &lsm_names) < 0)
   563				panic("%s - Cannot get early memory.\n", __func__);
   564		}
   565	}
   566	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
