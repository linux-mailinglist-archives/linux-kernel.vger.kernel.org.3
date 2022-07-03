Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3556481E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGCOhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:36:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B963AF;
        Sun,  3 Jul 2022 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656859018; x=1688395018;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DMxpozazW6mTdg7Efhz9X5/dQ5of/dx9O2hS7N4aIYA=;
  b=jrhXw3GIj1TTCeJ4SGnS09jihVy7f4tBc2baK1DxPzy0JT310qb5bdkg
   /M0ouyPbXWYUdjaWdU2kvxFjoGKEmIS38NyJFU/W6j6sluFoFxwL3pOPY
   VNN9Ydi8pdzkXds0xQHjJ1Aa8hHf+hT6pcTWr4IgOzX9GGU1appOraovG
   cbBQ9ZMj6DqCaC4FlydDv6tkAr/cbwIEtn+Zrrj/x1ZKyExb6MB+E6zAu
   l0civyB6W3Epzdw+yrNM7naOc02rZULuU8ln/zrT7nf0Rezpf2eEBsDYY
   XIIaJ/Erlpi+2vnQPcZrK6toe7FLGuK1P7LtIjA4LdjXxr4zNSoN/m3+J
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="283683779"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="283683779"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 07:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="542225966"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Jul 2022 07:36:55 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o80iV-000Gbv-8S;
        Sun, 03 Jul 2022 14:36:55 +0000
Date:   Sun, 3 Jul 2022 22:36:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Madhavan Srinivasan <maddy@in.ibm.com>,
        linux-doc@vger.kernel.org
Subject: htmldocs: Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING:
 Unexpected indentation.
Message-ID: <202207032228.bTwnKXlK-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69cb6c6556ad89620547318439d6be8bb1629a5a
commit: 2bec6d9aa89cbe97deb6fbc64708212b780605a4 docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries for nvdimm pmu
date:   4 months ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.

vim +11 Documentation/ABI/testing/sysfs-bus-nvdimm

     9	
    10	What:           /sys/bus/event_source/devices/nmemX/format
  > 11	Date:           February 2022
    12	KernelVersion:  5.18
    13	Contact:        Kajol Jain <kjain@linux.ibm.com>
    14	Description:	(RO) Attribute group to describe the magic bits
    15			that go into perf_event_attr.config for a particular pmu.
    16			(See ABI/testing/sysfs-bus-event_source-devices-format).
    17	
    18			Each attribute under this group defines a bit range of the
    19			perf_event_attr.config. Supported attribute is listed
    20			below::
    21			  event  = "config:0-4"  - event ID
    22	
    23			For example::
    24				ctl_res_cnt = "event=0x1"
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
