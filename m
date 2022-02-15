Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2784B77CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiBOUDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:03:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbiBOUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:02:55 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C370876
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:44 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w7so25344738ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cc2okdfwpU6v3MTluxoRaJkx6yNhoy/GMswHLpFNKHM=;
        b=cJ4W93bn1AB0SoCbfoMeGIb862goGzxIqYJJLXZi5fSboXxOHC86rO67khWFCfro9d
         k0xQHMcoyMLdQs8TnTja3Y73A1MxktuIyeCVRAsEYiV3Zj55N+iavIIU3A0yuuS9y4FJ
         vcPhvpjHR8Z9y49hvUptuJgLrSD/We1LYUPg9H/yawdtVpxfHydBVK0haFroCmwsjTXk
         w2L943Z11U5uPYKX5N7qCX1bJ9dnn4doYIUQoABjFOomDXaLepp4rsTE6CRpHZ/4dszR
         O0zZsHh+iCHnxhOyTlriUusKqLFbQDB7ILsHmVeVKvLWF1oCoZWxZurLNG0um95Z1F9W
         Jy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cc2okdfwpU6v3MTluxoRaJkx6yNhoy/GMswHLpFNKHM=;
        b=Gv4EFQCreW648h9gaBlXHRUGiTn4V/85VqlKbzlN+jtBhuBcFXHCqkxPWxHnHG9akA
         XJqXS3OtbofHwB4pnEr5pQm59Xi+V0yLJ/DuqD4KgqAqTjny3XUejmefGiui0Z85EQvW
         ykPV1j6MUYECcC1BdYiD8kHY84c/RBb5C8q8dTVT03sJ3BRq5RuPU0Bkq0OBnfFLQPg0
         JbhZzVjjn18SCoMUOM1CU0BZp1LA/9hG+q7G1f+ZvAx6deCozcNoWP2Sle4Hiykcx+NS
         i4pmdja2DfPADuVmg+RexysvY0PHyfMsrTYwuQFucHlZYiswlclRqgBTFA1RosyyeMEY
         DRGA==
X-Gm-Message-State: AOAM532a3dBgS1k7wTA0YK3gSVhXklYB8vWxI6p3fvX/KPgOi9nHmKG+
        2Pl1SeKQAd9bsgVGz6vf5Umieg==
X-Google-Smtp-Source: ABdhPJxnvK5PDAQ35RlTyGmUqlEmlTU1ne4mRhDWnh7pLLiBOTckgRBiX/xAhza2m/FPlULwOwE0mQ==
X-Received: by 2002:a05:6638:35a1:: with SMTP id v33mr338410jal.277.1644955363240;
        Tue, 15 Feb 2022 12:02:43 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v16sm19993328ilm.25.2022.02.15.12.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:02:42 -0800 (PST)
Message-ID: <4cc78936-b419-4738-b5b2-65c53be06f33@linaro.org>
Date:   Tue, 15 Feb 2022 14:02:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
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

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> This commit adds support for registering MHI endpoint controller drivers
> with the MHI endpoint stack. MHI endpoint controller drivers manages

s/manages/manage/

> the interaction with the host machines such as x86. They are also the

  (such as x86)

> MHI endpoint bus master in charge of managing the physical link between the
> host and endpoint device.
> 
> The endpoint controller driver encloses all information about the
> underlying physical bus like PCIe. The registration process involves

s/like PCIe/(i.e., PCIe)/

> parsing the channel configuration and allocating an MHI EP device.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

OK!!!  On to the MHI endpoint code!

Quite a few comments below, but nothing very major.

					-Alex

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

s/the host processors/a host processor/

> +	  and communicate with modem devices over a high speed peripheral

s/modem devices/a modem device/

> +	  bus or shared memory.
> +
> +	  MHI_BUS_EP implements the MHI protocol for the endpoint devices
> +	  like SDX55 modem connected to the host machine over PCIe.

s/devices like/devices, such as/

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

Update your copyright statement (here and everywhere before you
send your next version).

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

Rather than defining the REG_OFFSET values here and adding
them to every definition below, why not have the base
address used (e.g., in mhi_write_reg_field()) be adjusted
by the constant amount?

I'm just looking at mhi_init_mmio() (in the existing code)
as an example, but for example, the base address used
comes from mhi_cntrl->regs.  Can you instead just define
a pointer somewhere that is the base of the MHI register
range, which is already offset by the appropriate amount?

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
> +/*
> + * Unlike the usual "masking" convention, writing "1" to a bit in this register
> + * enables the interrupt and writing "0" will disable it..
> + */
> +#define MHI_CTRL_INT_MASK_A7			0x94
> +#define MHI_CTRL_INT_MASK_A7_MASK		GENMASK(1, 0)
> +#define MHI_CTRL_MHICTRL_MASK			BIT(0)
> +#define MHI_CTRL_CRDB_MASK			BIT(1)
> +
> +#define MHI_CHDB_INT_MASK_A7_n(n)		(0xb8 + 0x4 * (n))
> +#define MHI_CHDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
> +#define MHI_ERDB_INT_MASK_A7_n(n)		(0xc8 + 0x4 * (n))
> +#define MHI_ERDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
> +
> +#define NR_OF_CMD_RINGS				1
> +#define MHI_MASK_ROWS_CH_EV_DB			4
> +#define MHI_MASK_CH_EV_LEN			32
> +
> +/* Generic context */
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

I'm pretty sure this constitutes an external interface, so
every field should have its endianness annotated.

Mentioned elsewhere, I think you can define the structure
with those attributes rather than the multiple fields.

> +
> +enum mhi_ep_ring_type {
> +	RING_TYPE_CMD = 0,
> +	RING_TYPE_ER,
> +	RING_TYPE_CH,
> +};
> +
> +struct mhi_ep_ring_element {
> +	u64 ptr;
> +	u32 dword[2];
> +};

Are these host resident rings?  Even if not, this is an external
interface, so this should be defined with explicit endianness.
The cpu_to_le64() call will be a no-op so there is no cost
to correcting this.

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
> +	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> +	union mhi_ep_ring_ctx *ring_ctx;
> +	struct mhi_ep_ring_element *ring_cache;
> +	enum mhi_ep_ring_type type;
> +	size_t rd_offset;
> +	size_t wr_offset;
> +	size_t ring_size;
> +	u32 db_offset_h;
> +	u32 db_offset_l;
> +	u32 ch_id;
> +};

Not sure about the db_offset fields, etc. here, but it's possible
they need endianness annotations.  I'm going to stop making this
comment; please make sure anything that's exposed to the host
specifies that it's little endian.  (The host and endpoint should
have a common definition of these shared structures anyway; maybe
I'm misreading this or assuming something incorrectly.)

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
> index 000000000000..b006011d025d
> --- /dev/null
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -0,0 +1,234 @@
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
> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> +		mhi_dev->mhi_cntrl->mhi_dev = NULL;
> +
> +	/*
> +	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
> +	 * devices for the channels will only get created during start
> +	 * channel if the mhi_dev associated with it is NULL.
> +	 */

Can you mention where in the code the above occurs?  Just for
reference.  Like, "will only get created in mhi_ep_create_device()
if the..." or whatever.

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

Maybe mention that the controller device is always allocated
first.

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

I think the name of the next function could be better.  Yes, it
parses the channel configuration, but what it *really* does is
alloocate and initialize the channel array.  So maybe something
more like mhi_chan_init()?

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

This entire block could be encapsulated in mhi_channel_add()
or something,

> +		ch_cfg = &config->ch_cfg[i];

Move the above assignment down a few lines, to just before
where it's used.

> +
> +		chan = ch_cfg->num;
> +		if (chan >= mhi_cntrl->max_chan) {
> +			dev_err(dev, "Channel %d not available\n", chan);

Maybe report the maximum channel so it's obvious why it's
not available.

> +			goto error_chan_cfg;
> +		}
> +
> +		/* Bi-directional and direction less channels are not supported */
> +		if (ch_cfg->dir == DMA_BIDIRECTIONAL || ch_cfg->dir == DMA_NONE) {
> +			dev_err(dev, "Invalid channel configuration\n");

Maybe be more specific in your message about what's wrong here.

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

I'm not sure what the caller does, but maybe null this
after it's freed, or don't assign mhi_cntrll->mhi_chan
until the initialization is successful.


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
> +	ret = parse_ch_cfg(mhi_cntrl, config);
> +	if (ret)
> +		return ret;
> +
> +	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS, sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);

I said before I thought it was silly to even define NR_OF_CMD_RINGS.
Does the MHI specification actually allow more than one command
ring for a given MHI controller?  Ever?

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
> +	dev_set_name(&mhi_dev->dev, "mhi_ep%d", mhi_cntrl->index);
> +	mhi_dev->name = dev_name(&mhi_dev->dev);
> +
> +	ret = device_add(&mhi_dev->dev);
> +	if (ret)
> +		goto err_put_dev;
> +

Should the mhi_dev pointer be set before device_add() gets called?

> +	mhi_cntrl->mhi_dev = mhi_dev;
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
> index 000000000000..20238e9df1b3
> --- /dev/null
> +++ b/include/linux/mhi_ep.h
> @@ -0,0 +1,143 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021, Linaro Ltd.
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
> + * @max_channels: Maximum number of channels supported
> + * @num_channels: Number of channels defined in @ch_cfg
> + * @ch_cfg: Array of defined channels
> + * @mhi_version: MHI spec version supported by the controller
> + */
> +struct mhi_ep_cntrl_config {
> +	u32 max_channels;
> +	u32 num_channels;
> +	const struct mhi_ep_channel_config *ch_cfg;
> +	u32 mhi_version;

Put mhi_version first?

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
> +	int index;

Will index ever be negative?

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

There are two device types, controller and transfer.  Unless
there is ever going to be anything more than that, I think
the distinction is better represented as a Boolean, such as:

	bool controller;

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

