Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE446F332
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbhLISiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:38:01 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:45776 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhLISiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639074867; x=1670610867;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nsPJ7/k89vzzxkh5RRjNbawEHMMBxtLsztWJUQr9r1I=;
  b=asyXfZFpGDO1vWzORG2FTXoXF269tUzhH7iMU4lwl5CTdMi6Qr9dFhcD
   Ju1hZPYsKoL5qY3HDc3eWsnEvSLwtJ7rxlTjaCOGIwvAPfhrhetsz1Yz3
   dCII/xo8yGFZs7f+/aGNkyS8Qwigtt3IN+p7gPZah/jFx3G+yITCva2g+
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Dec 2021 10:34:27 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 10:34:26 -0800
Received: from [10.110.124.149] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 9 Dec 2021
 10:34:26 -0800
Subject: Re: [PATCH v2 6/9] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
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
        <linux-arm-msm@vger.kernel.org>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-7-quic_jinlmao@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
Message-ID: <f8553de9-9a28-2624-0257-777f05ef6010@quicinc.com>
Date:   Thu, 9 Dec 2021 10:34:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209141543.21314-7-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Jinlong,

On 12/9/2021 6:15 AM, Mao Jinlong wrote:
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

Just keep one name? I am not sure if we are adding multiple names for 
other files.

> +Description:	(Read) Show available datasets for TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
> +Date:		December 2020
> 

December 2021?
