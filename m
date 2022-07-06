Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2709656902E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiGFRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiGFRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:01:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69213E09
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657126897; x=1688662897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PcO8QiwDz7uOVn9a7f/+veYZTkuAp/A2fAVf+lWbA2s=;
  b=h+9mTqACRVC4MqYcbRD2fxDXzz1tYMRosgIJw+pHAky6A/yMuvHapua6
   lR1QU1C5xOO0zaIZxT4wgUT3CLx6qUdZFdaBIfARIkpbZv/gmGHlp3o5t
   XJl87s00g1Kaaiz8fcEdA5O0R7t6O05jq0GWYcRL4fnorE20gV3y3MgQW
   Y2WfHu9kvCq8S4fPZ9yShSrGWUkfvyOs2h+zcIYWE0sx+vCUgGj4kCtv+
   JGUdfPPC3tIABchA78Hffk5b8dXEnXKxLflO/8W5lPxkFwp7yJy9msQZY
   UAzobcnBAXaoS+rDk0KRTcnkGRbDz4bR+oKMvvxwpT0/FVout2NYB5Tn6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="272602810"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="272602810"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="620409044"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2022 10:01:14 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o98On-000Kop-QN;
        Wed, 06 Jul 2022 17:01:13 +0000
Date:   Thu, 7 Jul 2022 01:00:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:xdp_hints 5/52] net/bpf/prog_ops.c:895:31: sparse: sparse:
 symbol 'xdp_verifier_ops' was not declared. Should it be static?
Message-ID: <202207070053.RTwePsFp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux xdp_hints
head:   e9f4215398901c2e3f477da53abc668ce7b7e320
commit: 40ce0c8bf2731c92fb015a03a7f9b26d90d547d0 [5/52] net, xdp: decouple XDP code from the core networking code
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220707/202207070053.RTwePsFp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/alobakin/linux/commit/40ce0c8bf2731c92fb015a03a7f9b26d90d547d0
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin xdp_hints
        git checkout 40ce0c8bf2731c92fb015a03a7f9b26d90d547d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/bpf/prog_ops.c:895:31: sparse: sparse: symbol 'xdp_verifier_ops' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
