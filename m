Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E382F4B5FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiBOBOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:14:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBOBOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:14:46 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 92D7AD76C6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:14:37 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644887677; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=iVlJD7hevk745hR82UWssLvOu64dOiqyn3Bntky6xx8=; b=QiW8JhW4OZaQnXCjXVK/jJcWvq/qmzCOP9LZ1TUJDuqEzSj+1S9wD3HZ8lepTCtPzbv1WeSo
 IwVIVVXh+/8jz0ay3CcobiXEfju7zrep0Xfp731zzIYRRrODzYu3jKsbgjvm6Odc2bTDte+u
 ar2nFcoKmaRhhuAhL94gF2B5n8Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 620afe7c2afeb7f9b5b2a0e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Feb 2022 01:14:36
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 78AF0C43616; Tue, 15 Feb 2022 01:14:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from [192.168.1.14] (cpe-76-176-73-171.san.res.rr.com [76.176.73.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9A6AC4338F;
        Tue, 15 Feb 2022 01:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D9A6AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <54bcb1c0-d264-5b82-e9f6-0343579d4978@codeaurora.org>
Date:   Mon, 14 Feb 2022 17:14:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 11/25] bus: mhi: ep: Add support for managing MMIO
 registers
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
 <20220212182117.49438-12-manivannan.sadhasivam@linaro.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
In-Reply-To: <20220212182117.49438-12-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani

On 2/12/2022 10:21 AM, Manivannan Sadhasivam wrote:
> Add support for managing the Memory Mapped Input Output (MMIO) registers
> of the MHI bus. All MHI operations are carried out using the MMIO registers
> by both host and the endpoint device.
> 
> The MMIO registers reside inside the endpoint device memory (fixed
> location based on the platform) and the address is passed by the MHI EP
> controller driver during its registration.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/ep/Makefile   |   2 +-
>   drivers/bus/mhi/ep/internal.h |  37 +++++
>   drivers/bus/mhi/ep/main.c     |   6 +-
>   drivers/bus/mhi/ep/mmio.c     | 274 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |  18 +++
>   5 files changed, 335 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/bus/mhi/ep/mmio.c
> 
> diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> index 64e29252b608..a1555ae287ad 100644
> --- a/drivers/bus/mhi/ep/Makefile
> +++ b/drivers/bus/mhi/ep/Makefile
> @@ -1,2 +1,2 @@
>   obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> -mhi_ep-y := main.o
> +mhi_ep-y := main.o mmio.o
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index e313a2546664..2c756a90774c 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -101,6 +101,17 @@ struct mhi_generic_ctx {
>   	__u64 wp __packed __aligned(4);
>   };
>   
> +/**
> + * enum mhi_ep_execenv - MHI Endpoint Execution Environment
> + * @MHI_EP_SBL_EE: Secondary Bootloader
> + * @MHI_EP_AMSS_EE: Advanced Mode Subscriber Software
> + */
> +enum mhi_ep_execenv {
> +	MHI_EP_SBL_EE = 1,
> +	MHI_EP_AMSS_EE = 2,
> +	MHI_EP_UNRESERVED
> +};
can we move or use the exec env definitions from common header ?
> +
>   enum mhi_ep_ring_type {
>   	RING_TYPE_CMD = 0,
>   	RING_TYPE_ER,
> @@ -157,4 +168,30 @@ struct mhi_ep_chan {
>   	bool skip_td;
>   };
>   
> +/* MMIO related functions */
> +u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset);
> +void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
> +void mhi_ep_mmio_masked_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 mask, u32 val);
> +u32 mhi_ep_mmio_masked_read(struct mhi_ep_cntrl *dev, u32 offset, u32 mask);
> +void mhi_ep_mmio_enable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_disable_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_enable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_disable_cmdb_interrupt(struct mhi_ep_cntrl *mhi_cntrl);
> +void mhi_ep_mmio_enable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
can we get rid of a7 from function and macros ?
> +void mhi_ep_mmio_disable_chdb_a7(struct mhi_ep_cntrl *mhi_cntrl, u32 chdb_id);
[..]
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
