Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9332B51E32A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357287AbiEGBlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445257AbiEGBlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:41:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4346712DF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 18:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651887440; x=1683423440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S0Bz8rP4s41uJJFTlsYVLSGlvcZ5POkxwtRvtC3Kw7o=;
  b=kJIsBwnSZmgRzuftvRIFzraPZPNNi/jrKeqJ1aFaJZVNAZIUbCgSvFlf
   UPOm6AqDShFMdo2em0ZtOQYn6Q9krmQpoA7qhz8Zz3Ekdi3MUvGxC7cX7
   cfC25vyEeDf4opqUQsCphdxpaaOUuYOSgLhXh33bWP0x8AUUe9aD2NNAW
   GIjWXtNhgAhrexokPMBCjQKkXpx0jVjDsPvNG8q+ScBRxwnzBkysiL2zp
   10JdukMComPSId6gO9LBLXlErfWQZy/tJ+Kkyplel2Q9dEAILEqX9jNO+
   78mA92UcE02wQsps+qHxqjxqr/IN2/HT1ZZqJE5e07Leqiqpjvz3YpkFN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="249161435"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="249161435"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 18:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="550108812"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2022 18:37:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn9Nm-000E5s-9k;
        Sat, 07 May 2022 01:37:18 +0000
Date:   Sat, 7 May 2022 09:36:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>
Subject: [krzk-github:n/qcom-ufs-opp-cleanups-v2-drv-owner-wip 5/7]
 drivers/scsi/scsi_proc.c:145:6: warning: syntax error: keyword 'while' is
 not allowed in global scope [syntaxError]
Message-ID: <202205070933.wIiOiR2Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
head:   17609caecd53df20f631703ea084a70e7735b5d7
commit: 157eb2ee8867afbae9dac3836e4c0bedb542e5c1 [5/7] scsi: proc: do not store proc_dir in scsi_host_template
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 157eb2ee8867afbae9dac3836e4c0bedb542e5c1
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/scsi/scsi_proc.c:145:6: warning: syntax error: keyword 'while' is not allowed in global scope [syntaxError]
   void scsi_proc_hostdir_add(const struct scsi_host_template *sht)
        ^
   drivers/scsi/scsi_proc.c:464:61: warning: Parameter 'pos' can be declared with const [constParameter]
   static void *scsi_seq_start(struct seq_file *sfile, loff_t *pos)
                                                               ^
>> drivers/scsi/scsi_proc.c:115:12: warning: Uninitialized variable: dir->sht [uninitvar]
     if (dir->sht == sht)
              ^
   drivers/scsi/scsi_proc.c:154:12: warning: Uninitialized variable: dir->sht [uninitvar]
     if (dir->sht == sht) {
              ^
   drivers/scsi/scsi_proc.c:149:6: note: Assuming condition is false
    if (!sht->show_info)
        ^
   drivers/scsi/scsi_proc.c:154:12: note: Uninitialized variable: dir->sht
     if (dir->sht == sht) {
              ^

vim +/while +145 drivers/scsi/scsi_proc.c

   106	
   107	static struct sht_proc_dir *
   108	scsi_proc_find_sht_proc_dir(const struct scsi_host_template *sht)
   109	{
   110		struct sht_proc_dir *dir;
   111	
   112		lockdep_assert_held(&global_host_template_mutex);
   113	
   114		list_for_each_entry(dir, &sht_proc_dir_list, list) {
 > 115			if (dir->sht == sht)
   116				return dir;
   117		}
   118	
   119		return NULL;
   120	}
   121	
   122	struct proc_dir_entry *
   123	scsi_proc_get_proc_dir(const struct scsi_host_template *sht)
   124	{
   125		struct proc_dir_entry *proc_dir = NULL;
   126		struct sht_proc_dir *dir;
   127	
   128		mutex_lock(&global_host_template_mutex);
   129		dir = scsi_proc_find_sht_proc_dir(sht);
   130		if (dir)
   131			proc_dir = dir->proc_dir;
   132		mutex_unlock(&global_host_template_mutex);
   133	
   134		return proc_dir;
   135	}
   136	EXPORT_SYMBOL_GPL(scsi_proc_get_proc_dir);
   137	
   138	/**
   139	 * scsi_proc_hostdir_add - Create directory in /proc for a scsi host
   140	 * @sht: owner of this directory
   141	 *
   142	 * Sets sht->proc_dir to the new directory.
   143	 */
   144	
 > 145	void scsi_proc_hostdir_add(const struct scsi_host_template *sht)
   146	{
   147		struct sht_proc_dir *dir;
   148	
   149		if (!sht->show_info)
   150			return;
   151	
   152		mutex_lock(&global_host_template_mutex);
   153		list_for_each_entry(dir, &sht_proc_dir_list, list) {
   154			if (dir->sht == sht) {
   155				dir->cnt++;
   156				goto out;
   157			}
   158		}
   159		dir = kzalloc(sizeof(*dir), GFP_KERNEL);
   160		if (!dir)
   161			goto out;
   162	
   163		dir->proc_dir = proc_mkdir(sht->proc_name, proc_scsi);
   164		if (!dir->proc_dir) {
   165			printk(KERN_ERR "%s: proc_mkdir failed for %s\n",
   166			       __func__, sht->proc_name);
   167			kfree(dir);
   168			goto out;
   169		}
   170	
   171		dir->cnt++;
   172		list_add_tail(&dir->list, &sht_proc_dir_list);
   173	
   174	out:
   175		mutex_unlock(&global_host_template_mutex);
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
