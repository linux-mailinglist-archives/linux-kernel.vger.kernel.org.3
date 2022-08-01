Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D3586FBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiHARrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiHARrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:47:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD582A71C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659376062; x=1690912062;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d1tYTsp95n8Spsdrl2hf4UlQdR9GEgA0rx3KEAZ315U=;
  b=mG7GFRlZOjnDBjJXp+2Hi7ibysIQB2CAYiUi0c56IIGx65LNe0d2IGEJ
   Gup6IdBTv4H+vgYQTClz9pkjxqGiX+NV/CyNKNKiX/hsxUBmg1VZWD7UT
   d9S7rVpLZYpMPG7Bdov5oK4MqEoP/zI1Nm6gLYzDQAQEcrBZubsUxxVSe
   rliW4rEQ9C3K6Wh4940SMkky466jQNOLlTO8WL+9AuR33kjlJfDT4v8Vh
   XV810Wet1TYLQqnx6R1KIr/iHM/8CqyKcM9qzN2h6QBG7h51EWyI1Aka5
   v8QsZ/EQk3wSwFetzb7K0jn74qCElh2qVDw2MCnoamEfK1RQ/43Cn5hSc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315038912"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="315038912"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="929642179"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2022 10:47:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIZW0-000FCC-1M;
        Mon, 01 Aug 2022 17:47:40 +0000
Date:   Tue, 2 Aug 2022 01:47:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lina Wang <lina.wang@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maciej enczykowski <maze@google.com>
Subject: error: unable to open output file 'kselftest/net/bpf/nat6to4.o': 'No
 such file or directory'
Message-ID: <202208020112.9k23Y19d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0fac198def2b41138850867b6aa92044c76ff802
commit: edae34a3ed9293b5077dddf9e51a3d86c95dc76a selftests net: add UDP GRO fraglist + bpf self-tests
date:   3 months ago
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edae34a3ed9293b5077dddf9e51a3d86c95dc76a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout edae34a3ed9293b5077dddf9e51a3d86c95dc76a
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: unable to open output file 'kselftest/net/bpf/nat6to4.o': 'No such file or directory'
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
