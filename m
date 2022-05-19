Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E2052D742
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbiESPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiESPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:18:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE9EC6E79
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652973524; x=1684509524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Zsg46ZEcQlkoKtsE67ncfy4PgbeqNyaojjUkYedI74=;
  b=M02LwhdM6Yx5EWbRPdqeuj0NUPxpNmNk+614x9nuYFt69mfY/77nnpOX
   Ye+IzfJx+hUZ7CasXrDZJGy8crJdMunK9VrBgLo2Q4bAAwgGYAXApKESk
   R09Fe+OdA5qn1JOQzhCbe6r8/cdFwvgA17q90g64hEgB1u/MNmwILcFgf
   lP9SIF5VrR7dlpyrITIs2dV1kzGV6VwFs7PN9cRY3D6F/jrz79V6CjRp8
   NDuirC99shu3QEbNgl+MlqrczwcOVAg830issX4/Mr1I54a2AEfJB0131
   gT+JWbwzDGVwole6DvLqydnXOokbNLj+sZ1p2Yn653mpkig6giZRbCo3W
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="271943925"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="271943925"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="674059304"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2022 08:18:41 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrhvE-0003gJ-P0;
        Thu, 19 May 2022 15:18:40 +0000
Date:   Thu, 19 May 2022 23:17:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <202205192320.CoXevcfR-lkp@intel.com>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Naveen,

I love your patch! Yet something to improve:

[auto build test ERROR on f993aed406eaf968ba3867a76bb46c95336a33d0]

url:    https://github.com/intel-lab-lkp/linux/commits/Naveen-N-Rao/kexec_file-Drop-weak-attribute-from-arch_kexec_apply_relocations-_add/20220519-171432
base:   f993aed406eaf968ba3867a76bb46c95336a33d0
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220519/202205192320.CoXevcfR-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/67171688c71cb5b05f26e0dfc45eec8d8d1428ff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naveen-N-Rao/kexec_file-Drop-weak-attribute-from-arch_kexec_apply_relocations-_add/20220519-171432
        git checkout 67171688c71cb5b05f26e0dfc45eec8d8d1428ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/machine_kexec_reloc.c:3:
>> arch/s390/include/asm/kexec.h:89:38: error: unknown type name 'Elf_Shdr'; did you mean 'elf_shdr'?
      89 |                                      Elf_Shdr *section,
         |                                      ^~~~~~~~
         |                                      elf_shdr
   arch/s390/include/asm/kexec.h:90:44: error: unknown type name 'Elf_Shdr'
      90 |                                      const Elf_Shdr *relsec,
         |                                            ^~~~~~~~
   arch/s390/include/asm/kexec.h:91:44: error: unknown type name 'Elf_Shdr'
      91 |                                      const Elf_Shdr *symtab);
         |                                            ^~~~~~~~


vim +89 arch/s390/include/asm/kexec.h

    85	
    86	#ifdef CONFIG_KEXEC_FILE
    87	struct purgatory_info;
    88	int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
  > 89					     Elf_Shdr *section,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
