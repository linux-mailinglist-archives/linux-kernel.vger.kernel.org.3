Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781CD513298
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbiD1Lml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiD1Lmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:42:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D676C969;
        Thu, 28 Apr 2022 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651145965; x=1682681965;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EbBBYh9NEVCvlqlF3DlWr+jmXA+iZzTdz52n2zWzX24=;
  b=bnlQ0KsgHpIYCluMGz4XZdj/4y4/OwRg5aETa6GB94ziHz8thtv7bexG
   T2kTcY0/OXo4td4nUGxnzhZbonqfaGP7MdJ8ZVBUzPLExXznfjvuUoLhG
   ZuR97/byk/NGhvavVfiwPMG8VUnQUdqSA8tmPAusT7GMaWkvYv/sdY6YL
   cdd2j8V25Et8PDHpqt0mJQR5ouJYclKBrQ2vqSCYSc4ECoWQPgz62KOWc
   QENuAZgRJG9cOtTv41BO6UPgXttRA8vA7R3RD7z2zd3891KaSi/ui/LBm
   1XKu7vHE2Kzw75fTT5VPyT+oJnYYTgYa14eXFs/P7PoOTNzTcJk22eXU4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="352695562"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="352695562"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:39:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="731421296"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.248]) ([10.255.31.248])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:39:21 -0700
Subject: Re: [kbuild-all] Re: [PATCH v3 2/2] PM / devfreq: mediatek: Introduce
 MediaTek CCI devfreq driver
To:     Johnson Wang <johnson.wang@mediatek.com>,
        kernel test robot <lkp@intel.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220425125546.4129-3-johnson.wang@mediatek.com>
 <202204271737.oAuTwqZH-lkp@intel.com>
 <a72b6333be0d8a2065477e47222c309a0d520fd4.camel@mediatek.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <abc836d8-b7da-c9da-6936-567df7206ca5@intel.com>
Date:   Thu, 28 Apr 2022 19:39:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a72b6333be0d8a2065477e47222c309a0d520fd4.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2022 6:11 PM, Johnson Wang wrote:
> On Wed, 2022-04-27 at 17:25 +0800, kernel test robot wrote:
>> Hi Johnson,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on robh/for-next]
>> [also build test WARNING on linus/master v5.18-rc4 next-20220427]
>> [If your patch is applied to the wrong git tree, kindly drop us a
>> note.
>> And when submitting patch, we suggest to use '--base' as documented
>> in
>>
> https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMS_s9zEZ$
>>   ]
>>
>> url:
>> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Johnson-Wang/Introduce-MediaTek-CCI-devfreq-driver/20220425-205820__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMc1U_tqz$
>>   
>> base:
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMUzTprof$
>>    for-next
>> config: hexagon-allyesconfig (
>> https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20220427/202204271737.oAuTwqZH-lkp@intel.com/config__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMaVRzbSL$
>>   )
>> compiler: clang version 15.0.0 (
>> https://urldefense.com/v3/__https://github.com/llvm/llvm-project__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMRqw5IY-$
>> $  1cddcfdc3c683b393df1a5c9063252eb60e52818)
>> reproduce (this is a W=1 build):
>>          wget
>> https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMQLiD-i9$
>>    -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          #
>> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commit/98b34c0587837b0e5b880b11a52433f8f0eee19f__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMU5yd7Y2$
>>   
>>          git remote add linux-review
>> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMW4ldtnH$
>>   
>>          git fetch --no-tags linux-review Johnson-Wang/Introduce-
>> MediaTek-CCI-devfreq-driver/20220425-205820
>>          git checkout 98b34c0587837b0e5b880b11a52433f8f0eee19f
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
>> W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash block/partitions/
>> drivers/devfreq/ drivers/iio/imu/ drivers/misc/lkdtm/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/devfreq/mtk-cci-devfreq.c:372:16: error: no member named
>> 'parent_type' in 'struct devfreq_passive_data'
>>             passive_data->parent_type = CPUFREQ_PARENT_DEV;
>>             ~~~~~~~~~~~~  ^
>>     drivers/devfreq/mtk-cci-devfreq.c:372:30: error: use of undeclared
>> identifier 'CPUFREQ_PARENT_DEV'
>>             passive_data->parent_type = CPUFREQ_PARENT_DEV;
>>                                         ^
>>>> drivers/devfreq/mtk-cci-devfreq.c:379:4: warning: format
>>>> specifies type 'int' but the argument has type 'long' [-Wformat]
>>
>>                             PTR_ERR(drv->devfreq));
>>                             ^~~~~~~~~~~~~~~~~~~~~
>>     include/linux/dev_printk.h:144:65: note: expanded from macro
>> 'dev_err'
>>             dev_printk_index_wrap(_dev_err, KERN_ERR, dev,
>> dev_fmt(fmt), ##__VA_ARGS__)
>>                                                                    ~~~
>>       ^~~~~~~~~~~
>>     include/linux/dev_printk.h:110:23: note: expanded from macro
>> 'dev_printk_index_wrap'
>>                     _p_func(dev, fmt,
>> ##__VA_ARGS__);                       \
>>                                  ~~~    ^~~~~~~~~~~
>>     1 warning and 2 errors generated.
>>
>>
>> vim +379 drivers/devfreq/mtk-cci-devfreq.c
>>
>>     255	
>>     256	static int mtk_ccifreq_probe(struct platform_device
>> *pdev)
>>     257	{
>>     258		struct device *dev = &pdev->dev;
>>     259		struct mtk_ccifreq_drv *drv;
>>     260		struct devfreq_passive_data *passive_data;
>>     261		struct dev_pm_opp *opp;
>>     262		unsigned long rate, opp_volt;
>>     263		int ret;
>>     264	
>>     265		drv = devm_kzalloc(dev, sizeof(*drv),
>> GFP_KERNEL);
>>     266		if (!drv)
>>     267			return -ENOMEM;
>>     268	
>>     269		drv->dev = dev;
>>     270		drv->soc_data = (const struct
>> mtk_ccifreq_platform_data *)
>>     271					of_device_get_match_dat
>> a(&pdev->dev);
>>     272		mutex_init(&drv->reg_lock);
>>     273		platform_set_drvdata(pdev, drv);
>>     274	
>>     275		drv->cci_clk = devm_clk_get(dev, "cci");
>>     276		if (IS_ERR(drv->cci_clk)) {
>>     277			ret = PTR_ERR(drv->cci_clk);
>>     278			return dev_err_probe(dev, ret,
>>     279					     "failed to get cci
>> clk: %d\n", ret);
>>     280		}
>>     281	
>>     282		drv->inter_clk = devm_clk_get(dev,
>> "intermediate");
>>     283		if (IS_ERR(drv->inter_clk)) {
>>     284			ret = PTR_ERR(drv->inter_clk);
>>     285			dev_err_probe(dev, ret,
>>     286				      "failed to get
>> intermediate clk: %d\n", ret);
>>     287			goto out_free_resources;
>>     288		}
>>     289	
>>     290		drv->proc_reg =
>> devm_regulator_get_optional(dev, "proc");
>>     291		if (IS_ERR(drv->proc_reg)) {
>>     292			ret = PTR_ERR(drv->proc_reg);
>>     293			dev_err_probe(dev, ret,
>>     294				      "failed to get proc
>> regulator: %d\n", ret);
>>     295			goto out_free_resources;
>>     296		}
>>     297	
>>     298		ret = regulator_enable(drv->proc_reg);
>>     299		if (ret) {
>>     300			dev_err(dev, "failed to enable proc
>> regulator\n");
>>     301			goto out_free_resources;
>>     302		}
>>     303	
>>     304		drv->sram_reg = regulator_get_optional(dev,
>> "sram");
>>     305		if (IS_ERR(drv->sram_reg))
>>     306			drv->sram_reg = NULL;
>>     307		else {
>>     308			ret = regulator_enable(drv->sram_reg);
>>     309			if (ret) {
>>     310				dev_err(dev, "failed to enable
>> sram regulator\n");
>>     311				goto out_free_resources;
>>     312			}
>>     313		}
>>     314	
>>     315		/*
>>     316		 * We assume min voltage is 0 and tracking
>> target voltage using
>>     317		 * min_volt_shift for each iteration.
>>     318		 * The retry_max is 3 times of expeted
>> iteration count.
>>     319		 */
>>     320		drv->vtrack_max = 3 * DIV_ROUND_UP(max(drv-
>>> soc_data->sram_max_volt,
>>     321						       drv-
>>> soc_data->proc_max_volt),
>>     322						   drv-
>>> soc_data->min_volt_shift);
>>     323	
>>     324		ret = clk_prepare_enable(drv->cci_clk);
>>     325		if (ret)
>>     326			goto out_free_resources;
>>     327	
>>     328		ret = clk_prepare_enable(drv->inter_clk);
>>     329		if (ret)
>>     330			goto out_disable_cci_clk;
>>     331	
>>     332		ret = dev_pm_opp_of_add_table(dev);
>>     333		if (ret) {
>>     334			dev_err(dev, "failed to add opp table:
>> %d\n", ret);
>>     335			goto out_disable_inter_clk;
>>     336		}
>>     337	
>>     338		rate = clk_get_rate(drv->inter_clk);
>>     339		opp = dev_pm_opp_find_freq_ceil(dev, &rate);
>>     340		if (IS_ERR(opp)) {
>>     341			ret = PTR_ERR(opp);
>>     342			dev_err(dev, "failed to get
>> intermediate opp: %d\n", ret);
>>     343			goto out_remove_opp_table;
>>     344		}
>>     345		drv->inter_voltage =
>> dev_pm_opp_get_voltage(opp);
>>     346		dev_pm_opp_put(opp);
>>     347	
>>     348		rate = U32_MAX;
>>     349		opp = dev_pm_opp_find_freq_floor(drv->dev,
>> &rate);
>>     350		if (IS_ERR(opp)) {
>>     351			dev_err(dev, "failed to get opp\n");
>>     352			ret = PTR_ERR(opp);
>>     353			goto out_remove_opp_table;
>>     354		}
>>     355	
>>     356		opp_volt = dev_pm_opp_get_voltage(opp);
>>     357		dev_pm_opp_put(opp);
>>     358		ret = mtk_ccifreq_set_voltage(drv, opp_volt);
>>     359		if (ret) {
>>     360			dev_err(dev, "failed to scale to
>> highest voltage %lu in proc_reg\n",
>>     361				opp_volt);
>>     362			goto out_remove_opp_table;
>>     363		}
>>     364	
>>     365		passive_data = devm_kzalloc(dev, sizeof(struct
>> devfreq_passive_data),
>>     366					    GFP_KERNEL);
>>     367		if (!passive_data) {
>>     368			ret = -ENOMEM;
>>     369			goto out_remove_opp_table;
>>     370		}
>>     371	
>>     372		passive_data->parent_type = CPUFREQ_PARENT_DEV;
>>     373		drv->devfreq = devm_devfreq_add_device(dev,
>> &mtk_ccifreq_profile,
>>     374						       DEVFREQ_
>> GOV_PASSIVE,
>>     375						       passive_
>> data);
>>     376		if (IS_ERR(drv->devfreq)) {
>>     377			ret = -EPROBE_DEFER;
>>     378			dev_err(dev, "failed to add devfreq
>> device: %d\n",
>>   > 379				PTR_ERR(drv->devfreq));
>>     380			goto out_remove_opp_table;
>>     381		}
>>     382	
>>     383		drv->opp_nb.notifier_call =
>> mtk_ccifreq_opp_notifier;
>>     384		ret = dev_pm_opp_register_notifier(dev, &drv-
>>> opp_nb);
>>     385		if (ret) {
>>     386			dev_err(dev, "failed to register opp
>> notifier: %d\n", ret);
>>     387			goto out_remove_devfreq_device;
>>     388		}
>>     389		return 0;
>>     390	
>>     391	out_remove_devfreq_device:
>>     392		devm_devfreq_remove_device(dev, drv->devfreq);
>>     393	
>>     394	out_remove_opp_table:
>>     395		dev_pm_opp_of_remove_table(dev);
>>     396	
>>     397	out_disable_inter_clk:
>>     398		clk_disable_unprepare(drv->inter_clk);
>>     399	
>>     400	out_disable_cci_clk:
>>     401		clk_disable_unprepare(drv->cci_clk);
>>     402	
>>     403	out_free_resources:
>>     404		if (regulator_is_enabled(drv->proc_reg))
>>     405			regulator_disable(drv->proc_reg);
>>     406		if (drv->sram_reg && regulator_is_enabled(drv-
>>> sram_reg))
>>     407			regulator_disable(drv->sram_reg);
>>     408	
>>     409		if (!IS_ERR(drv->proc_reg))
>>     410			regulator_put(drv->proc_reg);
>>     411		if (!IS_ERR(drv->sram_reg))
>>     412			regulator_put(drv->sram_reg);
>>     413		if (!IS_ERR(drv->cci_clk))
>>     414			clk_put(drv->cci_clk);
>>     415		if (!IS_ERR(drv->inter_clk))
>>     416			clk_put(drv->inter_clk);
>>     417	
>>     418		return ret;
>>     419	}
>>     420	
>>
> 
> Hi "kernel test robot",
> 
> Thanks for your review.
> 
> This patch is based on chanwoo/devfreq-testing[1]
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

Hi Johnson,

Thanks for the feedback, we'll take a look too.

Best Regards,
Rong Chen

> 
> I will follow your suggestion to use '--base' in the next version.
> 
> BRs,
> Johnson Wang
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
