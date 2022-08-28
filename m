Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2D5A3B63
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 06:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiH1EMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 00:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiH1EMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 00:12:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9D32EFA;
        Sat, 27 Aug 2022 21:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661659955; x=1693195955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y1cvwA5B/KTDuGwWbT7lYJngHEIcaBGUlKJsOxZFDTE=;
  b=gngvyIobVmWB4suUfw/7i8KzgVgr6WHQgsLUC2cHnR0kJwV/rrdqDD6z
   TJwvvaR4vLM6IlMunOoJs7FlcYyHZVgHY5BVY0CgL7OM9R0X85n8399hm
   KIFzonf+9llNiBemj3ZAZxHg82/9cDWjD8Bv4hZ4kfI8qmgLSn9maWPwp
   UDKo6LOfI2BbDLLZ/Z40uhXjjput2+bov7m5yjuhl7gHRlO7pMVPNVL3l
   /9kxZLGqfQyzFF+XA8+m7ceobPMzCw66T3CFqfgdIetTGrUJ6TLK8s9be
   7C+Vo3JOmHlEwe8Wj043ys5IsV2vi8ZyelR9mcuhb/fG3QoS9hjz6eQSc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="294718541"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="294718541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 21:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="587769335"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2022 21:12:34 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS9ez-0000mU-1h;
        Sun, 28 Aug 2022 04:12:33 +0000
Date:   Sun, 28 Aug 2022 12:12:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:guest-attest 3/9] htmldocs:
 Documentation/x86/tdx.rst:275: WARNING: Field list ends without a blank
 line; unexpected unindent.
Message-ID: <202208281215.tlxpe8Ws-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git guest-attest
head:   32e0f882efcb0632adda39679d116f589f249d27
commit: c7d3f5519cee8f4cc42ed709450b48dd41876418 [3/9] Documentation/x86: Document TDX attestation process
reproduce:
        # https://github.com/intel/tdx/commit/c7d3f5519cee8f4cc42ed709450b48dd41876418
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout c7d3f5519cee8f4cc42ed709450b48dd41876418
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/x86/tdx.rst:275: WARNING: Field list ends without a blank line; unexpected unindent.

vim +275 Documentation/x86/tdx.rst

   266	
   267	Input parameters: Parameters passed to the IOCTL and related details.
   268	Output          : Details about output data and return value (with details
 > 269	                  about the non common error values).
   270	
   271	TDX_CMD_GET_REPORT
   272	------------------
   273	
   274	:Input parameters: struct tdx_report_req
 > 275	:Output          : Upon successful execution, TDREPORT data is copied to
   276	                   tdx_report_req.tdreport and returns 0 or returns
   277	                   -EIO on TDCALL failure and standard error number on
   278	                   other common failures.
   279	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
