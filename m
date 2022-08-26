Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95055A2F69
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbiHZS4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345543AbiHZSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:55:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1DC04
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661539931; x=1693075931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=COSxgPHDF1QO//PAjTryPLSND40+U0v04W129rm9JsU=;
  b=CuTdrOBUYyMcvuSNZf6/NGLcOxKeH9M1rFlBJM0YXL/3m3ErbDLbYJuE
   MUrFLK+60Tt051NvQPRHjfpjdUIV0Q8+grFYkRireSxfhVBdIWZOdNxxu
   oiOxRrIB373KkUiZKA+NGsMFHgz93xL/OeHhvhDgmn1gCqeXwW/8ztbli
   sEEBm9vzqPlW8V8NYmbaKCfxCKobabx1HxPWkjTnnp9otyp0PZTV7spZ+
   pcN8L35eML9RBckWVACpB/1citzn8ko+9sTZm23ih0IQYPO3Ipy5KAg0l
   Gn3vrwpp5FD8JWjGMv/ch65mWCOqH68SP2uDGBuaSOUrOAkPqUZaiaue7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292152716"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="292152716"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 11:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="938852067"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 11:52:09 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oReR6-0000Hv-2u;
        Fri, 26 Aug 2022 18:52:08 +0000
Date:   Sat, 27 Aug 2022 02:51:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Subject: [matthias-bgg:v6.0-next/soc 11/11]
 drivers/soc/mediatek/mtk-svs.c:887:47: error: implicit declaration of
 function 'FIELD_GET'; did you mean 'FOLL_GET'?
Message-ID: <202208270239.HjU7TSCX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v6.0-next/soc
head:   a92438c5a30a27b6791da025306a45478a6ac7a4
commit: a92438c5a30a27b6791da025306a45478a6ac7a4 [11/11] soc: mediatek: mtk-svs: Use bitfield access macros where possible
config: arm-buildonly-randconfig-r006-20220823 (https://download.01.org/0day-ci/archive/20220827/202208270239.HjU7TSCX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?id=a92438c5a30a27b6791da025306a45478a6ac7a4
        git remote add matthias-bgg https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
        git fetch --no-tags matthias-bgg v6.0-next/soc
        git checkout a92438c5a30a27b6791da025306a45478a6ac7a4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/mediatek/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/mediatek/mtk-svs.c: In function 'svs_get_bank_volts_v3':
>> drivers/soc/mediatek/mtk-svs.c:887:47: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     887 |                         svsb->volt[turn_pt] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
         |                                               ^~~~~~~~~
         |                                               FOLL_GET
   drivers/soc/mediatek/mtk-svs.c: In function 'svs_set_bank_freq_pct_v2':
>> drivers/soc/mediatek/mtk-svs.c:1073:25: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
    1073 |         freqpct74_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[8]) |
         |                         ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +887 drivers/soc/mediatek/mtk-svs.c

   858	
   859	static void svs_get_bank_volts_v3(struct svs_platform *svsp)
   860	{
   861		struct svs_bank *svsb = svsp->pbank;
   862		u32 i, j, *vop, vop74, vop30, turn_pt = svsb->turn_pt;
   863		u32 b_sft, shift_byte = 0, opp_start = 0, opp_stop = 0;
   864		u32 middle_index = (svsb->opp_count / 2);
   865	
   866		if (svsb->phase == SVSB_PHASE_MON &&
   867		    svsb->volt_flags & SVSB_MON_VOLT_IGNORE)
   868			return;
   869	
   870		vop74 = svs_readl_relaxed(svsp, VOP74);
   871		vop30 = svs_readl_relaxed(svsp, VOP30);
   872	
   873		/* Target is to set svsb->volt[] by algorithm */
   874		if (turn_pt < middle_index) {
   875			if (svsb->type == SVSB_HIGH) {
   876				/* volt[0] ~ volt[turn_pt - 1] */
   877				for (i = 0; i < turn_pt; i++) {
   878					b_sft = BITS8 * (shift_byte % REG_BYTES);
   879					vop = (shift_byte < REG_BYTES) ? &vop30 :
   880									 &vop74;
   881					svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
   882					shift_byte++;
   883				}
   884			} else if (svsb->type == SVSB_LOW) {
   885				/* volt[turn_pt] + volt[j] ~ volt[opp_count - 1] */
   886				j = svsb->opp_count - 7;
 > 887				svsb->volt[turn_pt] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
   888				shift_byte++;
   889				for (i = j; i < svsb->opp_count; i++) {
   890					b_sft = BITS8 * (shift_byte % REG_BYTES);
   891					vop = (shift_byte < REG_BYTES) ? &vop30 :
   892									 &vop74;
   893					svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
   894					shift_byte++;
   895				}
   896	
   897				/* volt[turn_pt + 1] ~ volt[j - 1] by interpolate */
   898				for (i = turn_pt + 1; i < j; i++)
   899					svsb->volt[i] = interpolate(svsb->freq_pct[turn_pt],
   900								    svsb->freq_pct[j],
   901								    svsb->volt[turn_pt],
   902								    svsb->volt[j],
   903								    svsb->freq_pct[i]);
   904			}
   905		} else {
   906			if (svsb->type == SVSB_HIGH) {
   907				/* volt[0] + volt[j] ~ volt[turn_pt - 1] */
   908				j = turn_pt - 7;
   909				svsb->volt[0] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
   910				shift_byte++;
   911				for (i = j; i < turn_pt; i++) {
   912					b_sft = BITS8 * (shift_byte % REG_BYTES);
   913					vop = (shift_byte < REG_BYTES) ? &vop30 :
   914									 &vop74;
   915					svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
   916					shift_byte++;
   917				}
   918	
   919				/* volt[1] ~ volt[j - 1] by interpolate */
   920				for (i = 1; i < j; i++)
   921					svsb->volt[i] = interpolate(svsb->freq_pct[0],
   922								    svsb->freq_pct[j],
   923								    svsb->volt[0],
   924								    svsb->volt[j],
   925								    svsb->freq_pct[i]);
   926			} else if (svsb->type == SVSB_LOW) {
   927				/* volt[turn_pt] ~ volt[opp_count - 1] */
   928				for (i = turn_pt; i < svsb->opp_count; i++) {
   929					b_sft = BITS8 * (shift_byte % REG_BYTES);
   930					vop = (shift_byte < REG_BYTES) ? &vop30 :
   931									 &vop74;
   932					svsb->volt[i] = (*vop >> b_sft) & GENMASK(7, 0);
   933					shift_byte++;
   934				}
   935			}
   936		}
   937	
   938		if (svsb->type == SVSB_HIGH) {
   939			opp_start = 0;
   940			opp_stop = svsb->turn_pt;
   941		} else if (svsb->type == SVSB_LOW) {
   942			opp_start = svsb->turn_pt;
   943			opp_stop = svsb->opp_count;
   944		}
   945	
   946		for (i = opp_start; i < opp_stop; i++)
   947			if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
   948				svsb->volt[i] -= svsb->dvt_fixed;
   949	}
   950	
   951	static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
   952	{
   953		struct svs_bank *svsb = svsp->pbank;
   954		u32 i, j, *freq_pct, freq_pct74 = 0, freq_pct30 = 0;
   955		u32 b_sft, shift_byte = 0, turn_pt;
   956		u32 middle_index = (svsb->opp_count / 2);
   957	
   958		for (i = 0; i < svsb->opp_count; i++) {
   959			if (svsb->opp_dfreq[i] <= svsb->turn_freq_base) {
   960				svsb->turn_pt = i;
   961				break;
   962			}
   963		}
   964	
   965		turn_pt = svsb->turn_pt;
   966	
   967		/* Target is to fill out freq_pct74 / freq_pct30 by algorithm */
   968		if (turn_pt < middle_index) {
   969			if (svsb->type == SVSB_HIGH) {
   970				/*
   971				 * If we don't handle this situation,
   972				 * SVSB_HIGH's FREQPCT74 / FREQPCT30 would keep "0"
   973				 * and this leads SVSB_LOW to work abnormally.
   974				 */
   975				if (turn_pt == 0)
   976					freq_pct30 = svsb->freq_pct[0];
   977	
   978				/* freq_pct[0] ~ freq_pct[turn_pt - 1] */
   979				for (i = 0; i < turn_pt; i++) {
   980					b_sft = BITS8 * (shift_byte % REG_BYTES);
   981					freq_pct = (shift_byte < REG_BYTES) ?
   982						   &freq_pct30 : &freq_pct74;
   983					*freq_pct |= (svsb->freq_pct[i] << b_sft);
   984					shift_byte++;
   985				}
   986			} else if (svsb->type == SVSB_LOW) {
   987				/*
   988				 * freq_pct[turn_pt] +
   989				 * freq_pct[opp_count - 7] ~ freq_pct[opp_count -1]
   990				 */
   991				freq_pct30 = svsb->freq_pct[turn_pt];
   992				shift_byte++;
   993				j = svsb->opp_count - 7;
   994				for (i = j; i < svsb->opp_count; i++) {
   995					b_sft = BITS8 * (shift_byte % REG_BYTES);
   996					freq_pct = (shift_byte < REG_BYTES) ?
   997						   &freq_pct30 : &freq_pct74;
   998					*freq_pct |= (svsb->freq_pct[i] << b_sft);
   999					shift_byte++;
  1000				}
  1001			}
  1002		} else {
  1003			if (svsb->type == SVSB_HIGH) {
  1004				/*
  1005				 * freq_pct[0] +
  1006				 * freq_pct[turn_pt - 7] ~ freq_pct[turn_pt - 1]
  1007				 */
  1008				freq_pct30 = svsb->freq_pct[0];
  1009				shift_byte++;
  1010				j = turn_pt - 7;
  1011				for (i = j; i < turn_pt; i++) {
  1012					b_sft = BITS8 * (shift_byte % REG_BYTES);
  1013					freq_pct = (shift_byte < REG_BYTES) ?
  1014						   &freq_pct30 : &freq_pct74;
  1015					*freq_pct |= (svsb->freq_pct[i] << b_sft);
  1016					shift_byte++;
  1017				}
  1018			} else if (svsb->type == SVSB_LOW) {
  1019				/* freq_pct[turn_pt] ~ freq_pct[opp_count - 1] */
  1020				for (i = turn_pt; i < svsb->opp_count; i++) {
  1021					b_sft = BITS8 * (shift_byte % REG_BYTES);
  1022					freq_pct = (shift_byte < REG_BYTES) ?
  1023						   &freq_pct30 : &freq_pct74;
  1024					*freq_pct |= (svsb->freq_pct[i] << b_sft);
  1025					shift_byte++;
  1026				}
  1027			}
  1028		}
  1029	
  1030		svs_writel_relaxed(svsp, freq_pct74, FREQPCT74);
  1031		svs_writel_relaxed(svsp, freq_pct30, FREQPCT30);
  1032	}
  1033	
  1034	static void svs_get_bank_volts_v2(struct svs_platform *svsp)
  1035	{
  1036		struct svs_bank *svsb = svsp->pbank;
  1037		u32 temp, i;
  1038	
  1039		temp = svs_readl_relaxed(svsp, VOP74);
  1040		svsb->volt[14] = FIELD_GET(SVSB_VOPS_FLD_VOP3_7, temp);
  1041		svsb->volt[12] = FIELD_GET(SVSB_VOPS_FLD_VOP2_6, temp);
  1042		svsb->volt[10] = FIELD_GET(SVSB_VOPS_FLD_VOP1_5, temp);
  1043		svsb->volt[8] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, temp);
  1044	
  1045		temp = svs_readl_relaxed(svsp, VOP30);
  1046		svsb->volt[6] = FIELD_GET(SVSB_VOPS_FLD_VOP3_7, temp);
  1047		svsb->volt[4] = FIELD_GET(SVSB_VOPS_FLD_VOP2_6, temp);
  1048		svsb->volt[2] = FIELD_GET(SVSB_VOPS_FLD_VOP1_5, temp);
  1049		svsb->volt[0] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, temp);
  1050	
  1051		for (i = 0; i <= 12; i += 2)
  1052			svsb->volt[i + 1] = interpolate(svsb->freq_pct[i],
  1053							svsb->freq_pct[i + 2],
  1054							svsb->volt[i],
  1055							svsb->volt[i + 2],
  1056							svsb->freq_pct[i + 1]);
  1057	
  1058		svsb->volt[15] = interpolate(svsb->freq_pct[12],
  1059					     svsb->freq_pct[14],
  1060					     svsb->volt[12],
  1061					     svsb->volt[14],
  1062					     svsb->freq_pct[15]);
  1063	
  1064		for (i = 0; i < svsb->opp_count; i++)
  1065			svsb->volt[i] += svsb->volt_od;
  1066	}
  1067	
  1068	static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
  1069	{
  1070		struct svs_bank *svsb = svsp->pbank;
  1071		u32 freqpct74_val, freqpct30_val;
  1072	
> 1073		freqpct74_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[8]) |
  1074				FIELD_PREP(SVSB_FREQPCTS_FLD_PCT1_5, svsb->freq_pct[10]) |
  1075				FIELD_PREP(SVSB_FREQPCTS_FLD_PCT2_6, svsb->freq_pct[12]) |
  1076				FIELD_PREP(SVSB_FREQPCTS_FLD_PCT3_7, svsb->freq_pct[14]);
  1077	
  1078		freqpct30_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[0]) |
  1079				FIELD_PREP(SVSB_FREQPCTS_FLD_PCT1_5, svsb->freq_pct[2]) |
  1080				FIELD_PREP(SVSB_FREQPCTS_FLD_PCT2_6, svsb->freq_pct[4]) |
  1081				FIELD_PREP(SVSB_FREQPCTS_FLD_PCT3_7, svsb->freq_pct[6]);
  1082	
  1083		svs_writel_relaxed(svsp, freqpct74_val, FREQPCT74);
  1084		svs_writel_relaxed(svsp, freqpct30_val, FREQPCT30);
  1085	}
  1086	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
