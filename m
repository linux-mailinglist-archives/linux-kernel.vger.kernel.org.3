Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8191A4F74B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiDGEa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiDGEaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:30:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A39A9BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 21:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649305702; x=1680841702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XrW9SXojce5RjrVNbIRPCRINFxKG9EhgsLK2JOGi9H4=;
  b=fwm91ovRkCA5sltYVtq2VLaIVT9NdvD0TYReC0tbZ43tfkIf25gQ7Bew
   JxbbKGgHZtzaecyGDfjMckTI0WzJAd8t05W91ttuy+5GEimBs1TF6sGRw
   JC7RQW3q35/hczsVQFbmHTaExzhp7AJPq7MaXBuFTUfPE5XyEBeIbaQAx
   HheRqgGxK1+zMVaZJEAZ9YEj2vgRvzqn06z3OKiuVjkqObaR8BLxJLmmA
   Mybg3Rv1p22Ys+fZADlAD5oB0TcJm599vEakwXjdtsHFgS7bJRc6UhLea
   AXFOhYm0WltwfeEGWaBU/lcLwHkX7U6O9DOJZMOrejiGslOv7zQjiyrbH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324389831"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="324389831"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 21:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="588652082"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2022 21:28:20 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncJkq-000546-50;
        Thu, 07 Apr 2022 04:28:20 +0000
Date:   Thu, 7 Apr 2022 12:28:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:extron 101/124]
 ./usr/include/linux/cec.h:150:19: error: unknown type name 'bool'
Message-ID: <202204071243.QQM5gyph-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

FYI, the error/warning still remains.

tree:   git://linuxtv.org/hverkuil/media_tree.git extron
head:   b74048be758a379d7414219b0223bc85b848ccc7
commit: d679f6adf24b7fef91e8a3b3584b48587e9cf0a2 [101/124] cec.h: add cec_msg_recv_is_tx_result() helper
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220407/202204071243.QQM5gyph-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree extron
        git checkout d679f6adf24b7fef91e8a3b3584b48587e9cf0a2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/cec-funcs.h:11,
                    from <command-line>:
>> ./usr/include/linux/cec.h:150:19: error: unknown type name 'bool'
     150 | static __inline__ bool cec_msg_recv_is_tx_result(const struct cec_msg *msg)
         |                   ^~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
