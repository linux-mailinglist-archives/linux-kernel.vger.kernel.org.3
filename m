Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850C84C9028
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiCAQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiCAQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:18:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB725B3FE;
        Tue,  1 Mar 2022 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646151469; x=1677687469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oW7rCjucB/FAM9m562SoKysdtSc96jMNqsGkSaAFJyc=;
  b=huswXYlCt6OzR/mdF2ftO/wK3tzrZC4LEK/1F60nwtX/odL93YIuOjXG
   UlbazkApYAGFNAMo5ZofHiqcN8EMCVTv4GTiTxwjvgLOl6gaU+hRq8ET3
   h2vFMnybKQDHsaG8EmJlAmfMDBCq9a6rMtL6AVLpUx0S1+PKl1EiSDbam
   id9uwldaBIjzj6rarg/VA4aJXUa3u0g6FUm1ex6FHHBd7+GtGS/E6Fjet
   mzOhh714wdKEIf+FGsUgKYz9xqh06mixb/OqeVsDT+mlJNtwr6RGeaHCY
   TmB3VtECprjGy3F4EUtYbSuXmbdM72YpqeCh4Sxfr2yacOZV7DhhTieYA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339600547"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="339600547"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:17:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="545146496"
Received: from rbrosius-mobl.amr.corp.intel.com (HELO [10.209.131.146]) ([10.209.131.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:17:48 -0800
Message-ID: <a3240a03-2e14-35e6-4915-41f994e365fc@linux.intel.com>
Date:   Tue, 1 Mar 2022 07:52:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] soundwire: qcom: add in-band wake up interrupt
 support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220228172528.3489-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/22 11:25, Srinivas Kandagatla wrote:
> Some of the Qualcomm SoundWire Controller instances like the ones that are
> connected to RX path along with Headset connections support Waking up
> Controller from Low power clock stop state using SoundWire In-band interrupt.
> SoundWire Slave on the bus would initiate this by pulling the data line high,
> while the clock is stopped.
> 
> Add support to this wake up interrupt.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/qcom.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 810232686196..e893aee1b057 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/slimbus.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
> @@ -154,6 +155,7 @@ struct qcom_swrm_ctrl {
>  	u8 rd_cmd_id;
>  	int irq;
>  	unsigned int version;
> +	int wake_irq;
>  	int num_din_ports;
>  	int num_dout_ports;
>  	int cols_index;
> @@ -503,6 +505,31 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
>  	return 0;
>  }
>  
> +static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
> +{
> +	struct qcom_swrm_ctrl *swrm = dev_id;
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(swrm->dev);
> +	if (ret < 0 && ret != -EACCES) {
> +		dev_err_ratelimited(swrm->dev,
> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    __func__, ret);
> +		pm_runtime_put_noidle(swrm->dev);
> +	}
> +
> +	if (swrm->wake_irq > 0) {
> +		if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
> +			disable_irq_nosync(swrm->wake_irq);
> +	}
> +
> +	pm_runtime_mark_last_busy(swrm->dev);
> +	pm_runtime_put_autosuspend(swrm->dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
>  static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  {
>  	struct qcom_swrm_ctrl *swrm = dev_id;
> @@ -1340,6 +1367,19 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  		goto err_clk;
>  	}
>  
> +	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
> +	if (ctrl->wake_irq > 0) {
> +		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
> +						qcom_swrm_wake_irq_handler,
> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +						"swr_wake_irq", ctrl);
> +		if (ret) {
> +			dev_err(dev, "Failed to request soundwire wake irq\n");
> +			goto err_init;
> +		}
> +	}
> +
> +
>  	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
>  	if (ret) {
>  		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
> @@ -1424,6 +1464,11 @@ static int swrm_runtime_resume(struct device *dev)
>  	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
>  	int ret;
>  
> +	if (ctrl->wake_irq > 0) {
> +		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
> +			disable_irq_nosync(ctrl->wake_irq);
> +	}
> +
>  	clk_prepare_enable(ctrl->hclk);
>  
>  	if (ctrl->clock_stop_not_supported) {
> @@ -1491,6 +1536,11 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
>  
>  	usleep_range(300, 305);
>  
> +	if (ctrl->wake_irq > 0) {
> +		if (irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
> +			enable_irq(ctrl->wake_irq);
> +	}
> +
>  	return 0;
>  }
>  
