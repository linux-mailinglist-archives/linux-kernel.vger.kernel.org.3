Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B179348B2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiAKRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:09:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:3890 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242636AbiAKRJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641920973; x=1673456973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DiMg4uiDcYvGINhJ1evaXjCSFfSPnawKpCWqwJ14ezE=;
  b=HnIAWGpy9WJ1RV8HGZfezYKLVuo4Zu8tfwazT2ItN6cQF3o2xklGKgx+
   t1moD1Vs/ZA5C5kXTg59sVyLzKryf91ndIcEOZaSHWT403Aj0YUiBsqLy
   D+CdmyecPnJbK8WBQ96S2yKKOBt/khsKUSH8JFaCp5PR6G0Ku93LRO3Tt
   SehVoVK+v4MsmxHTkWuZt6BPT+LdtaLaA+EDRK0ITeJjYK1pBPPbvxNbQ
   7wYcC1cz5zRiMVjXxlvSAQNJvtQ4JhRoqLmguhTx09UMRkiQ2FfrXnSNu
   KCoZZ6vtGI6wnZKWLYtNYedFLhi3arkiO2awbyG1o5yKzKmDzYSoT0SIt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243336663"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243336663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 09:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="474606649"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2022 09:09:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7KeG-00051R-JP; Tue, 11 Jan 2022 17:09:28 +0000
Date:   Wed, 12 Jan 2022 01:09:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [hverkuil-media-tree:for-v5.18b 91/91]
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c: linux/pm_runtime.h
 is included more than once.
Message-ID: <202201120137.01tmxORg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.18b
head:   54ac00224f00e07d103cf562b0c434b8a77b1329
commit: 54ac00224f00e07d103cf562b0c434b8a77b1329 [91/91] media: mtk-vcodec: Remove mtk_vcodec_release_enc_pm
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c: linux/pm_runtime.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
