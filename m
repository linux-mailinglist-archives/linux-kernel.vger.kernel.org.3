Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5FE4E8BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiC1BgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiC1Bfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:35:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A822BD3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648431254; x=1679967254;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3KHGE+WqhvAZT5kNAoIUyMV4hgYav51qW1Y/FDQV68=;
  b=Yki9Uxhf0r6pdeK1KLNGTJE313RnPTEkLOLb21njPzNWifpZmCBWQcJk
   7x70PwVlhFlokWcSY9Lzn/5fk3A4R1InV/SZEjbEhmggCjhhRFsaRp/vE
   17yyR4CHfdYDDKYl58BrrN/Ltca2IJPig6DrhH4spsy24UXBMyQon2hj3
   nFiPXJKzmTFL1Cqc+fd3KmL0LVvX1W/k8tKP0/mF6OAiGYe94Ibp5R+Hm
   XWuythNB5jGD2PGGUnJbXV+OjVU9fXuZ21pD1IDn+ERW1Fhjr9NI6Z8g/
   0BFqGQkwHpYP/T69qNBsfFBbhVC7C0eP+jMEd9WUBH64GVfIxi5tstE+Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="258858061"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="258858061"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 18:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="651407208"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2022 18:34:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYeGq-0001cb-Co; Mon, 28 Mar 2022 01:34:12 +0000
Date:   Mon, 28 Mar 2022 09:33:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steve French <stfrench@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [samba-ksmbd:for-next 16/16] fs/cifs/cifsfs.c:709:30: warning:
 implicit conversion from 'enum statusEnum' to 'enum tid_status_enum'
Message-ID: <202203280919.pdULZ8dR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git for-next
head:   7e5c8c02911ba8d7e61d4fbd130215318343cf60
commit: 7e5c8c02911ba8d7e61d4fbd130215318343cf60 [16/16] smb3: cleanup and clarify status of tree connections
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220328/202203280919.pdULZ8dR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add samba-ksmbd git://git.samba.org/ksmbd.git
        git fetch --no-tags samba-ksmbd for-next
        git checkout 7e5c8c02911ba8d7e61d4fbd130215318343cf60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/cifs/cifsfs.c: In function 'cifs_umount_begin':
>> fs/cifs/cifsfs.c:709:30: warning: implicit conversion from 'enum statusEnum' to 'enum tid_status_enum' [-Wenum-conversion]
     709 |                 tcon->status = CifsExiting;
         |                              ^


vim +709 fs/cifs/cifsfs.c

   690	
   691	static void cifs_umount_begin(struct super_block *sb)
   692	{
   693		struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
   694		struct cifs_tcon *tcon;
   695	
   696		if (cifs_sb == NULL)
   697			return;
   698	
   699		tcon = cifs_sb_master_tcon(cifs_sb);
   700	
   701		spin_lock(&cifs_tcp_ses_lock);
   702		if ((tcon->tc_count > 1) || (tcon->status == TID_EXITING)) {
   703			/* we have other mounts to same share or we have
   704			   already tried to force umount this and woken up
   705			   all waiting network requests, nothing to do */
   706			spin_unlock(&cifs_tcp_ses_lock);
   707			return;
   708		} else if (tcon->tc_count == 1)
 > 709			tcon->status = CifsExiting;
   710		spin_unlock(&cifs_tcp_ses_lock);
   711	
   712		/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
   713		/* cancel_notify_requests(tcon); */
   714		if (tcon->ses && tcon->ses->server) {
   715			cifs_dbg(FYI, "wake up tasks now - umount begin not complete\n");
   716			wake_up_all(&tcon->ses->server->request_q);
   717			wake_up_all(&tcon->ses->server->response_q);
   718			msleep(1); /* yield */
   719			/* we have to kick the requests once more */
   720			wake_up_all(&tcon->ses->server->response_q);
   721			msleep(1);
   722		}
   723	
   724		return;
   725	}
   726	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
