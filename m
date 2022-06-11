Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425954776F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiFKUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiFKUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:09:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3DD50E2E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654978185; x=1686514185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Olh02j3wi2fQZDkwNjfefhjGDhiY15t33SL5mIHfbKo=;
  b=Rdu0KfBGEDj+T793h8mbAPC0IooJtAKEAFv6iqPYERcM6avfZuno57CC
   1SCpCNtho9jkei0rDChNHYDOACeyZHW0npo8iw9lNxTvDCWcqze81sw/H
   lYHQyYuL6iPARXtHORWLaAH9EpAmiiJLpqvXXpEOVUlh2gD723mdl7Y+m
   He1IBYTku4wAbN7I/FejVW+Z4kNKdmPKjLc9pavqSGUu3JbheGzSr9cJ/
   z5ysnQG+YHUbSv7huTV1EzIPfcLxrUbJXzRhLu/4fE85Anc03VoFivA1A
   kTBCGfcMmo4ryq211TeWnHBtBl9yyTdZD9nNQi8+Ng0wPYBh0adOXRLL0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="276711232"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="276711232"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 13:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="611185440"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2022 13:09:41 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o07QS-000JFS-Od;
        Sat, 11 Jun 2022 20:09:40 +0000
Date:   Sun, 12 Jun 2022 04:09:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/ath12k-bringup 29/59]
 drivers/net/wireless/ath/ath12k/pci.c:667:14: error: implicit declaration of
 function 'of_property_read_u32'
Message-ID: <202206120434.r1vyzSDI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasanthakumar,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/ath12k-bringup
head:   56d7bae345221fbbbabd4742151baf4d21e4822d
commit: f40abb4788a2a3868606a29d99583421e0874350 [29/59] ath12k: New driver for Qualcomm 11be hw family
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220612/202206120434.r1vyzSDI-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f40abb4788a2a3868606a29d99583421e0874350
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/ath12k-bringup
        git checkout f40abb4788a2a3868606a29d99583421e0874350
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/wireless/ath/ath12k/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath12k/pci.c: In function 'ath12k_pci_init_qmi_ce_config':
>> drivers/net/wireless/ath/ath12k/pci.c:667:14: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
     667 |         if (!of_property_read_u32(ab->dev->of_node, "qrtr_instance_id", &instance_id))
         |              ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/of_property_read_u32 +667 drivers/net/wireless/ath/ath12k/pci.c

   655	
   656	static void ath12k_pci_init_qmi_ce_config(struct ath12k_base *ab)
   657	{
   658		struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
   659		u32 instance_id = 0;
   660	
   661		cfg->tgt_ce = ab->hw_params.target_ce_config;
   662		cfg->tgt_ce_len = ab->hw_params.target_ce_count;
   663	
   664		cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
   665		cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
   666		ab->qmi.service_ins_id = ab->hw_params.qmi_service_ins_id;
 > 667		if (!of_property_read_u32(ab->dev->of_node, "qrtr_instance_id", &instance_id))
   668			ab->qmi.service_ins_id = instance_id + ATH12K_QMI_WLFW_NODE_ID_BASE;
   669	}
   670	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
