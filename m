Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D052D4BB0E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiBREuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:50:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiBREua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:50:30 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46914381B5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645159814; x=1676695814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1q9lyZ7SfHxzF/tZG+SDZW03B5Y5ntyuNBRp9lB7juU=;
  b=VfW8/csyX1lGWZ62BbhRVZYcVirGe6rZ5hU8ZdcRdR9+F/DNfjVBJkpY
   ZnzKAaEmb2bkoXIYDOChMTpgz1uf8gd0wpQw1H7oDfe9A1EDFDOjkTvng
   EX2LZ0p9ZzErenWk7NQwDXG0Vw5jR/P1sSh1OEv5x+dMhWCrkyhmF6fCb
   kU/bRdseTaor037Pqz3/ledlrpB07bblVGmR6f+C0cxQOkhayPZnyu/+W
   HX9bR2hBO7UYeaZEZNQ+M3XXVhXAUqRUwxCGLWBflQ43egKIc9vOeikjJ
   uxLzaoA+kdMdih6nSkoIp5YeQeWZ2Jlw+vvL/WDgB+eKXsNAzDNaOx174
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311793122"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="311793122"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635515186"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2022 20:50:12 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKvDf-0000wf-VH; Fri, 18 Feb 2022 04:50:11 +0000
Date:   Fri, 18 Feb 2022 12:49:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 21/24]
 drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool:
 Hal_EfuseReadEFuse88E()+0x6e: relocation to !ENDBR:
 Hal_EfuseReadEFuse88E+0x0
Message-ID: <202202181231.hlZjRGdf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   20f0cd68b8d42470e0a0459aa5db23d7dae8f83d
commit: 885519698e96a729a44a35f71f898d52b11704d7 [21/24] x86/alternative: Use .ibt_endbr_sites to seal indirect calls
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202181231.hlZjRGdf-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=885519698e96a729a44a35f71f898d52b11704d7
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 885519698e96a729a44a35f71f898d52b11704d7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: phy_IQCalibrate_8188E()+0x5b: relocation to !ENDBR: phy_IQCalibrate_8188E+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: odm_RSSIMonitorCheck()+0x46: relocation to !ENDBR: odm_RSSIMonitorCheck+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: FillH2CCmd_88E()+0x4c: relocation to !ENDBR: FillH2CCmd_88E+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: ConstructBeacon()+0x4f: relocation to !ENDBR: ConstructBeacon+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: SetFwRsvdPagePkt.constprop.0()+0x45: relocation to !ENDBR: SetFwRsvdPagePkt.constprop.0+0x0
>> drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: Hal_EfuseReadEFuse88E()+0x6e: relocation to !ENDBR: Hal_EfuseReadEFuse88E+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: iol_read_efuse.constprop.0()+0x5c: relocation to !ENDBR: iol_read_efuse.constprop.0+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: usb_read()+0x4e: relocation to !ENDBR: usb_read+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: usb_write()+0x55: relocation to !ENDBR: usb_write+0x0
>> drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: rtw_set_wpa_ie()+0x4d: relocation to !ENDBR: rtw_set_wpa_ie+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: translate_scan()+0x5e: relocation to !ENDBR: translate_scan+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: rtw_p2p_get_go_device_address.isra.0()+0x51: relocation to !ENDBR: rtw_p2p_get_go_device_address.isra.0+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: rtw_p2p_prov_disc.isra.0()+0x49: relocation to !ENDBR: rtw_p2p_prov_disc.isra.0+0x0
>> drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: rtw_p2p_invite_req.isra.0()+0x53: relocation to !ENDBR: rtw_p2p_invite_req.isra.0+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: lps_ctrl_wk_hdl()+0x3a: relocation to !ENDBR: lps_ctrl_wk_hdl+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: init_channel_list()+0x5b: relocation to !ENDBR: init_channel_list+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: update_hidden_ssid()+0x48: relocation to !ENDBR: update_hidden_ssid+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: process_80211d()+0x53: relocation to !ENDBR: process_80211d+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: issue_p2p_GO_response()+0x5c: relocation to !ENDBR: issue_p2p_GO_response+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: issue_p2p_GO_confirm()+0x4a: relocation to !ENDBR: issue_p2p_GO_confirm+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: on_action_public_p2p()+0x37: relocation to !ENDBR: on_action_public_p2p+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: issue_action_BSSCoexistPacket()+0x4d: relocation to !ENDBR: issue_action_BSSCoexistPacket+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: _issue_probereq_p2p.constprop.0()+0x4b: relocation to !ENDBR: _issue_probereq_p2p.constprop.0+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: _issue_probereq()+0x55: relocation to !ENDBR: _issue_probereq+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: _issue_deauth()+0x4f: relocation to !ENDBR: _issue_deauth+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: issue_p2p_provision_resp()+0x47: relocation to !ENDBR: issue_p2p_provision_resp+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: issue_p2p_presence_resp.constprop.0()+0x41: relocation to !ENDBR: issue_p2p_presence_resp.constprop.0+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: wlanhdr_to_ethhdr()+0x46: relocation to !ENDBR: wlanhdr_to_ethhdr+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: amsdu_to_msdu()+0x56: relocation to !ENDBR: amsdu_to_msdu+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: validate_recv_data_frame()+0x57: relocation to !ENDBR: validate_recv_data_frame+0x0
>> drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: validate_recv_frame()+0x48: relocation to !ENDBR: validate_recv_frame+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: recv_func_posthandle()+0x43: relocation to !ENDBR: recv_func_posthandle+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: phase2()+0x63: relocation to !ENDBR: phase2+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: next_key()+0x48: relocation to !ENDBR: next_key+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: mix_column()+0x50: relocation to !ENDBR: mix_column+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: aes128k128d()+0x53: relocation to !ENDBR: aes128k128d+0x0
>> drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: aes_decipher.isra.0()+0x76: relocation to !ENDBR: aes_decipher.isra.0+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: aes_cipher()+0x66: relocation to !ENDBR: aes_cipher+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: set_qos()+0x3a: relocation to !ENDBR: set_qos+0x0
   drivers/staging/r8188eu/r8188eu.lto.o: warning: objtool: update_attrib()+0x4f: relocation to !ENDBR: update_attrib+0x0

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
