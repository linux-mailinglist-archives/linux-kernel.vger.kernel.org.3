Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932B54B6D27
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiBONRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:17:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiBONRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:17:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53240C7D4E;
        Tue, 15 Feb 2022 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644931014; x=1676467014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/fCEkspTynMx/KBUNmalbFEyHPshGMZWUJ7Yi9YEdY=;
  b=VX4GJyTTpn49ihfaU96YFA3qbY232+7ltnC49JbTlqVZbPeW8IAIFC3g
   KygJFJKrtY+CrtC7bd4de63mCvsyeCK/4LThZHtxf6rZntEBI0lV/zvCZ
   02zStrQr14gAneRRxkwylbtwEEyJP9T7pLWlrOPTbdT7ybUFh/M2pNg6E
   2RYM3LzLiT5ATbAdB2ZKtazS6W35dlKZpA7buRWAmGRd5lnky8Vfu/ZVv
   qyHtV9Yhz+ABSH9FKPSqO321gvBpMJiQ3qKWs4rqqy+avcs57id29Xhmy
   ob/F5uD5sNKOMsNqXVGotuUPvoaDF1OSsScZ2snWUxJMEoM9ybvadp40z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230976804"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="230976804"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 05:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="703670560"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2022 05:16:50 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJxhJ-0009gq-Kk; Tue, 15 Feb 2022 13:16:49 +0000
Date:   Tue, 15 Feb 2022 21:16:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        bjorn.andersson@linaro.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V4 2/2] soc: qcom: smem: validate fields of shared
 structures
Message-ID: <202202152150.EZ8yJDzm-lkp@intel.com>
References: <1644849974-8043-2-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644849974-8043-2-git-send-email-quic_deesin@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc4 next-20220215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Deepak-Kumar-Singh/soc-qcom-smem-map-only-partitions-used-by-local-HOST/20220214-224750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 754e0b0e35608ed5206d6a67a791563c631cec07
config: openrisc-randconfig-s031-20220214 (https://download.01.org/0day-ci/archive/20220215/202202152150.EZ8yJDzm-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/cfc33be784b2bfdafba0ae278dfbf92bdd9111da
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Deepak-Kumar-Singh/soc-qcom-smem-map-only-partitions-used-by-local-HOST/20220214-224750
        git checkout cfc33be784b2bfdafba0ae278dfbf92bdd9111da
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/soc/qcom/smem.c:430:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:430:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:430:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:517:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:517:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:517:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:534:50: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:534:50: sparse:     expected void *
   drivers/soc/qcom/smem.c:534:50: sparse:     got void [noderef] __iomem *
>> drivers/soc/qcom/smem.c:695:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:695:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:695:22: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:699:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:699:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:699:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:699:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:699:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:699:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:703:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:703:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:703:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:707:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:707:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:707:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:707:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:707:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:707:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:710:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:710:24: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:710:24: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:723:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/soc/qcom/smem.c:723:30: sparse:    void *
   drivers/soc/qcom/smem.c:723:30: sparse:    void [noderef] __iomem *
   drivers/soc/qcom/smem.c:744:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:753:28: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:762:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:777:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:777:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:777:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:810:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/soc/qcom/smem.c:831:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *header @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:831:16: sparse:     expected struct smem_partition_header *header
   drivers/soc/qcom/smem.c:831:16: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:982:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_ptable *ptable @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:982:22: sparse:     expected struct smem_ptable *ptable
   drivers/soc/qcom/smem.c:982:22: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:1091:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:1091:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:1091:16: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:1112:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1112:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smem.c:1112:31: sparse:     got restricted __le32 *
   drivers/soc/qcom/smem.c:1112:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1112:67: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smem.c:1112:67: sparse:     got restricted __le32 *
   drivers/soc/qcom/smem.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32

vim +695 drivers/soc/qcom/smem.c

4b638df4c9d556 Bjorn Andersson    2015-06-26  675  
4b638df4c9d556 Bjorn Andersson    2015-06-26  676  /**
4b638df4c9d556 Bjorn Andersson    2015-06-26  677   * qcom_smem_get_free_space() - retrieve amount of free space in a partition
4b638df4c9d556 Bjorn Andersson    2015-06-26  678   * @host:	the remote processor identifying a partition, or -1
4b638df4c9d556 Bjorn Andersson    2015-06-26  679   *
4b638df4c9d556 Bjorn Andersson    2015-06-26  680   * To be used by smem clients as a quick way to determine if any new
4b638df4c9d556 Bjorn Andersson    2015-06-26  681   * allocations has been made.
4b638df4c9d556 Bjorn Andersson    2015-06-26  682   */
4b638df4c9d556 Bjorn Andersson    2015-06-26  683  int qcom_smem_get_free_space(unsigned host)
4b638df4c9d556 Bjorn Andersson    2015-06-26  684  {
70716a4ee6c89c Deepak Kumar Singh 2022-02-14  685  	struct smem_partition *part;
4b638df4c9d556 Bjorn Andersson    2015-06-26  686  	struct smem_partition_header *phdr;
4b638df4c9d556 Bjorn Andersson    2015-06-26  687  	struct smem_header *header;
4b638df4c9d556 Bjorn Andersson    2015-06-26  688  	unsigned ret;
4b638df4c9d556 Bjorn Andersson    2015-06-26  689  
4b638df4c9d556 Bjorn Andersson    2015-06-26  690  	if (!__smem)
4b638df4c9d556 Bjorn Andersson    2015-06-26  691  		return -EPROBE_DEFER;
4b638df4c9d556 Bjorn Andersson    2015-06-26  692  
70716a4ee6c89c Deepak Kumar Singh 2022-02-14  693  	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
70716a4ee6c89c Deepak Kumar Singh 2022-02-14  694  		part = &__smem->partitions[host];
70716a4ee6c89c Deepak Kumar Singh 2022-02-14 @695  		phdr = part->virt_base;
9806884d8cd552 Stephen Boyd       2015-09-02  696  		ret = le32_to_cpu(phdr->offset_free_cached) -
9806884d8cd552 Stephen Boyd       2015-09-02  697  		      le32_to_cpu(phdr->offset_free_uncached);
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  698  
cfc33be784b2bf Deepak Kumar Singh 2022-02-14 @699  		if (ret > le32_to_cpu(part->size))
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  700  			return -EINVAL;
70716a4ee6c89c Deepak Kumar Singh 2022-02-14  701  	} else if (__smem->global_partition.virt_base) {
70716a4ee6c89c Deepak Kumar Singh 2022-02-14  702  		part = &__smem->global_partition;
70716a4ee6c89c Deepak Kumar Singh 2022-02-14  703  		phdr = part->virt_base;
d52e404874369f Chris Lew          2017-10-11  704  		ret = le32_to_cpu(phdr->offset_free_cached) -
d52e404874369f Chris Lew          2017-10-11  705  		      le32_to_cpu(phdr->offset_free_uncached);
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  706  
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  707  		if (ret > le32_to_cpu(part->size))
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  708  			return -EINVAL;
4b638df4c9d556 Bjorn Andersson    2015-06-26  709  	} else {
4b638df4c9d556 Bjorn Andersson    2015-06-26  710  		header = __smem->regions[0].virt_base;
9806884d8cd552 Stephen Boyd       2015-09-02  711  		ret = le32_to_cpu(header->available);
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  712  
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  713  		if (ret > __smem->regions[0].size)
cfc33be784b2bf Deepak Kumar Singh 2022-02-14  714  			return -EINVAL;
4b638df4c9d556 Bjorn Andersson    2015-06-26  715  	}
4b638df4c9d556 Bjorn Andersson    2015-06-26  716  
4b638df4c9d556 Bjorn Andersson    2015-06-26  717  	return ret;
4b638df4c9d556 Bjorn Andersson    2015-06-26  718  }
4b638df4c9d556 Bjorn Andersson    2015-06-26  719  EXPORT_SYMBOL(qcom_smem_get_free_space);
4b638df4c9d556 Bjorn Andersson    2015-06-26  720  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
