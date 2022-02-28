Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5864C7145
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiB1QHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiB1QHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:07:39 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536F7486E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:07:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id f2so10345397ilq.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RzhMd97CtaQZDw6FhAV1yi4Tl7SK87wPE+vyp1xxwww=;
        b=syq593t+BiD7pDe3Ma10NPu9tLQK8nNSErVlZ+xPZBW8WtFPUQekA92Gq6gDoaUII+
         S33+jHYSDjs7fBDiaV9uzocxYMxNgxnakUUCpWKhd8O1SlbfEZGRLSgCO5/1861qrRGn
         3sHaXKl74xcRtIhnk3CawRsHXnOfIN5SilNapC29UyI00uBJP0HpAtT/o+Ks4hdXC/+b
         gCBFiIGMVUeLYrO22Jq7ErzmqtZOH7kmfjjS/EoqK/okIVm2YnKwlNz1Utu2aj+6LnVM
         MlQNNuhYbE2AKmn8BPEK7O0z6MN0evgBj469k7f/L7ze10ae/D7lXFfh1lNbi+kzcbp3
         ynHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RzhMd97CtaQZDw6FhAV1yi4Tl7SK87wPE+vyp1xxwww=;
        b=YYz7473d1jv4EUJbw4YfB58wjsrr995+/VIB9QNy0FxO8Gt0zQaJKk2KUah8MDkBuy
         u6Ny09HkMOqwM9m5bX1tDAmXLYFrlcvr2C1+e7a8+B4zHxGUqPV8Bkc3cmZyaiAtXp/S
         4qEAYLrQyP9y7SO+stbhczDGjnYJ5xZ+4rFjEjupyVsKtZlhn2s/U3mZ6bRLy9WFP1xv
         gx/4b9DKFGQ/Zt1xgiL9I5lcXB1o5Q2aClbo92wzHkuQeWdtCM+GHRuRZw2t5HyU3NLT
         HuJuOD+a7isjLpvMWsJmfzi5hQnZqjZHb1WGVdzvwMNM/RT/15Cv7u9ht1VaQoKuU+8H
         LELQ==
X-Gm-Message-State: AOAM53163dq7KseIh+Dr3pmhm5LFuH3JI6KZAfUyHIO/37ABSzWXFviR
        qnuEMeSk2QRSPKwCCHE8UbHCFA==
X-Google-Smtp-Source: ABdhPJyEnomE19p97KlzQbYT2F7OM+wQb1qF3M7FUBItAAjZ/LR49YlD2pWq5YPqE0boIgaarWo0xQ==
X-Received: by 2002:a92:4b0c:0:b0:2c2:b31f:f7ac with SMTP id m12-20020a924b0c000000b002c2b31ff7acmr13590415ilg.300.1646064419316;
        Mon, 28 Feb 2022 08:06:59 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y18-20020a056e02129200b002c26a6c9478sm6472503ilq.68.2022.02.28.08.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:06:58 -0800 (PST)
Message-ID: <6f20c574-d28f-9e39-0d0f-0b65f1448bb2@linaro.org>
Date:   Mon, 28 Feb 2022 10:06:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 10/27] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-11-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228124344.77359-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 6:43 AM, Manivannan Sadhasivam wrote:
> This commit adds support for registering MHI endpoint controller drivers
> with the MHI endpoint stack. MHI endpoint controller drivers manage
> the interaction with the host machines (such as x86). They are also the
> MHI endpoint bus master in charge of managing the physical link between
> the host and endpoint device. Eventhough the MHI spec is bus agnostic,
> the current implementation is entirely based on PCIe bus.
> 
> The endpoint controller driver encloses all information about the
> underlying physical bus like PCIe. The registration process involves
> parsing the channel configuration and allocating an MHI EP device.
> 
> Channels used in the endpoint stack follows the perspective of the MHI
> host stack. i.e.,
> 
> UL - From host to endpoint
> DL - From endpoint to host
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good to me.  I am partially relying on the more thorough
I did earlier (here and on other patchess I'm reviewing today).
This has clearly improved though.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/Kconfig       |   1 +
>   drivers/bus/mhi/Makefile      |   3 +
>   drivers/bus/mhi/ep/Kconfig    |  10 ++
>   drivers/bus/mhi/ep/Makefile   |   2 +
>   drivers/bus/mhi/ep/internal.h | 154 ++++++++++++++++++++++
>   drivers/bus/mhi/ep/main.c     | 236 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        | 143 ++++++++++++++++++++
>   7 files changed, 549 insertions(+)
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
> index 000000000000..90ab3b040672
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/Kconfig
> @@ -0,0 +1,10 @@
> +config MHI_BUS_EP
> +	tristate "Modem Host Interface (MHI) bus Endpoint implementation"
> +	help
> +	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
> +	  communication protocol used by a host processor to control
> +	  and communicate a modem device over a high speed peripheral
> +	  bus or shared memory.
> +
> +	  MHI_BUS_EP implements the MHI protocol for the endpoint devices,
> +	  such as SDX55 modem connected to the host machine over PCIe.
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
> index 000000000000..58ec5fdc503f
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022, Linaro Ltd.
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
> +#define EP_MHIREGLEN				(MHI_REG_OFFSET + MHIREGLEN)
> +#define EP_MHIVER				(MHI_REG_OFFSET + MHIVER)
> +#define EP_MHICFG				(MHI_REG_OFFSET + MHICFG)
> +#define EP_CHDBOFF				(MHI_REG_OFFSET + CHDBOFF)
> +#define EP_ERDBOFF				(MHI_REG_OFFSET + ERDBOFF)
> +#define EP_BHIOFF				(MHI_REG_OFFSET + BHIOFF)
> +#define EP_BHIEOFF				(MHI_REG_OFFSET + BHIEOFF)
> +#define EP_DEBUGOFF				(MHI_REG_OFFSET + DEBUGOFF)
> +#define EP_MHICTRL				(MHI_REG_OFFSET + MHICTRL)
> +#define EP_MHISTATUS				(MHI_REG_OFFSET + MHISTATUS)
> +#define EP_CCABAP_LOWER				(MHI_REG_OFFSET + CCABAP_LOWER)
> +#define EP_CCABAP_HIGHER			(MHI_REG_OFFSET + CCABAP_HIGHER)
> +#define EP_ECABAP_LOWER				(MHI_REG_OFFSET + ECABAP_LOWER)
> +#define EP_ECABAP_HIGHER			(MHI_REG_OFFSET + ECABAP_HIGHER)
> +#define EP_CRCBAP_LOWER				(MHI_REG_OFFSET + CRCBAP_LOWER)
> +#define EP_CRCBAP_HIGHER			(MHI_REG_OFFSET + CRCBAP_HIGHER)
> +#define EP_CRDB_LOWER				(MHI_REG_OFFSET + CRDB_LOWER)
> +#define EP_CRDB_HIGHER				(MHI_REG_OFFSET + CRDB_HIGHER)
> +#define EP_MHICTRLBASE_LOWER			(MHI_REG_OFFSET + MHICTRLBASE_LOWER)
> +#define EP_MHICTRLBASE_HIGHER			(MHI_REG_OFFSET + MHICTRLBASE_HIGHER)
> +#define EP_MHICTRLLIMIT_LOWER			(MHI_REG_OFFSET + MHICTRLLIMIT_LOWER)
> +#define EP_MHICTRLLIMIT_HIGHER			(MHI_REG_OFFSET + MHICTRLLIMIT_HIGHER)
> +#define EP_MHIDATABASE_LOWER			(MHI_REG_OFFSET + MHIDATABASE_LOWER)
> +#define EP_MHIDATABASE_HIGHER			(MHI_REG_OFFSET + MHIDATABASE_HIGHER)
> +#define EP_MHIDATALIMIT_LOWER			(MHI_REG_OFFSET + MHIDATALIMIT_LOWER)
> +#define EP_MHIDATALIMIT_HIGHER			(MHI_REG_OFFSET + MHIDATALIMIT_HIGHER)
> +
> +/* MHI BHI registers */
> +#define EP_BHI_INTVEC				(BHI_REG_OFFSET + BHI_INTVEC)
> +#define EP_BHI_EXECENV				(BHI_REG_OFFSET + BHI_EXECENV)
> +
> +/* MHI Doorbell registers */
> +#define CHDB_LOWER_n(n)				(0x400 + 0x8 * (n))
> +#define CHDB_HIGHER_n(n)			(0x404 + 0x8 * (n))
> +#define ERDB_LOWER_n(n)				(0x800 + 0x8 * (n))
> +#define ERDB_HIGHER_n(n)			(0x804 + 0x8 * (n))
> +
> +#define MHI_CTRL_INT_STATUS			0x4
> +#define MHI_CTRL_INT_STATUS_MSK			BIT(0)
> +#define MHI_CTRL_INT_STATUS_CRDB_MSK		BIT(1)
> +#define MHI_CHDB_INT_STATUS_n(n)		(0x28 + 0x4 * (n))
> +#define MHI_ERDB_INT_STATUS_n(n)		(0x38 + 0x4 * (n))
> +
> +#define MHI_CTRL_INT_CLEAR			0x4c
> +#define MHI_CTRL_INT_MMIO_WR_CLEAR		BIT(2)
> +#define MHI_CTRL_INT_CRDB_CLEAR			BIT(1)
> +#define MHI_CTRL_INT_CRDB_MHICTRL_CLEAR		BIT(0)
> +
> +#define MHI_CHDB_INT_CLEAR_n(n)			(0x70 + 0x4 * (n))
> +#define MHI_CHDB_INT_CLEAR_n_CLEAR_ALL		GENMASK(31, 0)
> +#define MHI_ERDB_INT_CLEAR_n(n)			(0x80 + 0x4 * (n))
> +#define MHI_ERDB_INT_CLEAR_n_CLEAR_ALL		GENMASK(31, 0)
> +
> +/*
> + * Unlike the usual "masking" convention, writing "1" to a bit in this register
> + * enables the interrupt and writing "0" will disable it..
> + */
> +#define MHI_CTRL_INT_MASK			0x94
> +#define MHI_CTRL_INT_MASK_MASK			GENMASK(1, 0)
> +#define MHI_CTRL_MHICTRL_MASK			BIT(0)
> +#define MHI_CTRL_CRDB_MASK			BIT(1)
> +
> +#define MHI_CHDB_INT_MASK_n(n)			(0xb8 + 0x4 * (n))
> +#define MHI_CHDB_INT_MASK_n_EN_ALL		GENMASK(31, 0)
> +#define MHI_ERDB_INT_MASK_n(n)			(0xc8 + 0x4 * (n))
> +#define MHI_ERDB_INT_MASK_n_EN_ALL		GENMASK(31, 0)
> +
> +#define NR_OF_CMD_RINGS				1
> +#define MHI_MASK_ROWS_CH_EV_DB			4
> +#define MHI_MASK_CH_EV_LEN			32
> +
> +/* Generic context */
> +struct mhi_generic_ctx {
> +	__le32 reserved0;
> +	__le32 reserved1;
> +	__le32 reserved2;
> +
> +	__le64 rbase __packed __aligned(4);
> +	__le64 rlen __packed __aligned(4);
> +	__le64 rp __packed __aligned(4);
> +	__le64 wp __packed __aligned(4);
> +};
> +
> +enum mhi_ep_ring_type {
> +	RING_TYPE_CMD,
> +	RING_TYPE_ER,
> +	RING_TYPE_CH,
> +};
> +
> +/* Ring element */
> +union mhi_ep_ring_ctx {
> +	struct mhi_cmd_ctxt cmd;
> +	struct mhi_event_ctxt ev;
> +	struct mhi_chan_ctxt ch;
> +	struct mhi_generic_ctx generic;
> +};
> +
> +struct mhi_ep_ring {
> +	struct mhi_ep_cntrl *mhi_cntrl;
> +	union mhi_ep_ring_ctx *ring_ctx;
> +	struct mhi_ring_element *ring_cache;
> +	enum mhi_ep_ring_type type;
> +	u64 rbase;
> +	size_t rd_offset;
> +	size_t wr_offset;
> +	size_t ring_size;
> +	u32 db_offset_h;
> +	u32 db_offset_l;
> +	u32 ch_id;
> +};
> +
> +struct mhi_ep_cmd {
> +	struct mhi_ep_ring ring;
> +};
> +
> +struct mhi_ep_event {
> +	struct mhi_ep_ring ring;
> +};
> +
> +struct mhi_ep_chan {
> +	char *name;
> +	struct mhi_ep_device *mhi_dev;
> +	struct mhi_ep_ring ring;
> +	struct mutex lock;
> +	void (*xfer_cb)(struct mhi_ep_device *mhi_dev, struct mhi_result *result);
> +	enum mhi_ch_state state;
> +	enum dma_data_direction dir;
> +	u64 tre_loc;
> +	u32 tre_size;
> +	u32 tre_bytes_left;
> +	u32 chan;
> +	bool skip_td;
> +};
> +
> +#endif
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> new file mode 100644
> index 000000000000..87ca42c7b067
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MHI Endpoint bus stack
> + *
> + * Copyright (C) 2022 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/dma-direction.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mhi_ep.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include "internal.h"
> +
> +static DEFINE_IDA(mhi_ep_cntrl_ida);
> +
> +static void mhi_ep_release_device(struct device *dev)
> +{
> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +
> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> +		mhi_dev->mhi_cntrl->mhi_dev = NULL;
> +
> +	/*
> +	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
> +	 * devices for the channels will only get created in mhi_ep_create_device()
> +	 * if the mhi_dev associated with it is NULL.
> +	 */
> +	if (mhi_dev->ul_chan)
> +		mhi_dev->ul_chan->mhi_dev = NULL;
> +
> +	if (mhi_dev->dl_chan)
> +		mhi_dev->dl_chan->mhi_dev = NULL;
> +
> +	kfree(mhi_dev);
> +}
> +
> +static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl,
> +						 enum mhi_device_type dev_type)
> +{
> +	struct mhi_ep_device *mhi_dev;
> +	struct device *dev;
> +
> +	mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
> +	if (!mhi_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev = &mhi_dev->dev;
> +	device_initialize(dev);
> +	dev->bus = &mhi_ep_bus_type;
> +	dev->release = mhi_ep_release_device;
> +
> +	/* Controller device is always allocated first */
> +	if (dev_type == MHI_DEVICE_CONTROLLER)
> +		/* for MHI controller device, parent is the bus device (e.g. PCI EPF) */
> +		dev->parent = mhi_cntrl->cntrl_dev;
> +	else
> +		/* for MHI client devices, parent is the MHI controller device */
> +		dev->parent = &mhi_cntrl->mhi_dev->dev;
> +
> +	mhi_dev->mhi_cntrl = mhi_cntrl;
> +	mhi_dev->dev_type = dev_type;
> +
> +	return mhi_dev;
> +}
> +
> +static int mhi_ep_chan_init(struct mhi_ep_cntrl *mhi_cntrl,
> +			    const struct mhi_ep_cntrl_config *config)
> +{
> +	const struct mhi_ep_channel_config *ch_cfg;
> +	struct device *dev = mhi_cntrl->cntrl_dev;
> +	u32 chan, i;
> +	int ret = -EINVAL;
> +
> +	mhi_cntrl->max_chan = config->max_channels;
> +
> +	/*
> +	 * Allocate max_channels supported by the MHI endpoint and populate
> +	 * only the defined channels
> +	 */
> +	mhi_cntrl->mhi_chan = kcalloc(mhi_cntrl->max_chan, sizeof(*mhi_cntrl->mhi_chan),
> +				      GFP_KERNEL);
> +	if (!mhi_cntrl->mhi_chan)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < config->num_channels; i++) {
> +		struct mhi_ep_chan *mhi_chan;
> +
> +		ch_cfg = &config->ch_cfg[i];
> +
> +		chan = ch_cfg->num;
> +		if (chan >= mhi_cntrl->max_chan) {
> +			dev_err(dev, "Channel (%u) exceeds maximum available channels (%u)\n",
> +				chan, mhi_cntrl->max_chan);
> +			goto error_chan_cfg;
> +		}
> +
> +		/* Bi-directional and direction less channels are not supported */
> +		if (ch_cfg->dir == DMA_BIDIRECTIONAL || ch_cfg->dir == DMA_NONE) {
> +			dev_err(dev, "Invalid direction (%u) for channel (%u)\n",
> +				ch_cfg->dir, chan);
> +			goto error_chan_cfg;
> +		}
> +
> +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> +		mhi_chan->name = ch_cfg->name;
> +		mhi_chan->chan = chan;
> +		mhi_chan->dir = ch_cfg->dir;
> +		mutex_init(&mhi_chan->lock);
> +	}
> +
> +	return 0;
> +
> +error_chan_cfg:
> +	kfree(mhi_cntrl->mhi_chan);
> +
> +	return ret;
> +}
> +
> +/*
> + * Allocate channel and command rings here. Event rings will be allocated
> + * in mhi_ep_power_up() as the config comes from the host.
> + */
> +int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> +				const struct mhi_ep_cntrl_config *config)
> +{
> +	struct mhi_ep_device *mhi_dev;
> +	int ret;
> +
> +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
> +		return -EINVAL;
> +
> +	ret = mhi_ep_chan_init(mhi_cntrl, config);
> +	if (ret)
> +		return ret;
> +
> +	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS, sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
> +	if (!mhi_cntrl->mhi_cmd) {
> +		ret = -ENOMEM;
> +		goto err_free_ch;
> +	}
> +
> +	/* Set controller index */
> +	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
> +	if (mhi_cntrl->index < 0) {
> +		ret = mhi_cntrl->index;
> +		goto err_free_cmd;
> +	}
> +
> +	/* Allocate the controller device */
> +	mhi_dev = mhi_ep_alloc_device(mhi_cntrl, MHI_DEVICE_CONTROLLER);
> +	if (IS_ERR(mhi_dev)) {
> +		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate controller device\n");
> +		ret = PTR_ERR(mhi_dev);
> +		goto err_ida_free;
> +	}
> +
> +	dev_set_name(&mhi_dev->dev, "mhi_ep%u", mhi_cntrl->index);
> +	mhi_dev->name = dev_name(&mhi_dev->dev);
> +	mhi_cntrl->mhi_dev = mhi_dev;
> +
> +	ret = device_add(&mhi_dev->dev);
> +	if (ret)
> +		goto err_put_dev;
> +
> +	dev_dbg(&mhi_dev->dev, "MHI EP Controller registered\n");
> +
> +	return 0;
> +
> +err_put_dev:
> +	put_device(&mhi_dev->dev);
> +err_ida_free:
> +	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
> +err_free_cmd:
> +	kfree(mhi_cntrl->mhi_cmd);
> +err_free_ch:
> +	kfree(mhi_cntrl->mhi_chan);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_register_controller);
> +
> +void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
> +
> +	kfree(mhi_cntrl->mhi_cmd);
> +	kfree(mhi_cntrl->mhi_chan);
> +
> +	device_del(&mhi_dev->dev);
> +	put_device(&mhi_dev->dev);
> +
> +	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
> +
> +static int mhi_ep_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +
> +	/*
> +	 * If the device is a controller type then there is no client driver
> +	 * associated with it
> +	 */
> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> +		return 0;
> +
> +	return 0;
> +};
> +
> +struct bus_type mhi_ep_bus_type = {
> +	.name = "mhi_ep",
> +	.dev_name = "mhi_ep",
> +	.match = mhi_ep_match,
> +};
> +
> +static int __init mhi_ep_init(void)
> +{
> +	return bus_register(&mhi_ep_bus_type);
> +}
> +
> +static void __exit mhi_ep_exit(void)
> +{
> +	bus_unregister(&mhi_ep_bus_type);
> +}
> +
> +postcore_initcall(mhi_ep_init);
> +module_exit(mhi_ep_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MHI Bus Endpoint stack");
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> new file mode 100644
> index 000000000000..9c58938371e2
> --- /dev/null
> +++ b/include/linux/mhi_ep.h
> @@ -0,0 +1,143 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022, Linaro Ltd.
> + *
> + */
> +#ifndef _MHI_EP_H_
> +#define _MHI_EP_H_
> +
> +#include <linux/dma-direction.h>
> +#include <linux/mhi.h>
> +
> +#define MHI_EP_DEFAULT_MTU 0x8000
> +
> +/**
> + * struct mhi_ep_channel_config - Channel configuration structure for controller
> + * @name: The name of this channel
> + * @num: The number assigned to this channel
> + * @num_elements: The number of elements that can be queued to this channel
> + * @dir: Direction that data may flow on this channel
> + */
> +struct mhi_ep_channel_config {
> +	char *name;
> +	u32 num;
> +	u32 num_elements;
> +	enum dma_data_direction dir;
> +};
> +
> +/**
> + * struct mhi_ep_cntrl_config - MHI Endpoint controller configuration
> + * @mhi_version: MHI spec version supported by the controller
> + * @max_channels: Maximum number of channels supported
> + * @num_channels: Number of channels defined in @ch_cfg
> + * @ch_cfg: Array of defined channels
> + */
> +struct mhi_ep_cntrl_config {
> +	u32 mhi_version;
> +	u32 max_channels;
> +	u32 num_channels;
> +	const struct mhi_ep_channel_config *ch_cfg;
> +};
> +
> +/**
> + * struct mhi_ep_db_info - MHI Endpoint doorbell info
> + * @mask: Mask of the doorbell interrupt
> + * @status: Status of the doorbell interrupt
> + */
> +struct mhi_ep_db_info {
> +	u32 mask;
> +	u32 status;
> +};
> +
> +/**
> + * struct mhi_ep_cntrl - MHI Endpoint controller structure
> + * @cntrl_dev: Pointer to the struct device of physical bus acting as the MHI
> + *             Endpoint controller
> + * @mhi_dev: MHI Endpoint device instance for the controller
> + * @mmio: MMIO region containing the MHI registers
> + * @mhi_chan: Points to the channel configuration table
> + * @mhi_event: Points to the event ring configurations table
> + * @mhi_cmd: Points to the command ring configurations table
> + * @sm: MHI Endpoint state machine
> + * @raise_irq: CB function for raising IRQ to the host
> + * @alloc_addr: CB function for allocating memory in endpoint for storing host context
> + * @map_addr: CB function for mapping host context to endpoint
> + * @free_addr: CB function to free the allocated memory in endpoint for storing host context
> + * @unmap_addr: CB function to unmap the host context in endpoint
> + * @read_from_host: CB function for reading from host memory from endpoint
> + * @write_to_host: CB function for writing to host memory from endpoint
> + * @mhi_state: MHI Endpoint state
> + * @max_chan: Maximum channels supported by the endpoint controller
> + * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
> + * @index: MHI Endpoint controller index
> + */
> +struct mhi_ep_cntrl {
> +	struct device *cntrl_dev;
> +	struct mhi_ep_device *mhi_dev;
> +	void __iomem *mmio;
> +
> +	struct mhi_ep_chan *mhi_chan;
> +	struct mhi_ep_event *mhi_event;
> +	struct mhi_ep_cmd *mhi_cmd;
> +	struct mhi_ep_sm *sm;
> +
> +	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
> +	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t *phys_addr,
> +		       size_t size);
> +	int (*map_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t phys_addr, u64 pci_addr,
> +			size_t size);
> +	void (*free_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t phys_addr,
> +			  void __iomem *virt_addr, size_t size);
> +	void (*unmap_addr)(struct mhi_ep_cntrl *mhi_cntrl, phys_addr_t phys_addr);
> +	int (*read_from_host)(struct mhi_ep_cntrl *mhi_cntrl, u64 from, void __iomem *to,
> +			      size_t size);
> +	int (*write_to_host)(struct mhi_ep_cntrl *mhi_cntrl, void __iomem *from, u64 to,
> +			     size_t size);
> +
> +	enum mhi_state mhi_state;
> +
> +	u32 max_chan;
> +	u32 mru;
> +	u32 index;
> +};
> +
> +/**
> + * struct mhi_ep_device - Structure representing an MHI Endpoint device that binds
> + *                     to channels or is associated with controllers
> + * @dev: Driver model device node for the MHI Endpoint device
> + * @mhi_cntrl: Controller the device belongs to
> + * @id: Pointer to MHI Endpoint device ID struct
> + * @name: Name of the associated MHI Endpoint device
> + * @ul_chan: UL channel for the device
> + * @dl_chan: DL channel for the device
> + * @dev_type: MHI device type
> + */
> +struct mhi_ep_device {
> +	struct device dev;
> +	struct mhi_ep_cntrl *mhi_cntrl;
> +	const struct mhi_device_id *id;
> +	const char *name;
> +	struct mhi_ep_chan *ul_chan;
> +	struct mhi_ep_chan *dl_chan;
> +	enum mhi_device_type dev_type;
> +};
> +
> +#define to_mhi_ep_device(dev) container_of(dev, struct mhi_ep_device, dev)
> +
> +/**
> + * mhi_ep_register_controller - Register MHI Endpoint controller
> + * @mhi_cntrl: MHI Endpoint controller to register
> + * @config: Configuration to use for the controller
> + *
> + * Return: 0 if controller registrations succeeds, a negative error code otherwise.
> + */
> +int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
> +			       const struct mhi_ep_cntrl_config *config);
> +
> +/**
> + * mhi_ep_unregister_controller - Unregister MHI Endpoint controller
> + * @mhi_cntrl: MHI Endpoint controller to unregister
> + */
> +void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl);
> +
> +#endif

