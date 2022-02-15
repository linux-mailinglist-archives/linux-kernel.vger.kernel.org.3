Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0144B5FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiBOBEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:04:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiBOBEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:04:37 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id EE063B8238
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:04:27 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644887067; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=TbKrSdPeOmU9I/7yAa8+efMmXNFvoFbYlAZx4JzTiLQ=; b=XEnbCpYDDTjfcQuXhhbU7GQmeCjw31Z+0VZYGmY6y5tZvorGpWFBeL5yLZDPiG/m2QBgx44o
 6PfrY5Nonda6JHv41KC6ZSX663bgtjBfMtn47sSmjHOY2w7GmcuAknXwIiEwOqZ3jg4/X8Cb
 Mf67q1hH/OBlfi0lw+ZZApkaHP8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 620afc1919d16b66a9c0b370 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Feb 2022 01:04:25
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1471C43616; Tue, 15 Feb 2022 01:04:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from [192.168.1.14] (cpe-76-176-73-171.san.res.rr.com [76.176.73.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDF3BC4338F;
        Tue, 15 Feb 2022 01:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CDF3BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <071200b2-8033-7016-f7e0-2a6ae6c947f2@codeaurora.org>
Date:   Mon, 14 Feb 2022 17:04:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 08/25] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
In-Reply-To: <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 2/12/2022 10:21 AM, Manivannan Sadhasivam wrote:
> This commit adds support for registering MHI endpoint controller drivers
> with the MHI endpoint stack. MHI endpoint controller drivers manages
> the interaction with the host machines such as x86. They are also the
> MHI endpoint bus master in charge of managing the physical link between the
> host and endpoint device.
> 
> The endpoint controller driver encloses all information about the
> underlying physical bus like PCIe. The registration process involves
> parsing the channel configuration and allocating an MHI EP device.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/Kconfig       |   1 +
>   drivers/bus/mhi/Makefile      |   3 +
>   drivers/bus/mhi/ep/Kconfig    |  10 ++
>   drivers/bus/mhi/ep/Makefile   |   2 +
>   drivers/bus/mhi/ep/internal.h | 160 +++++++++++++++++++++++
>   drivers/bus/mhi/ep/main.c     | 234 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        | 143 +++++++++++++++++++++
>   7 files changed, 553 insertions(+)
>   create mode 100644 drivers/bus/mhi/ep/Kconfig
>   create mode 100644 drivers/bus/mhi/ep/Makefile
>   create mode 100644 drivers/bus/mhi/ep/internal.h
>   create mode 100644 drivers/bus/mhi/ep/main.c
>   create mode 100644 include/linux/mhi_ep.h
> 
> diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
> index 4748df7f9cd5..b39a11e6c624 100644
> --- a/drivers/bus/mhi/Kconfig
> +++ b/drivers/bus/mhi/Kconfig
> @@ -6,3 +6,4 @@
>   #
>   
>   source "drivers/bus/mhi/host/Kconfig"
> +source "drivers/bus/mhi/ep/Kconfig"
> diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
> index 5f5708a249f5..46981331b38f 100644
> --- a/drivers/bus/mhi/Makefile
> +++ b/drivers/bus/mhi/Makefile
> @@ -1,2 +1,5 @@
>   # Host MHI stack
>   obj-y += host/
> +
> +# Endpoint MHI stack
> +obj-y += ep/
> diff --git a/drivers/bus/mhi/ep/Kconfig b/drivers/bus/mhi/ep/Kconfig
> new file mode 100644
> index 000000000000..229c71397b30
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/Kconfig
> @@ -0,0 +1,10 @@
> +config MHI_BUS_EP
> +	tristate "Modem Host Interface (MHI) bus Endpoint implementation"
> +	help
> +	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
> +	  communication protocol used by the host processors to control
> +	  and communicate with modem devices over a high speed peripheral
> +	  bus or shared memory.
> +
> +	  MHI_BUS_EP implements the MHI protocol for the endpoint devices
> +	  like SDX55 modem connected to the host machine over PCIe.
> diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> new file mode 100644
> index 000000000000..64e29252b608
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> +mhi_ep-y := main.o
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> new file mode 100644
> index 000000000000..e313a2546664
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -0,0 +1,160 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021, Linaro Ltd.
> + *
> + */
> +
> +#ifndef _MHI_EP_INTERNAL_
> +#define _MHI_EP_INTERNAL_
> +
> +#include <linux/bitfield.h>
> +
> +#include "../common.h"
> +
> +extern struct bus_type mhi_ep_bus_type;
> +
> +#define MHI_REG_OFFSET				0x100
> +#define BHI_REG_OFFSET				0x200
> +
> +/* MHI registers */
> +#define MHIREGLEN				(MHI_REG_OFFSET + REG_MHIREGLEN)
> +#define MHIVER					(MHI_REG_OFFSET + REG_MHIVER)
> +#define MHICFG					(MHI_REG_OFFSET + REG_MHICFG)
> +#define CHDBOFF					(MHI_REG_OFFSET + REG_CHDBOFF)
> +#define ERDBOFF					(MHI_REG_OFFSET + REG_ERDBOFF)
> +#define BHIOFF					(MHI_REG_OFFSET + REG_BHIOFF)
> +#define BHIEOFF					(MHI_REG_OFFSET + REG_BHIEOFF)
> +#define DEBUGOFF				(MHI_REG_OFFSET + REG_DEBUGOFF)
> +#define MHICTRL					(MHI_REG_OFFSET + REG_MHICTRL)
> +#define MHISTATUS				(MHI_REG_OFFSET + REG_MHISTATUS)
> +#define CCABAP_LOWER				(MHI_REG_OFFSET + REG_CCABAP_LOWER)
> +#define CCABAP_HIGHER				(MHI_REG_OFFSET + REG_CCABAP_HIGHER)
> +#define ECABAP_LOWER				(MHI_REG_OFFSET + REG_ECABAP_LOWER)
> +#define ECABAP_HIGHER				(MHI_REG_OFFSET + REG_ECABAP_HIGHER)
> +#define CRCBAP_LOWER				(MHI_REG_OFFSET + REG_CRCBAP_LOWER)
> +#define CRCBAP_HIGHER				(MHI_REG_OFFSET + REG_CRCBAP_HIGHER)
> +#define CRDB_LOWER				(MHI_REG_OFFSET + REG_CRDB_LOWER)
> +#define CRDB_HIGHER				(MHI_REG_OFFSET + REG_CRDB_HIGHER)
> +#define MHICTRLBASE_LOWER			(MHI_REG_OFFSET + REG_MHICTRLBASE_LOWER)
> +#define MHICTRLBASE_HIGHER			(MHI_REG_OFFSET + REG_MHICTRLBASE_HIGHER)
> +#define MHICTRLLIMIT_LOWER			(MHI_REG_OFFSET + REG_MHICTRLLIMIT_LOWER)
> +#define MHICTRLLIMIT_HIGHER			(MHI_REG_OFFSET + REG_MHICTRLLIMIT_HIGHER)
> +#define MHIDATABASE_LOWER			(MHI_REG_OFFSET + REG_MHIDATABASE_LOWER)
> +#define MHIDATABASE_HIGHER			(MHI_REG_OFFSET + REG_MHIDATABASE_HIGHER)
> +#define MHIDATALIMIT_LOWER			(MHI_REG_OFFSET + REG_MHIDATALIMIT_LOWER)
> +#define MHIDATALIMIT_HIGHER			(MHI_REG_OFFSET + REG_MHIDATALIMIT_HIGHER)
> +
> +/* MHI BHI registers */
> +#define BHI_IMGTXDB				(BHI_REG_OFFSET + REG_BHI_IMGTXDB)
> +#define BHI_EXECENV				(BHI_REG_OFFSET + REG_BHI_EXECENV)
> +#define BHI_INTVEC				(BHI_REG_OFFSET + REG_BHI_INTVEC)
> +
> +/* MHI Doorbell registers */
> +#define CHDB_LOWER_n(n)				(0x400 + 0x8 * (n))
> +#define CHDB_HIGHER_n(n)			(0x404 + 0x8 * (n))
> +#define ERDB_LOWER_n(n)				(0x800 + 0x8 * (n))
> +#define ERDB_HIGHER_n(n)			(0x804 + 0x8 * (n))
> +
> +#define MHI_CTRL_INT_STATUS_A7			0x4
can we get rid of all instances of "_A7" as this corresponds to 
Cortex-A7, in future this can change? At MHI core layer, we can avoid 
this naming convetion, even though register names are inculding them now 
and may change to something different later. This MHI EP driver would 
still be used for those new cortex vers.
> +#define MHI_CTRL_INT_STATUS_A7_MSK		BIT(0)
> +#define MHI_CTRL_INT_STATUS_CRDB_MSK		BIT(1)
> +#define MHI_CHDB_INT_STATUS_A7_n(n)		(0x28 + 0x4 * (n))
> +#define MHI_ERDB_INT_STATUS_A7_n(n)		(0x38 + 0x4 * (n))
> +
[..]

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
