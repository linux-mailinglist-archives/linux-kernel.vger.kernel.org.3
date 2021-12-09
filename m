Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8084746E9ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhLIO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:29:32 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:28431 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhLIO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059958; x=1670595958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8zJXc5Po1hNIUwqTo6KbQjK2WwHgfiiLazhchMg1Ubc=;
  b=Hkt3LG8Gn2YfC1W5PjVx2e9sEcBc7twnXtgpFQ7ewb+Qc3JHUlLSVMNX
   uHxR6CDXxWDz914VcNvrUIPs9fgn1LQDLK2XpD8CdVbzByXuBgkOQeezZ
   BoFQ0eiTjkMg8xUGYValbFSHURXpLlhq/hfuavPy645w2awlat7Pu07vv
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Dec 2021 06:25:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:25:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:25:55 -0800
Received: from [10.253.38.94] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 9 Dec 2021
 06:25:52 -0800
Message-ID: <837a087f-fcaa-ece4-c683-1bd36f7cfb2a@quicinc.com>
Date:   Thu, 9 Dec 2021 22:25:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 6/9] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-7-quic_jinlmao@quicinc.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20211209141543.21314-7-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/2021 10:15 PM, Mao Jinlong wrote:
> Add API usage document for sysfs API in TPDM driver.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm     | 12 ++++++++++++
>   MAINTAINERS                                          |  1 +
>   2 files changed, 13 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> new file mode 100644
> index 000000000000..fdd0bd0e1c33
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -0,0 +1,12 @@
> +What:		/sys/bus/coresight/devices/<tpdm-name>/available_datasets
> +Date:		December 2021
> +KernelVersion	5.16
> +Contact:	Jinlong Mao or Tao Zhang
> +Description:	(Read) Show available datasets for TPDM.

Sorry, forgot to remove the document of available_datasets.

Please help to review first. I will update in next version.

> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
> +Date:		December 2020
> +KernelVersion	5.16
> +Contact:	Jinlong Mao or Tao Zhang
> +Description:	(Write) Run integration test for tpdm.
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d763ba684b99..7e2898f1550b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15566,6 +15566,7 @@ M:	Jinlong Mao <quic_jinlmao@quicinc.com>
>   M:	Mathieu Poirier <mathieu.poirier@linaro.org>
>   M:	Suzuki K Poulose <suzuki.poulose@arm.com>
>   S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>   F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>   F:	drivers/hwtracing/coresight/coresight-tpdm.c
>   
