Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C034F1E43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379923AbiDDVrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379978AbiDDSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:31:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F501FA54
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649096986; x=1680632986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wrQWjw2RP2YIFawm/mVUoehDsL24l0yV/tsQe+E2Kow=;
  b=jVf1p18aJ/GmEYPybuPBXsfGvunFQaSeQKTY1svZNFEinG7GXPC7CFgo
   mpRFaDWyMvMaRU/E0K8RMPTxOjqBDJ5I905kCb53B9VNM4Rz8c0nswVzs
   s4/RFhrnEcegv5uLI+868uGHTyewv+BB8VsPObmvR/pFrbw7udLa7U9Xt
   pf34AYMBqm3TTp224j2Mo3PIyj+jgShMJ7gtlEuLuNBfNXG/5OijClhsN
   47uSGWdF8e3Hj+SBqpo8LZML8xBPtnUUhtyqksx2D5YUu0jdNbwOfiGdN
   u3FoSX9OGI0fMFpInINrsn+nsXKurayHEYu8dn4Yr4nHxrGCC4L8s40yp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347022583"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="347022583"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 11:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="721749996"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Apr 2022 11:29:30 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbRSD-0002H4-Qq;
        Mon, 04 Apr 2022 18:29:29 +0000
Date:   Tue, 5 Apr 2022 02:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/media/dvb-frontends/stv0367.c:995:12: warning: stack frame
 size (9464) exceeds limit (8192) in 'stv0367ter_algo'
Message-ID: <202204050247.aAIGVxqc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: a52f8a59aef46b59753e583bf4b28fccb069ce64 fortify: Explicitly disable Clang support
date:   6 months ago
config: x86_64-randconfig-r031-20220404 (https://download.01.org/0day-ci/archive/20220405/202204050247.aAIGVxqc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a52f8a59aef46b59753e583bf4b28fccb069ce64
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a52f8a59aef46b59753e583bf4b28fccb069ce64
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/dvb-frontends/ drivers/usb/gadget/udc/ drivers/usb/host/

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
--
>> drivers/usb/host/max3421-hcd.c:1378:1: warning: stack frame size (11288) exceeds limit (8192) in 'max3421_spi_thread' [-Wframe-larger-than]
   max3421_spi_thread(void *dev_id)
   ^
   1 warning generated.
--
>> drivers/usb/gadget/udc/max3420_udc.c:841:12: warning: stack frame size (13976) exceeds limit (8192) in 'max3420_thread' [-Wframe-larger-than]
   static int max3420_thread(void *dev_id)
              ^
   1 warning generated.


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
