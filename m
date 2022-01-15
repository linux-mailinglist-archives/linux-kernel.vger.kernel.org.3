Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7166C48F655
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 11:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiAOKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 05:15:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:18006 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbiAOKPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 05:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642241752; x=1673777752;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dHvT5E08iIm8DoTIcYlSY5gx2i+SV/S0fr7NiGQGD74=;
  b=Vtj72o9J+qUFxR+GAm23UEPB80TB4uA4BvWKoVDVD+zam9PnEOKI89RQ
   q95z9NRv1y+pICWltaXzUkffeMcrpli8hpEddX3FI9fxziTusxAmjC3/9
   Lznnendwu2jZptuNBfZTLuwazSXvUsX+Yu/8++WhHhI9MWrt/n0mXXAQG
   9+tDQy/mFKdSnIXFSjT2N2bEOWQ1nz2A/LrDQza5a/s2ORAf/K1XJKUBp
   vG/6CuVYoLEm9ZIVoAwaTe5+2EbkN1rgfzjoiEdOh//FElVDY0HLASk0f
   HL0pVEmsFQSVQ81ETJ6jRZwbV11gsusq4FrC/OprWW+hrW0dOq1lN+prS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="243214140"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="243214140"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 02:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692535408"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2022 02:15:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8g6A-0009dm-Fl; Sat, 15 Jan 2022 10:15:50 +0000
Date:   Sat, 15 Jan 2022 18:15:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 93/133] drivers/pci/probe.c:
 linux/cc_platform.h is included more than once.
Message-ID: <202201151810.flpn7t4e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: d36d7c52ab2f685d342b9ce1e51faa200a98ec3b [93/133] tdx: Disable ASPM with device filter
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/pci/probe.c: linux/cc_platform.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
