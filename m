Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B023F565E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiGDTjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGDTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:39:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4DE00F;
        Mon,  4 Jul 2022 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656963590; x=1688499590;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uXUWM4ZCmmyqWVnwBc+JZKXlVfuCIgdCR3FN6nzesaQ=;
  b=AbdP3PqFdoer2Pm9sYYNBS4fTfg8LAK4QnuuNjEynNI/Cp1GadKslm7C
   WGsFIoffpa1O8+6ghULMadQQB6olXZAtuRy9ZHinFXihUoG3GHs5ioBEL
   QUG54/jXyc5uADbFdjTRoq8Ttql6plcjO88qjqlSKkgFFM8e+iw/23/yk
   K7ajdEsbPnuYLHM+6kODPoTQSGe3/MzSaZ01yjN0tUymKjyG1VHuBSAZv
   FvstUUwGO26xoAnN+n2Vk3ovu+K1PK5Gvs/AJ1pWW6jY4DBtj7mIIOCk8
   pnZy3w234U4BmVtj1PIE+iqZFy+BQl9xaoAU7rQheo0ZNXRm6XwGQAuJQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284298622"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="284298622"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 12:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="919452883"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2022 12:39:48 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Rv9-000I7r-PO;
        Mon, 04 Jul 2022 19:39:47 +0000
Date:   Tue, 5 Jul 2022 03:39:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-doc@vger.kernel.org
Subject: [mgr:v5.19/topic/rk3568-vepu-h264-stateless-bootlin 2/4] htmldocs:
 Documentation/output/videodev2.h.rst:6: WARNING: undefined label:
 v4l2-ctrl-type-h264-encode-params (if the link has no caption the label must
 precede a section header)
Message-ID: <202207050300.unCEGUNs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.pengutronix.de/git/mgr/linux v5.19/topic/rk3568-vepu-h264-stateless-bootlin
head:   11fcd09bf7cbe84c3e2e322142e3aff59c5c8402
commit: ec2b92670100c6bd075ca859bc3392b5b913be27 [2/4] media: Introduce Hantro V4L2 H.264 stateless encoding API
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-ctrl-type-h264-encode-params (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-ctrl-type-h264-encode-rc (if the link has no caption the label must precede a section header)
>> Documentation/output/videodev2.h.rst:6: WARNING: undefined label: v4l2-ctrl-type-h264-encode-feedback (if the link has no caption the label must precede a section header)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
