Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8D5757C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiGNWlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbiGNWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:41:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141C71BE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657838510; x=1689374510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gZOMQWgLFBRi+y3k9o04QzaH/U1GVVLuwgNaNi71QTU=;
  b=hm9T5Yv5QIMybgiZpax9zI4jEfuHaaFRmSnYqMoS0DhsGBQg2KRrKs1P
   pkzjytz0pxHc1WseHMvyHXf0MW9fCWi7rdZqx6HApiqL7CC8A6/ZyI+lF
   5PwDx25Z5bkfhBPKwd7YDf7O+wPYAm4sFkesjS9klOY/gz4DvXxbbk7Gv
   dHFF0T+BptqRGOu0RCyiSSaZefjdYkyyf5tPdRlAaiIZjN1pOfQiq4o8s
   OZhtgYnfj1kW+iAYokFNf5p1pFxE/uqS6V8t0ohmxMma8S90lnAvoSRE5
   l9kX7jstXnrDrRZhxqE8K2ZUGgh5k49pj3b4VNv3zN+Tn1p26xVK+jE66
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268671344"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="268671344"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="923259715"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2022 15:41:48 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC7Wl-0001EV-Cy;
        Thu, 14 Jul 2022 22:41:47 +0000
Date:   Fri, 15 Jul 2022 06:40:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: drivers/virt/coco/sev-guest/sev-guest.c:709:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202207150617.jqwQ0Rpz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9bd572ec7a66b56e1aed896217ff311d981cf575
commit: d63670d23e60f00210635ca7c62bce27bec55f1b virt: sevguest: Rename the sevguest dir and files to sev-guest
date:   3 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220715/202207150617.jqwQ0Rpz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d63670d23e60f00210635ca7c62bce27bec55f1b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d63670d23e60f00210635ca7c62bce27bec55f1b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/virt/coco/sev-guest/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/virt/coco/sev-guest/sev-guest.c:709:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct snp_secrets_page_layout *[assigned] layout @@
   drivers/virt/coco/sev-guest/sev-guest.c:709:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/virt/coco/sev-guest/sev-guest.c:709:17: sparse:     got struct snp_secrets_page_layout *[assigned] layout

vim +709 drivers/virt/coco/sev-guest/sev-guest.c

fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  627  
2bf93ffbb97e061 drivers/virt/coco/sevguest/sevguest.c Tom Lendacky  2022-04-20  628  static int __init sev_guest_probe(struct platform_device *pdev)
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  629  {
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  630  	struct snp_secrets_page_layout *layout;
2bf93ffbb97e061 drivers/virt/coco/sevguest/sevguest.c Tom Lendacky  2022-04-20  631  	struct sev_guest_platform_data *data;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  632  	struct device *dev = &pdev->dev;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  633  	struct snp_guest_dev *snp_dev;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  634  	struct miscdevice *misc;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  635  	int ret;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  636  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  637  	if (!dev->platform_data)
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  638  		return -ENODEV;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  639  
2bf93ffbb97e061 drivers/virt/coco/sevguest/sevguest.c Tom Lendacky  2022-04-20  640  	data = (struct sev_guest_platform_data *)dev->platform_data;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  641  	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  642  	if (!layout)
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  643  		return -ENODEV;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  644  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  645  	ret = -ENOMEM;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  646  	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  647  	if (!snp_dev)
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  648  		goto e_unmap;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  649  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  650  	ret = -EINVAL;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  651  	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  652  	if (!snp_dev->vmpck) {
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  653  		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  654  		goto e_unmap;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  655  	}
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  656  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  657  	/* Verify that VMPCK is not zero. */
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  658  	if (is_vmpck_empty(snp_dev)) {
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  659  		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  660  		goto e_unmap;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  661  	}
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  662  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  663  	platform_set_drvdata(pdev, snp_dev);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  664  	snp_dev->dev = dev;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  665  	snp_dev->layout = layout;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  666  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  667  	/* Allocate the shared page used for the request and response message. */
2bf93ffbb97e061 drivers/virt/coco/sevguest/sevguest.c Tom Lendacky  2022-04-20  668  	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  669  	if (!snp_dev->request)
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  670  		goto e_unmap;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  671  
2bf93ffbb97e061 drivers/virt/coco/sevguest/sevguest.c Tom Lendacky  2022-04-20  672  	snp_dev->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  673  	if (!snp_dev->response)
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  674  		goto e_free_request;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  675  
2bf93ffbb97e061 drivers/virt/coco/sevguest/sevguest.c Tom Lendacky  2022-04-20  676  	snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  677  	if (!snp_dev->certs_data)
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  678  		goto e_free_response;
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  679  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  680  	ret = -EIO;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  681  	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  682  	if (!snp_dev->crypto)
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  683  		goto e_free_cert_data;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  684  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  685  	misc = &snp_dev->misc;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  686  	misc->minor = MISC_DYNAMIC_MINOR;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  687  	misc->name = DEVICE_NAME;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  688  	misc->fops = &snp_guest_fops;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  689  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  690  	/* initial the input address for guest request */
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  691  	snp_dev->input.req_gpa = __pa(snp_dev->request);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  692  	snp_dev->input.resp_gpa = __pa(snp_dev->response);
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  693  	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  694  
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  695  	ret =  misc_register(misc);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  696  	if (ret)
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  697  		goto e_free_cert_data;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  698  
2bf93ffbb97e061 drivers/virt/coco/sevguest/sevguest.c Tom Lendacky  2022-04-20  699  	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  700  	return 0;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  701  
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  702  e_free_cert_data:
d80b494f7123174 drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  703  	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  704  e_free_response:
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  705  	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  706  e_free_request:
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  707  	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  708  e_unmap:
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07 @709  	iounmap(layout);
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  710  	return ret;
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  711  }
fce96cf0443083e drivers/virt/coco/sevguest/sevguest.c Brijesh Singh 2022-03-07  712  

:::::: The code at line 709 was first introduced by commit
:::::: fce96cf0443083e37455eff8f78fd240c621dae3 virt: Add SEV-SNP guest driver

:::::: TO: Brijesh Singh <brijesh.singh@amd.com>
:::::: CC: Borislav Petkov <bp@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
