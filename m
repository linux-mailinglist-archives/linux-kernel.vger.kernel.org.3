Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BF5808FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbiGZBXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiGZBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:23:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24382870A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658798602; x=1690334602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JVOXlMCnJZBZLXEW2sa88gGuSpNuDa1rsxsUe58P/7o=;
  b=kUqfXAwhbbTIEYErzHCpHkBdRfCkA1X1ZHAFtMVLp3O8KWwQBR8w13rG
   5lguqOMsvmtqPcxNphqNpQyqh8FYtTIq4lJ9GQXxBaPvE8aYpvsNtIVV4
   pxkhxm6cEbzJNbr9yWm8CI7u4Q5TEq5q5ThEzHk4PkwwxhPBuyiCYKJTb
   K0dQ7D9brQOh7BBCFqwQY6rS1mJ1USCfFMQeFbF8I9R9Bz5nkPLHQTIeT
   1UNgLRvQ7e9wR0UDGiv4C+0Z/oEGSj+rcMFdSlz6g7JUtQPwzScLqF5X0
   8nvtBsbXJQCtBQkseISYXHWZhV3TFHkx9kAJvUiJSyGnnBonvoDYztcdo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="286589657"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="286589657"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 18:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="550203857"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2022 18:23:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oG9I8-0005mV-2n;
        Tue, 26 Jul 2022 01:23:20 +0000
Date:   Tue, 26 Jul 2022 09:22:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta5 4/9] sch_ingress.c:undefined reference to
 `sch_prog_detach_kern'
Message-ID: <202207260912.cE7cA84I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/cilium/linux.git pr/meta5
head:   bdb1b1139e4c469db3c039c9540b6252ac6363e7
commit: fafe94e50da7d56dd12f94a7bf97a0e3a9dda12d [4/9] bpf: Add initial fd-based API to attach tc BPF programs
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220726/202207260912.cE7cA84I-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/cilium/linux/commit/fafe94e50da7d56dd12f94a7bf97a0e3a9dda12d
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta5
        git checkout fafe94e50da7d56dd12f94a7bf97a0e3a9dda12d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/sched/sch_ingress.o: in function `ingress_destroy':
>> sch_ingress.c:(.text+0x19c): undefined reference to `sch_prog_detach_kern'
   ld: net/sched/sch_ingress.o: in function `clsact_destroy':
   sch_ingress.c:(.text+0x221): undefined reference to `sch_prog_detach_kern'
>> ld: sch_ingress.c:(.text+0x233): undefined reference to `sch_prog_detach_kern'
   ld: net/sched/sch_ingress.o: in function `clsact_init':
>> sch_ingress.c:(.text+0x6bc): undefined reference to `sch_prog_attach_kern'
>> ld: sch_ingress.c:(.text+0x796): undefined reference to `sch_prog_attach_kern'
   ld: net/sched/sch_ingress.o: in function `ingress_init':
   sch_ingress.c:(.text+0x92f): undefined reference to `sch_prog_attach_kern'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
