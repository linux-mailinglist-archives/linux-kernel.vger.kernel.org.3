Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E55029B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiDOMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiDOMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:31:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD94B1FB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650025764; x=1681561764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+5cP0nVMRluUUW9TwVdDj5Aa+5bddYAwN4kFENnsPQA=;
  b=Bl8MbRXzoA18ajSPScNpkvU4g/pLyrpDnNdOVvn9/1wz/nvooOwsfJvJ
   xD6HYyiJPyjo2I/ICCGuhG+1HE/FndHx0kMT8hyvw91zjAPosiRURbShi
   h/rs3lgRR+ajZ6o44xy2ERpKeIMJfKxrkSXC6kOXJNYSSzJTjdptWRokE
   o2pXxw5plH7LeOLvZGdOw0zEgEGRqvmF9f3lgYZkGC8YomNleTOPkkPsV
   NZuUqT5Hubr/NHzL47tiv0lrUrG8rHqdo2LC/SJx4PgaMduPcT+43LxY3
   62hNYBbX9chub3MCkr4akR5IE4UbxuKIveE7Zc9pBitl4eFyqb6ittAbP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="323589413"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="323589413"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 05:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="527381119"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2022 05:29:22 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfL4j-0001w9-Dp;
        Fri, 15 Apr 2022 12:29:21 +0000
Date:   Fri, 15 Apr 2022 20:29:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [tip:x86/sev 43/49] drivers/virt/coco/sevguest/sevguest.c:579:17:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202204152027.aJdnJRgJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
head:   101826e02ac6c829bf4e768295e79ae9c37b4b2a
commit: fce96cf0443083e37455eff8f78fd240c621dae3 [43/49] virt: Add SEV-SNP guest driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220415/202204152027.aJdnJRgJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fce96cf0443083e37455eff8f78fd240c621dae3
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/sev
        git checkout fce96cf0443083e37455eff8f78fd240c621dae3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/virt/coco/sevguest/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/virt/coco/sevguest/sevguest.c:579:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct snp_secrets_page_layout *[assigned] layout @@
   drivers/virt/coco/sevguest/sevguest.c:579:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/virt/coco/sevguest/sevguest.c:579:17: sparse:     got struct snp_secrets_page_layout *[assigned] layout

vim +579 drivers/virt/coco/sevguest/sevguest.c

   504	
   505	static int __init snp_guest_probe(struct platform_device *pdev)
   506	{
   507		struct snp_secrets_page_layout *layout;
   508		struct snp_guest_platform_data *data;
   509		struct device *dev = &pdev->dev;
   510		struct snp_guest_dev *snp_dev;
   511		struct miscdevice *misc;
   512		int ret;
   513	
   514		if (!dev->platform_data)
   515			return -ENODEV;
   516	
   517		data = (struct snp_guest_platform_data *)dev->platform_data;
   518		layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
   519		if (!layout)
   520			return -ENODEV;
   521	
   522		ret = -ENOMEM;
   523		snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
   524		if (!snp_dev)
   525			goto e_unmap;
   526	
   527		ret = -EINVAL;
   528		snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
   529		if (!snp_dev->vmpck) {
   530			dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
   531			goto e_unmap;
   532		}
   533	
   534		/* Verify that VMPCK is not zero. */
   535		if (is_vmpck_empty(snp_dev)) {
   536			dev_err(dev, "vmpck id %d is null\n", vmpck_id);
   537			goto e_unmap;
   538		}
   539	
   540		platform_set_drvdata(pdev, snp_dev);
   541		snp_dev->dev = dev;
   542		snp_dev->layout = layout;
   543	
   544		/* Allocate the shared page used for the request and response message. */
   545		snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
   546		if (!snp_dev->request)
   547			goto e_unmap;
   548	
   549		snp_dev->response = alloc_shared_pages(sizeof(struct snp_guest_msg));
   550		if (!snp_dev->response)
   551			goto e_free_request;
   552	
   553		ret = -EIO;
   554		snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
   555		if (!snp_dev->crypto)
   556			goto e_free_response;
   557	
   558		misc = &snp_dev->misc;
   559		misc->minor = MISC_DYNAMIC_MINOR;
   560		misc->name = DEVICE_NAME;
   561		misc->fops = &snp_guest_fops;
   562	
   563		/* initial the input address for guest request */
   564		snp_dev->input.req_gpa = __pa(snp_dev->request);
   565		snp_dev->input.resp_gpa = __pa(snp_dev->response);
   566	
   567		ret =  misc_register(misc);
   568		if (ret)
   569			goto e_free_response;
   570	
   571		dev_info(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
   572		return 0;
   573	
   574	e_free_response:
   575		free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
   576	e_free_request:
   577		free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
   578	e_unmap:
 > 579		iounmap(layout);
   580		return ret;
   581	}
   582	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
