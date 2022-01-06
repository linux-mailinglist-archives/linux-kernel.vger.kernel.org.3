Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D804485D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbiAFA1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbiAFA0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:26:54 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5032CC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:26:54 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l17so727450qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=xtfMYg0qpd+PPYfGHhyPVRhZrpKzif8o21JgiOWqJi0=;
        b=E7xui/oRvnyez/u1GzKzLU+SaSjXO7FBTa/Ke8XnVkEaLbtu38JQzwR/zZrZ/+WGW7
         KZV/cKI+bvYJQRxEoMzNMQWGYaDYVxMSdos24+au/yT7dMGLLcm0y4pCKoEVUToKqx5k
         rdHlOiL7CuwYHSIlQlX0dUcot/abXgTTo89TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=xtfMYg0qpd+PPYfGHhyPVRhZrpKzif8o21JgiOWqJi0=;
        b=ijh/JqUZLlsxsmzoPUZVDpJVJYcrQxyO0v0qxP9qnVdd4JY0JGabYWwy5u+wcvkUKZ
         gDAGVPJuAM9yvjqBXZaEYLTXXHGF/NvPJVsxODmsbpIEqv7naSKMHIdrc4n1E5O/brFM
         LgQY81Iob530PN1a+lKl/bkTSIv9cE9pDh+qbcOLiDfYwe8sl+cds6qewALYqfFyUzQc
         hNk9m9zoEH8ESI4bmHBSJXh91si2X5mugfTOrx3Ppi8COspyhikPk/uck/InuHx7fAuu
         bX/DPTi6Qgli1vkgg7Xas0bla3ztQ4YmDlo9K3by4MXq5mOaA0bIJAOOmw+Cm4tpQzUl
         UoXg==
X-Gm-Message-State: AOAM532QIJs8KWr3yLs/pNUg8zKScCPBStzxcZTrrBztBiwEWxotWX9m
        M4wvqNGY1YKYwI56UrRu7FML3Jx+bgkaQA==
X-Google-Smtp-Source: ABdhPJwRlNDHU/le0EvBpDU4xaY5NEITxAUWvOkv6+P4OunwV+Ebpo2L1GtKOQm88um6eEn8SQCxzw==
X-Received: by 2002:a05:622a:3c7:: with SMTP id k7mr51131025qtx.307.1641428813308;
        Wed, 05 Jan 2022 16:26:53 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id o9sm345122qtk.81.2022.01.05.16.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 16:26:52 -0800 (PST)
Message-ID: <dc338eb3-0c11-450f-bce0-9b515a969390@ieee.org>
Date:   Wed, 5 Jan 2022 18:26:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 05/20] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-6-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
In-Reply-To: <20211202113553.238011-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
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

See below.  Lots of little things, some I've said before.

> ---
>   drivers/bus/mhi/Kconfig       |   1 +
>   drivers/bus/mhi/Makefile      |   3 +
>   drivers/bus/mhi/ep/Kconfig    |  10 ++
>   drivers/bus/mhi/ep/Makefile   |   2 +
>   drivers/bus/mhi/ep/internal.h | 158 +++++++++++++++++++++++
>   drivers/bus/mhi/ep/main.c     | 231 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        | 140 +++++++++++++++++++++
>   7 files changed, 545 insertions(+)
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
> index 000000000000..7b164daf4332
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -0,0 +1,158 @@
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
> +/* MHI register definitions */
> +#define MHIREGLEN				0x100

I really think it would be nice if these could be common between the
host and endpoint.

> +#define MHIVER					0x108
> +#define MHICFG					0x110
> +#define CHDBOFF					0x118
> +#define ERDBOFF					0x120
> +#define BHIOFF					0x128
> +#define DEBUGOFF				0x130
> +#define MHICTRL					0x138
> +#define MHISTATUS				0x148
> +#define CCABAP_LOWER				0x158
> +#define CCABAP_HIGHER				0x15c
> +#define ECABAP_LOWER				0x160
> +#define ECABAP_HIGHER				0x164
> +#define CRCBAP_LOWER				0x168
> +#define CRCBAP_HIGHER				0x16c
> +#define CRDB_LOWER				0x170
> +#define CRDB_HIGHER				0x174
> +#define MHICTRLBASE_LOWER			0x180
> +#define MHICTRLBASE_HIGHER			0x184
> +#define MHICTRLLIMIT_LOWER			0x188
> +#define MHICTRLLIMIT_HIGHER			0x18c
> +#define MHIDATABASE_LOWER			0x198
> +#define MHIDATABASE_HIGHER			0x19c
> +#define MHIDATALIMIT_LOWER			0x1a0
> +#define MHIDATALIMIT_HIGHER			0x1a4

It wouldn't hurt to have a one or two line comment explaining how
these compute the offset for a given channel or event ring's
doorbell register.

I think you could use decimal for the multiplier (8 rather than 0x8),
but maybe you prefer not mixing that with a hex base offset.

Overall though, take a look at the macros you define like this.
See if you can decide on whether you can settle on a consistent
form.  Some places you use decimal, others hex.  It's not a
big deal, but consistency always helps.

> +#define CHDB_LOWER_n(n)				(0x400 + 0x8 * (n))
> +#define CHDB_HIGHER_n(n)			(0x404 + 0x8 * (n))
> +#define ERDB_LOWER_n(n)				(0x800 + 0x8 * (n))
> +#define ERDB_HIGHER_n(n)			(0x804 + 0x8 * (n))
> +#define BHI_INTVEC				0x220
> +#define BHI_EXECENV				0x228
> +#define BHI_IMGTXDB				0x218
> +

Will the AP always be an "A7"?

> +#define MHI_CTRL_INT_STATUS_A7			0x4
> +#define MHI_CTRL_INT_STATUS_A7_MSK		BIT(0)
> +#define MHI_CTRL_INT_STATUS_CRDB_MSK		BIT(1)
> +#define MHI_CHDB_INT_STATUS_A7_n(n)		(0x28 + 0x4 * (n))
> +#define MHI_ERDB_INT_STATUS_A7_n(n)		(0x38 + 0x4 * (n))
> +
> +#define MHI_CTRL_INT_CLEAR_A7			0x4c
> +#define MHI_CTRL_INT_MMIO_WR_CLEAR		BIT(2)
> +#define MHI_CTRL_INT_CRDB_CLEAR			BIT(1)
> +#define MHI_CTRL_INT_CRDB_MHICTRL_CLEAR		BIT(0)
> +
> +#define MHI_CHDB_INT_CLEAR_A7_n(n)		(0x70 + 0x4 * (n))
> +#define MHI_CHDB_INT_CLEAR_A7_n_CLEAR_ALL	GENMASK(31, 0)
> +#define MHI_ERDB_INT_CLEAR_A7_n(n)		(0x80 + 0x4 * (n))
> +#define MHI_ERDB_INT_CLEAR_A7_n_CLEAR_ALL	GENMASK(31, 0)
> +

The term "MASK" here might be confusing.  Does a bit set in
this mask register indicate an interrupt is enabled, or
disabled (masked)?  A comment (here or where used) could
clear it up without renaming the symbol.

> +#define MHI_CTRL_INT_MASK_A7			0x94
> +#define MHI_CTRL_INT_MASK_A7_MASK_MASK		GENMASK(1, 0)
> +#define MHI_CTRL_MHICTRL_MASK			BIT(0)
> +#define MHI_CTRL_MHICTRL_SHFT			0
> +#define MHI_CTRL_CRDB_MASK			BIT(1)
> +#define MHI_CTRL_CRDB_SHFT			1

Use SHIFT or SHFT (not both), consistently.  (But get rid of
this shift definition, and others like it...)

> +#define MHI_CHDB_INT_MASK_A7_n(n)		(0xb8 + 0x4 * (n))
> +#define MHI_CHDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
> +#define MHI_ERDB_INT_MASK_A7_n(n)		(0xc8 + 0x4 * (n))
> +#define MHI_ERDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
> +
> +#define NR_OF_CMD_RINGS				1

Is there ever any reason to believe there will be more than one
command ring for a given MHI instance?  I kept seeing loops over
NR_OF_CMD_RINGS, and it just seemed silly.

> +#define MHI_MASK_ROWS_CH_EV_DB			4
> +#define MHI_MASK_CH_EV_LEN			32
> +
> +/* Generic context */

Maybe define the entire structure as packed and aligned.

> +struct mhi_generic_ctx {
> +	__u32 reserved0;
> +	__u32 reserved1;
> +	__u32 reserved2;
> +
> +	__u64 rbase __packed __aligned(4);
> +	__u64 rlen __packed __aligned(4);
> +	__u64 rp __packed __aligned(4);
> +	__u64 wp __packed __aligned(4);
> +};

Are these structures defined separately for host and endpoint?
(I've lost track...  If they are, it would be better to define
them in common.)

> +
> +enum mhi_ep_ring_state {
> +	RING_STATE_UINT = 0,

I think "UINT" is a *terrible* abbreviation to represent
"uninitialized".

> +	RING_STATE_IDLE,

Since there are only two states, uninitialized or idle, maybe
you can get rid of this enum definition and just define the
ring state with "bool initialized".

> +};
> +
> +enum mhi_ep_ring_type {

Is the value 0 significant to hardware?  If not, there's no need
to define the numeric value on this first symbol.

> +	RING_TYPE_CMD = 0,
> +	RING_TYPE_ER,
> +	RING_TYPE_CH,

I don't think you ever use RING_TYPE_INVALID, so it does
not need to be defined.

> +	RING_TYPE_INVALID,
> +};
> +

I prefer a more meaningful structure definition than this (as
mentioned in I think the first patch).

> +struct mhi_ep_ring_element {
> +	u64 ptr;
> +	u32 dword[2];
> +};
> +
> +/* Transfer ring element type */

Not transfer ring, just ring.  Command, transfer, and event
ring descriptors are different things.

> +union mhi_ep_ring_ctx {
> +	struct mhi_cmd_ctxt cmd;
> +	struct mhi_event_ctxt ev;
> +	struct mhi_chan_ctxt ch;
> +	struct mhi_generic_ctx generic;
> +};
> +
> +struct mhi_ep_ring {
> +	struct list_head list;
> +	struct mhi_ep_cntrl *mhi_cntrl;
> +	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> +	union mhi_ep_ring_ctx *ring_ctx;
> +	struct mhi_ep_ring_element *ring_cache;
> +	enum mhi_ep_ring_type type;
> +	enum mhi_ep_ring_state state;
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
> index 000000000000..db664360c8ab
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MHI Bus Endpoint stack
> + *
> + * Copyright (C) 2021 Linaro Ltd.
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
> +	/*
> +	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
> +	 * devices for the channels will only get created if the mhi_dev
> +	 * associated with it is NULL.

Maybe say where in the code what the comment above says happens.

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
> +static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl)
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

I think you should pass the MHI device type as argument here, and
set it within this function.  Then use it in the test below, rather
than assuming the mhi_dev pointer will be NULL for the controller
only.  Maybe you should set the mhi_dev pointer here as well.

> +	if (mhi_cntrl->mhi_dev) {
> +		/* for MHI client devices, parent is the MHI controller device */
> +		dev->parent = &mhi_cntrl->mhi_dev->dev;
> +	} else {
> +		/* for MHI controller device, parent is the bus device (e.g. PCI EPF) */
> +		dev->parent = mhi_cntrl->cntrl_dev;
> +	}
> +
> +	mhi_dev->mhi_cntrl = mhi_cntrl;
> +
> +	return mhi_dev;
> +}
> +
> +static int parse_ch_cfg(struct mhi_ep_cntrl *mhi_cntrl,
> +			const struct mhi_ep_cntrl_config *config)
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
> +			dev_err(dev, "Channel %d not available\n", chan);
> +			goto error_chan_cfg;
> +		}
> +
> +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> +		mhi_chan->name = ch_cfg->name;
> +		mhi_chan->chan = chan;
> +		mhi_chan->dir = ch_cfg->dir;
> +		mutex_init(&mhi_chan->lock);

Move the error check below earlier, before assigning other values.

> +		/* Bi-directional and direction less channels are not supported */
> +		if (mhi_chan->dir == DMA_BIDIRECTIONAL || mhi_chan->dir == DMA_NONE) {
> +			dev_err(dev, "Invalid channel configuration\n");
> +			goto error_chan_cfg;
> +		}
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

Perhaps you could use a convention like "ep_dev" (and later, "ep_drv")
to represent an mhi_ep_device, different from "mhi_dev" representing
an mhi_device.

> +	int ret;
> +
> +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
> +		return -EINVAL;
> +
> +	ret = parse_ch_cfg(mhi_cntrl, config);
> +	if (ret)
> +		return ret;
> +

NR_OF_CMD_RINGS is 1, and I think always will be, right?  This and
elsewhere could be simplified if we just accept that.

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
> +	mhi_dev = mhi_ep_alloc_device(mhi_cntrl);
> +	if (IS_ERR(mhi_dev)) {
> +		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate controller device\n");
> +		ret = PTR_ERR(mhi_dev);
> +		goto err_ida_free;
> +	}
> +
> +	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
> +	dev_set_name(&mhi_dev->dev, "mhi_ep%d", mhi_cntrl->index);
> +	mhi_dev->name = dev_name(&mhi_dev->dev);
> +
> +	ret = device_add(&mhi_dev->dev);
> +	if (ret)
> +		goto err_release_dev;

goto err_put_device?

> +
> +	mhi_cntrl->mhi_dev = mhi_dev;
> +
> +	dev_dbg(&mhi_dev->dev, "MHI EP Controller registered\n");
> +
> +	return 0;
> +
> +err_release_dev:
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
> index 000000000000..14fd40af8974
> --- /dev/null
> +++ b/include/linux/mhi_ep.h

. . .

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
> + * @ul_chan_id: Channel id for UL transfer
> + * @dl_chan_id: Channel id for DL transfer
> + */
> +struct mhi_ep_device {
> +	struct device dev;
> +	struct mhi_ep_cntrl *mhi_cntrl;
> +	const struct mhi_device_id *id;
> +	const char *name;
> +	struct mhi_ep_chan *ul_chan;
> +	struct mhi_ep_chan *dl_chan;

Could the dev_type just be:    bool controller?

> +	enum mhi_device_type dev_type;
> +	int ul_chan_id;

Can't you ust use ul_chan->chan and dl_chan->chan?

In any case, I think the channel ids should be u32.

					-Alex

> +	int dl_chan_id;
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
> 

