Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C314AC01C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388828AbiBGNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350976AbiBGN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:26:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19247C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644240392; x=1675776392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OhLq9iOaKgngzX2eyZipiDbgiA3qy4PJPJO7vpmnR4A=;
  b=k6aBBTrZtT1ntxWE0+Is8HbdPfpf2Xx8ypza7z9MRgFkAqvtNV4pDkvi
   ykkOgtAen08KGnnnGapBRl7Q+EDewPxXiuYf2vftdI/D6sgoeDwQ6TgS+
   Sb4GBIbUscRb1g9w7lbCYGCga4BcZkBWIIthCr8wyjCyRJRHnhO33IxD2
   Iv3ck/w4LPmwDvaKhlraX/rf1EXNIA0cHOOsHFVRYa6a0PhJbWaeYbRyp
   tWUWhR7HvspU9eIZ9Wo9GCK7Z7vWCOHQFY3t3f0TXDZFRhC1vZM3CHta4
   htfpBvyz7fkCHzVkneiPTd8Fe3L976sKT9/LuQUn4XPf7LlKpP20OWYio
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="246303119"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="246303119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 05:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="621550973"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2022 05:26:30 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH42H-0000ZD-MQ; Mon, 07 Feb 2022 13:26:29 +0000
Date:   Mon, 7 Feb 2022 21:25:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/media/dvb-frontends/stv0367.c:995:12: warning: stack frame
 size (9464) exceeds limit (8192) in 'stv0367ter_algo'
Message-ID: <202202072142.Mdz2lNT9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfd42facf1e4ada021b939b4e19c935dcdd55566
commit: a52f8a59aef46b59753e583bf4b28fccb069ce64 fortify: Explicitly disable Clang support
date:   5 months ago
config: x86_64-randconfig-r034-20220207 (https://download.01.org/0day-ci/archive/20220207/202202072142.Mdz2lNT9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0d8850ae2cae85d49bea6ae0799fa41c7202c05c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a52f8a59aef46b59753e583bf4b28fccb069ce64
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a52f8a59aef46b59753e583bf4b28fccb069ce64
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/dvb-frontends/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/dvb-frontends/stv0367.c:995:12: warning: stack frame size (9464) exceeds limit (8192) in 'stv0367ter_algo' [-Wframe-larger-than]
   static int stv0367ter_algo(struct dvb_frontend *fe)
              ^
>> drivers/media/dvb-frontends/stv0367.c:2540:12: warning: stack frame size (9368) exceeds limit (8192) in 'stv0367cab_set_frontend' [-Wframe-larger-than]
   static int stv0367cab_set_frontend(struct dvb_frontend *fe)
              ^
   2 warnings generated.


vim +/stv0367ter_algo +995 drivers/media/dvb-frontends/stv0367.c

17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25   994  
285d55ad5f2cc0 drivers/media/dvb/frontends/stv0367.c Mauro Carvalho Chehab 2011-12-26  @995  static int stv0367ter_algo(struct dvb_frontend *fe)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25   996  {
285d55ad5f2cc0 drivers/media/dvb/frontends/stv0367.c Mauro Carvalho Chehab 2011-12-26   997  	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25   998  	struct stv0367_state *state = fe->demodulator_priv;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25   999  	struct stv0367ter_state *ter_state = state->ter_state;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1000  	int offset = 0, tempo = 0;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1001  	u8 u_var;
df1ec0272fd49a drivers/media/dvb/frontends/stv0367.c Peter Senna Tschudin  2012-06-14  1002  	u8 /*constell,*/ counter;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1003  	s8 step;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1004  	s32 timing_offset = 0;
b16338e3d346ce drivers/media/dvb-frontends/stv0367.c Daniel Scheller       2017-03-29  1005  	u32 trl_nomrate = 0, InternalFreq = 0, temp = 0, ifkhz = 0;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1006  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1007  	dprintk("%s:\n", __func__);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1008  
b16338e3d346ce drivers/media/dvb-frontends/stv0367.c Daniel Scheller       2017-03-29  1009  	stv0367_get_if_khz(state, &ifkhz);
b16338e3d346ce drivers/media/dvb-frontends/stv0367.c Daniel Scheller       2017-03-29  1010  
285d55ad5f2cc0 drivers/media/dvb/frontends/stv0367.c Mauro Carvalho Chehab 2011-12-26  1011  	ter_state->frequency = p->frequency;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1012  	ter_state->force = FE_TER_FORCENONE
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1013  			+ stv0367_readbits(state, F367TER_FORCE) * 2;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1014  	ter_state->if_iq_mode = state->config->if_iq_mode;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1015  	switch (state->config->if_iq_mode) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1016  	case FE_TER_NORMAL_IF_TUNER:  /* Normal IF mode */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1017  		dprintk("ALGO: FE_TER_NORMAL_IF_TUNER selected\n");
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1018  		stv0367_writebits(state, F367TER_TUNER_BB, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1019  		stv0367_writebits(state, F367TER_LONGPATH_IF, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1020  		stv0367_writebits(state, F367TER_DEMUX_SWAP, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1021  		break;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1022  	case FE_TER_LONGPATH_IF_TUNER:  /* Long IF mode */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1023  		dprintk("ALGO: FE_TER_LONGPATH_IF_TUNER selected\n");
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1024  		stv0367_writebits(state, F367TER_TUNER_BB, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1025  		stv0367_writebits(state, F367TER_LONGPATH_IF, 1);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1026  		stv0367_writebits(state, F367TER_DEMUX_SWAP, 1);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1027  		break;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1028  	case FE_TER_IQ_TUNER:  /* IQ mode */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1029  		dprintk("ALGO: FE_TER_IQ_TUNER selected\n");
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1030  		stv0367_writebits(state, F367TER_TUNER_BB, 1);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1031  		stv0367_writebits(state, F367TER_PPM_INVSEL, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1032  		break;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1033  	default:
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1034  		printk(KERN_ERR "ALGO: wrong TUNER type selected\n");
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1035  		return -EINVAL;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1036  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1037  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1038  	usleep_range(5000, 7000);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1039  
285d55ad5f2cc0 drivers/media/dvb/frontends/stv0367.c Mauro Carvalho Chehab 2011-12-26  1040  	switch (p->inversion) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1041  	case INVERSION_AUTO:
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1042  	default:
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1043  		dprintk("%s: inversion AUTO\n", __func__);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1044  		if (ter_state->if_iq_mode == FE_TER_IQ_TUNER)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1045  			stv0367_writebits(state, F367TER_IQ_INVERT,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1046  						ter_state->sense);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1047  		else
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1048  			stv0367_writebits(state, F367TER_INV_SPECTR,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1049  						ter_state->sense);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1050  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1051  		break;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1052  	case INVERSION_ON:
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1053  	case INVERSION_OFF:
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1054  		if (ter_state->if_iq_mode == FE_TER_IQ_TUNER)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1055  			stv0367_writebits(state, F367TER_IQ_INVERT,
285d55ad5f2cc0 drivers/media/dvb/frontends/stv0367.c Mauro Carvalho Chehab 2011-12-26  1056  						p->inversion);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1057  		else
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1058  			stv0367_writebits(state, F367TER_INV_SPECTR,
285d55ad5f2cc0 drivers/media/dvb/frontends/stv0367.c Mauro Carvalho Chehab 2011-12-26  1059  						p->inversion);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1060  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1061  		break;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1062  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1063  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1064  	if ((ter_state->if_iq_mode != FE_TER_NORMAL_IF_TUNER) &&
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1065  				(ter_state->pBW != ter_state->bw)) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1066  		stv0367ter_agc_iir_lock_detect_set(state);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1067  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1068  		/*set fine agc target to 180 for LPIF or IQ mode*/
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1069  		/* set Q_AGCTarget */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1070  		stv0367_writebits(state, F367TER_SEL_IQNTAR, 1);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1071  		stv0367_writebits(state, F367TER_AUT_AGC_TARGET_MSB, 0xB);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1072  		/*stv0367_writebits(state,AUT_AGC_TARGET_LSB,0x04); */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1073  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1074  		/* set Q_AGCTarget */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1075  		stv0367_writebits(state, F367TER_SEL_IQNTAR, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1076  		stv0367_writebits(state, F367TER_AUT_AGC_TARGET_MSB, 0xB);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1077  		/*stv0367_writebits(state,AUT_AGC_TARGET_LSB,0x04); */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1078  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1079  		if (!stv0367_iir_filt_init(state, ter_state->bw,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1080  						state->config->xtal))
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1081  			return -EINVAL;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1082  		/*set IIR filter once for 6,7 or 8MHz BW*/
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1083  		ter_state->pBW = ter_state->bw;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1084  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1085  		stv0367ter_agc_iir_rst(state);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1086  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1087  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1088  	if (ter_state->hierarchy == FE_TER_HIER_LOW_PRIO)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1089  		stv0367_writebits(state, F367TER_BDI_LPSEL, 0x01);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1090  	else
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1091  		stv0367_writebits(state, F367TER_BDI_LPSEL, 0x00);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1092  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1093  	InternalFreq = stv0367ter_get_mclk(state, state->config->xtal) / 1000;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1094  	temp = (int)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1095  		((((ter_state->bw * 64 * (1 << 15) * 100)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1096  						/ (InternalFreq)) * 10) / 7);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1097  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1098  	stv0367_writebits(state, F367TER_TRL_NOMRATE_LSB, temp % 2);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1099  	temp = temp / 2;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1100  	stv0367_writebits(state, F367TER_TRL_NOMRATE_HI, temp / 256);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1101  	stv0367_writebits(state, F367TER_TRL_NOMRATE_LO, temp % 256);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1102  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1103  	temp = stv0367_readbits(state, F367TER_TRL_NOMRATE_HI) * 512 +
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1104  			stv0367_readbits(state, F367TER_TRL_NOMRATE_LO) * 2 +
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1105  			stv0367_readbits(state, F367TER_TRL_NOMRATE_LSB);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1106  	temp = (int)(((1 << 17) * ter_state->bw * 1000) / (7 * (InternalFreq)));
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1107  	stv0367_writebits(state, F367TER_GAIN_SRC_HI, temp / 256);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1108  	stv0367_writebits(state, F367TER_GAIN_SRC_LO, temp % 256);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1109  	temp = stv0367_readbits(state, F367TER_GAIN_SRC_HI) * 256 +
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1110  			stv0367_readbits(state, F367TER_GAIN_SRC_LO);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1111  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1112  	temp = (int)
b16338e3d346ce drivers/media/dvb-frontends/stv0367.c Daniel Scheller       2017-03-29  1113  		((InternalFreq - ifkhz) * (1 << 16) / (InternalFreq));
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1114  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1115  	dprintk("DEROT temp=0x%x\n", temp);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1116  	stv0367_writebits(state, F367TER_INC_DEROT_HI, temp / 256);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1117  	stv0367_writebits(state, F367TER_INC_DEROT_LO, temp % 256);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1118  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1119  	ter_state->echo_pos = 0;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1120  	ter_state->ucblocks = 0; /* liplianin */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1121  	ter_state->pBER = 0; /* liplianin */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1122  	stv0367_writebits(state, F367TER_LONG_ECHO, ter_state->echo_pos);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1123  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1124  	if (stv0367ter_lock_algo(state) != FE_TER_LOCKOK)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1125  		return 0;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1126  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1127  	ter_state->state = FE_TER_LOCKOK;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1128  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1129  	ter_state->mode = stv0367_readbits(state, F367TER_SYR_MODE);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1130  	ter_state->guard = stv0367_readbits(state, F367TER_SYR_GUARD);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1131  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1132  	ter_state->first_lock = 1; /* we know sense now :) */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1133  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1134  	ter_state->agc_val =
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1135  			(stv0367_readbits(state, F367TER_AGC1_VAL_LO) << 16) +
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1136  			(stv0367_readbits(state, F367TER_AGC1_VAL_HI) << 24) +
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1137  			stv0367_readbits(state, F367TER_AGC2_VAL_LO) +
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1138  			(stv0367_readbits(state, F367TER_AGC2_VAL_HI) << 8);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1139  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1140  	/* Carrier offset calculation */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1141  	stv0367_writebits(state, F367TER_FREEZE, 1);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1142  	offset = (stv0367_readbits(state, F367TER_CRL_FOFFSET_VHI) << 16) ;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1143  	offset += (stv0367_readbits(state, F367TER_CRL_FOFFSET_HI) << 8);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1144  	offset += (stv0367_readbits(state, F367TER_CRL_FOFFSET_LO));
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1145  	stv0367_writebits(state, F367TER_FREEZE, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1146  	if (offset > 8388607)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1147  		offset -= 16777216;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1148  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1149  	offset = offset * 2 / 16384;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1150  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1151  	if (ter_state->mode == FE_TER_MODE_2K)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1152  		offset = (offset * 4464) / 1000;/*** 1 FFT BIN=4.464khz***/
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1153  	else if (ter_state->mode == FE_TER_MODE_4K)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1154  		offset = (offset * 223) / 100;/*** 1 FFT BIN=2.23khz***/
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1155  	else  if (ter_state->mode == FE_TER_MODE_8K)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1156  		offset = (offset * 111) / 100;/*** 1 FFT BIN=1.1khz***/
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1157  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1158  	if (stv0367_readbits(state, F367TER_PPM_INVSEL) == 1) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1159  		if ((stv0367_readbits(state, F367TER_INV_SPECTR) ==
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1160  				(stv0367_readbits(state,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1161  					F367TER_STATUS_INV_SPECRUM) == 1)))
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1162  			offset = offset * -1;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1163  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1164  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1165  	if (ter_state->bw == 6)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1166  		offset = (offset * 6) / 8;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1167  	else if (ter_state->bw == 7)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1168  		offset = (offset * 7) / 8;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1169  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1170  	ter_state->frequency += offset;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1171  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1172  	tempo = 10;  /* exit even if timing_offset stays null */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1173  	while ((timing_offset == 0) && (tempo > 0)) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1174  		usleep_range(10000, 20000);	/*was 20ms  */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1175  		/* fine tuning of timing offset if required */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1176  		timing_offset = stv0367_readbits(state, F367TER_TRL_TOFFSET_LO)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1177  				+ 256 * stv0367_readbits(state,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1178  							F367TER_TRL_TOFFSET_HI);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1179  		if (timing_offset >= 32768)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1180  			timing_offset -= 65536;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1181  		trl_nomrate = (512 * stv0367_readbits(state,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1182  							F367TER_TRL_NOMRATE_HI)
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1183  			+ stv0367_readbits(state, F367TER_TRL_NOMRATE_LO) * 2
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1184  			+ stv0367_readbits(state, F367TER_TRL_NOMRATE_LSB));
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1185  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1186  		timing_offset = ((signed)(1000000 / trl_nomrate) *
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1187  							timing_offset) / 2048;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1188  		tempo--;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1189  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1190  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1191  	if (timing_offset <= 0) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1192  		timing_offset = (timing_offset - 11) / 22;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1193  		step = -1;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1194  	} else {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1195  		timing_offset = (timing_offset + 11) / 22;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1196  		step = 1;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1197  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1198  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1199  	for (counter = 0; counter < abs(timing_offset); counter++) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1200  		trl_nomrate += step;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1201  		stv0367_writebits(state, F367TER_TRL_NOMRATE_LSB,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1202  						trl_nomrate % 2);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1203  		stv0367_writebits(state, F367TER_TRL_NOMRATE_LO,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1204  						trl_nomrate / 2);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1205  		usleep_range(1000, 2000);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1206  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1207  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1208  	usleep_range(5000, 6000);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1209  	/* unlocks could happen in case of trl centring big step,
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1210  	then a core off/on restarts demod */
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1211  	u_var = stv0367_readbits(state, F367TER_LK);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1212  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1213  	if (!u_var) {
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1214  		stv0367_writebits(state, F367TER_CORE_ACTIVE, 0);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1215  		msleep(20);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1216  		stv0367_writebits(state, F367TER_CORE_ACTIVE, 1);
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1217  	}
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1218  
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1219  	return 0;
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1220  }
17cce932e8be9a drivers/media/dvb/frontends/stv0367.c Igor M. Liplianin     2011-01-25  1221  

:::::: The code at line 995 was first introduced by commit
:::::: 285d55ad5f2cc0b8a316c3574e2faa0a5b45bd0f [media] stv0367: convert set_fontend to use DVBv5 parameters

:::::: TO: Mauro Carvalho Chehab <mchehab@redhat.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
