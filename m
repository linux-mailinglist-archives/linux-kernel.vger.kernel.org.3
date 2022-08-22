Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C759BBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiHVIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiHVIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:48:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FFB1146F;
        Mon, 22 Aug 2022 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661158122; x=1692694122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqreuZ0XbXPfbB6mvgSmsxtnzxVXkLrvDEBrwPh/UB0=;
  b=JH2Wg4xYbKbxO/dHeIY4e6xvJMIblf5Z+9SP8MtSYnibN8lh18x+4FjH
   BC5cLUSxUl27vCuP3FHie4ZewAvet6EywdChKZd9p2jxn4E3HqY9tmPPa
   ujV0OYrBbKsjWVB7z3ApIdkakg4hWmY+n9mM3Og2kyekhX527EHOp36ny
   WMqk/EL8bo67KWRgyf4VBeA+hTGtiLA5ZjoOefJE12SNl9m7SvVQg2wjx
   2P67GlYlQVI3+M88ZkgxmimaDiakbT+vrQ3sgo3dWdTA3kT9yfWVBGD2q
   uXilY6o1IcPEydEnnMCWPCzm5WmMFdHbJ/mZ7pCOQ8V3h0RBFiEfzGLOj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="357342562"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="357342562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 01:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="638101722"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2022 01:48:39 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ36t-00058d-12;
        Mon, 22 Aug 2022 08:48:39 +0000
Date:   Mon, 22 Aug 2022 16:47:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     kbuild-all@lists.01.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] soc: qcom: qmi: use const for struct qmi_elem_info
Message-ID: <202208221632.bulgoDlE-lkp@intel.com>
References: <20220822064648.30794-1-quic_jjohnson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822064648.30794-1-quic_jjohnson@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220822/202208221632.bulgoDlE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/84f0de3071b40fad5e5a48ad27b16ce28f9210fb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeff-Johnson/soc-qcom-qmi-use-const-for-struct-qmi_elem_info/20220822-144905
        git checkout 84f0de3071b40fad5e5a48ad27b16ce28f9210fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/qcom/qmi_encdec.c: In function 'skip_to_next_elem':
>> drivers/soc/qcom/qmi_encdec.c:94:16: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      94 |         return temp_ei;
         |                ^~~~~~~


vim +/const +94 drivers/soc/qcom/qmi_encdec.c

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
