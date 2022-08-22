Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49159C1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiHVOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiHVOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:45:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D5248C2;
        Mon, 22 Aug 2022 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661179547; x=1692715547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SoEASToC8Lg7LTAIRzKTjzRxmyACvRFQA1v66YGhhoQ=;
  b=C0qktZQldaHxhlWoEtzuImNvoZh4jFUoomhYIR1IAdbZNl/S7klYKgbm
   yBIaXjA3lBZTPgpHH+bQP41zxD3tQK+JdUECHF5IOftsF5zgAZd6WG/vS
   AOJDq56Pwf2Kl23HdEGvh8tFx7yaqG099rLO2tgpKJZwK5JzSQ8ZRkzkE
   dEw+EdyT8rslPWL15kAduhhSvndO4JDTBAM3TKZu8nJSF9kqymnYJsxCX
   E/xPLidoyLBH+n4Km86a8NDAacnrrGGnNqO/7yi5H+eEV8D1wGTOczAj+
   e0KIW1RXZl5kZS3L6Ypn3UApWXP2vfI9qwmU+Z/oUqTK+nIOtSRnoSxqP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="319465545"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="319465545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 07:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="677235022"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2022 07:45:44 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ8gS-0000K0-0s;
        Mon, 22 Aug 2022 14:45:44 +0000
Date:   Mon, 22 Aug 2022 22:45:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] soc: qcom: qmi: use const for struct qmi_elem_info
Message-ID: <202208222238.2bPtxE6h-lkp@intel.com>
References: <20220822064648.30794-1-quic_jjohnson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822064648.30794-1-quic_jjohnson@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc2 next-20220822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Johnson/soc-qcom-qmi-use-const-for-struct-qmi_elem_info/20220822-144905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1c23f9e627a7b412978b4e852793c5e3c3efc555
config: mips-buildonly-randconfig-r002-20220821 (https://download.01.org/0day-ci/archive/20220822/202208222238.2bPtxE6h-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project abce7acebd4c06c977bc4bd79170697f1122bc5e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/84f0de3071b40fad5e5a48ad27b16ce28f9210fb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeff-Johnson/soc-qcom-qmi-use-const-for-struct-qmi_elem_info/20220822-144905
        git checkout 84f0de3071b40fad5e5a48ad27b16ce28f9210fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/qcom/qmi_encdec.c:94:9: error: returning 'const struct qmi_elem_info *' from a function with result type 'struct qmi_elem_info *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           return temp_ei;
                  ^~~~~~~
   1 error generated.


vim +94 drivers/soc/qcom/qmi_encdec.c

9b8a11e82615274 Bjorn Andersson 2017-12-05  59  
84f0de3071b40fa Jeff Johnson    2022-08-21  60  static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
9b8a11e82615274 Bjorn Andersson 2017-12-05  61  		      const void *in_c_struct, u32 out_buf_len,
9b8a11e82615274 Bjorn Andersson 2017-12-05  62  		      int enc_level);
9b8a11e82615274 Bjorn Andersson 2017-12-05  63  
84f0de3071b40fa Jeff Johnson    2022-08-21  64  static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
9b8a11e82615274 Bjorn Andersson 2017-12-05  65  		      const void *in_buf, u32 in_buf_len, int dec_level);
9b8a11e82615274 Bjorn Andersson 2017-12-05  66  
9b8a11e82615274 Bjorn Andersson 2017-12-05  67  /**
9b8a11e82615274 Bjorn Andersson 2017-12-05  68   * skip_to_next_elem() - Skip to next element in the structure to be encoded
9b8a11e82615274 Bjorn Andersson 2017-12-05  69   * @ei_array: Struct info describing the element to be skipped.
9b8a11e82615274 Bjorn Andersson 2017-12-05  70   * @level: Depth level of encoding/decoding to identify nested structures.
9b8a11e82615274 Bjorn Andersson 2017-12-05  71   *
9b8a11e82615274 Bjorn Andersson 2017-12-05  72   * This function is used while encoding optional elements. If the flag
9b8a11e82615274 Bjorn Andersson 2017-12-05  73   * corresponding to an optional element is not set, then encoding the
9b8a11e82615274 Bjorn Andersson 2017-12-05  74   * optional element can be skipped. This function can be used to perform
9b8a11e82615274 Bjorn Andersson 2017-12-05  75   * that operation.
9b8a11e82615274 Bjorn Andersson 2017-12-05  76   *
9b8a11e82615274 Bjorn Andersson 2017-12-05  77   * Return: struct info of the next element that can be encoded.
9b8a11e82615274 Bjorn Andersson 2017-12-05  78   */
84f0de3071b40fa Jeff Johnson    2022-08-21  79  static struct qmi_elem_info *skip_to_next_elem(const struct qmi_elem_info *ei_array,
9b8a11e82615274 Bjorn Andersson 2017-12-05  80  					       int level)
9b8a11e82615274 Bjorn Andersson 2017-12-05  81  {
84f0de3071b40fa Jeff Johnson    2022-08-21  82  	const struct qmi_elem_info *temp_ei = ei_array;
9b8a11e82615274 Bjorn Andersson 2017-12-05  83  	u8 tlv_type;
9b8a11e82615274 Bjorn Andersson 2017-12-05  84  
9b8a11e82615274 Bjorn Andersson 2017-12-05  85  	if (level > 1) {
9b8a11e82615274 Bjorn Andersson 2017-12-05  86  		temp_ei = temp_ei + 1;
9b8a11e82615274 Bjorn Andersson 2017-12-05  87  	} else {
9b8a11e82615274 Bjorn Andersson 2017-12-05  88  		do {
9b8a11e82615274 Bjorn Andersson 2017-12-05  89  			tlv_type = temp_ei->tlv_type;
9b8a11e82615274 Bjorn Andersson 2017-12-05  90  			temp_ei = temp_ei + 1;
9b8a11e82615274 Bjorn Andersson 2017-12-05  91  		} while (tlv_type == temp_ei->tlv_type);
9b8a11e82615274 Bjorn Andersson 2017-12-05  92  	}
9b8a11e82615274 Bjorn Andersson 2017-12-05  93  
9b8a11e82615274 Bjorn Andersson 2017-12-05 @94  	return temp_ei;
9b8a11e82615274 Bjorn Andersson 2017-12-05  95  }
9b8a11e82615274 Bjorn Andersson 2017-12-05  96  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
