Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63958B137
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiHEVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiHEVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:43:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2523C14D;
        Fri,  5 Aug 2022 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659735815; x=1691271815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NpludD3pNBFukze8ah1npXAw02fk1Yx2nd1X/2H0KSo=;
  b=ifYozoWtvOqHj21NsAaV6LMyiPRFwvE4nrFlpdo3B6Unxc/XbP03liw4
   fPn1y2GAC5tXscQmz/CzaERCl/C6buLO4cZ0stxflV0C105sDJgCJ/lvs
   UR2wfzsYrK0XUxTGSsGOlaw+JitimyLdki+H04WsXRmLRSX9urZDf2gdu
   hNldwSoI4aYkP4HkFH+PTB/DiVOH+aWD/2OtLRdX2hBYSRWQ1lltM+TAZ
   co239s7ivLRYPrSVmqTRXd8gy94lF/gHPzAT12dlagZlSYtbRLjsAK8s8
   XFVqvtgLrVkj/0zPwWYVjxOszqWs0BXRJPjOOUKM6a1qzCGqMS6XtDqAX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270684116"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270684116"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 14:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671830664"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2022 14:43:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK56T-000Jl3-0o;
        Fri, 05 Aug 2022 21:43:33 +0000
Date:   Sat, 6 Aug 2022 05:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc:     kbuild-all@lists.01.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH 4/5] asus-wmi: Document many of the undocumented API
Message-ID: <202208060544.FBvHeTue-lkp@intel.com>
References: <20220805081909.10962-5-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805081909.10962-5-luke@ljones.dev>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Luke,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.19]
[cannot apply to linus/master next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/asus-wmi-Add-support-for-RGB-keyboards/20220805-162136
base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-platform-asus-wmi:71: WARNING: Unexpected indentation.

vim +71 Documentation/ABI/testing/sysfs-platform-asus-wmi

  > 71	Date:		Dec 2022
    72	KernelVersion:	5.17
    73	Contact:	"Luke Jones" <luke@ljones.dev>
    74	Description:
    75			Enable the external GPU paired with ROG X-Flow laptops.
    76			Toggling this setting will also trigger ACPI to disable the dGPU:
    77				* 0 - Disable,
    78				* 1 - Enable,
    79	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
