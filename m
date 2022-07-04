Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0246F5657B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiGDNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiGDNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:46:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A53881;
        Mon,  4 Jul 2022 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656942397; x=1688478397;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5zUYi9hFulEcq18gTTEqTPTIMNxqSPUj8pcIbAxujCQ=;
  b=bodWifa0DY6uZtX1FrdUsnLzejJzV4saDpWDIX5Dw01U3IbJeGlRSQGu
   S6fjcyAh23l88hnd8fQcqDqCs2mIoKw/i5UU931JHPmmeDcYGl0JxGUdz
   qpOuAvycRXQWqsyPuZ6Tei9sJkQJd6u0Da7znlG01XRlTMRv8H3Y/RNbs
   tQ6dqlp/bC7Ar2lzbhPqYtT3Rc2lwhPVEF0zyMBvwDdKvT1WdgCLy/bfc
   /jMTuUhet4cAD/IfXXp3T/wu7pu4HS982LllywcV43E46clyKQXFHkyB9
   PBZxXHLkRgkV1W/CzmcLynnI0deukS8hGXRLssouUQas2tnq7xPBKO4XV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="308668191"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="308668191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 06:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="542594346"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 06:46:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8MPI-000HvB-Vz;
        Mon, 04 Jul 2022 13:46:32 +0000
Date:   Mon, 4 Jul 2022 21:46:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-doc@vger.kernel.org
Subject: htmldocs: Documentation/leds/leds-qcom-lpg.rst: WARNING: document
 isn't included in any toctree
Message-ID: <202207042124.UDWeFBUb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88084a3df1672e131ddc1b4e39eeacfd39864acf
commit: 24e2d05d1b68981f22c984c766fabc5a93c83dba leds: Add driver for Qualcomm LPG
date:   9 weeks ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
