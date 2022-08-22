Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB94259C151
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiHVOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiHVOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:06:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D725290;
        Mon, 22 Aug 2022 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661177168; x=1692713168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TLxCowTuiycxIkNM4i5ZvR8SCdmJF+q2NSnhQlqLy2o=;
  b=ajS2tn7k87EzQkGf1k9HJiZErqK73B4/n4sLoVpq9TFc/1gHy9BvPGJ3
   N4OTK4aevVxkxsO3DNnqQEunF2dMfkjoE8MEfQTkoLE1K8VGh0tlm8PlL
   6qxxab8cRYnpmERETsBHAQ//A2hH5ui+NDw9UyMczijVj+KDPn8co2in4
   L9EyoI/ybw9jCd9alSQIT+c2CPq0TaLdbD3D1u5n+p9dyv5CHR+ohww1Y
   JcX+NQRemoLiHThUg2xLsbavHg/pBzIJKij6I5AnzZb66cM82eXto6fFU
   xJY5IKdm1638mlMZZjSZqBLKzwKLHvqodw3f7Wi8FqeEAGVxokiGc78nx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294209621"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294209621"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 07:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698297865"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 07:05:38 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ83d-0000CX-1L;
        Mon, 22 Aug 2022 14:05:37 +0000
Date:   Mon, 22 Aug 2022 22:05:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     kbuild-all@lists.01.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] soc: qcom: qmi: use const for struct qmi_elem_info
Message-ID: <202208222141.fcwTIcFt-lkp@intel.com>
References: <20220822064648.30794-1-quic_jjohnson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822064648.30794-1-quic_jjohnson@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc2 next-20220822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Johnson/soc-qcom-qmi-use-const-for-struct-qmi_elem_info/20220822-144905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1c23f9e627a7b412978b4e852793c5e3c3efc555
config: nios2-randconfig-s051-20220821 (https://download.01.org/0day-ci/archive/20220822/202208222141.fcwTIcFt-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/84f0de3071b40fad5e5a48ad27b16ce28f9210fb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeff-Johnson/soc-qcom-qmi-use-const-for-struct-qmi_elem_info/20220822-144905
        git checkout 84f0de3071b40fad5e5a48ad27b16ce28f9210fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/qcom/qmi_encdec.c:94:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected struct qmi_elem_info * @@     got struct qmi_elem_info const *[assigned] temp_ei @@
   drivers/soc/qcom/qmi_encdec.c:94:16: sparse:     expected struct qmi_elem_info *
   drivers/soc/qcom/qmi_encdec.c:94:16: sparse:     got struct qmi_elem_info const *[assigned] temp_ei

vim +94 drivers/soc/qcom/qmi_encdec.c

9b8a11e8261527 Bjorn Andersson 2017-12-05  59  
84f0de3071b40f Jeff Johnson    2022-08-21  60  static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
9b8a11e8261527 Bjorn Andersson 2017-12-05  61  		      const void *in_c_struct, u32 out_buf_len,
9b8a11e8261527 Bjorn Andersson 2017-12-05  62  		      int enc_level);
9b8a11e8261527 Bjorn Andersson 2017-12-05  63  
84f0de3071b40f Jeff Johnson    2022-08-21  64  static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
9b8a11e8261527 Bjorn Andersson 2017-12-05  65  		      const void *in_buf, u32 in_buf_len, int dec_level);
9b8a11e8261527 Bjorn Andersson 2017-12-05  66  
9b8a11e8261527 Bjorn Andersson 2017-12-05  67  /**
9b8a11e8261527 Bjorn Andersson 2017-12-05  68   * skip_to_next_elem() - Skip to next element in the structure to be encoded
9b8a11e8261527 Bjorn Andersson 2017-12-05  69   * @ei_array: Struct info describing the element to be skipped.
9b8a11e8261527 Bjorn Andersson 2017-12-05  70   * @level: Depth level of encoding/decoding to identify nested structures.
9b8a11e8261527 Bjorn Andersson 2017-12-05  71   *
9b8a11e8261527 Bjorn Andersson 2017-12-05  72   * This function is used while encoding optional elements. If the flag
9b8a11e8261527 Bjorn Andersson 2017-12-05  73   * corresponding to an optional element is not set, then encoding the
9b8a11e8261527 Bjorn Andersson 2017-12-05  74   * optional element can be skipped. This function can be used to perform
9b8a11e8261527 Bjorn Andersson 2017-12-05  75   * that operation.
9b8a11e8261527 Bjorn Andersson 2017-12-05  76   *
9b8a11e8261527 Bjorn Andersson 2017-12-05  77   * Return: struct info of the next element that can be encoded.
9b8a11e8261527 Bjorn Andersson 2017-12-05  78   */
84f0de3071b40f Jeff Johnson    2022-08-21  79  static struct qmi_elem_info *skip_to_next_elem(const struct qmi_elem_info *ei_array,
9b8a11e8261527 Bjorn Andersson 2017-12-05  80  					       int level)
9b8a11e8261527 Bjorn Andersson 2017-12-05  81  {
84f0de3071b40f Jeff Johnson    2022-08-21  82  	const struct qmi_elem_info *temp_ei = ei_array;
9b8a11e8261527 Bjorn Andersson 2017-12-05  83  	u8 tlv_type;
9b8a11e8261527 Bjorn Andersson 2017-12-05  84  
9b8a11e8261527 Bjorn Andersson 2017-12-05  85  	if (level > 1) {
9b8a11e8261527 Bjorn Andersson 2017-12-05  86  		temp_ei = temp_ei + 1;
9b8a11e8261527 Bjorn Andersson 2017-12-05  87  	} else {
9b8a11e8261527 Bjorn Andersson 2017-12-05  88  		do {
9b8a11e8261527 Bjorn Andersson 2017-12-05  89  			tlv_type = temp_ei->tlv_type;
9b8a11e8261527 Bjorn Andersson 2017-12-05  90  			temp_ei = temp_ei + 1;
9b8a11e8261527 Bjorn Andersson 2017-12-05  91  		} while (tlv_type == temp_ei->tlv_type);
9b8a11e8261527 Bjorn Andersson 2017-12-05  92  	}
9b8a11e8261527 Bjorn Andersson 2017-12-05  93  
9b8a11e8261527 Bjorn Andersson 2017-12-05 @94  	return temp_ei;
9b8a11e8261527 Bjorn Andersson 2017-12-05  95  }
9b8a11e8261527 Bjorn Andersson 2017-12-05  96  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
