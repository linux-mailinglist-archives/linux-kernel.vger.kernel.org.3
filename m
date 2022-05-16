Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11C15290DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbiEPUfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 16:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351121AbiEPUCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 16:02:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12F91114
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652731155; x=1684267155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JVHTDrsnnqLUkVaLdHCsPY2iu0ZqZS0uhGRqoz753YU=;
  b=CX6YMBKT2F87NR4MPSGwD70f7k8bJIjbzujsU1ozkLFk9LqgG9dTj0kj
   D/qs9EQT7UoZCSy+I6J9pq6QS5iZaJsAIS+Gh4rDY0fBDui5EdBPQEtaV
   VwrlZ7yRql2yV4iAHirADV6DAYtGPRKF/vxb1gxiWEd2wLM1DTo48P62J
   Cqx/2xRDASLJIr4tLd7NK/kP6O7aJIEx7uKDQO+9pda7ClqJSpvCJke0y
   +jFC+HDhsH/IApmqmo6yyLVprasENN2Ibeea5cWz9xr+9+2cPczp/rAMV
   TR5Qrl/gtYrAlof82sewt9EtxHmSwij67GBZiyjS9f4Mi3FEGh20KrWGJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="331561823"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="331561823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 12:59:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="522602714"
Received: from csalmon-mobl.amr.corp.intel.com (HELO localhost) ([10.212.118.70])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 12:59:14 -0700
Date:   Mon, 16 May 2022 12:59:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Dan Williams <dan.j.williams@intel.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [cxl:preview 48/67] drivers/cxl/core/pci.c:302
 __cxl_hdm_decode_init() warn: ignoring unreachable code.
Message-ID: <YoKtEeOPJPGSO6MM@iweiny-desk3>
References: <202205130114.DpEOzjJn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205130114.DpEOzjJn-lkp@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:14:38PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
> head:   9c642abd8b31d895f34186bd72b7360083b58492
> commit: 2263e9ed65887cc7c6e977f372596199d2c9f4af [48/67] cxl/port: Enable HDM Capability after validating DVSEC Ranges
> config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220513/202205130114.DpEOzjJn-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks great catch!

Ira

> 
> smatch warnings:
> drivers/cxl/core/pci.c:302 __cxl_hdm_decode_init() warn: ignoring unreachable code.
> 
> vim +302 drivers/cxl/core/pci.c
> 
> 18e7a07f5d584d Dan Williams 2022-05-01  270  static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> 9382da4f1fd2c2 Dan Williams 2022-05-09  271  				  struct cxl_hdm *cxlhdm,
> 18e7a07f5d584d Dan Williams 2022-05-01  272  				  struct cxl_endpoint_dvsec_info *info)
> 18e7a07f5d584d Dan Williams 2022-05-01  273  {
> 9382da4f1fd2c2 Dan Williams 2022-05-09  274  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> 2263e9ed65887c Dan Williams 2022-05-10  275  	struct cxl_port *port = cxlhdm->port;
> 2263e9ed65887c Dan Williams 2022-05-10  276  	struct device *dev = cxlds->dev;
> 2263e9ed65887c Dan Williams 2022-05-10  277  	struct cxl_port *root;
> 18e7a07f5d584d Dan Williams 2022-05-01  278  	u32 global_ctrl;
> 2263e9ed65887c Dan Williams 2022-05-10  279  	int i, rc;
> 18e7a07f5d584d Dan Williams 2022-05-01  280  
> 9382da4f1fd2c2 Dan Williams 2022-05-09  281  	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> 18e7a07f5d584d Dan Williams 2022-05-01  282  
> 2263e9ed65887c Dan Williams 2022-05-10  283  	/*
> 2263e9ed65887c Dan Williams 2022-05-10  284  	 * If the HDM Decoder Capability is already enabled then assume
> 2263e9ed65887c Dan Williams 2022-05-10  285  	 * that some other agent like platform firmware set it up.
> 2263e9ed65887c Dan Williams 2022-05-10  286  	 */
> 2263e9ed65887c Dan Williams 2022-05-10  287  	if (global_ctrl & CXL_HDM_DECODER_ENABLE) {
> 2263e9ed65887c Dan Williams 2022-05-10  288  		rc = devm_cxl_enable_mem(&port->dev, cxlds);
> 2263e9ed65887c Dan Williams 2022-05-10  289  		if (rc)
> 9382da4f1fd2c2 Dan Williams 2022-05-09  290  			return false;
> 2263e9ed65887c Dan Williams 2022-05-10  291  		return true;
> 2263e9ed65887c Dan Williams 2022-05-10  292  	}
> 2263e9ed65887c Dan Williams 2022-05-10  293  
> 2263e9ed65887c Dan Williams 2022-05-10  294  	root = to_cxl_port(port->dev.parent);
> 2263e9ed65887c Dan Williams 2022-05-10  295  	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> 2263e9ed65887c Dan Williams 2022-05-10  296  		root = to_cxl_port(root->dev.parent);
> 2263e9ed65887c Dan Williams 2022-05-10  297  	if (!is_cxl_root(root)) {
> 2263e9ed65887c Dan Williams 2022-05-10  298  		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> 2263e9ed65887c Dan Williams 2022-05-10  299  		return false;
> 2263e9ed65887c Dan Williams 2022-05-10  300  	}
> 2263e9ed65887c Dan Williams 2022-05-10  301  
> 2263e9ed65887c Dan Williams 2022-05-10 @302  	for (i = 0; i < info->ranges; i++) {
>                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This only loops once.  if (info->ranges != 0) {?
> 
> 
> 2263e9ed65887c Dan Williams 2022-05-10  303  		struct device *cxld_dev;
> 2263e9ed65887c Dan Williams 2022-05-10  304  
> 2263e9ed65887c Dan Williams 2022-05-10  305  		if (!info->mem_enabled)
> 2263e9ed65887c Dan Williams 2022-05-10  306  			break;
> 2263e9ed65887c Dan Williams 2022-05-10  307  
> 2263e9ed65887c Dan Williams 2022-05-10  308  		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
> 2263e9ed65887c Dan Williams 2022-05-10  309  					     dvsec_range_allowed);
> 2263e9ed65887c Dan Williams 2022-05-10  310  		if (!cxld_dev) {
> 2263e9ed65887c Dan Williams 2022-05-10  311  			dev_dbg(dev, "Range%d disallowed by platform\n", i);
> 2263e9ed65887c Dan Williams 2022-05-10  312  			cxl_set_mem_enable(cxlds, 0);
> 2263e9ed65887c Dan Williams 2022-05-10  313  			info->mem_enabled = 0;
> 2263e9ed65887c Dan Williams 2022-05-10  314  			break;
> 2263e9ed65887c Dan Williams 2022-05-10  315  		}
> 2263e9ed65887c Dan Williams 2022-05-10  316  		put_device(cxld_dev);
> 2263e9ed65887c Dan Williams 2022-05-10  317  		break;
> 
> Or delete this break?
> 
> 2263e9ed65887c Dan Williams 2022-05-10  318  	}
> 2263e9ed65887c Dan Williams 2022-05-10  319  	put_device(&root->dev);
> 18e7a07f5d584d Dan Williams 2022-05-01  320  
> 87aafd75cc537f Dan Williams 2022-04-30  321  	/*
> 2263e9ed65887c Dan Williams 2022-05-10  322  	 * At least one DVSEC range is enabled and allowed, skip HDM
> 2263e9ed65887c Dan Williams 2022-05-10  323  	 * Decoder Capability Enable
> 87aafd75cc537f Dan Williams 2022-04-30  324  	 */
> 2263e9ed65887c Dan Williams 2022-05-10  325  	if (info->mem_enabled)
> 2263e9ed65887c Dan Williams 2022-05-10  326  		return false;
> 2263e9ed65887c Dan Williams 2022-05-10  327  
> 2263e9ed65887c Dan Williams 2022-05-10  328  	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> 2263e9ed65887c Dan Williams 2022-05-10  329  	if (rc)
> 2263e9ed65887c Dan Williams 2022-05-10  330  		return false;
> 2263e9ed65887c Dan Williams 2022-05-10  331  
> 2263e9ed65887c Dan Williams 2022-05-10  332  	rc = devm_cxl_enable_mem(&port->dev, cxlds);
> 2263e9ed65887c Dan Williams 2022-05-10  333  	if (rc)
> 2263e9ed65887c Dan Williams 2022-05-10  334  		return false;
> 18e7a07f5d584d Dan Williams 2022-05-01  335  
> 9382da4f1fd2c2 Dan Williams 2022-05-09  336  	return true;
> 18e7a07f5d584d Dan Williams 2022-05-01  337  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
