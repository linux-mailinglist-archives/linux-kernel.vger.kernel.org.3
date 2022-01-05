Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA0C485A63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiAEVGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:06:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:49459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbiAEVF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641416759; x=1672952759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hkH35YbzF4YPt3ygjqNj8GfRVNnWzk1Z4UqheHX4CcU=;
  b=EjRbnF1csDdv6cErtwmoonnGJry40WAdxZi2jcr3KeDxTv8sXvdZU59Z
   uaRK0w3B6QgZENps76sab8pnCaQZRDKpIHUo9byZQT+8lpNEXecR/6A9K
   2sp4LCHhE2SJVF5bYH24+D4ZAdYRYQBLsjj8t/C9uecYIv9TVZnx4CY6G
   nMDkxLwaLNrU/iw8uhF/jYk6crE63Cu2K/8m8bNqMvCq4C6PnLuXCzD7P
   IPvCWE28gcJ/IOet5HJIoE1AKCuTMrH7qXwYAOdc2NZ2h0l8akygYA7hr
   ed/Zl5vIt+1PqMyBS3S4ghlzvq511Qknj3GzeoebrBZDeGSMV9I3xqAbB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305887357"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="305887357"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:05:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="621280687"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2022 13:05:54 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5DTl-000H2W-QE; Wed, 05 Jan 2022 21:05:53 +0000
Date:   Thu, 6 Jan 2022 05:05:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v2 3/7] iio: adc: qcom-spmi-rradc: introduce round robin
 adc
Message-ID: <202201060438.QiDzs9rA-lkp@intel.com>
References: <20220105183353.2505744-4-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105183353.2505744-4-caleb.connolly@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on jic23-iio/togreg lee-mfd/for-mfd-next v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Caleb-Connolly/iio-adc-introduce-Qualcomm-SPMI-Round-Robin-ADC/20220106-023716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220106/202201060438.QiDzs9rA-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/167368793a009e8c1ce75b0b8b0965a4574af527
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Caleb-Connolly/iio-adc-introduce-Qualcomm-SPMI-Round-Robin-ADC/20220106-023716
        git checkout 167368793a009e8c1ce75b0b8b0965a4574af527
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iio/adc/qcom-spmi-rradc.c: In function 'rradc_prepare_batt_id_conversion':
>> drivers/iio/adc/qcom-spmi-rradc.c:624:25: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     624 |                         FIELD_PREP(BATT_ID_SETTLE_MASK, chip->batt_id_delay);
         |                         ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +624 drivers/iio/adc/qcom-spmi-rradc.c

   607	
   608	static int rradc_prepare_batt_id_conversion(struct rradc_chip *chip,
   609						    enum rradc_channel_id chan_id,
   610						    u16 *data)
   611	{
   612		int ret, batt_id_delay;
   613	
   614		ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
   615					 RR_ADC_BATT_ID_CTRL_CHANNEL_CONV,
   616					 RR_ADC_BATT_ID_CTRL_CHANNEL_CONV);
   617		if (ret < 0) {
   618			dev_err(chip->dev, "Enabling BATT ID channel failed:%d\n", ret);
   619			return ret;
   620		}
   621	
   622		if (chip->batt_id_delay != -EINVAL) {
   623			batt_id_delay =
 > 624				FIELD_PREP(BATT_ID_SETTLE_MASK, chip->batt_id_delay);
   625			ret = regmap_update_bits(chip->regmap,
   626						 chip->base + RR_ADC_BATT_ID_CFG,
   627						 batt_id_delay, batt_id_delay);
   628			if (ret < 0) {
   629				dev_err(chip->dev,
   630					"BATT_ID settling time config failed:%d\n",
   631					ret);
   632				goto out_disable_batt_id;
   633			}
   634		}
   635	
   636		ret = regmap_update_bits(chip->regmap,
   637					 chip->base + RR_ADC_BATT_ID_TRIGGER,
   638					 RR_ADC_TRIGGER_CTL, RR_ADC_TRIGGER_CTL);
   639		if (ret < 0) {
   640			dev_err(chip->dev, "BATT_ID trigger set failed:%d\n", ret);
   641			goto out_disable_batt_id;
   642		}
   643	
   644		ret = rradc_read_status_in_cont_mode(chip, chan_id);
   645		if (ret < 0)
   646			dev_err(chip->dev, "Error reading in continuous mode:%d\n",
   647				ret);
   648	
   649		/*
   650		 * Reset registers back to default values
   651		 */
   652		ret = regmap_update_bits(chip->regmap,
   653					 chip->base + RR_ADC_BATT_ID_TRIGGER,
   654					 RR_ADC_TRIGGER_CTL, 0);
   655		if (ret < 0)
   656			dev_err(chip->dev, "BATT_ID trigger re-set failed:%d\n", ret);
   657	
   658	out_disable_batt_id:
   659		ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
   660					 RR_ADC_BATT_ID_CTRL_CHANNEL_CONV, 0);
   661		if (ret < 0)
   662			dev_err(chip->dev, "Disabling BATT ID channel failed:%d\n",
   663				ret);
   664	
   665		return ret;
   666	}
   667	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
