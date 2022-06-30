Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069B561678
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiF3Jgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiF3Jgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:36:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221643381
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656581804; x=1688117804;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k0kajREAJGyqUcdM7FLlH8cIL8gJhsUD4HxbAL58rOc=;
  b=eYvY14CDNF9XlNH/fNKaHWzsQY13vMfybJ/HBcS9+B/bbuxLSrvWHtuP
   GU3R7sWBMgqMNjblSCjFdE4uAKP1GX15K9v/65COdNz1C0Y9Uxk+/ezye
   fAIsRaLKg8+cZHVON6CBLej/82tIXrlkWOGPwawyWZmh7+yH2jgrkvrBj
   mUaZWLtrSf9ihtO2HCiMyxNDw/aH+bsbuDFRXyn3On5KZtUya3IThPDap
   x7xemHSxSEjVCVVD6iYMi6C9ETfnonxQBfiZ2N+oIHB0LXkDGMdWps6lV
   HTtSccM38PYWWJ1vm8bocpTvcysZT+/DV6zNICH6SyizyZjA0lfc6yZdb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283399039"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="283399039"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="917982056"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 02:36:42 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6qbK-000CYs-10;
        Thu, 30 Jun 2022 09:36:42 +0000
Date:   Thu, 30 Jun 2022 17:36:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Simo Sorce <simo@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: ERROR: modpost: "pkcs7_supply_detached_data"
 [crypto/asymmetric_keys/x509_key_parser.ko] undefined!
Message-ID: <202206301754.H9rIzcFy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d9b2ba67917c18822c6a09af41c32fa161f1606b
commit: 3cde3174eb910513d32a9ec8a9b95ea59be833df certs: Add FIPS selftests
date:   9 days ago
config: nios2-randconfig-r023-20220630 (https://download.01.org/0day-ci/archive/20220630/202206301754.H9rIzcFy-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3cde3174eb910513d32a9ec8a9b95ea59be833df
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3cde3174eb910513d32a9ec8a9b95ea59be833df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pkcs7_supply_detached_data" [crypto/asymmetric_keys/x509_key_parser.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
